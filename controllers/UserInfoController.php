<?php

class UserInfoController extends Controller
{
    public function fetch()
    {
        return $this->design->fetch('user_info.tpl');
    }
}