<?php

chdir('..');

require 'autoload.php';
require_once 'models/Hashids.php';

class ShortRejectLink extends Ajax
{
    public function run() {
        $code = $this->request->get('code');

        if ($code) {
            $hashids = new Hashids();
    
            //$id = $hashids->encode($code);
            $id = $hashids->decode($code);
        
            //var_dump($id);
            //exit;
            //$user = $this->users->get_user($id);

            $query = $this->db->placehold("
                SELECT * 
                FROM __users
                WHERE phone_mobile = ?
            ", (int)$id[0]);

            $this->db->query($query);

            $user = $this->db->result();

            //echo __FILE__.' '.__LINE__.'<br /><pre>';var_dump($user, $id[0]);echo '</pre><hr />';

            //exit;
            header('Location: https://sapsanzaim.ru/?phone='.$user->phone_mobile);
            exit;
        }
    
        $this->response['error'] = 'empty_code';
        $this->output();
    }
}

$ajax = new ShortRejectLink();
$ajax->run();
