<?php

class OnecLogs extends Core
{
    public function add($log)
    {
        $query = $this->db->placehold("
            INSERT INTO s_onec_logs SET ?%
        ", (array)$log);

        $this->db->query($query);
        $id = $this->db->insert_id();

        return $id;
    }
}