<?php

class AdSpireLead extends Core
{
    public function sendPendingPostback($orderId)
    {
        $order = $this->orders->get_order($orderId);

        $link = 'https://postback.adspire.io/';
        $link .= '?key=u95fl39xjo';
        $link .= '&order_id=' . $orderId;

        $atm_marketing = '';
        $atm_remarketing = '';
        $atm_closer = '';

        if ($order->utm_content == 'marketing')
            $atm_marketing = $order->utm_content;
        elseif ($order->utm_content == 'remarketing')
            $atm_remarketing = $order->utm_content;
        elseif ($order->utm_content == 'closer')
            $atm_closer = $order->utm_content;

        $link .= '&atm_marketing=' . $atm_marketing;
        $link .= '&atm_remarketing=' . $atm_remarketing;
        $link .= '&atm_closer=' . $atm_closer;


        $ch = curl_init($link);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
        curl_setopt($ch, CURLOPT_TIMEOUT, 15);
        $res = curl_exec($ch);
        curl_close($ch);

        $log =
            [
                'className' => 'AdSpire',
                'log' => $res,
                'params' => $link
            ];

        $this->Logs->add($log);

        return 1;
    }
}