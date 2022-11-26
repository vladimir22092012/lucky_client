<?php

class Documents extends Core
{
    private $templates = array(
        'ANKETA_PEP' => 'anketa-pep.tpl',
        'SOLGLASHENIE_PEP' => 'soglashenie-pep.tpl',
        'SOGLASIE_VZAIMODEYSTVIE' => 'soglasie-na-vzaimodeystvie.tpl',
        'SOGLASIE_SPISANIE' => 'reccurent.tpl',
        'IND_USLOVIYA' => 'individ_usloviya.tpl',
        'POLIS_STRAHOVANIYA' => 'polis_vidacha.tpl',
        'PDN' => 'pdn.tpl',
        'DOP_SOGLASHENIE' => 'prolongation.tpl'
    );
    
    
    private $names = array(
        'ANKETA_PEP' => 'Анкета - заявление ПЭП',
        'SOLGLASHENIE_PEP' => 'Соглашение об использовании ПЭП',
        'SOGLASIE_VZAIMODEYSTVIE' => 'Согласие на обработку персональных данных',
        'SOGLASIE_SPISANIE' => 'Согласие на списание рекуррентных платежей',
        'IND_USLOVIYA' => 'Индивидуальные условия',
        'POLIS_STRAHOVANIYA' => 'Полис страхования',
        'PDN' => 'Уведомление о показателе долговой нагрузки',
        'DOP_SOGLASHENIE' => 'Дополнительное соглашение о пролонгации займа'
    );
    
    private $client_visible = array(
        'ANKETA_PEP' => 0,
        'SOLGLASHENIE_PEP' => 1,
        'SOGLASIE_VZAIMODEYSTVIE' => 0,
        'SOGLASIE_SPISANIE' => 0,
        'IND_USLOVIYA' => 1,
        'POLIS_STRAHOVANIYA' => 1,
        'PDN' => 1,
        'DOP_SOGLASHENIE' => 1
    );
    
    
    public function update_document_params($document_id)
    {
        if (!($document = $this->get_document($document_id)))
            return false;
            
        if (!$user = $this->users->get_user((int)$document->user_id))
            return false;
        
        list($passport_number, $passport_serial) = explode('-', $user->passport_serial);
        $params = array(
            'lastname' => $user->lastname,
            'firstname' => $user->firstname,
            'patronymic' => $user->patronymic,
            'gender' => $user->gender,
            'phone' => $user->phone_mobile,
            'birth' => $user->birth,
            'birth_place' => $user->birth_place,
            'inn' => $user->inn,
            'snils' => $user->snils,
            'email' => $user->email,

            'passport_serial' => $passport_serial,
            'passport_number' => $passport_number,
            'passport_date' => $user->passport_date,
            'passport_code' => $user->subdivision_code,
            'passport_issued' => $user->passport_issued,
            
            'regindex' => $user->Regindex,
            'regregion' => $user->Regregion,
            'regcity' => $user->Regcity,
            'regstreet' => $user->Regstreet,
            'reghousing' => $user->Reghousing,
            'regbuilding' => $user->Regbuilding,
            'regroom' => $user->Regroom,
            'faktindex' => $user->Faktindex,
            'faktregion' => $user->Faktregion,
            'faktcity' => $user->Faktcity,
            'faktstreet' => $user->Faktstreet,
            'fakthousing' => $user->Fakthousing,
            'faktbuilding' => $user->Faktbuilding,
            'faktroom' => $user->Faktroom,

            'profession' => $user->profession,
            'workplace' => $user->workplace,
            'workphone' => $user->workphone,
            'chief_name' => $user->chief_name,
            'chief_position' => $user->chief_position,
            'chief_phone' => $user->chief_phone,
            'income' => $user->income,
            'expenses' => $user->expenses,
            
            'first_loan_amount' => $user->first_loan_amount,
            'first_loan_period' => $user->first_loan_period,
            
            'asp' => $user->sms,
            
//            'contract_date' => '2021-09-22 13:40:15',
        );

        $regaddress_full = empty($user->Regindex) ? '' : $user->Regindex.', ';
        $regaddress_full .= trim($user->Regregion.' '.$user->Regregion_shorttype);
        $regaddress_full .= empty($user->Regcity) ? '' : trim(', '.$user->Regcity.' '.$user->Regcity_shorttype);
        $regaddress_full .= empty($user->Regdistrict) ? '' : trim(', '.$user->Regdistrict.' '.$user->Regdistrict_shorttype);
        $regaddress_full .= empty($user->Reglocality) ? '' : trim(', '.$user->Reglocality.' '.$user->Reglocality_shorttype);
        $regaddress_full .= empty($user->Reghousing) ? '' : ', д.'.$user->Reghousing;
        $regaddress_full .= empty($user->Regbuilding) ? '' : ', стр.'.$user->Regbuilding;
        $regaddress_full .= empty($user->Regroom) ? '' : ', к.'.$user->Regroom;

        $params['regaddress_full'] = $regaddress_full;
        
        foreach ($params as $key => $param)
        {
            $document->params[$key] = $param;
        }
        
        $this->update_document($document->id, array('params' => $document->params));
    }
    
    
    public function create_document($data)
    {
        $id =  $this->add_document(array(
            'user_id' => isset($data['user_id']) ? $data['user_id'] : 0,
            'order_id' => isset($data['order_id']) ? $data['order_id'] : 0,
            'contract_id' => isset($data['contract_id']) ? $data['contract_id'] : 0,
            'type' => $data['type'],
            'name' => $this->names[$data['type']],
            'template' => $this->templates[$data['type']],
            'client_visible' => $this->client_visible[$data['type']],
            'params' => $data['params'],
            'created' => date('Y-m-d H:i:s'),
        ));
        
        return $id;
    }
    
    public function get_templates()
    {
    	return $this->templates;
    }    
    
    public function get_template($type)
    {
    	return isset($this->templates[$type]) ? $this->templates[$type] : null;
    }    
    
    public function get_template_name($type)
    {
    	return isset($this->names[$type]) ? $this->names[$type] : null;
    }    
    
	public function get_document($id)
	{
		$query = $this->db->placehold("
            SELECT * 
            FROM __documents
            WHERE id = ?
        ", (int)$id);
        $this->db->query($query);
        if ($result = $this->db->result())
            $result->params = unserialize($result->params);

        return $result;
    }
    
	public function get_documents($filter = array())
	{
		$id_filter = '';
		$user_id_filter = '';
		$order_id_filter = '';
		$contract_id_filter = '';
		$client_visible_filter = '';
        $keyword_filter = '';
        $limit = 1000;
		$page = 1;
        
        if (!empty($filter['id']))
            $id_filter = $this->db->placehold("AND id IN (?@)", array_map('intval', (array)$filter['id']));
        
        if (!empty($filter['user_id']))
            $user_id_filter = $this->db->placehold("AND user_id IN (?@)", array_map('intval', (array)$filter['user_id']));
        
        if (!empty($filter['order_id']))
            $order_id_filter = $this->db->placehold("AND order_id IN (?@)", array_map('intval', (array)$filter['order_id']));
        
        if (!empty($filter['contract_id']))
            $contract_id_filter = $this->db->placehold("AND contract_id IN (?@)", array_map('intval', (array)$filter['contract_id']));
        
        if (isset($filter['client_visible']))
            $client_visible_filter = $this->db->placehold("AND client_visible = ?", (int)$filter['client_visible']);
        
		if(isset($filter['keyword']))
		{
			$keywords = explode(' ', $filter['keyword']);
			foreach($keywords as $keyword)
				$keyword_filter .= $this->db->placehold('AND (name LIKE "%'.$this->db->escape(trim($keyword)).'%" )');
		}
        
		if(isset($filter['limit']))
			$limit = max(1, intval($filter['limit']));

		if(isset($filter['page']))
			$page = max(1, intval($filter['page']));
            
        $sql_limit = $this->db->placehold(' LIMIT ?, ? ', ($page-1)*$limit, $limit);

        $query = $this->db->placehold("
            SELECT * 
            FROM __documents
            WHERE 1
                $id_filter
        		$user_id_filter
        		$order_id_filter
        		$contract_id_filter
                $client_visible_filter
 	            $keyword_filter
            ORDER BY id ASC 
            $sql_limit
        ");
        $this->db->query($query);
        if ($results = $this->db->results())
        {
            foreach ($results as $result)
            {
                $result->params = unserialize($result->params);
            }
        }
        
        return $results;
	}
    
	public function count_documents($filter = array())
	{
        $id_filter = '';
		$user_id_filter = '';
		$order_id_filter = '';
		$contract_id_filter = '';
        $client_visible_filter = '';
        $keyword_filter = '';
        
        if (!empty($filter['id']))
            $id_filter = $this->db->placehold("AND id IN (?@)", array_map('intval', (array)$filter['id']));
		
        if (!empty($filter['user_id']))
            $user_id_filter = $this->db->placehold("AND user_id IN (?@)", array_map('intval', (array)$filter['user_id']));
        
        if (!empty($filter['order_id']))
            $order_id_filter = $this->db->placehold("AND order_id IN (?@)", array_map('intval', (array)$filter['order_id']));
        
        if (!empty($filter['contract_id']))
            $contract_id_filter = $this->db->placehold("AND contract_id IN (?@)", array_map('intval', (array)$filter['contract_id']));
        
        if (isset($filter['client_visible']))
            $client_visible_filter = $this->db->placehold("AND client_visible = ?", (int)$filter['client_visible']);
        
        if(isset($filter['keyword']))
		{
			$keywords = explode(' ', $filter['keyword']);
			foreach($keywords as $keyword)
				$keyword_filter .= $this->db->placehold('AND (name LIKE "%'.$this->db->escape(trim($keyword)).'%" )');
		}
                
		$query = $this->db->placehold("
            SELECT COUNT(id) AS count
            FROM __documents
            WHERE 1
                $id_filter
        		$user_id_filter
        		$order_id_filter
        		$contract_id_filter
                $client_visible_filter
                $keyword_filter
        ");
        $this->db->query($query);
        $count = $this->db->result('count');
	
        return $count;
    }
    
    public function add_document($document)
    {
        $document = (array)$document;
        
        if (isset($document['params']))
            $document['params'] = serialize($document['params']);
        
		$query = $this->db->placehold("
            INSERT INTO __documents SET ?%
        ", $document);
        $this->db->query($query);
        $id = $this->db->insert_id();
//echo __FILE__.' '.__LINE__.'<br /><pre>';var_dump($query);echo '</pre><hr />';exit;
        return $id;
    }
    
    public function update_document($id, $document)
    {
        $document = (array)$document;
        
        if (isset($document['params']))
            $document['params'] = serialize($document['params']);
        
		$query = $this->db->placehold("
            UPDATE __documents SET ?% WHERE id = ?
        ", $document, (int)$id);
        $this->db->query($query);
        
        return $id;
    }
    
    public function delete_document($id)
    {
		$query = $this->db->placehold("
            DELETE FROM __documents WHERE id = ?
        ", (int)$id);
        $this->db->query($query);
    }
}