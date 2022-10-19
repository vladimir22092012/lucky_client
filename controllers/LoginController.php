<?php

class LoginController extends Controller
{

    function fetch()
    {
        // Выход
        if ($this->request->get('action') == 'logout') {
            unset($_SESSION['user_id']);
            unset($_SESSION['looker_mode']);
            if ($this->config->root_url != $this->config->front_url) {
                header('Location: ' . $this->config->front_url . '/lk/logout');
                exit();
            } else {
                header('Location: ' . $this->config->root_url);
                exit();
            }
        } // Вход
        elseif ($this->request->method('post')) {
            $phone = $this->request->post('phone', 'string');
            $code = $this->request->post('code', 'string');
            $password = $this->request->post('password');

            $clean_phone = $this->sms->clear_phone($phone);

            $error = NULL;
            if (!empty($password)) {
                if (!($user_id = $this->users->check_password($clean_phone, $password))) {
                    $error = 'Пароль не совпадает';
                }
            } else {
                $db_code = $this->sms->get_code($clean_phone);
                if ($db_code != $code) {
                    $error = 'Код из СМС не совпадает';
                }
            }

            if (empty($error)) {
                // клиента нет в 1с но есть в базе
                if ($user_id = $this->users->get_phone_user($clean_phone)) {
                    $_SESSION['user_id'] = $user_id;

                    $user = $this->users->get_user($user_id);

                    $update = array(
                        'last_ip' => $_SERVER['REMOTE_ADDR'],
                    );
                    if (!empty($user->password_sent_wa)) {
                        // записываем в базу что вотсапп активен
                        $update['wa_enabled'] = 1;
                        $update['password_sent_wa'] = 0;
                    }
                    $this->users->update_user($user_id, $update);

                    if (empty($this->is_developer)) {
                        $this->authorizations->add_authorization(array(
                            'user_id' => $user_id,
                            'ip' => $_SERVER['REMOTE_ADDR'],
                            'created' => date('Y-m-d H:i:s'),
                            'user_agent' => $_SERVER['HTTP_USER_AGENT']
                        ));
                    }

                    header('Location: /account');
                    exit;
                } else {
                    $this->design->assign('message_error', 'Пользователь с номером телефона ' . $phone . ' не найден');
                }

                if (!empty($user_id)) {
                    $_SESSION['user_id'] = $user_id;

                    $this->users->update_user($user_id, array('last_ip' => $_SERVER['REMOTE_ADDR'], 'UID' => $resp_1c->uid));

                    // проверяем есть ли открытый займ
                    $balance = $this->soap1c->get_user_balance($resp_1c->uid);
                    $this->import1c->import_balance($user_id, $balance);

                    // сохраняем историю займов из 1с
                    $credits_history = $this->soap1c->get_client_credits($resp_1c->uid);
                    $this->users->save_loan_history($user_id, $credits_history);

                    if (empty($this->is_developer)) {
                        $this->authorizations->add_authorization(array(
                            'user_id' => $user_id,
                            'ip' => $_SERVER['REMOTE_ADDR'],
                            'created' => date('Y-m-d H:i:s'),
                            'user_agent' => $_SERVER['HTTP_USER_AGENT']
                        ));
                    }

                    header('Location: /account');
                    exit;
                }
            } else {
                $this->design->assign('message_error', 'Произошла ошибка');
            }
        }

        if (isset($_SESSION['splash'])) {
            $this->design->assign('message_error', $_SESSION['splash']);
            $_SESSION['splash'] = NULL;
        }


        return $this->design->fetch('login.tpl');
    }
}
