<?php

class AccountAnketaController extends Controller
{
    public function fetch()
    {
        if (empty($this->user))
        {
            header('Location: /lk/login');
            exit;
        }

        if ($this->request->method('post'))
        {
            $update = array();
            if ($lastname = $this->request->post('lastname'))
                $update['lastname'] = $lastname;
            if ($firstname = $this->request->post('firstname'))
                $update['firstname'] = $firstname;
            if ($patronymic = $this->request->post('patronymic'))
                $update['patronymic'] = $patronymic;
            if ($email = $this->request->post('email'))
                $update['email'] = $email;
            if ($gender = $this->request->post('gender'))
                $update['gender'] = $gender;
            if ($birth = $this->request->post('birth'))
                $update['birth'] = $birth;
            if ($birth_place = $this->request->post('birth_place'))
                $update['birth_place'] = $birth_place;

            if ($passport_serial = $this->request->post('passport_serial'))
                $update['passport_serial'] = $passport_serial;
            if ($passport_date = $this->request->post('passport_date'))
                $update['passport_date'] = $passport_date;
            if ($subdivision_code = $this->request->post('subdivision_code'))
                $update['subdivision_code'] = $subdivision_code;
            if ($passport_issued = $this->request->post('passport_issued'))
                $update['passport_issued'] = $passport_issued;

            if (!empty($this->request->post('Regadress'))) {
                $Regadress = json_decode($this->request->post('Regadress'));
                $regaddress = [];
                $regaddress['adressfull'] = $this->request->post('Regadressfull');
                $regaddress['zip'] = $Regadress->data->postal_code ?? '';
                $regaddress['region'] = $Regadress->data->region ?? '';
                $regaddress['region_type'] = $Regadress->data->region_type ?? '';
                $regaddress['city'] = $Regadress->data->city ?? '';
                $regaddress['city_type'] = $Regadress->data->city_type ?? '';
                $regaddress['district'] = $Regadress->data->city_district ?? '';
                $regaddress['district_type'] = $Regadress->data->city_district_type ?? '';
                $regaddress['locality'] = $Regadress->data->settlement ?? '';
                $regaddress['locality_type'] = $Regadress->data->settlement_type ?? '';
                $regaddress['street'] = $Regadress->data->street ?? '';
                $regaddress['street_type'] = $Regadress->data->street_type ?? '';
                $regaddress['house'] = $Regadress->data->house ?? '';
                $regaddress['building'] = $Regadress->data->block ?? '';
                $regaddress['room'] = $Regadress->data->flat ?? '';
                $regaddress['okato'] = $Regadress->data->okato ?? '';
                $regaddress['oktmo'] = $Regadress->data->oktmo ?? '';
                if ($this->request->post('clone_address', 'integer')) {
                    $faktaddress = $regaddress;
                } else {
                    $Fakt_adress = json_decode($this->request->post('Fakt_adress'));
                    $faktaddress = [];
                    $faktaddress['adressfull'] = $this->request->post('Faktadressfull');
                    $faktaddress['zip'] = $Fakt_adress->data->postal_code ?? '';
                    $faktaddress['region'] = $Fakt_adress->data->region ?? '';
                    $faktaddress['region_type'] = $Fakt_adress->data->region_type ?? '';
                    $faktaddress['city'] = $Fakt_adress->data->city ?? '';
                    $faktaddress['city_type'] = $Fakt_adress->data->city_type ?? '';
                    $faktaddress['district'] = $Fakt_adress->data->city_district ?? '';
                    $faktaddress['district_type'] = $Fakt_adress->data->city_district_type ?? '';
                    $faktaddress['locality'] = $Fakt_adress->data->settlement ?? '';
                    $faktaddress['locality_type'] = $Fakt_adress->data->settlement_type ?? '';
                    $faktaddress['street'] = $Fakt_adress->data->street ?? '';
                    $faktaddress['street_type'] = $Fakt_adress->data->street_type ?? '';
                    $faktaddress['house'] = $Fakt_adress->data->house ?? '';
                    $faktaddress['building'] = $Fakt_adress->data->block ?? '';
                    $faktaddress['room'] = $Fakt_adress->data->flat ?? '';
                    $faktaddress['okato'] = $Fakt_adress->data->okato ?? '';
                    $faktaddress['oktmo'] = $Fakt_adress->data->oktmo ?? '';
                }
            }

            if ($workplace = $this->request->post('workplace'))
                $update['workplace'] = $workplace;
            if ($profession = $this->request->post('profession'))
                $update['profession'] = $profession;
            if ($workphone = $this->request->post('workphone'))
                $update['workphone'] = $workphone;
            if ($workaddress = $this->request->post('workaddress'))
                $update['workaddress'] = $workaddress;
            if ($income = $this->request->post('income'))
                $update['income'] = $income;
            if ($expenses = $this->request->post('expenses'))
                $update['expenses'] = $expenses;
            if ($chief_name = $this->request->post('chief_name'))
                $update['chief_name'] = $chief_name;
            if ($chief_position = $this->request->post('chief_position'))
                $update['chief_position'] = $chief_position;
            if ($chief_phone = $this->request->post('chief_phone'))
                $update['chief_phone'] = $chief_phone;


            if ($contact_person_name = $this->request->post('contact_person_name'))
                $update['contact_person_name'] = $contact_person_name;
            if ($contact_person_phone = $this->request->post('contact_person_phone'))
                $update['contact_person_phone'] = $contact_person_phone;
            if ($contact_person_relation = $this->request->post('contact_person_relation'))
                $update['contact_person_relation'] = $contact_person_relation;
            if ($contact_person2_name = $this->request->post('contact_person2_name'))
                $update['contact_person2_name'] = $contact_person2_name;
            if ($contact_person2_phone = $this->request->post('contact_person2_phone'))
                $update['contact_person2_phone'] = $contact_person2_phone;
            if ($contact_person2_relation = $this->request->post('contact_person2_relation'))
                $update['contact_person2_relation'] = $contact_person2_relation;



            if (!empty($update))
            {
                $update = array_map('strip_tags', $update);

                $this->users->update_user($this->user->id, $update);
            }

            if (!empty($regaddress)) {
                $regaddress_id = $this->Addresses->add_address($regaddress);
                $faktaddress_id = $this->Addresses->add_address($faktaddress);
                $this->users->update_user($this->user->id, array('regaddress_id' => $regaddress_id, 'faktaddress_id' => $faktaddress_id, 'stage_address' => 1));
            }

            $this->user = $this->users->get_user((int)$this->user->id);
        }

        $need_fields = $this->users->check_fields($this->user);
        if (empty($need_fields))
        {
            header('Location: '.$this->config->root_url.'/account');
            exit;
        }
        $this->design->assign('need_fields', $need_fields);

        return $this->design->fetch('account/anketa.tpl');
    }
}