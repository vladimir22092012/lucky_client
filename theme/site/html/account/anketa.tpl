{$meta_title='Дополнение анкеты' scope=parent}{capture name='page_scripts'}
    <script src="theme/site/libs/autocomplete/jquery.autocomplete-min.js"></script>
    <script src="theme/site/js/dadata.app.js"></script>
    <script src="theme/site/js/form.app.js"></script>
    <script src="theme/site/js/stage_address.app.js"></script>
    <script src="theme/site/js/stage_files.app.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/suggestions-jquery@21.12.0/dist/js/jquery.suggestions.min.js"></script>
    <script>        $(function () {
            let token_dadata = "222e191767518127bcf15cc4d2a23c131404fdf2";
            $('.Regadress').suggestions({
                token: token_dadata,
                type: "ADDRESS",
                minChars: 3, /* Вызывается, когда пользователь выбирает одну из подсказок */
                onSelect: function (suggestion) {
                    $(this).val(suggestion.value);
                    $('.Registration').val(JSON.stringify(suggestion));
                }
            });
            $('.Faktaddress').suggestions({
                token: token_dadata,
                type: "ADDRESS",
                minChars: 3, /* Вызывается, когда пользователь выбирает одну из подсказок */
                onSelect: function (suggestion) {
                    $(this).val(suggestion.value);
                    $('.Fakt_adress').val(JSON.stringify(suggestion));
                }
            });
        });    </script>
{/capture}{capture name='page_styles'}
<link rel="stylesheet" href="theme/site/libs/autocomplete/styles.css"/>
<link rel="stylesheet" href="theme/site/libs/autocomplete/styles.css"/>
<link href="https://cdn.jsdelivr.net/npm/suggestions-jquery@21.12.0/dist/css/suggestions.min.css"
      rel="stylesheet"/>{/capture}
<main class="main">
    <div class="section section_form">
        <div class="container">
            <div class="section_form_row row">
                <div class="col-lg-5">
                    <div class="main_form_info">
                        <div class="form_info_title -fs-28"><span class="-black">Заполните недостающие данные</span>
                            <span class="-orange">чтобы получить займ</span></div>
                        <div class="form_info_subtitle"><p>В Вашей анкете не хватает некоторых данных</p></div>
                    </div>
                </div>
                <div class="col-lg-7">
                    <div class="main_form">                        {if !empty($need_fields['personal'])}
                            <form action="" method="POST" class="regform js-form-app js-stage-personal-form">
                                <div class="step_box step1">
                                    <div class="form_group -fs-18">
                                        <div class="form_group-title -gil-m">ФИО как в паспорте:</div>
                                        <div class="form_row">                                            {if in_array('lastname', $need_fields['personal'])}
                                                <label class="input_box "> <input type="text"
                                                                                  class="form-control js-input-cirylic js-input-required"
                                                                                  name="lastname" id="last_name"
                                                                                  value="{$lastname|escape}"/> <span
                                                            class="input_name {if $lastname}-top{/if}">Фамилия</span>
                                                </label>
                                            {/if}                                            {if in_array('firstname', $need_fields['personal'])}
                                                <label class="input_box"> <input type="text"
                                                                                 class="form-control js-input-cirylic js-input-required"
                                                                                 name="firstname" id="first_name"
                                                                                 value="{$firstname|escape}"/> <span
                                                            class="input_name {if $firstname}-top{/if}">Имя</span>
                                                </label>
                                            {/if}                                        </div>
                                        <div class="form_row">                                            {if in_array('patronymic', $need_fields['personal'])}
                                                <label class="input_box "> <input type="text"
                                                                                  class="form-control js-input-cirylic js-input-required"
                                                                                  name="patronymic" id="patronym"
                                                                                  value="{$patronymic|escape}"/> <span
                                                            class="input_name {if $patronymic}-top{/if}">Отчество</span>
                                                </label>
                                            {/if}                                            {if in_array('email', $need_fields['personal'])}
                                                <label class="input_box "> <input type="email"
                                                                                  class="form-control js-input-required"
                                                                                  name="email" id="email"
                                                                                  value="{$email|escape}"/> <span
                                                            class="input_name {if $email}-top{/if}">Емайл</span>
                                                </label>
                                            {/if}                                        </div>
                                    </div> {if in_array('gender', $need_fields['personal'])}
                                        <div class="form_group -fs-18 js-radio-required" data-msg="Укажите Ваш пол">
                                            <div class="form_group-title -gil-m">Укажите ваш пол:</div>
                                            <div class="form_row justify-content-start ">
                                                <div class="form_radio_btn"><input id="radio-1" type="radio"
                                                                                   name="gender" value="male"
                                                                                   {if $gender=='male'}checked{/if} />
                                                    <label for="radio-1">Мужской</label></div>
                                                <div class="form_radio_btn"><input id="radio-2" type="radio"
                                                                                   name="gender" value="female"
                                                                                   {if $gender=='female'}checked{/if} />
                                                    <label for="radio-2">Женский</label></div>
                                            </div>
                                        </div>
                                    {/if}                                    {if in_array('birth', $need_fields['personal']) || in_array('birth_place', $need_fields['personal'])}
                                        <div class="form_group -fs-18">
                                            <div class="form_group-title -gil-m">Дата и место рождения:</div>
                                            <div class="form_row">                                                {if in_array('birth', $need_fields['personal'])}
                                                    <label class="input_box"> <input type="text"
                                                                                     class="form-control js-mask-date js-input-required"
                                                                                     name="birth" id="birth_date"
                                                                                     value="{$birth}"/> <span
                                                                class="input_name {if $birth}-top{/if}">Дата рождения</span>
                                                    </label>
                                                {/if}                                                {if in_array('birth_place', $need_fields['personal'])}
                                                    <label class="input_box"> <input type="text"
                                                                                     class="form-control js-input-required js-input-cirylic js-cirylic-plus"
                                                                                     name="birth_place" id="birthplace"
                                                                                     value="{$birth_place}"/> <span
                                                                class="input_name {if $birth_place}-top{/if}">Место рождения</span>
                                                    </label>
                                                {/if}                                            </div>
                                        </div>
                                    {/if}
                                    <div class="step_box_btn"><a href=""
                                                                 class="btn btn_back btn-link -green -gil-m"></a>
                                        <button type="submit" class="btn btn_next btn-secondary">Далее</button>
                                    </div>
                                </div>
                            </form>
                        {elseif !empty($need_fields['passport'])}
                            <form action="" method="POST" class="regform js-form-app js-stage-passport-form">
                                <div class="step_box step2">
                                    <div class="form_group -fs-18">
                                        <div class="form_group-title -gil-m">Паспортные данные:</div>
                                        <div class="form_row">                                            {if in_array('passport_serial', $need_fields['passport'])}
                                                <label class="input_box"> <input type="text"
                                                                                 class="form-control js-mask-passport js-input-required"
                                                                                 name="passport_serial" id="series"
                                                                                 value="{$passport_serial}"/> <span
                                                            class="input_name {if $passport_serial}-top{/if}">Серия и номер</span>
                                                </label>
                                            {/if}                                            {if in_array('passport_date', $need_fields['passport'])}
                                                <label class="input_box "> <input type="text"
                                                                                  class="form-control js-mask-date js-input-required"
                                                                                  name="passport_date" id="issue"
                                                                                  value="{$passport_date}"/> <span
                                                            class="input_name {if $passport_date}-top{/if}">Дата выдачи</span>
                                                </label>
                                            {/if}                                        </div>
                                        <div class="form_row">                                            {if in_array('passport_issued', $need_fields['passport'])}
                                                <label class="input_box"> <input type="text"
                                                                                 class="form-control js-input-cirylic js-cirylic-plus js-input-required"
                                                                                 name="passport_issued" id="issued_by"
                                                                                 value="{$passport_issued}"/> <span
                                                            class="input_name {if $passport_issued}-top{/if}">Кем выдан</span>
                                                </label>
                                            {/if}                                            {if in_array('subdivision_code', $need_fields['passport'])}
                                                <label class="input_box"> <input type="text"
                                                                                 class="form-control js-mask-subdivision js-input-required"
                                                                                 name="subdivision_code"
                                                                                 id="department_code"
                                                                                 value="{$subdivision_code}"/> <span
                                                            class="input_name {if $subdivision_code}-top{/if}">Код подразделения</span>
                                                </label>
                                            {/if}                                        </div>
                                    </div>
                                    <div class="step_box_btn">
                                        <button type="submit" class="btn btn_next btn-secondary">Далее</button>
                                    </div>
                                </div>
                            </form>
                        {elseif !empty($need_fields['address'])}
                            <form action="" method="POST" class="regform js-form-app js-stage-address-form">
                                <div class="step_box step3">                                    {if in_array('regaddress', $need_fields['address'])}
                                        <div class="form_group -fs-18 js-dadata-address">
                                            <div class="form_group-title -gil-m">Адрес регистрации</div>
                                            <input class="form-control casing-upper-mask Regadress" name="Regadressfull"
                                                   style="width: 700px; margin-left: 25px" type="text"
                                                   {if !empty($Regaddressfull)}value="{$Regaddressfull->adressfull}"{/if}/>
                                            <input style="display: none" class="Registration"
                                                   name="Regadress"/> {if in_array('faktaddress', $need_fields['address'])}
                                                <div class="form_group-title -gil-m">Адрес места жительства</div>
                                                <div class="form_row">
                                                    <div class="check"><input type="checkbox" class="custom-checkbox"
                                                                              id="clone_address" name="clone_address"
                                                                              value="1"
                                                                              {if $equal_addresses}checked{/if} />
                                                        <label for="clone_address"
                                                               class="check_box check_box_black -gil-m"> Совпадает с
                                                            адресом места жительства </label></div>
                                                </div>
                                                <div class="js-regaddress-block"><input
                                                            class="form-control casing-upper-mask Faktaddress"
                                                            id="actual_address_toggle"
                                                            style="width: 700px; margin-left: 25px;"
                                                            name="Faktadressfull"
                                                            {if !empty($Faktaddressfull)}value="{$Faktaddressfull->adressfull}"{/if}
                                                            type="text"/> <input style="display: none"
                                                                                 class="Fakt_adress"
                                                                                 name="Fakt_adress"/></div>
                                            {/if}                                        </div>
                                    {/if}
                                    <div class="step_box_btn">
                                        <button type="submit" class="btn btn_next btn-secondary">Далее</button>
                                    </div>
                                </div>
                            </form>
                        {elseif !empty($need_fields['work'])}
                            <form action="" method="POST" class="regform js-form-app js-stage-work-form">
                                <div class="step_box step4">
                                    <div class="form_group -fs-18 js-dadata-work">
                                        <div class="form_group-title -gil-m">Информация о работе
                                        </div> {if in_array('workplace', $need_fields['work'])}
                                            <div class="form_row"><label class="input_box -fullwidth"> <input
                                                            type="text"
                                                            class="form-control js-input-required js-dadata-company"
                                                            name="workplace" id="company" value="{$workplace|escape}"/>
                                                    <span class="input_name {if $workplace}-top{/if}">Компания</span>
                                                </label></div>
                                            <div class="form_row"><label class="input_box -fullwidth"> <input
                                                            type="text" name="workaddress"
                                                            class="form-control js-input-required js-dadata-company-address"
                                                            value="{$workaddress|escape}"/> <span
                                                            class="input_name {if $workaddress}-top{/if}">Адрес</span>
                                                </label></div>
                                        {/if}
                                        <div class="form_row">                                            {if in_array('profession', $need_fields['work'])}
                                                <label class="input_box"> <input type="text"
                                                                                 class="form-control js-input-required"
                                                                                 name="profession" id="post"
                                                                                 value="{$profession|escape}"/> <span
                                                            class="input_name {if $profession}-top{/if}">Должность</span>
                                                </label>
                                            {/if}                                            {if in_array('workphone', $need_fields['work'])}
                                                <label class="input_box"> <input type="text"
                                                                                 class="form-control js-mask-phone js-input-required js-dadata-phone"
                                                                                 name="workphone" id="work_phone"
                                                                                 value="{$workphone}"/> <span
                                                            class="input_name {if $workphone}-top{/if}">Рабочий телефон</span>
                                                </label>
                                            {/if}                                        </div>
                                        <div class="form_row">                                            {if in_array('income', $need_fields['work'])}
                                                <label class="input_box"> <input type="text"
                                                                                 class="form-control js-input-digits js-input-required"
                                                                                 name="income" id="income"
                                                                                 value="{$income}"/> <span
                                                            class="input_name {if $income}-top{/if}">Ежемесячный доход</span>
                                                </label>
                                            {/if}                                            {if in_array('expenses', $need_fields['work'])}
                                                <label class="input_box"> <input type="text"
                                                                                 class="form-control js-input-digits js-input-required"
                                                                                 name="expenses" id="expenses"
                                                                                 value="{$expenses}"/> <span
                                                            class="input_name {if $expenses}-top{/if}">Ежемесячные расходы</span>
                                                </label>
                                            {/if}</div> {if in_array('chief', $need_fields['work'])}
                                            <div class="form_row"><label class="input_box -fullwidth"> <input
                                                            type="text"
                                                            class="form-control js-only-cirylic js-input-required js-dadata-chief-name"
                                                            name="chief_name" id="chief_name"
                                                            value="{$chief_name|escape}"> <span
                                                            class="input_name {if $chief_name}-top{/if}">ФИО начальника</span>
                                                </label></div>
                                            <div class="form_row"><label class="input_box"> <input type="text"
                                                                                                   class="form-control js-input-required js-dadata-chief-position"
                                                                                                   name="chief_position"
                                                                                                   id="chief_position"
                                                                                                   value="{$chief_position}">
                                                    <span class="input_name {if $chief_position}-top{/if}">Должность начальника</span>
                                                </label> <label class="input_box"> <input type="text"
                                                                                          class="form-control js-mask-phone js-input-required js-dadata-chief-phone"
                                                                                          name="chief_phone"
                                                                                          id="chief_phone"
                                                                                          value="{$chief_phone}"/> <span
                                                            class="input_name {if $chief_phone}-top{/if}">Телефон начальника</span>
                                                </label></div>
                                        {/if}                                    </div>
                                    <div class="step_box_btn">
                                        <button type="submit" id="next_stage" class="btn btn_next btn-secondary">Далее
                                        </button>
                                    </div>
                                </div>
                            </form>
                        {elseif !empty($need_fields['contactpersons'])}
                            <form action="" method="POST" class="regform js-form-app js-stage-work-form">
                                <div class="step_box step4">
                                    <div class="form_group -fs-18">
                                        <div class="form_group-title -gil-m">Контактные лица
                                        </div> {if in_array('contactperson', $need_fields['contactpersons'])}
                                            <div class="form_row"><label class="input_box -fullwidth"> <input
                                                            type="text" class="form-control js-input-required"
                                                            name="contact_person_name" id="contact_person1"
                                                            value="{$contact_person_name}"/> <span
                                                            class="input_name {if $contact_person_name}-top{/if}">ФИО контактного лица</span>
                                                </label></div>
                                            <div class="form_row"><label class="input_box"> <input type="text"
                                                                                                   class="form-control js-mask-phone js-input-required"
                                                                                                   name="contact_person_phone"
                                                                                                   id="contact_person_phone1"
                                                                                                   value="{$contact_person_phone}"/>
                                                    <span class="input_name {if $contact_person_phone}-top{/if}">Телефон контактного лица</span>
                                                </label> <label class="input_box"> <select
                                                            name="contact_person_relation" class="form-control">
                                                        <option value="мать/отец"
                                                                {if $contact_person_relation=='мать/отец'}selected="selected"{/if}>
                                                            мать/отец
                                                        </option>
                                                        <option value="муж/жена"
                                                                {if $contact_person_relation=='муж/жена'}selected="selected"{/if}>
                                                            муж/жена
                                                        </option>
                                                        <option value="сын/дочь"
                                                                {if $contact_person_relation=='сын/дочь'}selected="selected"{/if}>
                                                            сын/дочь
                                                        </option>
                                                        <option value="коллега"
                                                                {if $contact_person_relation=='коллега'}selected="selected"{/if}>
                                                            коллега
                                                        </option>
                                                        <option value="друг/сосед"
                                                                {if $contact_person_relation=='друг/сосед'}selected="selected"{/if}>
                                                            друг/сосед
                                                        </option>
                                                        <option value="иной родственник"
                                                                {if $contact_person_relation=='иной родственник'}selected="selected"{/if}>
                                                            иной родственник
                                                        </option>
                                                    </select> <span class="input_name -top">Кем приходится</span>
                                                </label></div>
                                        {/if}                                        {if in_array('contactperson2', $need_fields['contactpersons'])}
                                            <div class="form_row"><label class="input_box -fullwidth"> <input
                                                            type="text" class="form-control js-input-required"
                                                            name="contact_person2_name" id="contact_person2"
                                                            value="{$contact_person2_name}"/> <span
                                                            class="input_name {if $contact_person2_name}-top{/if}">ФИО контактного лица</span>
                                                </label></div>
                                            <div class="form_row"><label class="input_box"> <input type="text"
                                                                                                   class="form-control js-mask-phone js-input-required"
                                                                                                   name="contact_person2_phone"
                                                                                                   id="contact_person_phone2"
                                                                                                   value="{$contact_person2_phone}"/>
                                                    <span class="input_name {if $contact_person2_phone}-top{/if}">Телефон контактного лица</span>
                                                </label> <label class="input_box"> <select
                                                            name="contact_person2_relation" class="form-control">
                                                        <option value="мать/отец"
                                                                {if $contact_person2_relation=='мать/отец'}selected="selected"{/if}>
                                                            мать/отец
                                                        </option>
                                                        <option value="муж/жена"
                                                                {if $contact_person2_relation=='муж/жена'}selected="selected"{/if}>
                                                            муж/жена
                                                        </option>
                                                        <option value="сын/дочь"
                                                                {if $contact_person2_relation=='сын/дочь'}selected="selected"{/if}>
                                                            сын/дочь
                                                        </option>
                                                        <option value="коллега"
                                                                {if $contact_person2_relation=='коллега'}selected="selected"{/if}>
                                                            коллега
                                                        </option>
                                                        <option value="друг/сосед"
                                                                {if $contact_person2_relation=='друг/сосед'}selected="selected"{/if}>
                                                            друг/сосед
                                                        </option>
                                                        <option value="иной родственник"
                                                                {if $contact_person2_relation=='иной родственник'}selected="selected"{/if}>
                                                            иной родственник
                                                        </option>
                                                    </select> <span class="input_name -top">Кем приходится</span>
                                                </label></div>
                                        {/if}                                    </div>
                                    <div class="step_box_btn">
                                        <button type="submit" id="next_stage" class="btn btn_next btn-secondary">Далее
                                        </button>
                                    </div>
                                </div>
                            </form>
                        {elseif !empty($need_fields['files'])}
                            <form action="" method="POST" class="regform js-stage-files-form">
                                <div class="step_box step5">
                                    <div class="form_group -fs-18">
                                        <div class="form_group-title -gil-m">Загрузите документы:
                                        </div> {if in_array('passport1', $need_fields['files'])}
                                            <div class="form_file_item {if $user_files['passport1']->status == 3}rejected{/if}">
                                                <p>Первая страница паспорта</p><input type="file" name="file1"
                                                                                      id="file1" data-type="passport1"
                                                                                      class="input_file"> <label
                                                        for="file1" class="btn js-labelFile"> <span
                                                            class="js-fileName {if $user_files['passport1']}uploaded{/if}">                        <img
                                                                src="/theme/site/i/passport.png" width="150"/>                      </span>
                                                    <div class="-gil-m -fs-16 -green text-center">Добавить файл</div>
                                                </label></div>
                                        {/if}                                        {if in_array('passport2', $need_fields['files'])}
                                            <div class="form_file_item {if $user_files['passport2']->status == 3}rejected{/if}">
                                                <p>Страница с пропиской</p><input type="file" name="file2" id="file2"
                                                                                  data-type="passport2"
                                                                                  class="input_file"> <label for="file2"
                                                                                                             class="btn js-labelFile">
                                                    <span class="js-fileName ">                        <img
                                                                src="/theme/site/i/registration.png" width="150"/>                      </span>
                                                    <div class="-gil-m -fs-16 -green text-center">Добавить файл</div>
                                                </label></div>
                                        {/if}                                        {if in_array('face', $need_fields['files'])}
                                            <div class="form_file_item"><p>Ваше фото с разворотом паспорта</p><input
                                                        type="file" name="file3" id="file3" data-type="face"
                                                        class="input_file"> <label for="file3" class=" js-labelFile">
                                                    <span class="js-fileName ">                        <img
                                                                src="/theme/site/i/selfi.png" width="150"/>                      </span>
                                                    <div class="-gil-m -fs-16 -green text-center">Добавить файл</div>
                                                </label></div>
                                        {/if}                                        {if in_array('card', $need_fields['files'])}
                                            <div class="form_file_item "><p>Фото личной банковской карты</p><input
                                                        type="file" name="file4" id="file4" data-type="card"
                                                        class="input_file"> <label for="file4" class="btn js-labelFile">
                                                    <span class="js-fileName {if $user_files['card']}uploaded{/if}">                        <img
                                                                src="/theme/site/i/card.png" width="150"/>                      </span>
                                                    <div class="-gil-m -fs-16 -green text-center">Добавить файл</div>
                                                </label></div>
                                        {/if}                                    </div>
                                    <div class="step_box_btn">
                                        <button type="submit" class="btn btn_next btn-secondary -fs-20">Далее</button>
                                    </div>
                                </div>
                            </form>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>