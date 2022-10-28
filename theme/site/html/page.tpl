{capture name='page_scripts'}


{/capture}

{capture name='page_styles'}
    
{/capture}

<main class="main">
  <div class="section ">
    <div class="container">
      <div class="section_row row">

        
        <div class="col-lg-12">
          <h1>{$page->name}</h1>
            {if $page->url == 'documents'}
            <h2>Правоустанавливающие документы</h2>
            <div class="row">
				<div class="col-md-6">
                    <ul class="docs_list">
                        <li class=""><a class="docs_list_link_footer" href="/files/about/bazovie_standarti.pdf"
                                        target="_blank">Базовые стандарты совершения операций</a></li>
                        <li class=""><a class="docs_list_link_footer" href="/files/about/standart.pdf" target="_blank">Базовый
                                стандарт</a></li>
                        <li class=""><a class="docs_list_link_footer" href="/files/about/dogovor_ind.pdf"
                                        target="_blank">Договор займа/Индивидуальные условия</a></li>
                        <li class=""><a class="docs_list_link_footer" href="/files/about/pamatka_po_zashite.pdf"
                                        target="_blank">Памятка для клиентов по защите информации</a></li>
                        <li class=""><a class="docs_list_link_footer" href="/files/about/ombud.pdf" target="_blank">Памятка
                                омбудсмена</a></li>
                        <li class=""><a class="docs_list_link_footer" href="/files/about/cb_rf.pdf" target="_blank">Памятка
                                ЦБ РФ</a></li>
                        <li class=""><a class="docs_list_link_footer" href="/files/about/ki.pdf" target="_blank">Положение
                                об обеспечении защиты сведений КИ</a></li>
                        <li class=""><a class="docs_list_link_footer" href="/files/about/fiz_lica.pdf" target="_blank">Правила
                                предоставления микрозаймов физическим лицам</a></li>
                    </ul>
                </div>
                <div class="col-md-6">
                    <ul class="docs_list">
                        <li class=""><a class="docs_list_link_footer" href="/files/about/requisites.pdf"
                                        target="_blank">Реквизиты</a></li>
                        <li class=""><a class="docs_list_link_footer" href="/files/about/o_vnesenii_v_reestr.pdf"
                                        target="_blank">Сведетельство о внесении в государственный реестр
                                микрофинансовых организаций</a></li>
                        <li class=""><a class="docs_list_link_footer" href="/files/about/inn.pdf" target="_blank">Свидетельство
                                ИНН</a></li>
                        <li class=""><a class="docs_list_link_footer" href="/files/about/sushestvennoe vliyanie.pdf"
                                        target="_blank">Список лиц, оказывающих существенное влияние</a></li>
                        <li class=""><a class="docs_list_link_footer" href="/files/about/politica_bezopasnosti.pdf"
                                        target="_blank">Политика безопасности платежей</a></li>

                        <li class=""><a class="docs_list_link_footer" href="/files/about/pravila_167.pdf"
                                        target="_blank">Правила страхования от несчастных случаев</a></li>
                        <li class=""><a class="docs_list_link_footer" href="/files/about/pravila_183.pdf"
                                        target="_blank">Правила страхования банковских карт</a></li>
                        <li class=""><a class="docs_list_link_footer" href="/files/about/politica_obrabotki.pdf"
                                        target="_blank">Политика обработки и защиты персональных данных</a></li>
                    </ul>
                </div>
            </div>
            {/if}

          <div>
              {$page->body}
          </div>
        </div>
      </div>

    </div>
  </div>
</main>
