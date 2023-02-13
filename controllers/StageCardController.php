<?php

class StageCardController extends Controller
{
    public function fetch()
    {
        if (empty($this->user)) {
            header('Location: /lk/login');
            exit;
        }

        if (!empty($this->user->stage_card)) {
            header('Location: /account');
            exit;
        }

        if (empty($this->user->stage_files)) {
            header('Location: /stage/files');
            exit;
        }

        if ($this->request->get('step') == 'prev') {
            $this->users->update_user($this->user->id, array('stage_files' => 0));
            header('Location: /stage/files');
            exit;
        }

        if ($cards = $this->cards->get_cards(array('user_id' => $this->user->id))) {
            $card = reset($cards);

            // устанавливаем карту как основную
            if (count($cards) > 1) {
                $have_base_card = 0;
                foreach ($cards as $c)
                    if (!empty($c->base_card))
                        $have_base_card = 1;
                if (empty($have_base_card))
                    $this->cards->update_card($card->id, array('base_card' => 1));
            } else {
                $file_id = 1;
                foreach ($this->users->get_files(array('user_id' => $this->user->id)) as $f)
                    if ($f->type == 'card')
                        $file_id = $f->id;
                $this->cards->update_card($card->id, array('base_card' => 1, 'file_id' => $file_id));

            }

            $order = array(
                'card_id' => $card->id,
                'user_id' => $this->user->id,
                'ip' => $_SERVER['REMOTE_ADDR'],
                'amount' => $this->user->first_loan_amount,
                'period' => $this->user->first_loan_period,
                'first_loan' => 1,
                'date' => date('Y-m-d H:i:s'),
                'local_time' => $this->user->last_local_time,
                'juicescore_session_id' => $this->user->juicescore_session_id,
                'accept_sms' => $this->user->sms,
                'client_status' => 'nk',
            );


            $order['utm_source']   = (isset($_COOKIE['utm_source']))   ? $_COOKIE["utm_source"]   : null;
            $order['utm_medium']   = (isset($_COOKIE['utm_medium']))   ? $_COOKIE["utm_medium"]   : null;
            $order['utm_campaign'] = (isset($_COOKIE['utm_campaign'])) ? $_COOKIE["utm_campaign"] : null;
            $order['utm_content']  = (isset($_COOKIE['utm_content']))  ? $_COOKIE["utm_content"]  : null;
            $order['utm_term']     = (isset($_COOKIE['utm_term']))     ? $_COOKIE["utm_term"]     : null;

            if (isset($_COOKIE['click_id']))
                $order['click_hash'] = $_COOKIE["click_id"];

            $order['autoretry'] = 1;
            
            $order_id = $this->orders->add_order($order);

            if($order['utm_source'] =='guruleads')
                $this->Gurulead->sendPendingPostback($order_id);

            $equiReport = EquifaxFactory::get('pending');
            $equiReport->processing($order_id);

//            70093bcc-3a3f-11eb-9983-00155d2d0507
            $uid = 'a0' . $order_id . '-' . date('Y') . '-' . date('md') . '-' . date('Hi') . '-01771ca07de7';
            $this->users->update_user($this->user->id, array(
                'stage_card' => 1,
                'UID' => $uid,
                'card_added_date' => date('Y-m-d H:i:s'),
            ));

            // добавляем задание для проведения активных скорингов
            $scoring_types = $this->scorings->get_types();
            foreach ($scoring_types as $scoring_type) {
                if ($scoring_type->active && empty($scoring_type->is_paid)) {
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


            /** ******** создаем доки ********* **/
            list($passport_number, $passport_serial) = explode('-', $this->user->passport_serial);
            $params = array(
                'lastname' => $this->user->lastname,
                'firstname' => $this->user->firstname,
                'patronymic' => $this->user->patronymic,
                'gender' => $this->user->gender,
                'phone' => $this->user->phone_mobile,
                'birth' => $this->user->birth,
                'birth_place' => $this->user->birth_place,
                'inn' => $this->user->inn,
                'snils' => $this->user->snils,
                'email' => $this->user->email,
                'created' => $this->user->created,

                'passport_serial' => $passport_serial,
                'passport_number' => $passport_number,
                'passport_date' => $this->user->passport_date,
                'passport_code' => $this->user->subdivision_code,
                'passport_issued' => $this->user->passport_issued,

                'regindex' => $this->user->Regindex,
                'regregion' => $this->user->Regregion,
                'regcity' => $this->user->Regcity,
                'regstreet' => $this->user->Regstreet,
                'reghousing' => $this->user->Reghousing,
                'regbuilding' => $this->user->Regbuilding,
                'regroom' => $this->user->Regroom,
                'faktindex' => $this->user->Faktindex,
                'faktregion' => $this->user->Faktregion,
                'faktcity' => $this->user->Faktcity,
                'faktstreet' => $this->user->Faktstreet,
                'fakthousing' => $this->user->Fakthousing,
                'faktbuilding' => $this->user->Faktbuilding,
                'faktroom' => $this->user->Faktroom,

                'profession' => $this->user->profession,
                'workplace' => $this->user->workplace,
                'workphone' => $this->user->workphone,
                'chief_name' => $this->user->chief_name,
                'chief_position' => $this->user->chief_position,
                'chief_phone' => $this->user->chief_phone,
                'income' => $this->user->income,
                'expenses' => $this->user->expenses,

                'first_loan_amount' => $this->user->first_loan_amount,
                'first_loan_period' => $this->user->first_loan_period,

                'number' => $order->order_id,
                'create_date' => $order->date,
                'asp' => $this->user->sms,
            );
            if (!empty($this->user->contact_person_name)) {
                $params['contactperson_phone'] = $this->user->contact_person_phone;

                $contact_person_name = explode(' ', $this->user->contact_person_name);
                $params['contactperson_name'] = $this->user->contact_person_name;
                $params['contactperson_lastname'] = isset($contact_person_name[0]) ? $contact_person_name[0] : '';
                $params['contactperson_firstname'] = isset($contact_person_name[1]) ? $contact_person_name[1] : '';
                $params['contactperson_patronymic'] = isset($contact_person_name[2]) ? $contact_person_name[2] : '';
            }
            if (!empty($this->user->contact_person2_name)) {
                $params['contactperson2_phone'] = $this->user->contact_person_phone;

                $contact_person2_name = explode(' ', $this->user->contact_person2_name);
                $params['contactperson2_name'] = $this->user->contact_person2_name;
                $params['contactperson2_lastname'] = isset($contact_person2_name[0]) ? $contact_person2_name[0] : '';
                $params['contactperson2_firstname'] = isset($contact_person2_name[1]) ? $contact_person2_name[1] : '';
                $params['contactperson2_patronymic'] = isset($contact_person2_name[2]) ? $contact_person2_name[2] : '';
            }
            // анкета заявление
            $this->documents->create_document(array(
                'user_id' => $this->user->id,
                'order_id' => 0,
                'type' => 'ANKETA_PEP',
                'params' => $params,
            ));

            // соглашение пэп
            $this->documents->create_document(array(
                'user_id' => $this->user->id,
                'order_id' => 0,
                'type' => 'SOLGLASHENIE_PEP',
                'params' => $params,
            ));

            // согласие ОПД
            $this->documents->create_document(array(
                'user_id' => $this->user->id,
                'order_id' => 0,
                'type' => 'SOGLASIE_VZAIMODEYSTVIE',
                'params' => $params,
            ));

            // согласие на взаимодействие
            $this->documents->create_document(array(
                'user_id' => $this->user->id,
                'order_id' => 0,
                'type' => 'TRETI_LICA',
                'params' => $params,
            ));

            // согласие на списание
            $this->documents->create_document(array(
                'user_id' => $this->user->id,
                'order_id' => 0,
                'type' => 'SOGLASIE_SPISANIE',
                'params' => $params,
            ));

            // согласие на уведомлеие о ПДН
            $this->documents->create_document(array(
                'user_id' => $this->user->id,
                'order_id' => 0,
                'type' => 'PDN',
                'params' => $params,
            ));

            header('Location: /account');
            exit;
        }

        return $this->design->fetch('stage/card.tpl');
    }

    private function create_documents()
    {

    }

}