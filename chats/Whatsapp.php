<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Whatsapp
 *
 * @author alexey
 */
include_once ROOT . DIRECTORY_SEPARATOR . 'core' . DIRECTORY_SEPARATOR . 'Core.php';
include_once ROOT . DIRECTORY_SEPARATOR . 'core' . DIRECTORY_SEPARATOR . 'Config.php';
include_once ROOT . DIRECTORY_SEPARATOR . 'core' . DIRECTORY_SEPARATOR . 'Db.php';
include_once ROOT . DIRECTORY_SEPARATOR . 'models' . DIRECTORY_SEPARATOR . 'Users.php';

class Whatsapp
{

    private $token;
    private $instans;
    private $url;
    private $phone;
    private $text;

    public $headers = [
        100 => '100 Continue',
        101 => '101 Switching Protocols',
        103 => '103 Early Hints',
        200 => '200 OK',
        201 => '201 Created',
        202 => '202 Accepted',
        203 => '203 Non-Authoritative Information',
        204 => '204 No Content',
        205 => '205 Reset Content',
        206 => '206 Partial Content',
        300 => '300 Multiple Choices',
        301 => '301 Moved Permanently',
        302 => '302 Found',
        303 => '303 See Other',
        304 => '304 Not Modified',
        307 => '307 Temporary Redirect',
        308 => '308 Permanent Redirect',
        400 => '400 Bad Request',
        401 => '401 Unauthorized',
        402 => '402 Payment Required',
        403 => '403 Forbidden',
        404 => '404 Not Found',
        405 => '405 Method Not Allowed',
        406 => '406 Not Acceptable',
        407 => '407 Proxy Authentication Required',
        408 => '408 Request Timeout',
        409 => '409 Conflict',
        410 => '410 Gone',
        411 => '411 Length Required',
        412 => '412 Precondition Failed',
        413 => '413 Payload Too Large',
        414 => '414 URI Too Long',
        415 => '415 Unsupported Media Type',
        416 => '416 Range Not Satisfiable',
        417 => '417 Expectation Failed',
        418 => "418 I'm a teapot",
        422 => '422 Unprocessable Entity',
        425 => '425 Too Early',
        426 => '426 Upgrade Required',
        428 => '428 Precondition Required',
        429 => '429 Too Many Requests',
        431 => '431 Request Header Fields Too Large',
        451 => '451 Unavailable For Legal Reasons',
        500 => '500 Internal Server Error',
        501 => '501 Not Implemented',
        502 => '502 Bad Gateway',
        503 => '503 Service Unavailable',
        504 => '504 Gateway Timeout',
        505 => '505 HTTP Version Not Supported',
        506 => '506 Variant Also Negotiates',
        507 => '507 Insufficient Storage',
        508 => '508 Loop Detected',
        510 => '510 Not Extended',
        511 => '511 Network Authentication Required',
        0 => 'Error request'
    ];


    /**
     * Конструктор класса
     */
    public function __construct()
    {
        $_SESSION['chat_type'] = 'whatsapp';
        if (isset($_GET['phone'])) {
            if ($_GET['phone']) {
                $this->phone = (int) $this->preparePhone($_GET['phone']);
                $_SESSION['phone'] = $this->phone;
            }
        }
        if (isset($_GET['text'])) {
            if ($_GET['text']) {
                $this->text = $_GET['text'];
            }
        }
        $this->token = '?token=' . 'jlvz3h2fbrwcdt77';
        $this->instans = '353173';
        $this->url = 'https://api.chat-api.com/instance' . $this->instans . '/';
    }

    /**
     * Отправка сообщения получателю по номеру телефона
     * @param string|int $phone
     * @param string $text
     * @return object
     */
    public function sendMessage($phone=false, $text=false)
    {
        if(!$phone){
        $phone = $this->phone;
        }
        if(!$text){
            $text = $this->text;
        }
        $url = $this->url . 'sendMessage' . $this->token;
        $data = [
            'phone' => (int) $this->preparePhone($phone),
            'body' => (string) $text,
        ];
        $curl = $this->curlInit($url);
        curl_setopt($curl, CURLOPT_POST, 1);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        return $this->curlClose($curl);
    }

    public function curlInit($url, $curlHeaders = ['application/json']) {
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_HTTPHEADER, $curlHeaders);
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        return $curl;
    }

    public function curlClose($curl) {
        $curlResponse = curl_exec($curl);
        $curlResponseCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        $res = json_decode($curlResponse);
        $header = $this->headers[$curlResponseCode];
        curl_close($curl);
        return json_encode((object)['ResponseCode' => $curlResponseCode, 'Data' => $res, 'Header' => $header]);
    }

    public function preparePhone($phone)
    {
        if (is_string($phone) or is_integer($phone)) {
            $phone = preg_replace('/\D+/iu', '', $phone);
            settype($phone, 'integer');
            return (int) $phone;
        }
    }

    public function ressetPassword($phone = false)
    {
        $simbols = [1,2,3,4,5,6,7,8,9,0,
            'q','w','r','t','y','u','i','o','p','a','s','d','f','g','h','j','k','l','z','x','c','v','b','n','m'
            ,'Q','W','E','R','T','Y','U','I','O','P','A','S','D','F','G','H','J','K','L','Z','X','C','V','B','N','M'
            ];
        $lenghtNewPassword = rand(6, 10);
        $newPassword = '';
        $count = count($simbols) -1;
        for($i = 0; $i < $lenghtNewPassword; $i++){
            $newPassword .= $simbols[rand(0,  $count)];
        }
        if (!$phone) {
            $phone = $this->phone;
        }
        $userObj = new Users();
        $userId = $userObj->get_phone_user($phone);
        if($userId){
            $userObj->update_user($userId, ['password' => $newPassword, 'password_sent_wa' => 1]);
            $msg = "Ваш новый пароль для входа в ЛК : \n\n" . $newPassword. "\n ";
            return $this->sendMessage($phone, $msg);
        }

    }

     public function newCodeGenerate($phone)
    {
        $code = rand(1000, 9999);
        $_SESSION['code'] = $code;
        $msg = 'Ваш код для входа в ЛК : ' . $code;
        return $msg;
    }
    /**
     * отправляем код верификации
     * @param string|int $phone
     */
    public function sendCode($phone = false)
    {
        if (!$phone) {
            $phone = $this->phone;
        }
        return $this->sendMessage($phone, $this->newCodeGenerate($phone));
    }
}
