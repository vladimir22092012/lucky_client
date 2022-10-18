<?php

class Documents extends Core
{
    private $templates = array(
        'ANKETA_PEP' => 'anketa-zayavlenie-pep.finfive.tpl',
        'SOLGLASHENIE_PEP' => 'soglashenie-pep.tpl',
        'SOGLASIE_VZAIMODEYSTVIE' => 'soglasie-na-vzaimodeystvie.01072021.tpl',
        'SOGLASIE_MEGAFON' => 'soglasie-dlya-megafona.tpl',
        'SOGLASIE_SCORING' => 'soglasie-dlya-skoringa.tpl',
        'SOGLASIE_SPISANIE' => 'soglasie-na-spisanie.tpl',
        'PRICHINA_OTKAZA' => 'zayavlenie-na-uslugu-uznay-prichinu-otkaza.tpl',
        'DOP_SOGLASHENIE_PROLONGATSIYA' => 'dopolnitelnoe-soglashenie-o-prolongatsii.finfive.tpl',

        'IND_USLOVIYA_NL' => 'individualnie-usloviya.finfive.tpl',
        'POLIS_STRAHOVANIYA' => 'polis-strahovaniya.03032022.tpl',
        'DOP_USLUGI_VIDACHA' => 'soglasie-na-okazanie-dopuslugi-pri-vidache.21012022.tpl',

        'DOP_USLUGI_PROLONGATSIYA' => 'soglasie-na-okazanie-dopuslugi-pri-prolongatsii.tpl',
        
        'SUD_PRIKAZ' => 'sudblock_prikaz.tpl',
        'SUD_SPRAVKA' => 'sudblock_spravka.tpl',
        'SUD_VOZBUZHDENIE' => 'sudblock_spravka.tpl',
        
        'OFFLINE_AKT_CONSULTATION' => 'offline/akt_consultation.tpl',
        'OFFLINE_ANKETA' => 'offline/anketa.tpl',
        'OFFLINE_DOGOVOR' => 'offline/dogovor.tpl',
        'OFFLINE_DOGOVOR_CONSULTATION' => 'offline/dogovor_consultation.tpl',
        'OFFLINE_DOP_SOGLASHENIE' => 'offline/dop_soglashenie.tpl',
        'OFFLINE_PKO' => 'offline/pko.tpl',
        'OFFLINE_RKO' => 'offline/rko.tpl',
        'OFFLINE_ASP' => 'offline/soglashenie_asp.tpl',
        'OFFLINE_OBRABOTKA' => 'offline/soglasie_na_obrabotku.tpl',
        'OFFLINE_INFORM' => 'offline/zayavlenie_inform.tpl',
        'OFFLINE_SMS' => 'offline/zayavlenie_sms.tpl',
        'OFFLINE_ZAKRYTIE' => 'offline/spravka_zakrytie.tpl',
    );
    
    
    private $names = array(
        'ANKETA_PEP' => 'Анкета - заявление ПЭП',
        'SOLGLASHENIE_PEP' => 'Соглашение об использовании ПЭП',
        'SOGLASIE_VZAIMODEYSTVIE' => 'Согласие на взаимодействие',
        'SOGLASIE_MEGAFON' => 'Согласие для мегафона',
        'SOGLASIE_SCORING' => 'Согласие для скоринга',
        'SOGLASIE_SPISANIE' => 'Согласие на списание',
        'PRICHINA_OTKAZA' => 'Заявление на услугу Узнай причину отказа',
        'DOP_SOGLASHENIE_PROLONGATSIYA' => 'Дополнительное соглашение',

        'IND_USLOVIYA_NL' => 'Индивидуальные условия',
        'POLIS_STRAHOVANIYA' => 'Полис страхования',
        'DOP_USLUGI_VIDACHA' => 'Заявление на страхование',

        'DOP_USLUGI_PROLONGATSIYA' => 'Согласие на оказание доп услуги при пролонгации',
        
        'SUD_PRIKAZ' => 'Заявление о вынесении судебного приказа',
        'SUD_SPRAVKA' => 'Справка',
        'SUD_VOZBUZHDENIE' => 'Заявление о возбуждении испольнительного производства',
        
        'OFFLINE_AKT_CONSULTATION' => 'Акт об оказании услуг к договору',
        'OFFLINE_ANKETA' => 'Электронная анкета ЦБ',
        'OFFLINE_DOGOVOR' => 'Договор на оказание услуг к договору',
        'OFFLINE_DOGOVOR_CONSULTATION' => 'Договор оказания консультационных услуг',
        'OFFLINE_DOP_SOGLASHENIE' => 'Дополнительное соглашение',
        'OFFLINE_PKO' => 'Приходный кассовый ордер',
        'OFFLINE_RKO' => 'Расходный кассовый ордер',
        'OFFLINE_ASP' => 'Соглашение на ПЭП',
        'OFFLINE_OBRABOTKA' => 'Согласие на обработку и взаимодействие',
        'OFFLINE_INFORM' => 'Бот информирование',
        'OFFLINE_SMS' => 'Смс информирование',
        'OFFLINE_ZAKRYTIE' => 'Справка о закрытии',
    );
    
    private $client_visible = array(
        'ANKETA_PEP' => 0,
        'SOLGLASHENIE_PEP' => 1,
        'SOGLASIE_VZAIMODEYSTVIE' => 0,
        'SOGLASIE_MEGAFON' => 0,
        'SOGLASIE_SCORING' => 0,
        'SOGLASIE_SPISANIE' => 0,
        'PRICHINA_OTKAZA' => 0,
        'DOP_SOGLASHENIE_PROLONGATSIYA' => 1,
        
        'IND_USLOVIYA_NL' => 1,
        'POLIS_STRAHOVANIYA' => 1,
        'DOP_USLUGI_VIDACHA' => 1,

        'DOP_USLUGI_PROLONGATSIYA' => 0,
        
        'SUD_PRIKAZ' => 0,
        'SUD_SPRAVKA' => 0,
        'SUD_VOZBUZHDENIE' => 0,

        'OFFLINE_AKT_CONSULTATION' => 0,
        'OFFLINE_ANKETA' => 0,
        'OFFLINE_DOGOVOR' => 0,
        'OFFLINE_DOGOVOR_CONSULTATION' => 0,
        'OFFLINE_DOP_SOGLASHENIE' => 0,
        'OFFLINE_PKO' => 0,
        'OFFLINE_RKO' => 0,
        'OFFLINE_ASP' => 0,
        'OFFLINE_OBRABOTKA' => 0,
        'OFFLINE_INFORM' => 0,
        'OFFLINE_SMS' => 0,
        'OFFLINE_ZAKRYTIE' => 0,
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