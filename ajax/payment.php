<?php

error_reporting(-1);
ini_set('display_errors', 'On');

//date_default_timezone_set('Etc/GMT-1');
session_start();







$simpla = new Simpla();
$response = array();

if (!empty($_SESSION['user_id']))
{
    $user = $simpla->users->get_user((int)$_SESSION['user_id']);
    if (empty($user))
    {
        $response['error'] = 'UNKNOWN_USER';
    }
    else
    {
        
        $action = $simpla->request->get('action', 'string');
        
        switch ($action):
            
            case 'recurent':
                
                $amount = $simpla->request->get('amount');
                $prolongation = $simpla->request->get('prolongation', 'integer');
                $code_sms = $simpla->request->get('code_sms', 'string');
                
                if (empty($amount))
                {
                    $response['error'] = 'EMPTY_AMOUNT';
                }
                else
                {
                    $card_id = $
                }
                
            break;







            // создаем в тинькове транзацию и записываем ее в базу
            case 'create_transaction':
                
                $amount = $simpla->request->get('amount');
                $prolongation = $simpla->request->get('prolongation', 'integer');
                $code_sms = $simpla->request->get('code_sms', 'string');
                
                if (empty($amount))
                {
                    $response['error'] = 'EMPTY_AMOUNT';
                }
                else
                {
                    
                    $response = $simpla->tinkoff->init_payment($user->id, $amount);

                    if (!empty($response['Success']))
                    {
                        $simpla->transactions->add_transaction(array(
                            'user_id' => $user->id,
                            'uid' => $user->uid,
                            'order_id' => $response['OrderId'],
                            'card_id' => '',
                            'amount' => $response['Amount'],
                            'payment_id' => $response['PaymentId'],
                            'payment_link' => $response['PaymentURL'],
                            'sended' => 0,
                            'status' => $response['Status'],
                            'prolongation' => $prolongation,
                            'sms' => $code_sms,
                        ));
                    }
                }
                
            break;
            
            // получаем статус транзакции, обновляем в базе и в случае успеха отправляем в 1с
            case 'get_state':
                
                $payment_id = $simpla->request->get('payment_id', 'string');
                
                if (empty($payment_id))
                {
                    $response['error'] = 'EMPTY_PAYMENT_ID';
                }
                elseif (!is_numeric($payment_id))
                {
                    $response['error'] = 'Не удалось выполнить оплату.';
                }
                else
                {
                    $response = $simpla->tinkoff->get_state($payment_id);
                    
                    if (!empty($response['Success']))
                    {
                        $transaction = $simpla->transactions->get_payment_id_transaction($payment_id);
                        $simpla->transactions->update_transaction($transaction->id, array(
                            'status' => $response['Status']
                        ));
                        
                        if ($response['Status'] == 'CONFIRMED')
                        {
                            $result = $simpla->soap->send_payment_result(
                                $transaction->uid, 
                                $transaction->amount, 
                                $transaction->payment_id,
                                $transaction->code_sms, 
                                $transaction->prolongation
                            );
//echo __FILE__.' '.__LINE__.'<br /><pre>';var_dump($result);echo '</pre><hr />';
                            $simpla->transactions->update_transaction($transaction->id, array(
                                'sended' => 1,
                                'send_result' => $result->return
                            ));                            
                        }
                    }
                    
                }
                
            break;
                        
            // 
            case 'send_payment_attach':

                $card_id = $simpla->request->get('card_id', 'integer');
                $amount = $simpla->request->get('amount');
                $prolongation = $simpla->request->get('prolongation', 'integer');
                $code_sms = $simpla->request->get('code_sms', 'string');
                
                
                if (empty($card_id))
                {
                    $response['error'] = 'EMPTY_CARD_ID';
                }
                elseif (empty($amount))
                {
                    $response['error'] = 'EMPTY_AMOUNT';
                }
                else
                {
                    $summ = $simpla->tinkoff->format_summ($amount);
                    
                    $result = $simpla->soap->send_payment_from_attach_card($card_id, $summ, $user->uid);
                    
                    if (empty($result->return))
                    {
                        $response['error'] = 'NOT_PAYMENT_ID';
                    }
                    else
                    {
                        $response['PaymentId'] = $result->return;

                        $simpla->transactions->add_transaction(array(
                            'user_id' => $user->id,
                            'uid' => $user->uid,
                            'order_id' => '',
                            'card_id' => $card_id,
                            'amount' => $summ,
                            'payment_id' => $response['PaymentId'],
                            'payment_link' => '',
                            'sended' => 0,
                            'status' => '',
                            'prolongation' => $prolongation,
                            'code_sms' => $code_sms,
                        ));

                    }
                }
                
            break;
            
            default: 
                $response['error'] = 'UNDEFINED_ACTION';
            
        endswitch;
    }
    
}
else
{
    $response['error'] = 'UNDEFINED_USER';
}
header("Content-type: application/json; charset=UTF-8");
header("Cache-Control: must-revalidate");
header("Pragma: no-cache");
header("Expires: -1");		

echo json_encode($response);
