<?php

class AccountCardsController extends Controller
{
    public function fetch()
    {
        if (empty($this->user))
        {
            header('Location: /lk/login');
            exit;
        }
    	
        if (empty($this->user->stage_personal))
        {
            header('Location: /stage/personal');
            exit;
        }

        if (empty($this->user->stage_passport))
        {
            header('Location: /stage/passport');
            exit;
        }

        if (empty($this->user->stage_address))
        {
            header('Location: /stage/address');
            exit;
        }

        if (empty($this->user->stage_work))
        {
            header('Location: /stage/work');
            exit;
        }

        if (empty($this->user->stage_files))
        {
            header('Location: /stage/files');
            exit;
        }

        if (empty($this->user->stage_card))
        {
            header('Location: /stage/card');
            exit;
        }

        if (!$this->is_developer && empty($this->user->password))
        {
            header('Location: /account/password');
            exit;
        }

        if ($remove = $this->request->get('remove', 'integer'))
        {
            if (!empty($_SESSION['looker_mode']))
                return false;
            
            if ($card = $this->cards->get_card($remove))
            {
                if ($card->user_id == $this->user->id)
                {
                    $user_cards = $this->cards->get_cards(array('user_id' => $this->user->id));
                    if (count($user_cards) > 1)
                    {
                        if ($user_orders = $this->orders->get_orders(array('user_id' => $this->user->id, 'status' => array(0, 1, 2, 4, 5))))
                        {
                            $card_has_order = 0;
                            foreach ($user_orders as $uo)
                            {
                                if ($uo->card_id == $remove)
                                {
                                    $card_has_order = 1;
                                }
                            }
                            if (!empty($card_has_order))
                            {
                                $this->design->assign('error', 'Карта используется в активной заявке');
                            }
                            else
                            {
                                $this->cards->update_card($remove, array('deleted'=>1));
                                
                                header('Location: '.$this->request->url(array('remove'=>null)));
                                exit;
                                
                            }
                        }
                        else
                        {
                            $this->cards->update_card($remove, array('deleted'=>1));
                            
                            header('Location: '.$this->request->url(array('remove'=>null)));
                            exit;
                        }
                    }
                    else
                    {
                        $this->design->assign('error', 'Нельзя удалить единственную карту');
                    }
                }
                else
                {
                    $this->design->assign('error', 'Нет доступа к карте');
                }
            }
            else
            {
                $this->design->assign('error', 'Карта не найдена');
            }
        }
        
        if ($base = $this->request->get('base', 'integer'))
        {
            if (!empty($_SESSION['looker_mode']))
                return false;
            

            if ($card = $this->cards->get_card($base))
            {
                if ($card->user_id == $this->user->id)
                {
                    $user_cards = $this->cards->get_cards(array('user_id' => $this->user->id));
                    foreach ($user_cards as $c)
                    {
                        $this->cards->update_card($c->id, array('base_card' => 0));
                    }
                    $this->cards->update_card($card->id, array('base_card' => 1));
                    
                    header('Location: '.$this->request->url(array('base'=>null)));
                    exit;
                }
                else
                {
                    $this->design->assign('error', 'Нет доступа к карте');
                }
            }
            else
            {
                $this->design->assign('error', 'Карта не найдена');
            }
        }
        
        $cards = $this->cards->get_cards(array('user_id'=>$this->user->id));
        $this->design->assign('cards', $cards);
        
        
//        $card_link = $this->best2pay->add_card($this->user->id);
//        $this->design->assign('card_link', $card_link);
        
        return $this->design->fetch('account/cards.tpl');
    }
    
}