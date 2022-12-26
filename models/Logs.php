<?php

class Logs extends Core
{
    public function add($log)
    {
        $query = $this->db->placehold("
            INSERT INTO s_logs SET ?%
        ", $log);
        $this->db->query($query);

        return 1;
    }
}