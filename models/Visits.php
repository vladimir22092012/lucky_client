<?php

class Visits extends Core
{
    public function add_visit($visit)
    {
        $query = $this->db->placehold("
            INSERT INTO __visits SET ?%
        ", (array)$visit);

        $this->db->query($query);

        $id = $this->db->insert_id();

        return $id;
    }
}