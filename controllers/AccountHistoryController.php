<?php

class AccountHistoryController extends Controller
{
    public function fetch()
    {
        if (empty($this->user))
        {
            header('Location: /lk/login');
            exit;
        }

        $history_items = array();
        if (!empty($this->user->UID))
        {
            $history_1c = $this->soap1c->get_client_credits($this->user->UID);
            $this->users->save_loan_history($this->user->id, $history_1c );
            if (!empty($history_1c))
            {
                foreach ($history_1c as $history_1c_item)
                {
                    $item = new StdClass();
                    
                    $item->date = date('Y-m-d H:i:s', strtotime($history_1c_item->ДатаЗайма));
                    $item->number = $history_1c_item->НомерЗайма;
                    $item->summ = $history_1c_item->ОстатокОД;
                    
                    $history_items[] = $item;
                }
            }
        }

        $orders = $this->orders->get_orders(array('user_id'=>$this->user->id, 'sort' => 'id_desc'));
        foreach ($orders as $order)
        {
            if (!empty($order->contract_id))
                $order->contract = $this->contracts->get_contract($order->contract_id);
        }

        foreach ($history_items as $k => $history_item)
        {
            if (!empty($orders))
                foreach ($orders as $order)
                {
                    if (!empty($order->contract) && $history_item->number == $order->contract->number)
                        unset($history_items[$k]);
                }
        }

        $this->design->assign('orders', $orders);
    	
        $statuses = $this->orders->get_statuses();
        $this->design->assign('statuses', $statuses);
        
        $this->design->assign('history_items', $history_items);

        return $this->design->fetch('account/history.tpl');
    }
    
}