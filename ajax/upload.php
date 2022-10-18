<?php
header('Access-Control-Allow-Origin: *');

session_start();

chdir('..');
require('autoload.php');


class UploadApp extends Core
{
    private $response;
    private $user;
    
    private $max_file_size = 5242880;
    
    public function __construct()
    {
        parent::__construct();
        
        $this->response = new StdClass();
        
        $this->run();
        
        $this->output();
    }
    
    public function run()
    {
        if (!empty($_SESSION['user_id']))
            $this->user = $this->users->get_user((int)$_SESSION['user_id']);
        elseif ($user_id = $this->request->post('user_id', 'integer'))
            $this->user = $this->users->get_user($user_id);
            
        if (empty($this->user))
        {
            $this->response->error = 'unknown_user';
        }
        else
        {
            
            switch ($this->request->post('action', 'string')) :
                
                case 'add':
                    $this->add();
                break;
                
                case 'remove':
                    $this->remove();
                break;
                
                default:
                    $this->response->error = 'undefined action';
                
            endswitch;
            
        }
    }
    
    private function add()
    {
    	if ($file = $this->request->files('file'))
        {
            if ($type = $this->request->post('type', 'string'))
            {
                if ($this->max_file_size > $file['size'])
                {
                    $ext = pathinfo($file['name'], PATHINFO_EXTENSION);
                    do {
      		            $new_filename = md5(microtime().rand()).'.'.$ext;
      		        } while ($this->users->check_filename($new_filename));
                        
                    if (move_uploaded_file($file['tmp_name'], $this->config->root_dir.$this->config->user_files_dir.$new_filename))
                    {
                        $this->response->filename = $this->config->root_url.'/'.$this->config->user_files_dir.$new_filename;
                        
                        
                        if (!$this->request->post('notreplace'))    
                        {
//                            $old_files = $this->users->get_files(array('user_id'=>$this->user->id, 'type'=>$type));
//                            foreach ($old_files as $old_file)
//                                $this->users->delete_file($old_file->id);
                        }
                        
                        $file_id = $this->response->id = $this->users->add_file(array(
                            'user_id' => $this->user->id,
                            'name' => $new_filename,
                            'type' => $type,
                            'status' => 0
                        ));
                        
                        if ($card_id = $this->request->post('card_id', 'integer'))
                        {
                            $this->cards->update_card($card_id, array('file_id' => $file_id));
                        }
                        
                        $this->response->success = 'added';
                    }
                    else
                    {
                        $this->response->error = 'error_uploading';
                    }
                }
                else
                {
                    $this->response->error = 'max_file_size';
                    $this->response->max_file_size = $this->max_file_size;
                }
            }
            else
            {
                $this->response->error = 'empty_type';
            }

//echo __FILE__.' '.__LINE__.'<br /><pre>';var_dump($file);echo '</pre><hr />';            
        }
        else
        {
            $this->response->error = 'empty_file';
        }
    } 
    
    private function remove()
    {
        if ($id = $this->request->post('id', 'integer'))
        {
            $this->users->delete_file($id);
            
            $this->response->success = 'removed';
            
        }
        else
        {
            $this->response->error = 'empty_file_id';
        }
    } 
    
    private function output()
    {
   		header("Content-type: application/json; charset=UTF-8");
    	header("Cache-Control: must-revalidate");
    	header("Pragma: no-cache");
    	header("Expires: -1");		
        
        echo json_encode($this->response);
        exit();
    }
    
}


new UploadApp();

