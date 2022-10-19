<?php

class BestpayCallback extends Controller
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

        return $this->design->fetch('Bestpay_callback.tpl');
    }
    
    public function payment_action()
    {
        $register_id = $this->request->get('id', 'integer');
        $operation = $this->request->get('operation', 'integer');
        $reference = $this->request->get('reference', 'integer');
        $error = $this->request->get('error', 'integer');
        $code = $this->request->get('code', 'integer');
        
        $sector = $this->Bestpay->get_sector('PAYMENT');
        

        if (!empty($register_id))
        {
            if ($transaction = $this->transactions->get_register_id_transaction($register_id))
            {
                if ($transaction_operation = $this->operations->get_transaction_operation($transaction->id))
                {
                    $meta_title = 'Оплата уже принята';
                    $this->design->assign('error', 'Оплата уже принята.');                    
                }
                else
                {
// TODO: сделать запрос в бест2пей и получить успешную операцию
        
                    if (!empty($operation))
                    {
                        $operation_info = $this->Bestpay->get_operation_info($transaction->sector, $register_id, $operation);
                        $xml = simplexml_load_string($operation_info);
                        $operation_reference = (string)$xml->reference;
                        $reason_code = (string)$xml->reason_code;
                        $payment_amount = strval($xml->amount) / 100;
    
    //echo __FILE__.' '.__LINE__.'<br /><pre>';echo(htmlspecialchars($operation_info));echo '</pre><hr />';
                        
                        if ($reason_code == 1)
                        {
                            
                            
                            if (!($contract = $this->contracts->get_contract($transaction->reference)))
                                $contract = $this->contracts->get_number_contract($transaction->reference);
                                
                            $rest_amount = $payment_amount;
                            
                            $contract_order = $this->orders->get_order((int)$contract->order_id);
                            
                            $regaddress_full = empty($contract_order->Regindex) ? '' : $contract_order->Regindex.', ';
                            $regaddress_full .= trim($contract_order->Regregion.' '.$contract_order->Regregion_shorttype);
                            $regaddress_full .= empty($contract_order->Regcity) ? '' : trim(', '.$contract_order->Regcity.' '.$contract_order->Regcity_shorttype);
                            $regaddress_full .= empty($contract_order->Regdistrict) ? '' : trim(', '.$contract_order->Regdistrict.' '.$contract_order->Regdistrict_shorttype);
                            $regaddress_full .= empty($contract_order->Reglocality) ? '' : trim(', '.$contract_order->Reglocality.' '.$contract_order->Reglocality_shorttype);
                            $regaddress_full .= empty($contract_order->Reghousing) ? '' : ', д.'.$contract_order->Reghousing;
                            $regaddress_full .= empty($contract_order->Regbuilding) ? '' : ', стр.'.$contract_order->Regbuilding;
                            $regaddress_full .= empty($contract_order->Regroom) ? '' : ', к.'.$contract_order->Regroom;
                    
                            $document_params = array(
                                'lastname' => $contract_order->lastname,
                                'firstname' => $contract_order->firstname,
                                'patronymic' => $contract_order->patronymic,
                                'birth' => $contract_order->birth,
                                'phone' => $contract_order->phone_mobile,
                                'regaddress_full' => $regaddress_full,
                                'passport_series' => substr(str_replace(array(' ', '-'), '', $contract_order->passport_serial), 0, 4),
                                'passport_number' => substr(str_replace(array(' ', '-'), '', $contract_order->passport_serial), 4, 6),
                                'asp' => $transaction->sms,
                                'created' => date('Y-m-d H:i:s'),
                                'base_percent' => $contract->base_percent,
                                'amount' => $contract->amount,
                                'number' => $contract->number,
                                
                            );
    
                            if (!empty($transaction->prolongation))
                            {
                                $new_return_date = date('Y-m-d H:i:s', time() + 86400 * $this->settings->prolongation_period);
                                
                                $document_params['return_date'] = $new_return_date;
                                $document_params['return_date_day'] = date('d', strtotime($new_return_date));
                                $document_params['return_date_month'] = date('m', strtotime($new_return_date));
                                $document_params['return_date_year'] = date('Y', strtotime($new_return_date));
                                
                                if (!empty($contract->prolongation)) // если это не первая пролонгация то делаем страховку
                                {
                                    $insurance_id = $this->insurances->add_insurance(array(
                                        'amount' => $this->settings->prolongation_amount,
                                        'user_id' => $contract->user_id,
                                        'create_date' => date('Y-m-d H:i:s'),
                                        'start_date' => date('Y-m-d H:i:s'),
                                        'end_date' => $new_return_date,
                                        'transaction_id' => $transaction->id,
                                    ));
                                
                                                                    
                                    $rest_amount = $rest_amount - $this->settings->prolongation_amount;
                                }
                                // продлеваем контракт
                                $this->contracts->update_contract($contract->id, array(
                                    'return_date' => $new_return_date,
                                    'prolongation' => $contract->prolongation + 1,
                                    'collection_status' => 0,
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
                            
                            // списываем ответсвенность
                            $contract_loan_charge_summ = (float)$contract->loan_charge_summ;
                            if ($contract->loan_charge_summ > 0)
                            {
                                if ($rest_amount >= $contract->loan_charge_summ)
                                {
                                    $contract_loan_charge_summ = 0;
                                    $rest_amount = $rest_amount - $contract->loan_charge_summ;
                                    $transaction_loan_charge_summ = $contract->loan_charge_summ;
                                }
                                else
                                {
                                    $contract_loan_charge_summ  = $contract->loan_charge_summ - $rest_amount;
                                    $transaction_loan_charge_summ = $rest_amount;
                                    $rest_amount = 0;
                                }
                            }
                            
                            // списываем проценты
                            $contract_loan_percents_summ = (float)$contract->loan_percents_summ;
                            if ($contract->loan_percents_summ > 0)
                            {
                                if ($rest_amount >= $contract->loan_percents_summ)
                                {
                                    $contract_loan_percents_summ = 0;
                                    $rest_amount = $rest_amount - $contract->loan_percents_summ;
                                    $transaction_loan_percents_summ = $contract->loan_percents_summ;
                                }
                                else
                                {
                                    $contract_loan_percents_summ  = $contract->loan_percents_summ - $rest_amount;
                                    $transaction_loan_percents_summ = $rest_amount;
                                    $rest_amount = 0;
                                }
                            }
                            
                            // списываем основной долг
                            $contract_loan_body_summ = (float)$contract->loan_body_summ;
                            if ($contract->loan_body_summ > 0)
                            {
                                if ($rest_amount >= $contract->loan_body_summ)
                                {
                                    $contract_loan_body_summ = 0;
                                    $rest_amount = $rest_amount - $contract->loan_body_summ;
                                    $transaction_loan_body_summ = $contract->loan_body_summ;
                                }
                                else
                                {
                                    $contract_loan_body_summ  = $contract->loan_body_summ - $rest_amount;
                                    $transaction_loan_body_summ = $rest_amount;
                                    $rest_amount = 0;
                                }
                            }
                            
                            $contract_loan_peni_summ = (float)$contract->loan_peni_summ;
                            if ($contract->loan_peni_summ > 0)
                            {
                                if ($rest_amount >= $contract->loan_peni_summ)
                                {
                                    $contract_loan_peni_summ = 0;
                                    $rest_amount = $rest_amount - $contract->loan_peni_summ;
                                    $transaction_loan_peni_summ = $contract->loan_peni_summ;
                                }
                                else
                                {
                                    $contract_loan_peni_summ  = $contract->loan_peni_summ - $rest_amount;
                                    $transaction_loan_peni_summ = $rest_amount;
                                    $rest_amount = 0;
                                }
                            }
                            
                            if (!empty($contract->collection_status))
                            {
                                $collection_order = array(
                                    'transaction_id' => $transaction->id,
                                    'manager_id' => $contract->collection_manager_id,
                                    'contract_id' => $contract->id,
                                    'created' => date('Y-m-d H:i:s'),
                                    'body_summ' => $transaction_loan_body_summ,
                                    'percents_summ' => $transaction_loan_percents_summ,
                                    'charge_summ' => $transaction_loan_charge_summ,
                                    'peni_summ' => $transaction_loan_peni_summ,
                                    'commision_summ' => $transaction->commision_summ,
                                    'closed' => 0,
                                    'prolongation' => 0
                                );
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
                            
                            if (!empty($transaction->prolongation))
                            {
                                if (!empty($collection_order))
                                    $collection_order['prolongation'] = 1;
                                
                                $return_amount = round($contract_loan_body_summ + $contract_loan_body_summ * $contract->base_percent * 14 / 100, 2);
                                $return_amount_percents = round($contract_loan_body_summ * $contract->base_percent * 14 / 100, 2);
                                
                                $document_params['return_amount'] = $return_amount;
                                $document_params['return_amount_percents'] = $return_amount_percents;
                                
                                $document_params['amount'] = $contract_loan_body_summ;
                                
                                // дополнительное соглашение
                                $this->documents->create_document(array(
                                    'user_id' => $contract->user_id,
                                    'order_id' => $contract->order_id,
                                    'contract_id' => $contract->id,
                                    'type' => 'DOP_SOGLASHENIE_PROLONGATSIYA',
                                    'params' => $document_params,                
                                ));
                            }
                            
                            // закрываем кредит
                            if ($contract_loan_body_summ <= 0 && $contract_loan_percents_summ <= 0 && $contract_loan_charge_summ <= 0 && $contract_loan_peni_summ <= 0)
                            {
                                $this->contracts->update_contract($contract->id, array(
                                    'status' => 3, 
                                    'collection_status' => 0,
                                    'close_date' => date('Y-m-d H:i:s'),
                                ));
                                
                                $this->orders->update_order($contract->order_id, array(
                                    'status' => 7
                                ));
                                
                                if (!empty($collection_order))
                                    $collection_order['closed'] = 1;

                                // проверяем мараторий
//                                $user = $this->users->get_user((int)$contract->user_id);
//                                $credits_history = $this->soap1c->get_client_credits($user->UID);
//                                $this->users->save_loan_history($user->id, $credits_history);
//
//                                $create_date = new DateTime($contract->create_date);
//                                $close_date = new DateTime($contract->create_date);
//

                            }

                            if (!empty($collection_order))
                            {
                                $this->collections->add_collection($collection_order);
                            }
                            
    
                            $this->operations->add_operation(array(
                                'contract_id' => $contract->id,
                                'user_id' => $contract->user_id,
                                'order_id' => $contract->order_id,
                                'type' => 'PAY',
                                'amount' => $payment_amount,
                                'created' => date('Y-m-d H:i:s'),
                                'transaction_id' => $transaction->id,
                                'loan_body_summ' => $contract_loan_body_summ,
                                'loan_percents_summ' => $contract_loan_percents_summ,
                                'loan_charge_summ' => $contract_loan_charge_summ,
                                'loan_peni_summ' => $contract_loan_peni_summ,
                            ));
                            
                            
    /* старая версия списывания                        
                            if (!empty($transaction->prolongation))
                            {
                                if (!empty($contract->prolongation))
                                {
                                    //TODO: делаем страховку 
                                    $payment_amount = $payment_amount - $this->settings->prolongation_amount;
                                }
                
                                // списываем долг
                                if ($contract->loan_percents_summ > $payment_amount)
                                {
                                    $new_loan_percents_summ = $contract->loan_percents_summ - $payment_amount;
                                    $new_loan_body_summ = $contract->loan_body_summ;
                                }
                                else
                                {
                                    $new_loan_percents_summ = 0;
                                    $new_loan_body_summ = ($contract->loan_body_summ + $contract->loan_percents_summ) - $payment_amount;
                                }
                                
                                $new_return_date = date('Y-m-d H:i:s', time() + 86400 * $this->settings->prolongation_period);
                                
                                $this->contracts->update_contract($contract->id, array(
                                    'loan_percents_summ' => $new_loan_percents_summ,
                                    'loan_body_summ' => $new_loan_body_summ,
                                    'return_date' => $new_return_date,
                                    'prolongation' => $contract->prolongation + 1,
                                ));
                                
                            }
                            else
                            {
                                // списываем долг
                                if ($contract->loan_percents_summ > $payment_amount)
                                {
                                    $new_loan_percents_summ = $contract->loan_percents_summ - $payment_amount;
                                    $new_loan_body_summ = $contract->loan_body_summ;
                                }
                                else
                                {
                                    $new_loan_percents_summ = 0;
                                    $new_loan_body_summ = ($contract->loan_body_summ + $contract->loan_percents_summ) - $payment_amount;
                                }
                                
                                $this->contracts->update_contract($contract->id, array(
                                    'loan_percents_summ' => $new_loan_percents_summ,
                                    'loan_body_summ' => $new_loan_body_summ
                                ));
                            }
                            
                            // закрываем кредит
                            if ($new_loan_body_summ <= 0)
                            {
                                $this->contracts->update_contract($contract->id, array(
                                    'status' => 3, 
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
                                'created' => date('Y-m-d H:i:s'),
                                'transaction_id' => $transaction->id,
                                'loan_body_summ' => '',
                                'loan_percents_summ' => '',
                                'loan_charge_summ' => '',
                                'loan_peni_summ' => '',
                            ));
    */
                            
                            $meta_title = 'Оплата прошла успешно';
                            $this->design->assign('success', 'Оплата прошла успешно.');
                                    
                            
                        }
                        else
                        {
                            $reason_code_description = $this->Bestpay->get_reason_code_description($code);
                            $this->design->assign('reason_code_description', $reason_code_description);
    
                            $meta_title = 'Не удалось оплатить';
                            $this->design->assign('error', 'При оплате произошла ошибка.');
                        }
                        $this->transactions->update_transaction($transaction->id, array(
                            'operation' => $operation,
                            'callback_response' => $operation_info,
                            'reason_code' => $reason_code
                        ));
    
    
                    }
                    else
                    {
                        $callback_response = $this->Bestpay->get_register_info($sector, $register_id, $operation);
                        $this->transactions->update_transaction($transaction->id, array(
                            'operation' => 0,
                            'callback_response' => $callback_response
                        ));
    //echo __FILE__.' '.__LINE__.'<br /><pre>';echo(htmlspecialchars($callback_response));echo '</pre><hr />';
                        $meta_title = 'Не удалось оплатить';
                        $this->design->assign('error', 'При оплате произошла ошибка. Код ошибки: '.$error);
                        
                    }
                }
            }
            else
            {
                $meta_title = 'Ошибка: Транзакция не найдена';
                $this->design->assign('error', 'Ошибка: Транзакция не найдена');                                    
            }
            
            
            
            
            
            
            
            
        }
        else
        {
            $meta_title = 'Ошибка запроса';
            $this->design->assign('error', 'Ошибка запроса');
        }
        


        
        
//echo __FILE__.' '.__LINE__.'<br /><pre>';var_dump($_GET);echo '</pre><hr />';
    
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
        
        if (!empty($register_id))
        {
            if ($transaction = $this->transactions->get_register_id_transaction($register_id))
            {
                if (!empty($operation))
                {
                    $operation_info = $this->Bestpay->get_operation_info($transaction->sector, $register_id, $operation);
                    $xml = simplexml_load_string($operation_info);
                    $operation_reference = (string)$xml->reference;
                    $reason_code = (string)$xml->reason_code;


//echo __FILE__.' '.__LINE__.'<br /><pre>';echo(htmlspecialchars($operation_info));echo '</pre><hr />';
                    
                    if ($reason_code == 1)
                    {
                        
                        $card = array(
                            'user_id' => (string)$xml->reference,
                            'name' => (string)$xml->name,
                            'pan' => (string)$xml->pan,
                            'expdate' => (string)$xml->expdate,
                            'approval_code' => (string)$xml->approval_code,
                            'token' => (string)$xml->token,
                            'operation_date' => str_replace('.', '-', (string)$xml->date),
                            'created' => date('Y-m-d H:i:s'),
                            'operation' => $xml->order_id,
                            'register_id' => $transaction->register_id,
                            'transaction_id' => $transaction->id
                        );
//echo __FILE__.' '.__LINE__.'<br /><pre>';var_dump($card);echo '</pre><hr />';
                        $this->cards->add_card($card);
                                                
                        $meta_title = 'Карта успешно привязана';
                        $this->design->assign('success', 'Карта успешно привязана.');
                        
                    }
                    else
                    {
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


                }
                else
                {
                    $callback_response = $this->Bestpay->get_register_info($transaction->sector, $register_id, $operation);
                    $this->transactions->update_transaction($transaction->id, array(
                        'operation' => 0,
                        'callback_response' => $callback_response
                    ));
//echo __FILE__.' '.__LINE__.'<br /><pre>';echo(htmlspecialchars($callback_response));echo '</pre><hr />';
                    $meta_title = 'Не удалось привязать карту';
                    $this->design->assign('error', 'При привязке карты произошла ошибка. Код ошибки: '.$error);
                    
                }
            }
            else
            {
                $meta_title = 'Ошибка: Транзакция не найдена';
                $this->design->assign('error', 'Ошибка: Транзакция не найдена');                                    
            }
            
            
            
            
            
            
            
            
        }
        else
        {
            $meta_title = 'Ошибка запроса';
            $this->design->assign('error', 'Ошибка запроса');
        }
        
//echo __FILE__.' '.__LINE__.'<br /><pre>';var_dump($_GET);echo '</pre><hr />';
    
    }
}