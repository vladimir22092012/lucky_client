<!DOCTYPE html>
<html>

<head>
    <base href="{$config->root_url}/"/>

    <meta charset="utf-8">
    <title>{$meta_title|escape}</title>
    <meta name="description" content="{$meta_keywords|escape}">
    <link rel="shortcut icon" href="theme/site/i/favicon/favicon.ico" type="image/x-icon">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- style -->
    <link rel="stylesheet" href="theme/site/libs/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="theme/site/libs/range/ion.rangeSlider.min.css"/>
    <link rel="stylesheet" href="theme/site/libs/fancybox/jquery.fancybox.min.css">
    <link rel="stylesheet" href="theme/site/libs/jquery/jquery-ui/jquery-ui.min.css"/>
    <link rel="stylesheet" href="theme/site/libs/jquery/jquery-ui/jquery-ui.theme.min.css"/>
    <link rel="stylesheet" href="theme/site/css/common.css?v=1.10"/>
    <link rel="stylesheet" href="theme/site/css/custom.css?v=1.09"/>

    {$smarty.capture.page_styles}


    {if in_array($module, ['MainController'])}
        <script>
            var comebackUrl = 'https://zaimwagon.online/';
            document.addEventListener("DOMContentLoaded", function () {
                if (typeof history.pushState === 'function') {
                    history.pushState('back', null, null);
                    window.onpopstate = function () {
                        history.pushState('back', null, null);
                        if (typeof comebackUrl !== 'undefined') {
                            window.location = comebackUrl;
                        }
                    };
                }
            });
        </script>
    {/if}


    <script>
        {if $is_developer}console.info('DEVELOPER MODE'){/if}
    </script>

    <meta name="yandex-verification" content="2c0068d5cbd1bd2c"/>
</head>
<body class="{if in_array($module, ['MainController'])}home{else}page{/if}">
<style>
    .developer-panel {
        background: #d22;
        color: #fff;
        padding: 10px;
        width: 100%;
    }

    .developer-panel:after {
        content: '';
        display: block;
        clear: both;
    }

    .developer-panel strong {
        float: left;
        font-size: 20px;
    }

    .developer-panel span {
    / / float: right;
        font-size: 16px;
        display: block;
        text-align: center;
        font-weight: bold;
    }

    .developer-panel.is-looker {
        background: #2d2
    }
</style>

{if $is_looker}
    <div class="developer-panel is-looker">
        <strong>ADMIN MODE</strong>
        {if $user}
            <span>ID {$user->id}</span>
        {/if}
    </div>
{elseif $is_developer}
    <div class="developer-panel">
        <strong>DEVELOPER MODE</strong>
        {if $user}
            <span>ID {$user->id}</span>
        {/if}
    </div>
{/if}


{*}
  <div class="developer-panel">
    <span>
        В период с 21:00 по 23:59 (МСК) 01.03.2022 будут проводиться технические работы, портал будет недоступен. 
        <br />Повторите авторизацию после завершения работ. 
        Спасибо за понимание!    
    </span>
  </div>
{*}
<div class="wrapper">
    <header class="header">
        <div class="container">
            <div class="header_row row">
                <div class="col-sm-6 col-md-4 col-lg-3 header-col-logo">
                    <div class="header_logo">
                        <a href="/" class="logo"><img src="theme/site/i/cropped-logo__poster_.png" alt=""></a>
                    </div>
                </div>
                <div class="col-lg-4 header-col-nav">
                    <div class="header_nav">
                        <nav class="navbar header_menu">
                            <ul class="nav header_menu_nav -gil-m">
                                <li class="nav-item">
                                    <a class="nav-link" href="/#how_get">Как получить</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/#how_repay">Как погасить</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="page/documents">Документы</a>
                                </li>
                                {*}
                                <li class="nav-item">
                                  <a class="nav-link" href="page/about">О компании</a>
                                </li>
                                {*}
                            </ul>
                        </nav>
                    </div>
                </div>
                <div class="col-sm-6 col-md-8 col-lg-5 header-col-contact">
                    <div class="header_right">
                        <div class="header_right_row">
                            <div class="header_btn">
                                {if $user}
                                    <a href="account" class="btn btn-primary -lk-btn">Личный кабинет</a>
                                {else}
                                    <a href="lk/login" class="btn btn-primary -lk-btn">Личный кабинет</a>
                                {/if}
                            </div>
                            <div class="header_contacts">
                                <a href="tel:88004448234" class="header_phone -gil-b -fs-24">8 812 604 28 78</a>
                                <span class="info -fs-14">звонок бесплатный</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <header class="mobheader">
        <div class="mobheader-logo">
            <a href="/" class="logo"><img src="theme/site/i/cropped-logo__poster_.png" alt=""></a>
        </div>
        <div class="mobheader-phone">
            <a href="tel:88004448234" class="">8 812 604 28 78</a>
            <span class="">звонок бесплатный</span>
        </div>
        <div class="mobheader-menu">
            <a class="mobheader-toggler" href="javascript:void(0);">
                <span></span>
                <span></span>
                <span></span>
            </a>
            <div class="mobheader-menu-nav">
                <nav class="navbar header_menu">
                    {if !$user}
                        <ul class="nav header_menu_nav -gil-m">
                            <li class="nav-item">
                                <a class="nav-link" href="/#how_get">Как получить</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/#how_repay">Как погасить</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="page/about">О компании</a>
                            </li>
                        </ul>
                    {else}
                        <ul class="nav header_menu_nav -gil-m">
                            <li class="nav-item active">
                                <a class="nav-link" href="account">Общая информация</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="account/history">История займов</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="account/cards">Банковские карты</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="account/data">Личные данные</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="account/docs">Документы</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-danger" href="lk/logout">Выйти</a>
                            </li>
                        </ul>
                    {/if}
                </nav>
            </div>
        </div>

        <div class="mobheader-account">
            {if $user}
                <a href="account" class=""></a>
            {else}
                <a href="lk/login" class=""></a>
            {/if}
        </div>
    </header>

    {$content}

    <footer class="footer">
        <div class="container">
            <div class="footer_row row">
                <div class="col-md-4 col-lg-2 footer-col-logo">
                    <div class="footer_logo">
                        <a href="/" class="logo"><img src="theme/site/i/cropped-logo__poster_.png" alt="logo"></a>
                        <span class="logo_info -fs-15 -gil-l">Комфортные займы
                на вашу карту
                не выходя из дома</span>
                    </div>
                </div>
                <div class="col-lg-3 footer-col-nav">
                    <div class="footer_nav">
                        <nav class="navbar navbar-expand-lg footer_menu">
                            <button class="navbar-toggler">
                                <span class="line"></span>
                                <span class="line"></span>
                                <span class="line"></span>
                            </button>
                            <ul class="nav footer_menu_nav -gil-m -fs-16">
                                <li class="nav-item">
                                    <a class="nav-link" href="page/about">О компании</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/#how_get">Как получить</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/#how_repay">Как погасить</a>
                                </li>

                                <li class="nav-item">
                                    <a class="nav-link" href="page/documents">Документы</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
                <div class="col-sm-6 col-md-4 col-lg-4 footer-col-btn">
                    <ul class="docs_list_footer">
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
                <div class="col-sm-6 col-md-4 col-lg-3 footer-col-contacts">
                    <div class="footer_contacts -fs-14">
                        <a href="tel:88004448234" class="footer_phone -fs-24 -gil-b">8 812 604 28 78</a>
                        <span class="footer_text -gil-m">звонок бесплатный</span>
                        <a href="mailto:mkk@finfive.ru" class="footer_email -gil-b">mkkbarvil@yandex.ru</a>
                        <div class="work_time">
                            <div class="work_time_title -gil-b">Время работы:</div>
                            <div class="work_time_text">понедельник - воскресенье <br>с 9:00 до 21:00</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer_row">
                <div class="copyright -fs-15">
                    Полное наименование: ОБЩЕСТВО С ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ «МИКРОКРЕДИТНАЯ КОМПАНИЯ «БАРВИЛ ХД»
                    <br/>
                    Сокращенное наименование: ООО «МКК «КОМПАНИЯ «БАРВИЛ ХД»
                    ИНН 7801323165
                    ОГРН 1167847454642
                    <br/>
                    Регистрационный номер записи в государственном реестре микрофинансовых организаций 1703140008262 от
                    15.05.2017
                    <br/>
                    Является членом Союза «Микрофинансовый Альянс Институты развития малого и среднего бизнеса» с
                    13.12.2021 г.
                    <br/>
                    Регистрационный номер в реестре членов Союза «МИКРОФИНАНСОВЫЙ АЛЬЯНС»: 12 21 031171785 от 13 декабря
                    2021 г.
                    <br/>
                    Адрес ООО «МКК БАРВИЛ ХД» 198332, город Санкт-Петербург, Ленинский пр-кт, д. 80 к. 1
                    литера А, кв. 188
                    <br/>
                    Режим работы: понедельник-пятница с 9.00 до 18.00. Время работы обособленных подразделений
                    необходимо узнавать по телефону 8 812 604 28 78 (звонок по России бесплатный)
                </div>
            </div>
        </div>

        <div class="hide">
            <div class="info-modal" id="sms_code_modal"></div>
            <div class="info-modal" id="error_modal">
                <span class="error-icon"></span>
                <span class="error-message js-error-message"></span>
            </div>
            <div class="info-modal" id="success_modal">
                <span class="success-message js-success-message"></span>
            </div>
        </div>

    </footer>
</div>
<script src="theme/site/libs/jquery/jquery-3.4.1.min.js"></script>
<script src="theme/site/libs/bootstrap/bootstrap.min.js"></script>
<script src="theme/site/libs/range/ion.rangeSlider.min.js"></script>
<script src="theme/site/libs/jquery/jquery.maskedinput.min.js"></script>
<script src="theme/site/libs/fancybox/jquery.fancybox.min.js"></script>
<script src="theme/site/libs/jquery/jquery-ui/jquery-ui.min.js"></script>
<script src="theme/site/js/common.js"></script>

<script src="theme/site/js/sms.app.js"></script>
<script src="theme/site/js/prolongation_sms.app.js"></script>
<script src="theme/site/js/attach_card.app.js?v=1.01"></script>

{$smarty.capture.page_scripts}


{if !$is_developer}
{literal}
    <!-- Yandex.Metrika counter -->
    <script type="text/javascript">
        (function (m, e, t, r, i, k, a) {
            m[i] = m[i] || function () {
                (m[i].a = m[i].a || []).push(arguments)
            };
            m[i].l = 1 * new Date();
            k = e.createElement(t), a = e.getElementsByTagName(t)[0], k.async = 1, k.src = r, a.parentNode.insertBefore(k, a)
        })
        (window, document, "script", "https://mc.yandex.ru/metrika/tag.js", "ym");

        ym(78433342, "init", {
            clickmap: true,
            trackLinks: true,
            accurateTrackBounce: true,
            webvisor: true
        });
    </script>
    <noscript>
        <div><img src="https://mc.yandex.ru/watch/78433342" style="position:absolute; left:-9999px;" alt=""/></div>
    </noscript>
    <!-- /Yandex.Metrika counter -->
{/literal}
{/if}

{if $message_error}
    <script>
        $('.js-error-message').html('{$message_error}');
        $.fancybox.open({
            src: '#error_modal'
        })
    </script>
{/if}

{if $user}
    <script>
        function save_local_time() {
            var date = new Date();
            var local_time = parseInt(date.getTime() / 1000);

            $.ajax({
                url: '/ajax/local_time.php',
                data: {
                    local: local_time
                }
            });
        }

        save_local_time();
        setInterval(function () {
            save_local_time();
        }, 30000);

    </script>
{/if}

</body>
</html>
