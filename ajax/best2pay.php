<?php
error_reporting(-1);
ini_set('display_errors', 'On');

chdir('..');

require 'autoload.php';

class Best2payAjax extends Ajax
{
    public function run()
    {
        $action = $this->request->get('action', 'string');
        
        switch($action):
            
            case 'attach_card':
                $this->attach_card();
            break;
            
            case 'get_payment_link':
                $this->get_payment_link();
            break;
            
            case 'recurrent':
                $this->recurrent_action();                
            break;
            
            default:
                $this->response['error'] = 'UNDEFINED_ACTION';
            
        endswitch;

        $this->output();
    }
    
    private function recurrent_action()
    {
        if (!empty($_SESSION['looker_mode']))
            return false;

        $card_id = $this->request->get('card_id', 'integer');
        $amount = (float)str_replace(',', '.', $this->request->get('amount'));
        $contract_id = $this->request->get('contract_id', 'integer');
        $prolongation = $this->request->get('prolongation', 'integer');
        
        if (empty($amount))
        {
            $this->response['error'] = 'EMPTY_AMOUNT';
        }
        elseif (empty($card_id))
        {
            $this->response['error'] = 'EMPTY_CARD';
        }
        elseif (!($card = $this->cards->get_card($card_id)))
        {
            $this->response['error'] = 'UNDEFINED_CARD';
        }
        else
        {
            $description = "Оплата по договору ".$contract_id;
            $amount = $amount * 100;
            $response = $this->best2pay->recurrent_pay($card->id, $amount, $description, $contract_id, $prolongation);
            if (empty($response))
                $this->response['error'] = 'Не удалось оплатить';
            else
                $this->response['success'] = 1;
        }
    }
    
    private function get_payment_link()
    {
        if (!empty($_SESSION['looker_mode']))
            return false;
        
        $amount = (float)str_replace(',', '.', $this->request->get('amount'));
        $contract_id = $this->request->get('contract_id', 'integer');
        $prolongation = $this->request->get('prolongation', 'integer');
        $sms = $this->request->get('code_sms', 'string');
        $isShort = $this->request->get('is_short', 'string');
        
        $card_id = $this->request->get('card_id', 'integer');

        
        if (empty($amount))
        {
            $this->response['error'] = 'EMPTY_AMOUNT';
        }
        else
        {
            $amount = $amount * 100;
            
            if ($isShort) {
                $this->response['link'] = $this->Bestpay->_get_payment_link_($amount, $contract_id, $prolongation, $card_id, $sms);
            } else {
                $this->response['link'] = $this->Bestpay->get_payment_link($amount, $contract_id, $prolongation, $card_id, $sms);
            }
        }
    }
    
    private function attach_card()
    {
        if (!empty($_SESSION['looker_mode']))
            return false;
        
        $user_id = $this->request->get('user_id', 'integer');
        
        if ($user_id != $this->user->id)
            $this->response['error'] = 'Ошибка при привязке';
        else
        	$this->response['link'] = $this->best2pay->add_card($user_id);
    }
    
}
$ajax = new Best2payAjax();
$ajax->run();