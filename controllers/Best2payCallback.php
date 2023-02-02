<?php

class Best2payCallback extends Controller
{
    public function fetch()
    {
        switch ($this->request->get('action')):

            case 'add_card':
                $this->add_card_action();
                break;

            case 'payment':
                $this->payment_action();
                break;

            case 'paymentWithInsurance':
                $this->paymentWithInsurance();
                break;

            case 'recurrent':
                $this->recurrent();
                break;

            default:
                $meta_title = 'Ошибка';
                $this->design->assign('error', 'Ошибка');

        endswitch;

        return $this->design->fetch('best2pay_callback.tpl');
    }

    public function payment_action()
    {
        $register_id = $this->request->get('id', 'integer');
        $operation = $this->request->get('operation', 'integer');
        $reference = $this->request->get('reference', 'integer');
        $error = $this->request->get('error', 'integer');
        $code = $this->request->get('code', 'integer');

        $sector = $this->Bestpay->get_sector('PAYMENT');

        if (!empty($register_id)) {
            if ($transaction = $this->transactions->get_register_id_transaction($register_id)) {
                if ($transaction_operation = $this->operations->get_transaction_operation($transaction->id)) {
                    $meta_title = 'Оплата уже принята';
                    $this->design->assign('error', 'Оплата уже принята.');
                } else {
                    if (empty($operation)) {
                        $register_info = $this->Bestpay->get_register_info($transaction->sector, $register_id);
                        $xml = simplexml_load_string($register_info);

                        foreach ($xml->operations as $xml_operation)
                            if ($xml_operation->operation->state == 'APPROVED')
                                $operation = (string)$xml_operation->operation->id;
                    }


                    if (!empty($operation)) {
                        $operation_info = $this->Bestpay->get_operation_info($transaction->sector, $register_id, $operation);
                        $xml = simplexml_load_string($operation_info);
                        $operation_reference = (string)$xml->reference;
                        $reason_code = (string)$xml->reason_code;
                        $payment_amount = strval($xml->amount) / 100;
                        $operation_date = date('Y-m-d H:i:s', strtotime(str_replace('.', '-', (string)$xml->date)));

                        if ($reason_code == 1) {


                            if (!($contract = $this->contracts->get_contract($transaction->reference)))
                                $contract = $this->contracts->get_number_contract($transaction->reference);

                            $rest_amount = $payment_amount;

                            $contract_order = $this->orders->get_order((int)$contract->order_id);

                            $user = $this->users->get_user($contract_order->user_id);

                            $regaddress = $this->Addresses->get_address($user->regaddress_id);
                            $regaddress_full = $regaddress->adressfull;

                            $passport_series = substr(str_replace(array(' ', '-'), '', $contract_order->passport_serial), 0, 4);
                            $passport_number = substr(str_replace(array(' ', '-'), '', $contract_order->passport_serial), 4, 6);
                            $subdivision_code = $contract_order->subdivision_code;
                            $passport_issued = $contract_order->passport_issued;
                            $passport_date = $contract_order->passport_date;

                            $document_params = array(
                                'lastname' => $contract_order->lastname,
                                'firstname' => $contract_order->firstname,
                                'patronymic' => $contract_order->patronymic,
                                'birth' => $contract_order->birth,
                                'phone' => $contract_order->phone_mobile,
                                'regaddress_full' => $regaddress_full,
                                'passport_series' => $passport_series,
                                'passport_number' => $passport_number,
                                'passport_serial' => $contract_order->passport_serial,
                                'subdivision_code' => $subdivision_code,
                                'passport_issued' => $passport_issued,
                                'passport_date' => $passport_date,
                                'asp' => $transaction->sms,
                                'created' => date('Y-m-d H:i:s'),
                                'base_percent' => $contract->base_percent,
                                'amount' => $contract->amount,
                                'number' => $contract->number,
                                'order_created' => $contract_order->date,

                            );

                            if (!empty($transaction->prolongation) && $payment_amount >= $contract->loan_percents_summ) {

                                $new_return_date = date('Y-m-d H:i:s', time() + 86400 * $this->settings->prolongation_period);

                                $document_params['return_date'] = $new_return_date;
                                $document_params['return_date_day'] = date('d', strtotime($new_return_date));
                                $document_params['return_date_month'] = date('m', strtotime($new_return_date));
                                $document_params['return_date_year'] = date('Y', strtotime($new_return_date));
                                $document_params['period'] = $this->settings->prolongation_period;

                                // продлеваем контракт
                                $this->contracts->update_contract($contract->id, array(
                                    'return_date' => $new_return_date,
                                    'prolongation' => $contract->prolongation + 1,
                                    'status' => 2
                                ));

                                //Создаем пролонгацию и записываем в нее айди страховки
                                $this->prolongations->add_prolongation(array(
                                    'contract_id' => $contract->id,
                                    'user_id' => $contract->user_id,
                                    'insurance_id' => empty($insurance_id) ? '' : $insurance_id,
                                    'created' => date('Y-m-d H:i:s'),
                                    'accept_code' => $transaction->sms,
                                    'transaction_id' => $transaction->id,
                                ));
                            }
                        } else {
                            $this->transactions->update_transaction($transaction->id, array('prolongation' => 0));
                        }

                        // списываем проценты
                        $contract_loan_percents_summ = (float)$contract->loan_percents_summ;
                        if ($contract->loan_percents_summ > 0) {
                            if ($rest_amount >= $contract->loan_percents_summ) {
                                $contract_loan_percents_summ = 0;
                                $rest_amount = $rest_amount - $contract->loan_percents_summ;
                                $transaction_loan_percents_summ = $contract->loan_percents_summ;
                            } else {
                                $contract_loan_percents_summ = $contract->loan_percents_summ - $rest_amount;
                                $transaction_loan_percents_summ = $rest_amount;
                                $rest_amount = 0;
                            }
                        }

                        // списываем основной долг
                        $contract_loan_body_summ = (float)$contract->loan_body_summ;
                        if ($contract->loan_body_summ > 0) {
                            if ($rest_amount >= $contract->loan_body_summ) {
                                $contract_loan_body_summ = 0;
                                $rest_amount = $rest_amount - $contract->loan_body_summ;
                                $transaction_loan_body_summ = $contract->loan_body_summ;
                            } else {
                                $contract_loan_body_summ = $contract->loan_body_summ - $rest_amount;
                                $transaction_loan_body_summ = $rest_amount;
                                $rest_amount = 0;
                            }
                        }

                        $contract_loan_peni_summ = (float)$contract->loan_peni_summ;
                        if ($contract->loan_peni_summ > 0) {
                            if ($rest_amount >= $contract->loan_peni_summ) {
                                $contract_loan_peni_summ = 0;
                                $rest_amount = $rest_amount - $contract->loan_peni_summ;
                                $transaction_loan_peni_summ = $contract->loan_peni_summ;
                            } else {
                                $contract_loan_peni_summ = $contract->loan_peni_summ - $rest_amount;
                                $transaction_loan_peni_summ = $rest_amount;
                                $rest_amount = 0;
                            }
                        }

                        $this->contracts->update_contract($contract->id, array(
                            'loan_percents_summ' => $contract_loan_percents_summ,
                            'loan_peni_summ' => $contract_loan_peni_summ,
                            'loan_body_summ' => $contract_loan_body_summ,
                        ));

                        $this->transactions->update_transaction($transaction->id, array(
                            'loan_percents_summ' => empty($transaction_loan_percents_summ) ? 0 : $transaction_loan_percents_summ,
                            'loan_charge_summ' => empty($transaction_loan_charge_summ) ? 0 : $transaction_loan_charge_summ,
                            'loan_peni_summ' => empty($transaction_loan_peni_summ) ? 0 : $transaction_loan_peni_summ,
                            'loan_body_summ' => empty($transaction_loan_body_summ) ? 0 : $transaction_loan_body_summ,
                        ));

                        // закрываем кредит
                        $contract_loan_peni_summ = round($contract_loan_peni_summ, 2);
                        $contract_loan_percents_summ = round($contract_loan_percents_summ, 2);
                        $contract_loan_body_summ = round($contract_loan_body_summ, 2);
                        if ($contract_loan_body_summ <= 0 && $contract_loan_percents_summ <= 0 && $contract_loan_peni_summ <= 0) {
                            $this->contracts->update_contract($contract->id, array(
                                'status' => 3,
                                'collection_status' => 0,
                                'close_date' => date('Y-m-d H:i:s'),
                            ));

                            $this->orders->update_order($contract->order_id, array(
                                'status' => 7
                            ));
                        }


                        $operation_id = $this->operations->add_operation(array(
                            'contract_id' => $contract->id,
                            'user_id' => $contract->user_id,
                            'order_id' => $contract->order_id,
                            'type' => 'PAY',
                            'amount' => $payment_amount,
                            'created' => $operation_date,
                            'transaction_id' => $transaction->id,
                            'loan_body_summ' => $contract_loan_body_summ,
                            'loan_percents_summ' => $contract_loan_percents_summ,
                            'loan_peni_summ' => $contract_loan_peni_summ,
                        ));

                        //Отправляем платежку в 1с
                        $payment =
                            [
                                'id' => $operation_id,
                                'order_id' => $contract->order_id,
                                'prolongation' => $transaction->prolongation,
                                'od' => empty($transaction_loan_body_summ) ? 0 : $transaction_loan_body_summ,
                                'prc' => empty($transaction_loan_percents_summ) ? 0 : $transaction_loan_percents_summ,
                                'peni' => empty($transaction_loan_peni_summ) ? 0 : $transaction_loan_peni_summ
                            ];

                        $this->Soap1c->send_payment($payment);


                        $meta_title = 'Оплата прошла успешно';
                        $this->design->assign('success', 'Оплата прошла успешно.');

                        if (!empty($transaction->prolongation) && $payment_amount >= $contract->loan_percents_summ) {

                            $return_amount = round($contract_loan_body_summ + $contract_loan_body_summ * $contract->base_percent * $this->settings->prolongation_period / 100, 2);
                            $return_amount_percents = round($contract_loan_body_summ * $contract->base_percent * $this->settings->prolongation_period / 100, 2);

                            $document_params['return_amount'] = $return_amount;
                            $document_params['return_amount_percents'] = $return_amount_percents;

                            $document_params['amount'] = $contract_loan_body_summ;

                            // дополнительное соглашение
                            $this->documents->create_document(array(
                                'user_id' => $contract->user_id,
                                'order_id' => $contract->order_id,
                                'contract_id' => $contract->id,
                                'type' => 'DOP_SOGLASHENIE',
                                'params' => $document_params
                            ));
                        }


                    } else {
                        $reason_code_description = $this->BestPay->get_reason_code_description($code);
                        $this->design->assign('reason_code_description', $reason_code_description);

                        $this->design->assign('error', 'При оплате произошла ошибка.');
                    }
                    $this->transactions->update_transaction($transaction->id, array(
                        'operation' => $operation,
                        'callback_response' => $register_info,
                        'reason_code' => $reason_code
                    ));


                }
            }
        } else {
            $this->design->assign('error', 'Ошибка: Транзакция не найдена');
        }


    }

    public function recurrent()
    {

    }

    public function add_card_action()
    {
        $register_id = $this->request->get('id', 'integer');
        $operation = $this->request->get('operation', 'integer');
        $reference = $this->request->get('reference', 'integer');
        $error = $this->request->get('error', 'integer');
        $code = $this->request->get('code', 'integer');

        if (!empty($register_id)) {
            if ($transaction = $this->transactions->get_register_id_transaction($register_id)) {
                if (!empty($operation)) {
                    $operation_info = $this->Bestpay->get_operation_info($transaction->sector, $register_id, $operation);
                    $xml = simplexml_load_string($operation_info);
                    $operation_reference = (string)$xml->reference;
                    $reason_code = (string)$xml->reason_code;
                    $operation_state = (string)$xml->state;

//echo __FILE__.' '.__LINE__.'<br /><pre>';echo(htmlspecialchars($operation_info));echo '</pre><hr />';

                    if ($operation_state == 'APPROVED') {

                        $card = array(
                            'user_id' => (string)$xml->reference,
                            'name' => (string)$xml->name,
                            'sector' => $transaction->sector,
                            'pan' => (string)$xml->pan,
                            'expdate' => (string)$xml->expdate,
                            'approval_code' => (string)$xml->approval_code,
                            'token' => (string)$xml->token,
                            'operation_date' => str_replace('.', '-', (string)$xml->date),
                            'created' => date('Y-m-d H:i:s'),
                            'operation' => $xml->order_id,
                            'register_id' => $transaction->register_id,
                            'transaction_id' => $transaction->id,
                            'bin_issuer' => (string)$xml->bin_issuer,
                        );
//echo __FILE__.' '.__LINE__.'<br /><pre>';var_dump($card);echo '</pre><hr />';
                        $cardId = $this->cards->add_card($card);
                        $this->design->assign('cardId', $cardId);
                        try {
                            $user_id = (int)$xml->reference;
                            $this->Cloudkassir->send_add_card($user_id);

                        } catch (Exception $e) {

                        }

                        $meta_title = 'Карта успешно привязана';
                        $this->design->assign('success', 'Карта успешно привязана.');

                    } else {
                        $reason_code_description = $this->Bestpay->get_reason_code_description($code);
                        $this->design->assign('reason_code_description', $reason_code_description);

                        $meta_title = 'Не удалось привязать карту';
                        $this->design->assign('error', 'При привязке карты произошла ошибка.');
                    }
                    $this->transactions->update_transaction($transaction->id, array(
                        'operation' => $operation,
                        'callback_response' => $operation_info,
                        'reason_code' => $reason_code
                    ));


                } else {
                    $callback_response = $this->Bestpay->get_register_info($transaction->sector, $register_id, $operation);
                    $this->transactions->update_transaction($transaction->id, array(
                        'operation' => 0,
                        'callback_response' => $callback_response
                    ));
//echo __FILE__.' '.__LINE__.'<br /><pre>';echo(htmlspecialchars($callback_response));echo '</pre><hr />';
                    $meta_title = 'Не удалось привязать карту';
                    $this->design->assign('error', 'При привязке карты произошла ошибка. Код ошибки: ' . $error);

                }
            } else {
                $meta_title = 'Ошибка: Транзакция не найдена';
                $this->design->assign('error', 'Ошибка: Транзакция не найдена');
            }


        } else {
            $meta_title = 'Ошибка запроса';
            $this->design->assign('error', 'Ошибка запроса');
        }

//echo __FILE__.' '.__LINE__.'<br /><pre>';var_dump($_GET);echo '</pre><hr />';

    }

    private function paymentWithInsurance()
    {
        $register_id = $this->request->get('id', 'integer');
        $operation = $this->request->get('operation', 'integer');
        $code = $this->request->get('code', 'integer');
        if (!empty($register_id)) {
            if ($transaction = $this->transactions->get_register_id_transaction($register_id)) {
                if ($transaction_operation = $this->operations->get_transaction_operation($transaction->id)) {
                    $this->design->assign('error', 'Оплата уже принята.');
                } else {
                    if (empty($operation)) {
                        $register_info = $this->Bestpay->get_register_info($transaction->sector, $register_id);
                        $xml = simplexml_load_string($register_info);

                        foreach ($xml->operations as $xml_operation)
                            if ($xml_operation->operation->state == 'APPROVED')
                                $operation = (string)$xml_operation->operation->id;
                    }


                    if (!empty($operation)) {
                        $operation_info = $this->Bestpay->get_operation_info($transaction->sector, $register_id, $operation);
                        $xml = simplexml_load_string($operation_info);
                        $reason_code = (string)$xml->reason_code;
                        $payment_amount = strval($xml->amount) / 100;
                        $operation_date = date('Y-m-d H:i:s', strtotime(str_replace('.', '-', (string)$xml->date)));

                        if ($reason_code == 1) {

                            if (!($contract = $this->contracts->get_contract($transaction->reference)))
                                $contract = $this->contracts->get_number_contract($transaction->reference);

                            $rest_amount = $payment_amount - $this->settings->prolongation_amount;

                            $contract_order = $this->orders->get_order((int)$contract->order_id);

                            $user = $this->users->get_user($contract_order->user_id);

                            $regaddress = $this->Addresses->get_address($user->regaddress_id);
                            $regaddress_full = $regaddress->adressfull;

                            $passport_series = substr(str_replace(array(' ', '-'), '', $contract_order->passport_serial), 0, 4);
                            $passport_number = substr(str_replace(array(' ', '-'), '', $contract_order->passport_serial), 4, 6);
                            $subdivision_code = $contract_order->subdivision_code;
                            $passport_issued = $contract_order->passport_issued;
                            $passport_date = $contract_order->passport_date;

                            $document_params = array(
                                'lastname' => $contract_order->lastname,
                                'firstname' => $contract_order->firstname,
                                'patronymic' => $contract_order->patronymic,
                                'birth' => $contract_order->birth,
                                'phone' => $contract_order->phone_mobile,
                                'regaddress_full' => $regaddress_full,
                                'passport_series' => $passport_series,
                                'passport_number' => $passport_number,
                                'passport_serial' => $contract_order->passport_serial,
                                'subdivision_code' => $subdivision_code,
                                'passport_issued' => $passport_issued,
                                'passport_date' => $passport_date,
                                'asp' => $transaction->sms,
                                'created' => date('Y-m-d H:i:s'),
                                'base_percent' => $contract->base_percent,
                                'amount' => $contract->amount,
                                'number' => $contract->number,
                                'order_created' => $contract_order->date,

                            );

                            $new_return_date = date('Y-m-d H:i:s', time() + 86400 * $this->settings->prolongation_period);
                            $document_params['return_date'] = $new_return_date;
                            $document_params['return_date_day'] = date('d', strtotime($new_return_date));
                            $document_params['return_date_month'] = date('m', strtotime($new_return_date));
                            $document_params['return_date_year'] = date('Y', strtotime($new_return_date));
                            $document_params['period'] = $this->settings->prolongation_period;

                            // списываем проценты
                            $contract_loan_percents_summ = (float)$contract->loan_percents_summ;
                            if ($contract->loan_percents_summ > 0) {
                                if ($rest_amount >= $contract->loan_percents_summ) {
                                    $contract_loan_percents_summ = 0;
                                    $rest_amount = $rest_amount - $contract->loan_percents_summ;
                                    $transaction_loan_percents_summ = $contract->loan_percents_summ;
                                } else {
                                    $contract_loan_percents_summ = $contract->loan_percents_summ - $rest_amount;
                                    $transaction_loan_percents_summ = $rest_amount;
                                    $rest_amount = 0;
                                }
                            }

                            // списываем основной долг
                            $contract_loan_body_summ = (float)$contract->loan_body_summ;
                            if ($contract->loan_body_summ > 0) {
                                if ($rest_amount >= $contract->loan_body_summ) {
                                    $contract_loan_body_summ = 0;
                                    $rest_amount = $rest_amount - $contract->loan_body_summ;
                                    $transaction_loan_body_summ = $contract->loan_body_summ;
                                } else {
                                    $contract_loan_body_summ = $contract->loan_body_summ - $rest_amount;
                                    $transaction_loan_body_summ = $rest_amount;
                                    $rest_amount = 0;
                                }
                            }

                            $contract_loan_peni_summ = (float)$contract->loan_peni_summ;
                            if ($contract->loan_peni_summ > 0) {
                                if ($rest_amount >= $contract->loan_peni_summ) {
                                    $contract_loan_peni_summ = 0;
                                    $rest_amount = $rest_amount - $contract->loan_peni_summ;
                                    $transaction_loan_peni_summ = $contract->loan_peni_summ;
                                } else {
                                    $contract_loan_peni_summ = $contract->loan_peni_summ - $rest_amount;
                                    $transaction_loan_peni_summ = $rest_amount;
                                    $rest_amount = 0;
                                }
                            }

                            $this->contracts->update_contract($contract->id, array(
                                'loan_percents_summ' => $contract_loan_percents_summ,
                                'loan_peni_summ' => $contract_loan_peni_summ,
                                'loan_body_summ' => $contract_loan_body_summ,
                            ));

                            $this->transactions->update_transaction($transaction->id, array(
                                'loan_percents_summ' => empty($transaction_loan_percents_summ) ? 0 : $transaction_loan_percents_summ,
                                'loan_charge_summ' => empty($transaction_loan_charge_summ) ? 0 : $transaction_loan_charge_summ,
                                'loan_peni_summ' => empty($transaction_loan_peni_summ) ? 0 : $transaction_loan_peni_summ,
                                'loan_body_summ' => empty($transaction_loan_body_summ) ? 0 : $transaction_loan_body_summ,
                            ));

                            // закрываем кредит
                            $contract_loan_peni_summ = round($contract_loan_peni_summ, 2);
                            $contract_loan_percents_summ = round($contract_loan_percents_summ, 2);
                            $contract_loan_body_summ = round($contract_loan_body_summ, 2);
                            if ($contract_loan_body_summ <= 0 && $contract_loan_percents_summ <= 0 && $contract_loan_peni_summ <= 0) {
                                $this->contracts->update_contract($contract->id, array(
                                    'status' => 3,
                                    'collection_status' => 0,
                                    'close_date' => date('Y-m-d H:i:s'),
                                ));

                                $this->orders->update_order($contract->order_id, array(
                                    'status' => 7
                                ));
                            }


                            $this->operations->add_operation(array(
                                'contract_id' => $contract->id,
                                'user_id' => $contract->user_id,
                                'order_id' => $contract->order_id,
                                'type' => 'PAY',
                                'amount' => $payment_amount,
                                'created' => $operation_date,
                                'transaction_id' => $transaction->id,
                                'loan_body_summ' => $contract_loan_body_summ,
                                'loan_percents_summ' => $contract_loan_percents_summ,
                                'loan_peni_summ' => $contract_loan_peni_summ,
                            ));

                            $operation_id = $this->operations->add_operation(array(
                                'contract_id' => $contract->id,
                                'user_id' => $contract->user_id,
                                'order_id' => $contract->order_id,
                                'transaction_id' => $transaction->id,
                                'type' => 'INSURANCE_REGULAR',
                                'amount' => $this->settings->prolongation_amount,
                                'created' => date('Y-m-d H:i:s'),
                                'sent_status' => 0,
                            ));

                            $insurance_id = $this->insurances->add_insurance(array(
                                'number' => '',
                                'amount' => $this->settings->prolongation_amount,
                                'user_id' => $contract->user_id,
                                'order_id' => $contract->order_id,
                                'create_date' => date('Y-m-d H:i:s'),
                                'start_date' => date('Y-m-d 00:00:00', time() + (1 * 86400)),
                                'end_date' => date('Y-m-d 23:59:59', time() + (31 * 86400)),
                                'operation_id' => $operation_id,
                                'protection' => 0,
                            ));

                            $this->transactions->update_transaction($transaction->id, array('insurance_id' => $insurance_id));

                            $document_params['insurance'] = $this->insurances->get_insurance($insurance_id);

                            $this->documents->create_document(array(
                                'user_id' => $contract->user_id,
                                'order_id' => $contract->order_id,
                                'contract_id' => $contract->id,
                                'type' => 'POLIS_STRAHOVANIYA',
                                'params' => $document_params
                            ));

                            $this->design->assign('success', 'Оплата прошла успешно.');

                        } else {
                            $reason_code_description = $this->BestPay->get_reason_code_description($code);
                            $this->design->assign('reason_code_description', $reason_code_description);

                            $this->design->assign('error', 'При оплате произошла ошибка.');
                        }
                        $this->transactions->update_transaction($transaction->id, array(
                            'operation' => $operation,
                            'callback_response' => $register_info,
                            'reason_code' => $reason_code
                        ));


                    }
                }
            } else {
                $this->design->assign('error', 'Ошибка: Транзакция не найдена');
            }
        }
    }
}