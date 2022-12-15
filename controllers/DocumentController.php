<?php


error_reporting(-1);

ini_set('display_errors', 'Off');

ini_set('max_execution_time', 120);


class DocumentController extends Controller

{

    public function fetch()

    {

//echo __FILE__.' '.__LINE__.'<br /><pre>';var_dump($document);echo '</pre><hr />';

        if ($this->request->get('action') == 'preview') {

            $this->action_preview();

        }


        $id = $this->request->get('id');

        $id = str_replace('.pdf', '', $id);

        if (empty($id))

            return false;


        if (!($user_id = $this->request->get('user_id', 'integer')))

            return false;


        if (!($document = $this->documents->get_document($id)))

            return false;


        if ($user_id != $document->user_id)

            return false;


        if (!($user = $this->users->get_user($document->user_id)))

            return false;


        if (!empty($document->params)) {

            if(is_string($document->params))
                $document->params = json_decode($document->params, true);

            foreach ($document->params as $param_name => $param_value)

                $this->design->assign($param_name, $param_value);


            $cards = $this->cards->get_cards($document->user_id);

            $active_card = '';


            if (!empty($cards)) {

                foreach ($cards as $card) {

                    if ($card->base_card == 1)

                        $active_card = $card->pan;

                }


                if (!empty($active_card))

                    $short_active_card = substr($active_card, -4);


                $this->design->assign('short_active_card', $short_active_card);

                $this->design->assign('active_card', $active_card);

            }


            $regaddress = $this->Addresses->get_address($user->regaddress_id);
            $this->design->assign('regaddress', $regaddress);

            $faktaddress = $this->Addresses->get_address($user->faktaddress_id);
            $this->design->assign('faktaddress', $faktaddress);

            $regaddress_full = $regaddress->adressfull;
            $this->design->assign('regaddress_full', $regaddress_full);

            $order = $this->orders->get_order($document->params['number']);

            $contract = $this->contracts->get_contract($order->contract_id);
            $this->design->assign('contract', $contract);

            $asp = $contract->accept_code;
            $this->design->assign('asp', $asp);

        }


        if ($document->type == 'IND_USLOVIYA_NL') {

            $tribunal = $this->tribunals->find_tribunal($user->Regregion);

            $this->design->assign('tribunal', $tribunal);

        }


        $tpl = $this->design->fetch('pdf/' . $document->template);


        $this->pdf->create($tpl, $document->name, $document->template);


    }


    private function action_preview()

    {

        $type = $this->request->get('type');

        $type = strtoupper(str_replace('.pdf', '', $type));

        if (empty($type))

            return false;


        if (!($template = $this->documents->get_template($type)))

            return false;


        if (!($template_name = $this->documents->get_template_name($type)))

            return false;


        if (!($contract_id = $this->request->get('contract_id', 'integer')))

            return false;


        if (!($contract = $this->contracts->get_contract($contract_id)))

            return false;


        $ob_date = new DateTime();

        $ob_date->add(DateInterval::createFromDateString($contract->period . ' days'));

        $return_date = $ob_date->format('Y-m-d H:i:s');


        $return_amount = round($contract->amount + $contract->amount * $contract->base_percent * $contract->period / 100, 2);

        $return_amount_rouble = (int)$return_amount;

        $return_amount_kop = ($return_amount - $return_amount_rouble) * 100;


        $contract_order = $this->orders->get_order((int)$contract->order_id);


        $insurance_rate = $this->insurances->get_insurance_rate($contract_order);


        $params = array(

            'lastname' => $contract_order->lastname,

            'firstname' => $contract_order->firstname,

            'patronymic' => $contract_order->patronymic,

            'phone' => $contract_order->phone_mobile,

            'birth' => $contract_order->birth,

            'number' => $contract->number,

            'contract_date' => date('Y-m-d H:i:s'),

            'created' => date('Y-m-d H:i:s'),

            'return_date' => $return_date,

            'return_date_day' => date('d', strtotime($return_date)),

            'return_date_month' => date('m', strtotime($return_date)),

            'return_date_year' => date('Y', strtotime($return_date)),

            'return_amount' => $return_amount,

            'return_amount_rouble' => $return_amount_rouble,

            'return_amount_kop' => $return_amount_kop,

            'base_percent' => $contract->base_percent,

            'amount' => $contract->amount,

            'period' => $contract->period,

            'return_amount_percents' => round($contract->amount * $contract->base_percent * $contract->period / 100, 2),

            'passport_serial' => $contract_order->passport_serial,

            'passport_date' => $contract_order->passport_date,

            'subdivision_code' => $contract_order->subdivision_code,

            'passport_issued' => $contract_order->passport_issued,

            'passport_series' => substr(str_replace(array(' ', '-'), '', $contract_order->passport_serial), 0, 4),

            'passport_number' => substr(str_replace(array(' ', '-'), '', $contract_order->passport_serial), 4, 6),

            'asp' => $contract->accept_code,

        );

        $regaddress_full = empty($contract_order->Regindex) ? '' : $contract_order->Regindex . ', ';

        $regaddress_full .= trim($contract_order->Regregion . ' ' . $contract_order->Regregion_shorttype);

        $regaddress_full .= empty($contract_order->Regcity) ? '' : trim(', ' . $contract_order->Regcity . ' ' . $contract_order->Regcity_shorttype);

        $regaddress_full .= empty($contract_order->Regdistrict) ? '' : trim(', ' . $contract_order->Regdistrict . ' ' . $contract_order->Regdistrict_shorttype);

        $regaddress_full .= empty($contract_order->Reglocality) ? '' : trim(', ' . $contract_order->Reglocality . ' ' . $contract_order->Reglocality_shorttype);

        $regaddress_full .= empty($contract_order->Reghousing) ? '' : ', д.' . $contract_order->Reghousing;

        $regaddress_full .= empty($contract_order->Regbuilding) ? '' : ', стр.' . $contract_order->Regbuilding;

        $regaddress_full .= empty($contract_order->Regroom) ? '' : ', к.' . $contract_order->Regroom;


        $params['regaddress_full'] = $regaddress_full;


        if ($type == 'IND_USLOVIYA_NL') {

            $params['tribunal'] = $this->tribunals->find_tribunal($contract_order->Regregion);

        }


        if ($type == 'POLIS_STRAHOVANIYA') {

            $insurance = new StdClass();


            $insurance->create_date = date('Y-m-d H:i:s');

            $insurance->amount = round($contract->amount * $insurance_rate, 2);

            $insurance->start_date = date('Y-m-d 00:00:00', time() + (1 * 86400));

            $insurance->end_date = date('Y-m-d 23:59:59', time() + (30 * 86400));


            $params['insurance'] = $insurance;

        }


        foreach ($params as $param_name => $param_value)

            $this->design->assign($param_name, $param_value);


        $tpl = $this->design->fetch('pdf/' . $template);


        $this->pdf->create($tpl, $template_name, $template);


    }

}