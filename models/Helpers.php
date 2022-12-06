<?php

class Helpers extends Core
{
    private $c2o_codes =
        [
            array('z', 'x', 'c', 'V', 'B', 'N', 'm', 'A', 's', '4'),
            array('Q', 'W', 'r', 'S', '6', 'Y', 'k', 'n', 'G', 'i'),
            array('T', '2', 'H', 'e', 'D', '1', '8', 'P', 'o', 'g'),
            array('O', 'u', 'Z', 'h', '0', 'I', 'J', '7', 'a', 'L'),
            array('v', 'w', 'p', 'E', 't', '5', 'b', '9', 'l', 'R'),
            array('d', '3', 'q', 'C', 'U', 'M', 'y', 'X', 'K', 'j'),
        ];

    public function c2o_encode($id)
    {
        $code = '';

        $chars = str_split($id);

        if (count($chars) != 6)
            return false;

        $code .= $this->c2o_codes[5][$chars[5]];
        $code .= $this->c2o_codes[4][$chars[4]];
        $code .= $this->c2o_codes[3][$chars[3]];
        $code .= $this->c2o_codes[2][$chars[2]];
        $code .= $this->c2o_codes[1][$chars[1]];
        $code .= $this->c2o_codes[0][$chars[0]];
        return $code;
    }

    public function c2o_decode($code)
    {
        $id = '';

        $chars = str_split($code);

        for ($i = 0; $i < count($chars); $i++)
            $id .= array_search($chars[$i], $this->c2o_codes[$i]);

        return $id;

    }


}