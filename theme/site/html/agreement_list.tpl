<div id="agreement_list" style="display:none" class="pr-3 pl-3">
    <ul>
        {*}
        <li>
            <a href="{$config->root_url}/files/docs/pravila_predostavleniya_mikrozaymov.pdf" target="_blank">
                <span>Правила предоставления микрозаймов</span>
            </a>
        </li>
        {*}
        <li>
            <a href="{$config->root_url}/files/docs/soglashenie_o_ispolzovanii_pep.pdf" target="_blank">
                <span>Соглашение о ПЭП</span>
            </a>
        </li>
        {if $order->contract}
        <li>
            <a href="{$config->root_url}/preview/ind_usloviya_nl?contract_id={$order->contract->id}" target="_blank">
                <span>Индивидуальные условия</span>
            </a>
        </li>
        <li>
            <a href="{$config->root_url}/preview/polis_strahovaniya?contract_id={$order->contract->id}" target="_blank">
                <span>Полис страхования</span>
            </a>
        </li>
        {/if}
    </ul>

    <div class="">
        <div class="form_row">
            <div class="check">
              <input type="hidden" class="custom-checkbox" name="service_insurance" value="1" />
              <input type="checkbox" class="custom-checkbox" {if !in_array($user->phone_mobile, ['79639143424', '79139096454', '79053032893', '79058977170', '79967276234', '79272624886'])}{/if} id="service_insurance" value="1" checked="true" />
              <label for="service_insurance" class="check_box -gil-m">
                 <span>
                    согласен заключить договор страхования в соответствии
                    <a class="text-success" href="https://{$config->main_domain}/files/about/Pravila_195_strahovanie_ot_ns.pdf" target="_blank">с правилами</a>
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
              <input type="hidden" class="custom-checkbox" name="service_reason" value="1" />
              <input type="checkbox" class="custom-checkbox" {if !in_array($user->phone_mobile, ['79639143424', '79139096454'])}{/if} id="service_reason" value="1" checked="true" />
              <label for="service_reason" class="check_box -gil-m">
                 <span>
                    В случае отказа по заявке, я хочу получить информацию о причине отказа
                 </span>
              </label>
            </div>
        </div>
    </div>

</div>