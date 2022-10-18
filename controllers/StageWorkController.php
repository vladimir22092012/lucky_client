<?php

class StageWorkController extends Controller
{
    public function fetch()
    {
        if (empty($this->user))
        {
            header('Location: /lk/login');
            exit;
        }
        
        if (!empty($this->user->stage_work))
        {
            header('Location: /stage/files');
            exit;
        }
        
        if (empty($this->user->stage_address))
        {
            header('Location: /stage/address');
            exit;
        }
        
        if ($this->request->get('step') == 'prev')
        {
            $this->users->update_user($this->user->id, array('stage_address'=>0));
            header('Location: /stage/address');
            exit;
        }
        
        if ($this->request->method('post'))
        {
            $workplace = (string)$this->request->post('workplace');
            $workaddress = (string)$this->request->post('workaddress');
            $profession = (string)$this->request->post('profession');
            $workphone = (string)$this->request->post('workphone');
            $income = (string)$this->request->post('income');
            $expenses = (string)$this->request->post('expenses');
            $chief_name = (string)$this->request->post('chief_name');
            $chief_position = (string)$this->request->post('chief_position');
            $chief_phone = (string)$this->request->post('chief_phone');

            $contact_person_name = (string)$this->request->post('contact_person_name');
            $contact_person_phone = (string)$this->request->post('contact_person_phone');
            $contact_person_relation = (string)$this->request->post('contact_person_relation');
            $contact_person2_name = (string)$this->request->post('contact_person2_name');
            $contact_person2_phone = (string)$this->request->post('contact_person2_phone');
            $contact_person2_relation = (string)$this->request->post('contact_person2_relation');

            $juicescore_session_id = (string)$this->request->post('juicescore_session_id');

            $this->design->assign('workplace', $workplace);
            $this->design->assign('profession', $profession);
            $this->design->assign('workphone', $workphone);
            $this->design->assign('workaddress', $workaddress);
            $this->design->assign('income', $income);
            $this->design->assign('expenses', $expenses);
            $this->design->assign('chief_name', $chief_name);
            $this->design->assign('chief_position', $chief_position);
            $this->design->assign('chief_phone', $chief_phone);
            $this->design->assign('contact_person_name', $contact_person_name);
            $this->design->assign('contact_person_phone', $contact_person_phone);
            $this->design->assign('contact_person_relation', $contact_person_relation);
            $this->design->assign('contact_person2_name', $contact_person2_name);
            $this->design->assign('contact_person2_phone', $contact_person2_phone);
            $this->design->assign('contact_person2_relation', $contact_person2_relation);
            
            $errors = array();
            
            if (empty($workplace))
                $errors[] = 'empty_workplace';
            if (empty($profession))
                $errors[] = 'empty_profession';
            if (empty($workphone))
                $errors[] = 'empty_workphone';
            if (empty($income))
                $errors[] = 'empty_income';
            if (empty($expenses))
                $errors[] = 'empty_expenses';
            if (empty($chief_name))
                $errors[] = 'empty_chief_name';
            if (empty($chief_position))
                $errors[] = 'empty_chief_position';
            if (empty($chief_phone))
                $errors[] = 'empty_chief_phone';
            if (empty($contact_person_name))
                $errors[] = 'empty_contact_person_name';
            if (empty($contact_person_phone))
                $errors[] = 'empty_contact_person_phone';
            if (empty($contact_person2_name))
                $errors[] = 'empty_contact_person2_name';
            if (empty($contact_person2_phone))
                $errors[] = 'empty_contact_person2_phone';
            
            $this->design->assign('errors', $errors);
            
            if (empty($errors))
            {
                $update = array(
                    'workplace' => $workplace,
                    'workaddress' => $workaddress,
                    'profession' => $profession,
                    'workphone' => $workphone,
                    'income' => $income,
                    'expenses' => $expenses,
                    'chief_name' => $chief_name,
                    'chief_position' => $chief_position,
                    'chief_phone' => $chief_phone,
                    'contact_person_name' => $contact_person_name,
                    'contact_person_phone' => $contact_person_phone,
                    'contact_person_relation' => $contact_person_relation,
                    'contact_person2_name' => $contact_person2_name,
                    'contact_person2_phone' => $contact_person2_phone,
                    'contact_person2_relation' => $contact_person2_relation,

                    'stage_work' => 1,
                    'work_added_date' => date('Y-m-d H:i:s'),
                    
                    'juicescore_session_id' => $juicescore_session_id,
                );

                $update = array_map('strip_tags', $update);

                $this->users->update_user($this->user->id, $update);
            
                header('Location: /stage/files');
                exit;
            }            
        }
        else
        {
            $this->design->assign('workplace', $this->user->workplace);
            $this->design->assign('workaddress', $this->user->workaddress);
            $this->design->assign('profession', $this->user->profession);
            $this->design->assign('workphone', $this->user->workphone);
            $this->design->assign('income', $this->user->income);
            $this->design->assign('expenses', $this->user->expenses);
            $this->design->assign('chief_name', $this->user->chief_name);
            $this->design->assign('chief_position', $this->user->chief_position);
            $this->design->assign('chief_phone', $this->user->chief_phone);
            $this->design->assign('contact_person_name', $this->user->contact_person_name);
            $this->design->assign('contact_person_phone', $this->user->contact_person_phone);
            $this->design->assign('contact_person_relation', $this->user->contact_person_relation);
            $this->design->assign('contact_person2_name', $this->user->contact_person2_name);
            $this->design->assign('contact_person2_phone', $this->user->contact_person2_phone);
            $this->design->assign('contact_person2_relation', $this->user->contact_person2_relation);
            
        }

    	return $this->design->fetch('stage/work.tpl');
    }
    
}