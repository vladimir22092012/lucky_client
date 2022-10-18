<?php

class IndexController extends Controller
{
    public $modules_dir = 'controllers/';

    public function __construct()
    {
        parent::__construct();
    }

    function fetch()
    {

        // Страницы
        $pages = $this->pages->get_pages(array('visible' => 1));
        $this->design->assign('pages', $pages);

        // Текущий модуль (для отображения центрального блока)
        $module = $this->request->get('module', 'string');
        $module = preg_replace("/[^A-Za-z0-9]+/", "", $module);


        if (class_exists($module)) {
            $this->main = new $module($this);
        } else {
            return false;
        }

        if (!$content = $this->main->fetch()) {
            return false;
        }

        $this->design->assign('content', $content);
        $this->design->assign('module', $module);

        $cookie_inspiration = 60 * 60 * 24 * 30;

        $integrations = $this->Integrations->get_integrations();

        foreach ($integrations as $integration){
            $utm_source = $this->request->get($integration->utm_source_name);
        }

        if (!empty($utm_source)) {

            $webmaster_id = $this->request->get('wm_id');
            $click_hash = $this->request->get('clickid');
            setcookie("wm_id", $webmaster_id, time() + $cookie_inspiration, '/', $this->config->main_domain);
            setcookie("clickid", $click_hash, time() + $cookie_inspiration, '/', $this->config->main_domain);

            $integration = $this->Integrations->get_integration(array('source' => $utm_source));

            if(!empty($integration)){
                $utm_medium = $this->request->get($integration->utm_medium_name);
                $utm_campaign = $this->request->get($integration->utm_campaign_name);
                $utm_term = $this->request->get($integration->utm_term_name);
                $utm_content = $this->request->get($integration->utm_content_name);
            }

            setcookie("utm_source", trim($utm_source), time() + $cookie_inspiration, '/', $this->config->main_domain);

            if (!empty($utm_medium))
                setcookie("utm_medium", trim($utm_medium), time() + $cookie_inspiration, '/', $this->config->main_domain);

            if (!empty($utm_campaign))
                setcookie("utm_campaign", trim($utm_campaign), time() + $cookie_inspiration, '/', $this->config->main_domain);

            if (!empty($utm_term))
                setcookie("utm_term", trim($utm_term), time() + $cookie_inspiration, '/', $this->config->main_domain);

            if (!empty($utm_content))
                setcookie("utm_content", trim($utm_content), time() + $cookie_inspiration, '/', $this->config->main_domain);
        }

        $wrapper = $this->design->get_var('wrapper');
        if (isset($this->user->contract->status) && !in_array($this->user->contract->status, [3,6]) && $this->user->contract->sold) // цессия
        {

            if (empty($this->user->contract->premier)) {
                if ($this->config->root_url != $this->config->cession_url) {
                    $redirect_token = md5(rand() . microtime());
                    $this->users->update_user($_SESSION['user_id'], array('redirect_token' => $redirect_token));

                    setcookie('redirect_token', $redirect_token, time() + 30, '/', '.' . $this->config->main_domain);
                    setcookie('user_id', $_SESSION['user_id'], time() + 30, '/', '.' . $this->config->main_domain);

                    if (!empty($_SESSION['looker']))
                        setcookie('looker', 1, time() + 30, '/', '.' . $this->config->main_domain);

                    header('Location: ' . $this->config->cession_url . $this->request->url());
                    exit;
                } else {
                    $wrapper = 'cession/index.tpl';
                }
            } else {

                if ($this->config->root_url != $this->config->premier_url) {
                    $redirect_token = md5(rand() . microtime());
                    $this->users->update_user($_SESSION['user_id'], array('redirect_token' => $redirect_token));

                    setcookie('redirect_token', $redirect_token, time() + 30, '/', '.' . $this->config->main_domain);
                    setcookie('user_id', $_SESSION['user_id'], time() + 30, '/', '.' . $this->config->main_domain);

                    if (!empty($_SESSION['looker']))
                        setcookie('looker', 1, time() + 30, '/', '.' . $this->config->main_domain);

                    header('Location: ' . $this->config->premier_url . $this->request->url());
                    exit;
                } else {
                    $wrapper = 'cession/premier_index.tpl';
                }
            }
        } elseif (is_null($wrapper)) {
            if ($module != 'C2oPaymentController' && $this->config->root_url != $this->config->front_url) {
                $redirect_token = md5(rand() . microtime());
                if (!empty($_SESSION['user_id']))
                {
                    $this->users->update_user($_SESSION['user_id'], array('redirect_token' => $redirect_token));
    
                    setcookie('redirect_token', $redirect_token, time() + 30, '/', '.' . $this->config->main_domain);
                    setcookie('user_id', $_SESSION['user_id'], time() + 30, '/', '.' . $this->config->main_domain);
                }
                if (!empty($_SESSION['looker']))
                    setcookie('looker', 1, time() + 30, '/', '.' . $this->config->main_domain);

                header('Location: ' . $this->config->front_url . $this->request->url());
                exit;
            } else {
                $wrapper = 'index.tpl';
            }

        }


        if (!empty($wrapper))
            return $this->body = $this->design->fetch($wrapper);
        else
            return $this->body = $content;

    }
}
