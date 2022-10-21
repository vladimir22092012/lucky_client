<?php

class StageAddressController extends Controller
{
    public function fetch()
    {
        if (empty($this->user)) {
            header('Location: /lk/login');
            exit;
        }

        if (!empty($this->user->stage_address)) {
            header('Location: /stage/work');
            exit;
        }

        if (empty($this->user->stage_passport)) {
            header('Location: /stage/passport');
            exit;
        }

        if ($this->request->get('step') == 'prev') {
            $this->users->update_user($this->user->id, array('stage_passport' => 0));
            header('Location: /stage/passport');
            exit;
        }

        if ($this->request->method('post')) {
            $Faktregion = (string)$this->request->post('Faktregion');
            $Faktcity = (string)$this->request->post('Faktcity');
            $Faktdistrict = (string)$this->request->post('Faktdistrict');
            $Faktlocality = (string)$this->request->post('Faktlocality');
            $Faktdistrict_shorttype = (string)$this->request->post('Faktdistrict_shorttype');
            $Faktlocality_shorttype = (string)$this->request->post('Faktlocality_shorttype');
            $Faktstreet = (string)$this->request->post('Faktstreet');
            $Fakthousing = (string)$this->request->post('Fakthousing');
            $Faktbuilding = (string)$this->request->post('Faktbuilding');
            $Faktroom = (string)$this->request->post('Faktroom');
            $Faktindex = (string)$this->request->post('Faktindex');
            $Faktregion_shorttype = (string)$this->request->post('Faktregion_shorttype');
            $Faktcity_shorttype = (string)$this->request->post('Faktcity_shorttype');
            $Faktstreet_shorttype = (string)$this->request->post('Faktstreet_shorttype');
            $Faktokato = (string)$this->request->post('Faktokato');
            $Faktoktmo = (string)$this->request->post('Faktoktmo');

            if ($this->request->post('clone_address', 'integer')) {
                $Regregion = $Faktregion;
                $Regcity = $Faktcity;
                $Regdistrict = $Faktdistrict;
                $Regdistrict_shorttype = $Faktdistrict_shorttype;
                $Reglocality = $Faktlocality;
                $Reglocality_shorttype = $Faktlocality_shorttype;
                $Regstreet = $Faktstreet;
                $Reghousing = $Fakthousing;
                $Regbuilding = $Faktbuilding;
                $Regroom = $Faktroom;
                $Regindex = $Faktindex;
                $Regregion_shorttype = $Faktregion_shorttype;
                $Regcity_shorttype = $Faktcity_shorttype;
                $Regstreet_shorttype = $Faktstreet_shorttype;
                $Regokato = $Faktokato;
                $Regoktmo = $Faktoktmo;
            } else {
                $Regregion = (string)$this->request->post('Regregion');
                $Regcity = (string)$this->request->post('Regcity');
                $Regdistrict = (string)$this->request->post('Regdistrict');
                $Reglocality = (string)$this->request->post('Reglocality');
                $Regdistrict_shorttype = (string)$this->request->post('Regdistrict_shorttype');
                $Reglocality_shorttype = (string)$this->request->post('Reglocality_shorttype');
                $Regstreet = (string)$this->request->post('Regstreet');
                $Reghousing = (string)$this->request->post('Reghousing');
                $Regbuilding = (string)$this->request->post('Regbuilding');
                $Regroom = (string)$this->request->post('Regroom');
                $Regindex = (string)$this->request->post('Regindex');
                $Regregion_shorttype = (string)$this->request->post('Regregion_shorttype');
                $Regcity_shorttype = (string)$this->request->post('Regcity_shorttype');
                $Regstreet_shorttype = (string)$this->request->post('Regstreet_shorttype');
                $Regokato = (string)$this->request->post('Regokato');
                $Regoktmo = (string)$this->request->post('Regoktmo');
            }


            $this->design->assign('Faktregion', $Faktregion);
            $this->design->assign('Faktcity', $Faktcity);
            $this->design->assign('Faktstreet', $Faktstreet);
            $this->design->assign('Faktdistrict', $Faktdistrict);
            $this->design->assign('Faktdistrict_shorttype', $Faktdistrict_shorttype);
            $this->design->assign('Faktlocality', $Faktlocality);
            $this->design->assign('Faktlocality_shorttype', $Faktlocality_shorttype);
            $this->design->assign('Fakthousing', $Fakthousing);
            $this->design->assign('Faktbuilding', $Faktbuilding);
            $this->design->assign('Faktroom', $Faktroom);
            $this->design->assign('Faktindex', $Faktindex);
            $this->design->assign('Faktregion_shorttype', $Faktregion_shorttype);
            $this->design->assign('Faktcity_shorttype', $Faktcity_shorttype);
            $this->design->assign('Faktstreet_shorttype', $Faktstreet_shorttype);
            $this->design->assign('Faktokato', $Faktokato);
            $this->design->assign('Faktoktmo', $Faktoktmo);

            $this->design->assign('Regregion', $Regregion);
            $this->design->assign('Regcity', $Regcity);
            $this->design->assign('Regdistrict', $Regdistrict);
            $this->design->assign('Regdistrict_shorttype', $Regdistrict_shorttype);
            $this->design->assign('Reglocality', $Reglocality);
            $this->design->assign('Reglocality_shorttype', $Reglocality_shorttype);
            $this->design->assign('Regstreet', $Regstreet);
            $this->design->assign('Reghousing', $Reghousing);
            $this->design->assign('Regbuilding', $Regbuilding);
            $this->design->assign('Regroom', $Regroom);
            $this->design->assign('Regindex', $Regindex);
            $this->design->assign('Regregion_shorttype', $Regregion_shorttype);
            $this->design->assign('Regcity_shorttype', $Regcity_shorttype);
            $this->design->assign('Regstreet_shorttype', $Regstreet_shorttype);
            $this->design->assign('Regokato', $Faktokato);
            $this->design->assign('Regoktmo', $Faktoktmo);


            $errors = array();

            if (empty($Faktregion))
                $errors[] = 'empty_faktregion';
            if (empty($Faktcity) && empty($Faktlocality))
                $errors[] = 'empty_faktcity';
            if (empty($Fakthousing))
                $errors[] = 'empty_fakthousing';

            if (empty($Regregion))
                $errors[] = 'empty_regregion';
            if (empty($Regcity) && empty($Reglocality))
                $errors[] = 'empty_regcity';
            if (empty($Reghousing))
                $errors[] = 'empty_reghousing';

            $this->design->assign('errors', $errors);

            if (empty($errors)) {

                $faktaddress = [];
                $faktaddress['adressfull'] = "$Faktindex $Faktregion $Faktregion_shorttype $Faktcity $Faktcity_shorttype $Faktdistrict $Faktdistrict_shorttype $Faktlocality $Faktlocality_shorttype $Faktstreet $Faktstreet_shorttype $Fakthousing $Faktbuilding $Faktroom";
                $faktaddress['zip'] = $Faktindex;
                $faktaddress['region'] = $Faktregion;
                $faktaddress['region_type'] = $Faktregion_shorttype;
                $faktaddress['city'] = $Faktcity;
                $faktaddress['city_type'] = $Faktcity_shorttype;
                $faktaddress['district'] = $Faktdistrict;
                $faktaddress['district_type'] = $Faktdistrict_shorttype;
                $faktaddress['locality'] = $Faktlocality;
                $faktaddress['locality_type'] = $Faktlocality_shorttype;
                $faktaddress['street'] = $Faktstreet;
                $faktaddress['street_type'] = $Faktstreet_shorttype;
                $faktaddress['house'] = $Fakthousing;
                $faktaddress['building'] = $Faktbuilding;
                $faktaddress['room'] = $Faktroom;
                $faktaddress['okato'] = (string)$this->request->post('Faktokato');
                $faktaddress['oktmo'] = (string)$this->request->post('Faktoktmo');

                $regaddress = [];
                $regaddress['adressfull'] = "$Regindex $Regregion $Regregion_shorttype $Regcity $Regcity_shorttype $Regdistrict $Regdistrict_shorttype $Reglocality $Reglocality_shorttype $Regstreet $Regstreet_shorttype $Reghousing $Regbuilding $Regroom";
                $regaddress['zip'] = $Regindex;
                $regaddress['region'] = $Regregion;
                $regaddress['region_type'] = $Regregion_shorttype;
                $regaddress['city'] = $Regcity;
                $regaddress['city_type'] = $Regcity_shorttype;
                $regaddress['district'] = $Regdistrict;
                $regaddress['district_type'] = $Regdistrict_shorttype;
                $regaddress['locality'] = $Reglocality;
                $regaddress['locality_type'] = $Reglocality_shorttype;
                $regaddress['street'] = $Regstreet;
                $regaddress['street_type'] = $Regstreet_shorttype;
                $regaddress['house'] = $Reghousing;
                $regaddress['building'] = $Regbuilding;
                $regaddress['room'] = $Regroom;
                $regaddress['okato'] = $Regokato;
                $regaddress['oktmo'] = $Regoktmo;

                $regaddress_id = $this->Addresses->add_address($regaddress);
                $faktaddress_id = $this->Addresses->add_address($faktaddress);

                $this->users->update_user($this->user->id, ['regaddress_id' => $regaddress_id, 'faktaddress_id' => $faktaddress_id, 'stage_address' => 1, 'address_data_added_date' => date('Y-m-d H:i:s')]);

                header('Location: /stage/work');
                exit;
            }
        } else {
            $this->design->assign('Faktregion', $this->user->Faktregion);
            $this->design->assign('Faktcity', $this->user->Faktcity);
            $this->design->assign('Faktdistrict', $this->user->Faktdistrict);
            $this->design->assign('Faktdistrict_shorttype', $this->user->Faktdistrict_shorttype);
            $this->design->assign('Faktlocality', $this->user->Faktlocality);
            $this->design->assign('Faktlocality_shorttype', $this->user->Faktlocality_shorttype);
            $this->design->assign('Faktstreet', $this->user->Faktstreet);
            $this->design->assign('Fakthousing', $this->user->Fakthousing);
            $this->design->assign('Faktbuilding', $this->user->Faktbuilding);
            $this->design->assign('Faktroom', $this->user->Faktroom);
            $this->design->assign('Faktindex', $this->user->Faktindex);
            $this->design->assign('Faktregion_shorttype', $this->user->Faktregion_shorttype);
            $this->design->assign('Faktcity_shorttype', $this->user->Faktcity_shorttype);
            $this->design->assign('Faktstreet_shorttype', $this->user->Faktstreet_shorttype);

            $this->design->assign('Regregion', $this->user->Regregion);
            $this->design->assign('Regcity', $this->user->Regcity);
            $this->design->assign('Regdistrict', $this->user->Regdistrict);
            $this->design->assign('Regdistrict_shorttype', $this->user->Regdistrict_shorttype);
            $this->design->assign('Reglocality', $this->user->Reglocality);
            $this->design->assign('Reglocality_shorttype', $this->user->Reglocality_shorttype);
            $this->design->assign('Regstreet', $this->user->Regstreet);
            $this->design->assign('Reghousing', $this->user->Reghousing);
            $this->design->assign('Regbuilding', $this->user->Regbuilding);
            $this->design->assign('Regroom', $this->user->Regroom);
            $this->design->assign('Regindex', $this->user->Regindex);
            $this->design->assign('Regregion_shorttype', $this->user->Regregion_shorttype);
            $this->design->assign('Regcity_shorttype', $this->user->Regcity_shorttype);
            $this->design->assign('Regstreet_shorttype', $this->user->Regstreet_shorttype);
            $this->design->assign('Regokato', $this->user->okato);
            $this->design->assign('Regoktmo', $this->user->oktmo);
        }

        return $this->design->fetch('stage/address.tpl');
    }

}