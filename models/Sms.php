<?php

//define("SMS_LOGIN", "v.kalinin.63@yandex.ru");
//define("SMS_PASSWORD", "dfAf#42!3");

define("SMS_LOGIN", "MKKNplus");
define("SMS_PASSWORD", "mkk_n_123456");

require_once 'Smsru.php';

class Sms extends Core
{
    private $login;
    private $password;
    private $originator;
    private $connect_id;
    
    private $aero_login;
    private $aero_api_key;
    
    public function __construct()
    {
    	parent::__construct();
        
        //$this->login = $this->settings->apikeys['sms']['login'];
        //$this->password = $this->settings->apikeys['sms']['password'];
        //$this->originator = $this->settings->apikeys['sms']['originator'];
        //$this->connect_id = $this->settings->apikeys['sms']['connect_id'];

        //$this->aero_login = 'webmaster@finreactor.ru';
        //$this->aero_api_key = '4ITlid0NnDePJe0awybOA5IxCv4g';

    }
    
    public function clear_phone($phone)
    {
        $remove_symbols = array(
            '(', 
            ')', 
            '-', 
            ' ', 
            '+'
        );
        $clear_phone = str_replace($remove_symbols, '', $phone);

        if (substr($clear_phone, 0, 1) == 8)
            $clear_phone = '7'.substr($clear_phone, 1);
        
        return $clear_phone;
    }
    
    public function send($phone, $message)
    {
        $phone = $this->clear_phone($phone);

        $api_code = 'CEC47EEB-DA21-5CDB-9431-7E53B513FAA5';

        $smsru = new SMSRU($api_code);

        $data = new stdClass();
        $data->to = $phone;
        $data->text = $message;

        $sms = $smsru->send_one($data);

        if ($sms->status == "OK") { // Запрос выполнен успешно
            $resp = "Сообщение отправлено успешно";
        } else {
            $resp = "Текст ошибки: $sms->status_text".' Телефон: '.$phone.' Сообщение: '.$message;
        }

        return $resp;
    }

    public function send_code_via_call($phone)
    {
        $url = 'https://smsc.ru/sys/send.php?login=' . SMS_LOGIN . '&psw=' . SMS_PASSWORD . '&phones=' . $phone . '&mes=code&call=3';
        $resultString = file_get_contents($url);
//echo __FILE__.' '.__LINE__.'<br /><pre>';var_dump($url);echo '</pre><hr />';
        return $resultString;
    }
    

    public function send_code_aero_call($phone, $code)
    {
        
        $url =  'http://gate.smsaero.ru/v2/flashcall/send';
        
        $post = array(
            'phone' => $this->clear_phone($phone),
            'code' => $code,
        );
        
        $ch = curl_init($url);

        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post));
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
        curl_setopt($ch, CURLOPT_FRESH_CONNECT, 1);
        curl_setopt($ch, CURLOPT_FORBID_REUSE, 1);

        curl_setopt($ch, CURLOPT_USERPWD, $this->aero_login.':'.$this->aero_api_key);
        curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);

        $resp = curl_exec($ch);
        
        $er = curl_error($ch);
        
//echo __FILE__.' '.__LINE__.'<br /><pre>';var_dump($er, $url, $resp);echo '</pre><hr />';
        curl_close($ch);

$log = PHP_EOL.http_build_query($post).PHP_EOL.$resp.PHP_EOL;
file_put_contents($this->config->root_dir.'logs/aero.log', $log, FILE_APPEND);
        
        return json_decode($resp);
    }
    
    public function get_status_aero_call($id)
    {
        $url =  'http://gate.smsaero.ru/v2/flashcall/status';
        
        $post = array(
            'id' => $id,
        );
        
        $ch = curl_init($url);

        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post));
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
        curl_setopt($ch, CURLOPT_FRESH_CONNECT, 1);
        curl_setopt($ch, CURLOPT_FORBID_REUSE, 1);

        curl_setopt($ch, CURLOPT_USERPWD, $this->aero_login.':'.$this->aero_api_key);
        curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);

        $resp = curl_exec($ch);
        
        $er = curl_error($ch);
        
//echo __FILE__.' '.__LINE__.'<br /><pre>';var_dump($er, $url, $resp);echo '</pre><hr />';
        curl_close($ch);

$log = PHP_EOL.http_build_query($post).PHP_EOL.$resp.PHP_EOL;
file_put_contents($this->config->root_dir.'logs/aero.log', $log, FILE_APPEND);
        
        return json_decode($resp);


    }
        
    public function get_code($phone)
    {
    	$query = $this->db->placehold("
            SELECT code
            FROM __sms_messages
            WHERE phone = ?
            ORDER BY id DESC
            LIMIT 1
        ", $this->clear_phone($phone));
        $this->db->query($query);
        
        $code = $this->db->result('code');
        
        return $code;
    }
    
	public function get_message($id)
	{
		$query = $this->db->placehold("
            SELECT * 
            FROM __sms_messages
            WHERE id = ?
        ", (int)$id);
        $this->db->query($query);
        $result = $this->db->result();
	
        return $result;
    }
    
	public function get_messages($filter = array())
	{
		$id_filter = '';
        $keyword_filter = '';
        $phone_filter = '';
        $limit = 1000;
		$page = 1;
        
        if (!empty($filter['id']))
            $id_filter = $this->db->placehold("AND id IN (?@)", array_map('intval', (array)$filter['id']));
        
        if (!empty($filter['phone']))
            $phone_filter = $this->db->placehold("AND phone = ?", $this->clear_phone($filter['phone']));
		
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
            FROM __sms_messages
            WHERE 1
                $id_filter
                $phone_filter
				$keyword_filter
            ORDER BY id DESC 
            $sql_limit
        ");
        $this->db->query($query);
        $results = $this->db->results();
        
        return $results;
	}
    
	public function count_messages($filter = array())
	{
        $id_filter = '';
        $phone_filter = '';
        $keyword_filter = '';
        
        if (!empty($filter['id']))
            $id_filter = $this->db->placehold("AND id IN (?@)", array_map('intval', (array)$filter['id']));
		
        if (!empty($filter['phone']))
            $phone_filter = $this->db->placehold("AND phone = ?", $this->clear_phone($filter['phone']));
		
        if(isset($filter['keyword']))
		{
			$keywords = explode(' ', $filter['keyword']);
			foreach($keywords as $keyword)
				$keyword_filter .= $this->db->placehold('AND (name LIKE "%'.$this->db->escape(trim($keyword)).'%" )');
		}
                
		$query = $this->db->placehold("
            SELECT COUNT(id) AS count
            FROM __sms_messages
            WHERE 1
                $id_filter
                $phone_filter
                $keyword_filter
        ");
        $this->db->query($query);
        $count = $this->db->result('count');
	
        return $count;
    }
    
    public function add_message($message)
    {
		$message = (array)$message;
        
        if (isset($message['phone']))
            $message['phone'] = $this->clear_phone($message['phone']);
        
        $query = $this->db->placehold("
            INSERT INTO __sms_messages SET ?%
        ", $message);
        $this->db->query($query);
        $id = $this->db->insert_id();
        
        return $id;
    }
    
    public function update_message($id, $message)
    {
		$message = (array)$message;
        
        if (isset($message['phone']))
            $message['phone'] = $this->clear_phone($message['phone']);
        
		$query = $this->db->placehold("
            UPDATE __sms_messages SET ?% WHERE id = ?
        ", $message, (int)$id);
        $this->db->query($query);
        
        return $id;
    }
    
    public function delete_message($id)
    {
		$query = $this->db->placehold("
            DELETE FROM __sms_messages WHERE id = ?
        ", (int)$id);
        $this->db->query($query);
    }
    
}