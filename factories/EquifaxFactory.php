<?php

class EquifaxFactory
{
    public static function get($triggerName)
    {
        switch ($triggerName)
        {
            case 'pay':
                return new PayReport();
                break;

            case 'close':
                return new ClosePayReport();
                break;

            case 'pending':
                return new PendingReport();
                break;
        }
    }
}