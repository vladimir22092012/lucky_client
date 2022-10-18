{$meta_title="Адреса регистрации и проживания" scope=parent}

{capture name='page_scripts'}

  <script src="theme/site/libs/autocomplete/jquery.autocomplete-min.js"></script>
  <script src="theme/site/js/dadata.app.js?v=1.01"></script>

  <script src="theme/site/js/form.app.js"></script>
  <script src="theme/site/js/stage_address.app.js"></script>

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
              <div class="form_info_progress_text -step1">До получения займа осталось: <span
                  class="step -green">4 этапа</span></div>
              <div class="form_info_progress_text -step2">До получения займа осталось: <span class="step -green">3
                  этапа</span></div>
              <div class="form_info_progress_text -step3 active">До получения займа осталось: <span class="step -green">2
                  этапа</span></div>
              <div class="form_info_progress_text -step4">До получения займа осталось: <span class="step -green">1
                  этап</span></div>
              <div class="form_info_progress_text -step5"><span class="step -green">Последний этап</span></div>
              <div class="form_info_progress_control -step3"></div>
            </div>
          </div>
        </div>
        <div class="col-lg-7">
          <div class="main_form">
            <form action="" method="POST" class="regform js-form-app js-stage-address-form">

              <div class="step_box step3">
                <div class="form_group -fs-18 js-dadata-address">
                  <div class="form_group-title -gil-m">Адрес места жительства</div>
                  <input type="hidden" name="Faktregion_shorttype" class="js-dadata-region-type" value="{$Faktregion_shorttype}" />
                  <input type="hidden" name="Faktcity_shorttype" class="js-dadata-city-type" value="{$Faktcity_shorttype}" />
                  <input type="hidden" name="Faktstreet_shorttype" class="js-dadata-street-type" value="{$Faktstreet_shorttype}" />
                  <input type="hidden" name="Faktbuilding" class="js-dadata-building" value="{$Faktbuilding}" />
                  <input type="hidden" name="Faktindex" class="js-dadata-index" value="{$Faktindex}" />
                  <input type="hidden" name="Faktcity" class="js-dadata-city-real" value="{$Faktcity}" />
                  <input type="hidden" name="Faktdistrict" class="js-dadata-district" value="{$Faktdistrict}" />
                  <input type="hidden" name="Faktlocality" class="js-dadata-locality" value="{$Faktlocality}" />
                  <input type="hidden" name="Faktdistrict_shorttype" class="js-dadata-district-type" value="{$Faktdistrict_shorttype}" />
                  <input type="hidden" name="Faktlocality_shorttype" class="js-dadata-locality-type" value="{$Faktlocality_shorttype}" />
                  <input type="hidden" name="Faktokato" class="js-dadata-okato" value="{$okato}" />
                  <input type="hidden" name="Faktoktmo" class="js-dadata-oktmo" value="{$oktmo}" />
                  <div class="form_row">
                    <label class="input_box">
                      <input type="text" class="form-control js-input-required js-dadata-region" name="Faktregion" id="city" value="{$Faktregion}" />
                      <span class="input_name {if $Faktregion}-top{/if}">Регион</span>
                    </label>
                    <label class="input_box">
                      <input type="text" class="form-control js-input-required js-dadata-city" id="code" value="{$Faktcity} {if $Faktlocality},{$Faktlocality} {$Faktlocality_shorttype}{/if}" />
                      <span class="input_name {if $Faktcity}-top{/if}">Город</span>
                    </label>
                  </div>
                  <div class="form_row">
                    <label class="input_box">
                      <input type="text" class="form-control js-dadata-street" name="Faktstreet" id="street" value="{$Faktstreet}" />
                      <span class="input_name {if $Faktstreet}-top{/if}">Улица</span>
                    </label>
                    <label class="input_box" data-msg="&nbsp;">
                      <input type="text" class="form-control js-input-required js-dadata-house" name="Fakthousing" id="house" value="{$Fakthousing}" />
                      <span class="input_name {if $Fakthousing}-top{/if}">Дом</span>
                    </label>
                    <label class="input_box">
                      <input type="text" class="form-control js-dadata-room" name="Faktroom" id="flat" value="{$Faktroom}" />
                      <span class="input_name {if $Faktroom}-top{/if}">Кв.</span>
                    </label>
                  </div>
                </div>
                <div class="form_group -fs-18 js-dadata-address js-dadata-okato">
                  <div class="form_group-title -gil-m">Адрес места регистрации</div>
                  <input type="hidden" name="Regregion_shorttype" class="js-dadata-region-type" value="{$Regregion_shorttype}" />
                  <input type="hidden" name="Regcity_shorttype" class="js-dadata-city-type" value="{$Regcity_shorttype}" />
                  <input type="hidden" name="Regstreet_shorttype" class="js-dadata-street-type" value="{$Regstreet_shorttype}" />
                  <input type="hidden" name="Regbuilding" class="js-dadata-building" value="{$Regbuilding}" />
                  <input type="hidden" name="Regindex" class="js-dadata-index" value="{$Regindex}" />
                  <input type="hidden" name="Regcity" class="js-dadata-city-real" value="{$Regcity}" />
                  <input type="hidden" name="Regdistrict" class="js-dadata-district" value="{$Regdistrict}" />
                  <input type="hidden" name="Reglocality" class="js-dadata-locality" value="{$Reglocality}" />
                  <input type="hidden" name="Regdistrict_shorttype" class="js-dadata-district-type" value="{$Regdistrict_shorttype}" />
                  <input type="hidden" name="Reglocality_shorttype" class="js-dadata-locality-type" value="{$Reglocality_shorttype}" />
                  <input type="hidden" name="Regokato" class="js-dadata-okato" value="{$okato}" />
                  <input type="hidden" name="Regoktmo" class="js-dadata-oktmo" value="{$oktmo}" />
                  <div class="form_row">
                    <div class="check">
                      <input type="checkbox" class="custom-checkbox" id="clone_address" name="clone_address" value="1" {if $equal_addresses}checked{/if} />
                      <label for="clone_address" class="check_box check_box_black -gil-m">
                        Совпадает с адресом места жительства
                      </label>
                    </div>
                  </div>
                    <div class="js-regaddress-block">
                      <div class="form_row">
                        <label class="input_box">
                          <input type="text" class="form-control js-input-required js-dadata-region" name="Regregion" id="reg-code" value="{$Regregion}" />
                          <span class="input_name {if $Regregion}-top{/if}">Регион</span>
                        </label>
                        <label class="input_box">
                          <input type="text" class="form-control js-input-required js-dadata-city" name="Regcity" id="reg-city" value="{$Regcity} {if $Reglocality},{$Reglocality} {$Reglocality_shorttype}{/if}" />
                          <span class="input_name {if $Regcity}-top{/if}">Город</span>
                        </label>
                      </div>
                      <div class="form_row">
                        <label class="input_box">
                          <input type="text" class="form-control  js-dadata-street" name="Regstreet" id="reg-street" value="{$Regstreet}" />
                          <span class="input_name {if $Regstreet}-top{/if}">Улица</span>
                        </label>
                        <label class="input_box" data-msg="&nbsp;">
                          <input type="text" class="form-control js-input-required js-dadata-house" name="Reghousing" id="reg-house" value="{$Reghousing}" />
                          <span class="input_name {if $Reghousing}-top{/if}">Дом</span>
                        </label>
                        <label class="input_box">
                          <input type="text" class="form-control js-dadata-room" name="Regroom" id="reg-flat" value="{$Regroom}" />
                          <span class="input_name {if $Regroom}-top{/if}">Кв.</span>
                        </label>
                      </div>
                    </div>
                </div>
                <div class="step_box_btn">
                  <a href="stage/address?step=prev" class="btn btn_back btn-link -green -gil-m">Назад</a>
                  <button type="submit" class="btn btn_next btn-secondary">Далее</button>
                </div>
              </div>
              
            </form>
          </div>
        </div>
      </div>

    </div>
  </div>
</main>
