{$meta_title="Информация о работе" scope=parent}

{capture name='page_scripts'}
  
  <script src="theme/site/libs/autocomplete/jquery.autocomplete-min.js"></script>
  <script src="theme/site/js/dadata.app.js"></script>
  <script src="theme/site/js/form.app.js"></script>
  
{/capture}

{capture name='page_styles'}

    <link rel="stylesheet" href="theme/site/libs/autocomplete/styles.css" />
    
{/capture}

<main class="main">
  <div class="section section_form">
    <div class="container">
      <div class="section_form_row row">
        <div class="col-lg-5">
          <div class="main_form_info">
            <div class="form_info_title -fs-28">
              <span class="-black">Пройдите короткую регистрацию</span>
              <span class="-orange">чтобы получить займ</span>
            </div>
            <div class="form_info_subtitle">
              <p>Вы выбрали сумму: <span class="sum">{$user->first_loan_amount} рублей</span></p>
              <p>На срок: <span class="days">{$user->first_loan_period} {$user->first_loan_period|plural:'день':'дней':'дня'}</span></p>
            </div>
            <div class="form_info_progress">
              <div class="form_info_progress_text -step1">До получения займа осталось: <span class="step -green">4 этапа</span></div>
              <div class="form_info_progress_text -step2">До получения займа осталось: <span class="step -green">3 этапа</span></div>
              <div class="form_info_progress_text -step3">До получения займа осталось: <span class="step -green">2 этапа</span></div>
              <div class="form_info_progress_text -step4 active">До получения займа осталось: <span class="step -green">1 этап</span></div>
              <div class="form_info_progress_text -step5"><span class="step -green">Последний этап</span></div>
              <div class="form_info_progress_control -step4"></div>
            </div>
          </div>
        </div>
        <div class="col-lg-7">
          <div class="main_form">
            <form action="" method="POST" class="regform js-form-app js-stage-work-form">
              
              <input type="hidden" name="juicescore_session_id" id="juicescore_session_id" value="" />
              
              <div class="step_box step4">
                <div class="form_group -fs-18 js-dadata-work">
                  <input type="hidden" name="workaddress" class="js-dadata-company-address" value="{$workaddress|escape}" />
                  <div class="form_group-title -gil-m">Информация о работе</div>
                  <div class="form_row">
                    <label class="input_box -fullwidth">
                      <input type="text" class="form-control js-input-required js-dadata-company" name="workplace" id="company" value="{$workplace|escape}" />
                      <span class="input_name {if $workplace}-top{/if}">Компания</span>
                    </label>
                  </div>
                  <div class="form_row">
                    <label class="input_box">
                      <input type="text" class="form-control js-input-required" name="profession" id="post" value="{$profession|escape}" />
                      <span class="input_name {if $profession}-top{/if}">Должность</span>
                    </label>
                    <label class="input_box">
                      <input type="text" class="form-control js-mask-phone js-input-required js-dadata-phone" name="workphone" id="work_phone" value="{$workphone}" />
                      <span class="input_name {if $workphone}-top{/if}">Рабочий телефон</span>
                    </label>
                  </div>
                  <div class="form_row">
                    <label class="input_box">
                      <input type="text" class="form-control js-input-digits js-input-required" name="income" id="income" value="{$income}" />
                      <span class="input_name {if $income}-top{/if}">Ежемесячный доход</span>
                    </label>
                    <label class="input_box">
                      <input type="text" class="form-control js-input-digits js-input-required" name="expenses" id="expenses" value="{$expenses}" />
                      <span class="input_name {if $expenses}-top{/if}">Ежемесячные расходы</span>
                    </label>
                  </div>
                  <div class="form_row">
                    <label class="input_box -fullwidth">
                      <input type="text" class="form-control js-only-cirylic js-input-required js-dadata-chief-name" name="chief_name" id="chief_name" value="{$chief_name|escape}">
                      <span class="input_name {if $chief_name}-top{/if}">ФИО начальника</span>
                    </label>
                  </div>
                  <div class="form_row">
                    <label class="input_box">
                      <input type="text" class="form-control js-input-required js-dadata-chief-position" name="chief_position" id="chief_position" value="{$chief_position}">
                      <span class="input_name {if $chief_position}-top{/if}">Должность начальника</span>
                    </label>
                    <label class="input_box">
                      <input type="text" class="form-control js-mask-phone js-input-required js-dadata-chief-phone" name="chief_phone" id="chief_phone" value="{$chief_phone}" />
                      <span class="input_name {if $chief_phone}-top{/if}">Телефон начальника</span>
                    </label>
                  </div>
                  <div class="form_row">
                    <label class="input_box -fullwidth">
                      <input type="text" class="form-control js-input-required" name="contact_person_name" id="contact_person1" value="{$contact_person_name}" />
                      <span class="input_name {if $contact_person_name}-top{/if}">ФИО контактного лица</span>
                    </label>
                  </div>
                  <div class="form_row">
                    <label class="input_box">
                      <input type="text" class="form-control js-mask-phone js-input-required" name="contact_person_phone" id="contact_person_phone1" value="{$contact_person_phone}" />
                      <span class="input_name {if $contact_person_phone}-top{/if}">Телефон контактного лица</span>
                    </label>
                    <label class="input_box">
                      <select name="contact_person_relation" class="form-control">
                        <option value="мать/отец" {if $contact_person_relation=='мать/отец'}selected="selected"{/if}>мать/отец</option>
                        <option value="муж/жена" {if $contact_person_relation=='муж/жена'}selected="selected"{/if}>муж/жена</option>
                        <option value="сын/дочь" {if $contact_person_relation=='сын/дочь'}selected="selected"{/if}>сын/дочь</option>
                        <option value="коллега" {if $contact_person_relation=='коллега'}selected="selected"{/if}>коллега</option>
                        <option value="друг/сосед" {if $contact_person_relation=='друг/сосед'}selected="selected"{/if}>друг/сосед</option>
                        <option value="иной родственник" {if $contact_person_relation=='иной родственник'}selected="selected"{/if}>иной родственник</option>
                      </select>
                      <span class="input_name -top">Кем приходится</span>
                    </label>
                  </div>
                  <div class="form_row">
                    <label class="input_box -fullwidth">
                      <input type="text" class="form-control js-input-required" name="contact_person2_name" id="contact_person2" value="{$contact_person2_name}" />
                      <span class="input_name {if $contact_person2_name}-top{/if}">ФИО контактного лица</span>
                    </label>
                  </div>
                  <div class="form_row">
                    <label class="input_box">
                      <input type="text" class="form-control js-mask-phone js-input-required" name="contact_person2_phone" id="contact_person_phone2" value="{$contact_person2_phone}" />
                      <span class="input_name {if $contact_person2_phone}-top{/if}">Телефон контактного лица</span>
                    </label>
                    <label class="input_box">
                      <select name="contact_person2_relation" class="form-control">
                        <option value="мать/отец" {if $contact_person2_relation=='мать/отец'}selected="selected"{/if}>мать/отец</option>
                        <option value="муж/жена" {if $contact_person2_relation=='муж/жена'}selected="selected"{/if}>муж/жена</option>
                        <option value="сын/дочь" {if $contact_person2_relation=='сын/дочь'}selected="selected"{/if}>сын/дочь</option>
                        <option value="коллега" {if $contact_person2_relation=='коллега'}selected="selected"{/if}>коллега</option>
                        <option value="друг/сосед" {if $contact_person2_relation=='друг/сосед'}selected="selected"{/if}>друг/сосед</option>
                        <option value="иной родственник" {if $contact_person2_relation=='иной родственник'}selected="selected"{/if}>иной родственник</option>
                      </select>
                      <span class="input_name -top">Кем приходится</span>
                    </label>
                  </div>
                  
                </div>
                <div class="step_box_btn">
                  <a href="/stage/work?step=prev" class="btn btn_back btn-link -green -gil-m">Назад</a>
                  <button type="submit" id="next_stage" class="btn btn_next btn-secondary">Далее</button>
                </div>

              </div>
              

            </form>
          </div>
        </div>
      </div>



    </div>
  </div>
</main>

<script type="text/javascript">
    var juicyLabConfig = {
        completeButton:"#next_stage"
    };
</script>

<script type="text/javascript">
    var s = document.createElement('script');
    s.type = 'text/javascript';
    s.async = true;
    s.src = "https://score.juicyscore.com/static/js.js";
    var x = document.getElementsByTagName('head')[0];
    x.appendChild(s);
</script>
<noscript>
  <img style="display:none;" src="https://score.juicyscore.com/savedata/?isJs=0"/>
</noscript>

