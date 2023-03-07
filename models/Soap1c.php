<?php

ini_set("soap.wsdl_cache_enabled", 0);
ini_set('default_socket_timeout', '300');


class Soap1c extends Core
{
    protected static $link = "http://109.195.83.202:80/bar/ws/";
    protected static $login = 'Администратор';
    protected static $password = '';
    protected static $orderId;

    public function send_payment($payment)
    {
        self::$orderId = $payment->order_id;

        $item = new StdClass();
        $item->ID = $payment->id;
        $item->Дата = date('YmdHis');
        $item->ЗаймID = $payment->order_id;
        $item->Пролонгация = !empty($payment->prolongation) ? 1 : 0;

        if($payment->prolongation == 1)
            $item->СрокПролонгации = '30';
        else
            $item->СрокПролонгации = 0;

        $item->Закрытие = !empty($payment->closed) ? 1 : 0;
        $item->ИдентификаторФормыОплаты = 'ТретьеЛицо';

        $operation = [];
        $operation[] = ['ИдентификаторВидаНачисления' => 'ОсновнойДолг', 'Сумма' => $payment->od];
        $operation[] = ['ИдентификаторВидаНачисления' => 'Проценты', 'Сумма' => $payment->prc];
        $operation[] = ['ИдентификаторВидаНачисления' => 'Пени', 'Сумма' => $payment->peni];

        $item->Оплаты = $operation;

        $request = new StdClass();
        $request->TextJSON = json_encode($item, JSON_UNESCAPED_UNICODE);

        $result = $this->send_request('CRM_WebService', 'Payments', $request);

        if (isset($result['return']) && $result['return'] == 'OK')
            return 1;
        else
            return 2;
    }

    private function send_request($service, $method, $request)
    {
        $params = array();
        if (!empty(self::$login) || !empty(self::$password)) {
            $params['login'] = self::$login;
            $params['password'] = self::$password;
        }

        try {
            $service_url = self::$link . $service . ".1cws?wsdl";

            $client = new SoapClient($service_url, $params);
            $response = $client->__soapCall($method, array($request));
        } catch (Exception $fault) {
            var_dump($fault);
            $response = $fault;
        }

        $response = json_encode($response, JSON_UNESCAPED_UNICODE);

        $insert =
            [
                'orderId' => self::$orderId,
                'request' => json_encode(json_decode($request->TextJSON), JSON_UNESCAPED_UNICODE),
                'response' => $response
            ];

        $response = $this->OnecLogs->add($insert);

        return $response;
    }
}