<?php

class ShortBest2payCallback extends Controller
{
    public function fetch()
    {
        switch ($this->request->get('action', 'string')):

            case 'payment':
                $this->payment_action();
                break;

            default:
                $meta_title = 'Ошибка';
                $this->design->assign('error', 'Ошибка');

        endswitch;

        exit;
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

        if (!empty($register_id)) {
            $query = $this->db->placehold("
                SELECT * 
                FROM __transactions_via_short_link
                WHERE register_id = ?
                and sended != 1
            ", (int)$register_id);
            
            $this->db->query($query);
            $transaction = $this->db->result();

            if ($transaction) {
                // TODO: сделать запрос в бест2пей и получить успешную операцию
                if (empty($operation)) {
                    $register_info = $this->Bestpay->get_register_info($transaction->sector, $register_id);
                    $xml = simplexml_load_string($register_info);

                    foreach ($xml->operations as $xml_operation) {
                        if ($xml_operation->operation->state == 'APPROVED') {
                            $operation = (string)$xml_operation->operation->id;
                        }
                    }
                }

                if (!empty($operation)) {
                    $operation_info = $this->Bestpay->get_operation_info($transaction->sector, $register_id, $operation);
                    $xml = simplexml_load_string($operation_info);
                    $operation_reference = (string)$xml->reference;
                    $reason_code = (string)$xml->reason_code;
                    $payment_amount = strval($xml->amount) / 100;
                    $amount = $xml->amount;
                    $operation_date = date('YmdHis', strtotime(str_replace('.', '-', (string)$xml->date)));
                    echo __FILE__.' '.__LINE__.'<br /><pre>';echo(htmlspecialchars($operation_info));echo '</pre><hr />';
                    //exit;
                    if ($reason_code == 1) {
                        $query = $this->db->placehold("
                            SELECT * 
                            FROM __users_from_one_s
                            WHERE id = ?
                        ", (int)$transaction->user_id);

                        $this->db->query($query);
                        $user_from_one_s = $this->db->result();
                    
                        $amount = $user_from_one_s->amount - $payment_amount;

                        //отправка в 1с оплаты
                        $request = [
                            'uid' => $user_from_one_s->uid,
                            'number_of_contract' => $user_from_one_s->number_of_contract,
                            'date' => $operation_date,
                            'register_id' => $register_id,
                            'operation_id' => $operation,
                            'organisation' => $user_from_one_s->organisation,
                            'amount' => $xml->amount,
                        ];

                        $this->soap1c->_send_payment_($request);

                        //теперь баланс берем из 1с
                        /*
                            $query = $this->db->placehold("
                                UPDATE __users_from_one_s SET ?% WHERE id = ?
                            ", array(
                                'amount' => $amount
                            ), (int)$transaction->user_id);

                            $this->db->query($query);
                        */
                        $meta_title = 'Оплата прошла успешно';

                        $query = $this->db->placehold("
                            UPDATE __transactions_via_short_link SET ?% WHERE id = ?
                        ", array(
                            'sended' => 1,
                            'sended_date' => date('Y-m-d H:i:s'),
                        ), (int)$transaction->id);

                        $this->db->query($query);
                    } else {
                        $reason_code_description = $this->Bestpay->get_reason_code_description($reason_code);

                        $meta_title = 'Не удалось оплатить';
                    }

                    $query = $this->db->placehold("
                        UPDATE __transactions_via_short_link SET ?% WHERE id = ?
                    ", array(
                        'operation' => $operation,
                        'callback_response' => $operation_info,
                        'reason_code' => $reason_code
                    ), (int)$transaction->id);

                    $this->db->query($query);
                } else {
                    $callback_response = $this->Bestpay->get_register_info($transaction->sector, $register_id, $operation);

                    $query = $this->db->placehold("
                        UPDATE __transactions_via_short_link SET ?% WHERE id = ?
                    ", array(
                        'operation' => 0,
                        'callback_response' => $callback_response
                    ), (int)$transaction->id);

                    $this->db->query($query);

                    //echo __FILE__.' '.__LINE__.'<br /><pre>';echo(htmlspecialchars($callback_response));echo '</pre><hr />';
                    $meta_title = 'Не удалось оплатить';
                }
            } else {
                $meta_title = 'Ошибка: Транзакция не найдена';
            }
        } else {
            $meta_title = 'Ошибка запроса';
        }

        echo $meta_title;

        sleep(2);

        $query = $this->db->placehold("
            SELECT * 
            FROM __users_from_one_s
            WHERE id = ?
        ", (int)$transaction->user_id);

        $this->db->query($query);
        $user_from_one_s = $this->db->result();

        header('Location: https://'.str_replace("pay/", "Payments/", $user_from_one_s->short_payment_link));

        exit;
        //echo __FILE__.' '.__LINE__.'<br /><pre>';var_dump($_GET);echo '</pre><hr />';
    }
}
