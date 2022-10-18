<?php

class Local_time_scoring extends Core
{
    private $user_id;
    private $order_id;
    private $audit_id;
    private $type;

    public function run($audit_id, $user_id, $order_id)
    {
        $this->user_id = $user_id;
        $this->audit_id = $audit_id;
        $this->order_id = $order_id;
//$this->orders->update_order(102465, array('local_time'=>time()));        
        $this->type = $this->scorings->get_type('local_time');

        $order = $this->orders->get_order((int)$order_id);
        if (!empty($order->local_time))
            return $this->scoring($order->local_time, strtotime($order->date));
        
        return false;
    }

    private function scoring($local_time, $order_time)
    {
        $diff = abs($order_time - $local_time);
        
        $score = $diff <= $this->type->params['max_diff'];
        
        $add_scoring = array(
            'user_id' => $this->user_id,
            'audit_id' => $this->audit_id,
            'type' => 'local_time',
            'body' => 'local_time: '.$local_time.'; diff: '.$diff,
            'success' => (int)$score,
        );        
        
        if ($score)
        {
            $add_scoring['string_result'] = 'Локальное время < '.$this->type->params['max_diff'].' c';
        }
        else
        {
            $add_scoring['string_result'] = 'Локальное время > '.$this->type->params['max_diff'].' c';
        }

        $this->scorings->add_scoring($add_scoring);

        return $score;        
    }

}