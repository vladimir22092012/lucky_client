<?php

error_reporting(-1);
ini_set('display_errors', 'On');

class Integrations extends Core
{
    public function get_integration($filter)
    {
        $source_name_filter = '';
        $source_filter = '';

        if(isset($filter['source_name']))
            $source_name_filter = $this->db->placehold("AND utm_source_name = ?", $filter['source_name']);

        if(isset($filter['source']))
            $source_filter = $this->db->placehold("AND utm_source = ?", $filter['source']);

        $query = $this->db->placehold("
            SELECT * 
            FROM __integrations
            WHERE 1
            $source_name_filter
            $source_filter
        ");

        $this->db->query($query);
        $result = $this->db->result();

        return $result;
    }

    public function get_integrations()
    {
        $query = $this->db->placehold("
            SELECT * 
            FROM __integrations
        ");

        $this->db->query($query);
        $result = $this->db->results();

        return $result;
    }

    public function add_integration($integration)
    {
        $query = $this->db->placehold("
            INSERT INTO __integrations SET ?%
        ", (array)$integration);

        $this->db->query($query);

        $id = $this->db->insert_id();

        return $id;
    }

    public function update_integration($integration)
    {
        $query = $this->db->placehold("
            UPDATE __integrations SET ?%
        ", (array)$integration);

        $this->db->query($query);
    }

    public function update_visits($utm_source)
    {
        $query = $this->db->placehold("
            UPDATE __integrations SET visits = visits + 1
            where utm_source = ?
        ", $utm_source);

        $this->db->query($query);
    }
}