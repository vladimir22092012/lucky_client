<div id="agreement_list" style="display:none" class="pr-3 pl-3">
    <div class="">
        <div class="form_row">
            <div class="check">
                <input type="hidden" class="custom-checkbox" name="service_reason" value="1"/>
                <input type="checkbox" class="custom-checkbox" id="service_reason" value="1" checked="true"/>
                <label for="service_reason" class="check_box -gil-m">
                    <span>Соглашение о <a href="{$config->root_url}/files/agreement/soglashenie_pep.pdf"
                                          target="_blank">ПЭП</a></span>
                </label>
            </div>
        </div>
    </div>
    <div class="">
        <div class="form_row">
            <div class="check">
                <input type="hidden" class="custom-checkbox" name="service_insurance" value="1"/>
                <input type="checkbox"
                       class="custom-checkbox"
                       id="service_insurance" value="1" checked="true"/>
                <label for="service_insurance" class="check_box -gil-m">
                 <span>
                    согласен заключить договор страхования в соответствии
                    <a class="text-success"
                       href="https://{$config->main_domain}/files/agreement/sertificat.pdf"
                       target="_blank">с правилами</a>
                    на следующих условиях: страховая премия 25% от суммы полученного займа,
                    срок страхования 14 дней, страховая сумма  100% от суммы займа
                 </span>
                </label>
            </div>
        </div>
    </div>
    <div class="">
        <div class="form_row">
            <div class="check">
                <input type="hidden" class="custom-checkbox" name="pravila_obrabotki" value="1"/>
                <input type="checkbox" class="custom-checkbox" id="pravila_obrabotki" value="1" checked="true"/>
                <label for="pravila_obrabotki" class="check_box -gil-m">
                    <span>Согласен с <a href="{$config->root_url}/files/agreement/pers_dannih.pdf" target="_blank">правилами обработки</a> пользовательских данных ПЭП</span>
                </label>
            </div>
        </div>
    </div>
    <div class="">
        <div class="form_row">
            <div class="check">
                <input type="hidden" class="custom-checkbox" name="bki" value="1"/>
                <input type="checkbox" class="custom-checkbox" id="bki" value="1" checked="true"/>
                <label for="bki" class="check_box -gil-m">
                    <span>Даю <a href="{$config->root_url}/files/agreement/bki.pdf" target="_blank">согласие на запрос и получение кредитной истории из БКИ</a></span>
                </label>
            </div>
        </div>
    </div>
    {if $order->contract}
        <div class="">
            <div class="form_row">
                <div class="check">
                    <input type="hidden" class="custom-checkbox" name="individ" value="1"/>
                    <input type="checkbox" class="custom-checkbox" id="individ" value="1" checked="true"/>
                    <label for="individ" class="check_box -gil-m">
                        <a href="{$config->root_url}/preview/IND_USLOVIYA?contract_id={$order->contract->id}"
                           target="_blank">
                            <span>Индивидуальные условия</span>
                        </a>
                    </label>
                </div>
            </div>
        </div>
        <div class="">
            <div class="form_row">
                <div class="check">
                    <input type="hidden" class="custom-checkbox" name="polis" value="1"/>
                    <input type="checkbox" class="custom-checkbox" id="polis" value="1" checked="true"/>
                    <label for="polis" class="check_box -gil-m">
                        <a href="{$config->root_url}/preview/POLIS_STRAHOVANIYA?contract_id={$order->contract->id}"
                           target="_blank">
                            <span>Полис страхования</span>
                        </a>
                    </label>
                </div>
            </div>
        </div>
    {/if}
</div>