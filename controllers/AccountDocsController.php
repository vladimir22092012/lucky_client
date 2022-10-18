<?php

class AccountDocsController extends Controller
{
    public function fetch()
    {
        if (empty($this->user))
        {
            header('Location: /lk/login');
            exit;
        }
    	
        $files = array();
        $other_files = array();
        foreach ($this->users->get_files(array('user_id' => $this->user->id)) as $f)
        {
            if ($f->type == 'file' || $f->type == 'document')
                $other_files[] = $f;
            else
                $files[$f->type] = $f;
        }
//echo __FILE__.' '.__LINE__.'<br /><pre>';var_dump($files);echo '</pre><hr />';
        $this->design->assign('files', $files);
        $this->design->assign('other_files', $other_files);

        $orders = $this->orders->get_orders(array('user_id'=>$this->user->id, 'sort'=>'order_id_desc'));

        $order = reset($orders);

        
        if (!empty($order) && ($order->status == 5))
        {
            
            
            $documents = $this->documents->get_documents(array('user_id' => $this->user->id, 'client_visible'=>1, 'order_id'=>$order->order_id));
            $this->design->assign('documents', $documents);
            
            $receipts = $this->receipts->get_receipts(array('user_id'=>$this->user->id, 'order_id'=>$order->order_id));
            $this->design->assign('receipts', $receipts);
        }
        if ($card_id = $this->request->get('card_id', 'integer'))
        {
            if (!($card = $this->cards->get_card($card_id)))
                return false;
            
            if ($card->user_id != $this->user->id)
                return false;
            
            $this->design->assign('card', $card);
        }
        
        return $this->design->fetch('account/docs.tpl');
    }
    
}