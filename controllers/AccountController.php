<?php

class AccountController extends Controller
{
    public function fetch()
    {
        if (empty($this->user))
        {
            header('Location: /lk/login');
            exit;
        }

        if (empty($this->user->stage_personal))
        {
            header('Location: /stage/personal');
            exit;
        }

        if (empty($this->user->stage_passport))
        {
            header('Location: /stage/passport');
            exit;
        }

        if (empty($this->user->stage_address))
        {
            header('Location: /stage/address');
            exit;
        }

        if (empty($this->user->stage_work))
        {
            header('Location: /stage/work');
            exit;
        }

        if (empty($this->user->stage_files))
        {
            header('Location: /stage/files');
            exit;
        }

        if (empty($this->user->stage_card))
        {
            header('Location: /stage/card');
            exit;
        }

        if (!$this->is_developer && empty($this->user->password))
        {
            header('Location: /account/password');
            exit;
        }

        $cards = $this->cards->get_cards(array('user_id'=>$this->user->id));
        foreach ($cards as $key => $card)
        {
            if ($card->deleted)
                unset($cards[$key]);
        }
        $this->design->assign('cards', $cards);

        // подача повторной заявки
        if ($this->request->method('post'))
        {
            if (!empty($_SESSION['looker_mode']))
                return false;

            $user_orders = $this->orders->get_orders(array('user_id'=>$this->user->id));
            $user_order = reset($user_orders);
            if (!empty($user_order) && in_array($user_order->status, array(0, 1, 2, 4, 5)))
            {
                $this->design->assign('error', 'У Вас уже есть активная заявка');
            }
            else
            {
                $amount = $this->request->post('amount', 'integer');
                $period = $this->request->post('period', 'integer');
                $card_id = $this->request->post('card_id', 'integer');

                $service_insurance = $this->request->post('service_insurance', 'integer');
                $service_reason = $this->request->post('service_reason', 'integer');

                $juicescore_session_id = $this->request->post('juicescore_session_id');
                $local_time = $this->request->post('local_time');

                setcookie('loan_amount', null);
                setcookie('loan_period', null);

                $client_status = $this->users->check_client_status($this->user);

                $this->users->update_user($this->user->id, array(
                    'service_insurance' => $service_insurance,
                    'service_reason' => $service_reason,
                    'client_status' => $client_status
                ));

                $order = array(
                    'amount' => $amount,
                    'period' => $period,
                    'card_id' => $card_id,
                    'date' => date('Y-m-d H:i:s'),
                    'user_id' => $this->user->id,
                    'status' => 0,
                    'ip' => $_SERVER['REMOTE_ADDR'],
                    'first_loan' => 0,
                    'juicescore_session_id' => $juicescore_session_id,
                    'local_time' => $local_time,
                    'client_status' => $client_status,
                );

                $order['utm_source']   = (isset($_COOKIE['utm_source'])    && $_COOKIE['utm_source'] != '')   ? $_COOKIE["utm_source"]   : 'organic';
                $order['utm_medium']   = (isset($_COOKIE['utm_medium'])    && $_COOKIE['utm_medium'] != '')   ? $_COOKIE["utm_medium"]   : ' ';
                $order['utm_campaign'] = (isset($_COOKIE['utm_campaign'])  && $_COOKIE['utm_campaign'] != '') ? $_COOKIE["utm_campaign"] : ' ';
                $order['utm_content']  = (isset($_COOKIE['utm_content'])   && $_COOKIE['utm_content'] != '')  ? $_COOKIE["utm_content"]  : ' ';
                $order['utm_term']     = (isset($_COOKIE['utm_term'])      && $_COOKIE['utm_term'] != '')     ? $_COOKIE["utm_term"]     : ' ';

                if (isset($_COOKIE['wm_id']))
                    $order['webmaster_id'] = $_COOKIE["wm_id"];

                if (isset($_COOKIE['clickid']))
                    $order['click_hash'] = $_COOKIE["clickid"];

                // сохраняем историю займов из 1с
                //$credits_history = $this->soap1c->get_client_credits($this->user->UID);
                //$this->users->save_loan_history($this->user->id, $credits_history);


                // проверяем возможность автоповтора
                $order['autoretry'] = 1;

                $order_id = $this->orders->add_order($order);

                // добавляем задание для проведения активных скорингов
                $scoring_types = $this->scorings->get_types();
                foreach ($scoring_types as $scoring_type)
                {
                    if ($scoring_type->active && empty($scoring_type->is_paid))
                    {
                        $add_scoring = array(
                            'user_id' => $this->user->id,
                            'order_id' => $order_id,
                            'type' => $scoring_type->name,
                            'status' => 'new',
                            'created' => date('Y-m-d H:i:s')
                        );
                        $this->scorings->add_scoring($add_scoring);
                    }
                }


                // отправляем заявку в 1с
                $order = $this->orders->get_order((int)$order_id);

                header('Location: /account');
                exit;
            }

        }

        if ($active_contract = $this->contracts->find_active_contracts($this->user->id))
        {
            $order = $this->orders->get_order((int)$active_contract->order_id);
        }
        else
        {
            $orders = $this->orders->get_orders(array('user_id'=>$this->user->id, 'sort'=>'order_id_desc'));

            $order = reset($orders);

        }

        if (!empty($order))
        {
            $order->return_amount = ($order->amount * 0.01 * $order->period) + $order->amount;
            $return_period = date_create();
            date_add($return_period, date_interval_create_from_date_string($order->period.' days'));
            $order->return_period = date_format($return_period, 'Y-m-d H:i:s');
        }
        else
        {
            foreach ($cards as $key => $card)
            {
                if (empty($card->file_id) && empty($card->deleted))
                {
                    header('Location:'.$this->config->root_url.'/card_image/'.$card->id);
                    exit;
                }
            }
        }

        // мараторий
        if (!empty($order) && ($order->status == 3 || $order->status == 8))
        {
            $reason = $this->reasons->get_reason($order->reason_id);
            if ($reason->maratory > 0)
            {
                if ((strtotime($order->reject_date) + $reason->maratory * 86400) > time())
                {
                    $reject_block = date('Y-m-d H:i:s', strtotime($order->reject_date) + $reason->maratory * 86400 + 64800);
                    $this->design->assign('reject_block', $reject_block);
                }
            }
        }

        if (!empty($order->contract_id))
        {
            $order->contract = $this->contracts->get_contract($order->contract_id);

            /*
            if ($order->contract->type == 'onec') {
                $phone = $order->phone_mobile;
                $uid = $order->user_uid;
                $date = date('Ymd');
                $ip = $_SERVER['REMOTE_ADDR'];
                $salt = 'v1XY4b9nM51J';

                $redirect_url = "https://xn--80akilidh4e.xn--p1ai/login/?p=".$order->phone_mobile."&u=".$order->user_uid."&h=".md5(md5($date.$phone.$uid.$ip).$salt);


                file_put_contents('redirect.txt', $redirect_url);
            }
            */


            $prolongation_amount = 0;
            if (!empty($order->contract) && empty($order->contract->hide_prolongation) && $order->contract->collection_status < 8)
            {
                if ($order->contract->type == 'base' && ($order->contract->status == 2 || $order->contract->status == 4)) // выдан
                {
                    if ($order->contract->prolongation < 5 || ($order->contract->prolongation >= 5 && $order->contract->sold))
                    {
                        // сделать проверку что бы в тот же день не было видно пролонгации
                        $prolongation_amount = $order->contract->loan_percents_summ + $order->contract->loan_charge_summ;
                        if (empty($order->contract->sold) && $order->contract->prolongation > 0 && $order->contract->prolongation < 5) // снимаем страховку начиная со 2 пролонгации
                            $prolongation_amount += $this->settings->prolongation_amount;
                    }
                }
            }
            $this->design->assign('prolongation_amount', $prolongation_amount);
            /*
            $inssuance_date = new DateTime();
            $finish_date = new DateTime();
            $finish_date->add(DateInterval::createFromDateString($order->contract->period.' days'));

            $inssuance_date = date_create($order->contract->inssuance_date);
            date_add($inssuance_date, date_interval_create_from_date_string($order->contract->period.' days'));
            $diff_period = date_diff($inssuance_date, );
            $order->contract->return_amount = ($order->contract->loan_body_summ * $order->contract->base_percent * $diff_period) + $order->contract->loan_body_summ + $order->contract->loan_percents_summ;
            */

//            $return_period = date_create($order->contract->inssuance_date);
//            date_add($return_period, date_interval_create_from_date_string($order->contract->period.' days'));
//            $order->contract->return_date = date_format($return_period, 'Y-m-d H:i:s');
        }


        if (!empty($order))
            $this->design->assign('order', $order);

        $need_fields = $this->users->check_fields($this->user);
        $this->design->assign('need_fields', $need_fields);

        $statuses = $this->orders->get_statuses();
        $this->design->assign('statuses', $statuses);

        $min_summ = $this->settings->loan_min_summ;
		$max_summ = $this->settings->loan_max_summ;
        $min_period = $this->settings->loan_min_period;
        $max_period = $this->settings->loan_max_period;
        $current_summ = empty($_COOKIE['loan_summ']) ? $this->settings->loan_default_summ : $_COOKIE['loan_summ'];
        $current_period = empty($_COOKIE['loan_period']) ? $this->settings->loan_default_period : $_COOKIE['loan_period'];
        $loan_percent = $this->settings->loan_default_percent;


        $this->design->assign('min_summ', $min_summ);
        $this->design->assign('max_summ', $max_summ);
        $this->design->assign('min_period', $min_period);
        $this->design->assign('max_period', $max_period);
        $this->design->assign('current_summ', $current_summ);
        $this->design->assign('current_period', $current_period);
        $this->design->assign('loan_percent', $loan_percent);


        // TODO: Сделать проверку на показ формы для нового кредита
        $this->design->assign('form_repeat_order', 1);

        //$hashed_phone = $this->hashids->encode($this->user->phone_mobile);

        $short_reject_link = 'https://t.credits-24.ru/wSzmNB1V?source=finreactor&wmid=button';//'https://finfive.ru/r/'.$hashed_phone;

        $this->design->assign('short_reject_link', $short_reject_link);

        if (isset($this->user->contract) && !in_array($this->user->contract->status, [3,6]) && $this->user->contract->sold)
        {
            if (empty($this->user->contract->premier))
                return $this->design->fetch('account/cession.tpl');
            else
                return $this->design->fetch('account/premier.tpl');
        }
        else
            return $this->design->fetch('account/home.tpl');
    }

}