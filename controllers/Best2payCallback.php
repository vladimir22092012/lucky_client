<?php

class Best2payCallback extends Controller
{
    public function fetch()
    {
        switch ($this->request->get('action', 'string')):

            case 'add_card':
                $this->add_card_action();
                break;

            case 'payment':
                $this->payment_action();
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

        $sector = $this->best2pay->get_sector('PAYMENT');

        if (!empty($register_id)) {
            if ($transaction = $this->transactions->get_register_id_transaction($register_id)) {
                if ($transaction_operation = $this->operations->get_transaction_operation($transaction->id)) {
                    $meta_title = 'Оплата уже принята';
                    $this->design->assign('error', 'Оплата уже принята.');
                } else {
// TODO: сделать запрос в бест2пей и получить успешную операцию
                    if (empty($operation)) {
                        $register_info = $this->best2pay->get_register_info($transaction->sector, $register_id);
                        $xml = simplexml_load_string($register_info);

                        foreach ($xml->operations as $xml_operation)
                            if ($xml_operation->operation->state == 'APPROVED')
                                $operation = (string)$xml_operation->operation->id;
                    }


                    if (!empty($operation)) {
                        $operation_info = $this->best2pay->get_operation_info($transaction->sector, $register_id, $operation);
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
                                'loan_charge_summ' => $contract_loan_charge_summ,
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
                            $contract_loan_charge_summ = round($contract_loan_charge_summ, 2);
                            $contract_loan_body_summ = round($contract_loan_body_summ, 2);
                            if ($contract_loan_body_summ <= 0 && $contract_loan_percents_summ <= 0 && $contract_loan_charge_summ <= 0 && $contract_loan_peni_summ <= 0) {
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
                                'loan_charge_summ' => $contract_loan_charge_summ,
                                'loan_peni_summ' => $contract_loan_peni_summ,
                            ));


                            $meta_title = 'Оплата прошла успешно';
                            $this->design->assign('success', 'Оплата прошла успешно.');


                        } else {
                            $reason_code_description = $this->best2pay->get_reason_code_description($code);
                            $this->design->assign('reason_code_description', $reason_code_description);

                            $meta_title = 'Не удалось оплатить';
                            $this->design->assign('error', 'При оплате произошла ошибка.');
                        }
                        $this->transactions->update_transaction($transaction->id, array(
                            'operation' => $operation,
                            'callback_response' => $operation_info,
                            'reason_code' => $reason_code
                        ));


                    } else {
                        $callback_response = $this->best2pay->get_register_info($transaction->sector, $register_id, $operation);
                        $this->transactions->update_transaction($transaction->id, array(
                            'operation' => 0,
                            'callback_response' => $callback_response
                        ));
                        //echo __FILE__.' '.__LINE__.'<br /><pre>';echo(htmlspecialchars($callback_response));echo '</pre><hr />';
                        $meta_title = 'Не удалось оплатить';
                        $this->design->assign('error', 'При оплате произошла ошибка. Код ошибки: ' . $error);

                    }
                }
            } else {
                $meta_title = 'Ошибка: Транзакция не найдена';
                $this->design->assign('error', 'Ошибка: Транзакция не найдена');
            }


        } else {
            $meta_title = 'Ошибка запроса';
            $this->design->assign('error', 'Ошибка запроса');
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
                    $operation_info = $this->best2pay->get_operation_info($transaction->sector, $register_id, $operation);
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
                        try{
                            $user_id = (int)$xml->reference;
                            $this->Cloudkassir->send_add_card($user_id);

                        }catch (Exception $e)
                        {

                        }

                        $meta_title = 'Карта успешно привязана';
                        $this->design->assign('success', 'Карта успешно привязана.');

                    } else {
                        $reason_code_description = $this->best2pay->get_reason_code_description($code);
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
                    $callback_response = $this->best2pay->get_register_info($transaction->sector, $register_id, $operation);
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
}