{$meta_title='Личный кабинет' scope=parent}

{capture name='page_scripts'}
    <script src="theme/site/js/calc.app.js"></script>
    <script src="theme/site/js/lk.app.js?v=1.03"></script>
    <script src="theme/site/js/contract_accept.app.js"></script>
{/capture}

{capture name='page_styles'}

{/capture}

<main class="main js-lk-app">
    <div class="section_lk_navbar">
        <div class="container">
            <nav class="navbar lk_menu">
                <ul class="nav lk_menu_nav -gil-m">
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
            </nav>
        </div>
    </div>
    <div class="content_wrap">
        <div class="container">
            <h1>Личный кабинет</h1>
            <!-- общая информация -->

            {if $user_balance1c}
                <div class="new_order_box " data-status="{$order->status}" data-order="{$order->order_id}">
                    <div class="row">
                        <div class="col-12">
                            <div class="-fs-32 -gil-b -green text-center pb-3">
                                У Вас есть активный займ от {$user_balance1c->loan_date|date}г.
                            </div>
                        </div>
                        <div class="col-md-6 pt-4">
                            <dl class="row pb-2 border-bottom">
                                <dd class="col-6 text-left">Номер договора</dd>
                                <dt class="col-6 text-right">{$user_balance1c->number|escape}</dt>
                            </dl>
                            <dl class="row pb-2 border-bottom">
                                <dd class="col-6 text-left">Основной долг</dd>
                                <dt class="col-6 text-right">{($user_balance1c->loan_body_summ)|convert} руб.</dt>
                            </dl>
                            <dl class="row pb-2 border-bottom">
                                <dd class="col-6 text-left">Проценты</dd>
                                <dt class="col-6 text-right">{($user_balance1c->loan_percents_summ)|convert} руб.</dt>
                            </dl>
                            {if $user_balance1c->loan_peni_summ > 0}
                                <dl class="row pb-2 border-bottom">
                                    <dd class="col-6 text-left">Пени</dd>
                                    <dt class="col-6 text-right">{($user_balance1c->loan_peni_summ)|convert} руб.</dt>
                                </dl>
                            {/if}
                            {*}
                            <dl class="row pb-2">
                              <dd class="col-6 text-left">Дата возврата</dd>
                              <dt class="col-6 text-right">{$order->contract->return_date|date} </dt>
                            </dl>
                            <dl class="row pb-2 border-bottom">
                              <dd class="col-6 text-left">Сумма на дату возврата</dd>
                              <dt class="col-6 text-right">{$order->contract->return_amount|convert} руб.</dt>
                            </dl>
                            {*}
                        </div>
                        <div class="col-md-6">

                            <div class="pt-4 pr-5 pl-5 text-center">

                            </div>
                            <div class="pt-4 text-center">
                                <form action="account/pay" method="POST" class="border rounded">
                                    <input type="hidden" name="user_balance_id" value="{$user_balance1c->id}"/>
                                    <div class="row">
                                        <div class="col-4">
                                            <div class="row">
                                                <div class="col-12">
                                                    <input type="text" class="form-control text-right" name="amount"
                                                           value="{$user_balance1c->loan_body_summ + $user_balance1c->loan_percents_summ + $user_balance1c->loan_peni_summ}"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-6 pt-1">
                                            <button type="submit" class="btn btn-primary btn-block">Оплатить</button>
                                        </div>
                                    </div>
                                </form>
                            </div>

                            {*
                            {if $prolongation_amount}
                                <div class="pt-4 text-center">
                                    <form action="account/pay" method="POST" class="border rounded">
                                        <input type="hidden" name="contract_id" value="{$order->contract->id}"/>
                                        <input type="hidden" name="prolongation" value="1"/>
                                        <input type="hidden" name="code" value=""/>
                                        <h3>Продление</h3>
                                        <div class="row">
                                            <div class="col-4">
                                                <div class="row">
                                                    <div class="col-12">
                                                        <input type="text" readonly=""
                                                               style="background-color: #fbfbfb;"
                                                               class="form-control text-right" name="amount"
                                                               value="{1 * $prolongation_amount}"
                                                               min="{$prolongation_amount}"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-6 pt-1">
                                                <button type="submit" class="btn btn-primary btn-block">Оплатить
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            {/if}
                            *}
                        </div>
                    </div>
                </div>
            {elseif $order->contract->sud}

                {if $user->id == '127170'}
                    <div class="new_order_box " data-status="{$order->status}" data-order="{$order->order_id}">
                        <div class="row">
                            <div class="col-12">
                                <div class="-fs-32 -gil-b -red text-center pb-3">
                                    Ваш договор переуступлен по договору цессии
                                </div>
                            </div>
                            <div class="col-md-6 pt-4">
                            </div>
                            <div class="col-md-6">

                                <div class="pt-4 pr-5 pl-5 text-center">

                                </div>


                            </div>
                        </div>
                    </div>
                {else}
                    <div class="new_order_box " data-status="{$order->status}" data-order="{$order->order_id}">
                        <div class="row">
                            <div class="col-12">
                                <div class="-fs-32 -gil-b -red text-center pb-3">
                                    У Вас есть активный займ от {$order->contract->create_date|date}г.
                                    <br/>
                                    Ваш договор передан в суд
                                </div>
                            </div>
                            <div class="col-md-6 pt-4">
                            </div>
                            <div class="col-md-6">

                                <div class="pt-4 pr-5 pl-5 text-center">

                                </div>


                            </div>
                        </div>
                    </div>
                {/if}
            {elseif $order}

                {* Заявка на рассмотрении *}
                {if $order->status < 2}
                    <div class="new_order_box js-check-status" data-status="{$order->status}"
                         data-order="{$order->order_id}">
                        <div class="row">
                            <div class="col-12">
                                <div class="-fs-32 -gil-b -green text-center pb-3">Ваша заявка рассматривается</div>
                            </div>
                            <div class="col-md-6 pt-4">
                                <dl class="row pb-2 border-bottom">
                                    <dd class="col-6 text-left">Номер заявки</dd>
                                    <dt class="col-6 text-right">{$order->order_id}</dt>
                                </dl>
                                <dl class="row pb-2 border-bottom">
                                    <dd class="col-6 text-left">Дата</dd>
                                    <dt class="col-6 text-right">{$order->date|date}</dt>
                                </dl>
                                <dl class="row pb-2 border-bottom">
                                    <dd class="col-6 text-left">Сумма</dd>
                                    <dt class="col-6 text-right">{$order->amount|convert} руб.</dt>
                                </dl>
                                <dl class="row pb-2">
                                    <dd class="col-6 text-left">Срок</dd>
                                    <dt class="col-6 text-right">{$order->period} {$order->period|plural:'день':'дней':'дня'}</dt>
                                </dl>
                            </div>
                            <div class="col-md-6">
                                <div class="time_preloader"></div>
                                <div class="pt-4 pr-5 pl-5 text-center">Ожидайте, в ближайшее время поступит
                                    автоматический звонок с номера 8 812 604 28 78
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}

                {* заявка одобрена *}
                {if $order->status == 2}
                    <div class="new_order_box  js-check-status" data-status="{$order->status}"
                         data-order="{$order->order_id}">
                        <div class="row">
                            <div class="col-12">
                                <div class="-fs-32 -gil-b -green text-center pb-3">
                                    {if $order->contract->status == 0}
                                        Вам одобрен кредит {$order->amount|convert} руб. на {$order->period} {$order->period|plural:'день':'дней':'дня'}
                                    {else}
                                        Договор подписан. Через несколько минут мы отправим деньги на карту.
                                    {/if}
                                </div>
                            </div>
                            <div class="col-md-6 pt-4">
                                <dl class="row pb-2 border-bottom">
                                    <dd class="col-6 text-left">Номер заявки</dd>
                                    <dt class="col-6 text-right">{$order->order_id}</dt>
                                </dl>
                                <dl class="row pb-2 border-bottom">
                                    <dd class="col-6 text-left">Одобренная сумма</dd>
                                    <dt class="col-6 text-right">{$order->amount|convert} руб.</dt>
                                </dl>
                                <dl class="row pb-2 border-bottom">
                                    <dd class="col-6 text-left">Сумма к возврату</dd>
                                    <dt class="col-6 text-right">{$order->return_amount|convert} руб.</dt>
                                </dl>
                                <dl class="row pb-2">
                                    <dd class="col-6 text-left">Дата возврата</dd>
                                    <dt class="col-6 text-right">{$order->return_period|date} </dt>
                                </dl>
                            </div>
                            <div class="col-md-6">
                                {if $order->contract->status == 0}
                                    <div class="order_accept_icon"></div>
                                    {*}
                                    <div class="pt-4 pr-5 pl-5 text-center">
                                        Перейдите к подписанию договора
                                    </div>
                                    <div class="pt-4 text-center">
                                        <a href="accept/{$order->contract_id}" class="btn btn-primary">Подписать договор</a>
                                    </div>
                                    {*}
                                    <form id="accept_credit_form" data-phone="{$user->phone_mobile}">
                                        <input type="hidden" name="contract_id" value="{$order->contract->id}"/>
                                        <input type="hidden" name="phone" value="{$user->phone_mobile}"/>

                                        <div class="form-group">
                                            <div class="form_row">
                                                <div class="check mb-0 js-loan-agreement-block">
                                                    <input type="checkbox" class="custom-checkbox js-loan-agreement"
                                                           id="check_agreement" name="agreement" value="1"/>
                                                    <label for="check_agreement" class="check_box -gil-m">
                                                        <span>Я ознакомлен и согласен со <a href="#agreement_list"
                                                                                            class="green-link js-toggle-agreement-list">следующим</a></span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        {include file='agreement_list.tpl'}

                                        <div class="form-group">
                                            <div class="form-phone">
                                                <label class="phone_info -fs-14" for="accept_code">Код активации из
                                                    СМС</label>
                                                <input type="text" placeholder="" name="accept_code" id="accept_code"
                                                       class="js-accept-code form-control" value=""/>
                                                <a class="js-repeat-accept-code" href="javascript:void(0);">отправить
                                                    еще раз <span class="js-accept-timer"></span></a>

                                                <div class="js-accept-code-error -red"></div>
                                            </div>
                                        </div>

                                        <div class="text-center">
                                            <a href="javascript:void(0);" class="btn btn-primary js-accept-contract">Подписать
                                                договор</a>
                                        </div>
                                        <div class="hide">
                                        </div>
                                    </form>
                                {else}
                                    <div class="time_preloader"></div>
                                    <div class="pt-4 pr-5 pl-5 text-center">Ожидайте перевода займа на карту.</div>
                                {/if}
                            </div>
                        </div>
                    </div>
                {/if}

                {* договор подписан *}
                {if $order->status == 4}
                    <div class="new_order_box js-check-status" data-status="{$order->status}"
                         data-order="{$order->order_id}">
                        <div class="row">
                            <div class="col-12">
                                <div class="-fs-32 -gil-b -green text-center pb-3">
                                    Договор подписан. Через несколько минут мы отправим деньги на карту.
                                </div>
                            </div>
                            <div class="col-md-6 pt-4">
                                <dl class="row pb-2 border-bottom">
                                    <dd class="col-6 text-left">Номер договора</dd>
                                    <dt class="col-6 text-right">{$order->contract->id}</dt>
                                </dl>
                                <dl class="row pb-2 border-bottom">
                                    <dd class="col-6 text-left">Одобренная сумма</dd>
                                    <dt class="col-6 text-right">{$order->amount|convert} руб.</dt>
                                </dl>
                                <dl class="row pb-2 border-bottom">
                                    <dd class="col-6 text-left">Сумма к возврату</dd>
                                    <dt class="col-6 text-right">{$order->return_amount|convert} руб.</dt>
                                </dl>
                                <dl class="row pb-2">
                                    <dd class="col-6 text-left">Дата возврата</dd>
                                    <dt class="col-6 text-right">{$order->return_period|date} </dt>
                                </dl>
                            </div>
                            <div class="col-md-6">
                                <div class="time_preloader"></div>
                                <div class="pt-4 pr-5 pl-5 text-center">Ожидайте перевода займа на карту.</div>
                            </div>
                        </div>
                    </div>
                {/if}

                {* отказ *}
                {if $order->status == 3 || $order->status == 8}
                    <div class="new_order_box " data-status="3" data-order="{$order->order_id}">
                        <div class="row">
                            <div class="col-12">
                                <div class="-fs-32 -gil-b -red text-center pb-3">Вам отказано в кредите</div>
                            </div>
                            <div class="col-md-6 pt-4">
                                <dl class="row pb-2 border-bottom">
                                    <dd class="col-6 text-left">Номер заявки</dd>
                                    <dt class="col-6 text-right">{$order->order_id}</dt>
                                </dl>
                                <dl class="row pb-2 border-bottom">
                                    <dd class="col-6 text-left">Дата</dd>
                                    <dt class="col-6 text-right">{$order->date|date}</dt>
                                </dl>
                                <dl class="row pb-2 border-bottom">
                                    <dd class="col-6 text-left">Сумма</dd>
                                    <dt class="col-6 text-right">{$order->amount|convert} руб.</dt>
                                </dl>
                                <dl class="row pb-2">
                                    <dd class="col-6 text-left">Срок</dd>
                                    <dt class="col-6 text-right">{$order->period} {$order->period|plural:'день':'дней':'дня'}</dt>
                                </dl>
                            </div>
                            <div class="col-md-6">
                                <div class="order_reject_icon"></div>
                                <div class="pt-4 pr-5 pl-5 text-center">
                                    {*
                                   <small>{$order->reject_reason}</small>
                                   *}
                                    <div>
                                        <a href="https://zaimwagon.online/" target="_blank"
                                           class="blue-link">
                                            Получите займ у наших партнёров
                                            <br/>
                                            <span class="sc-htoDjs fOeadG"><img class="smart-link-icon"
                                                                                src="theme/site/i/vsezaimi_logo.svg"
                                                                                width="20px"/></span>
                                            <span class="sc-iwsKbI jQhHGA">Лучшие предложения для вас</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            {if $reject_block}
                                <div class="col-12">
                                    <div class="-fs-24 -gil-b -red text-center pb-3">
                                        <br/>
                                        По заявке принято отрицательное решение, вы можете подать новую заявку
                                        с {$reject_block|date}
                                    </div>
                                </div>
                            {/if}
                        </div>
                    </div>
                {/if}

                {* Займ выдан *}
                {if $order->status == 5}
                    <div class="new_order_box " data-status="{$order->status}" data-order="{$order->order_id}">
                        <div class="row">
                            <div class="col-12">
                                <div class="-fs-32 -gil-b -green text-center pb-3">
                                    У Вас есть активный займ от {$order->contract->create_date|date}г.
                                </div>
                            </div>
                            <div class="col-md-6 pt-4">
                                <dl class="row pb-2 border-bottom">
                                    <dd class="col-6 text-left">Номер договора</dd>
                                    <dt class="col-6 text-right">
                                        {$order->contract->number}
                                    </dt>
                                </dl>
                                <dl class="row pb-2 border-bottom">
                                    <dd class="col-6 text-left">Основной долг</dd>
                                    <dt class="col-6 text-right">{($order->contract->loan_body_summ*1)} руб.</dt>
                                </dl>
                                <dl class="row pb-2 border-bottom">
                                    <dd class="col-6 text-left">Проценты</dd>
                                    <dt class="col-6 text-right">{($order->contract->loan_percents_summ + $order->contract->loan_charge_summ)*1}
                                        руб.
                                    </dt>
                                </dl>
                                {if $order->contract->loan_peni_summ > 0}
                                    <dl class="row pb-2 border-bottom">
                                        <dd class="col-6 text-left">Пени</dd>
                                        <dt class="col-6 text-right">{($order->contract->loan_peni_summ*1)} руб.</dt>
                                    </dl>
                                {/if}
                                <dl class="row pb-2">
                                    <dd class="col-6 text-left">Дата возврата</dd>
                                    <dt class="col-6 text-right">{$order->contract->return_date|date} </dt>
                                </dl>
                                {*}
                                <dl class="row pb-2 border-bottom">
                                  <dd class="col-6 text-left">Сумма на дату возврата</dd>
                                  <dt class="col-6 text-right">{$order->contract->return_amount|convert} руб.</dt>
                                </dl>
                                {*}
                            </div>
                            <div class="col-md-6">

                                <div class="pt-4 pr-5 pl-5 text-center">

                                </div>
                                <div class="pt-2 text-center">
                                    <form action="account/pay" method="POST" class="border rounded p-2">
                                        <input type="hidden" name="contract_id" value="{$order->contract->id}"/>
                                        <div class="row">
                                            <div class="col-md-4 col-12">
                                                <input type="text" class="form-control text-right" name="amount"
                                                       value="{$order->contract->loan_body_summ + $order->contract->loan_percents_summ + $order->contract->loan_charge_summ + $order->contract->loan_peni_summ}"/>
                                            </div>
                                            <div class="col-md-6 pt-1">
                                                {if $order->contract->type == 'onec'}
                                                    <a href="https://nalichnoe.com/login/"
                                                       class="btn btn-primary btn-block">Перейти&nbsp;к&nbsp;оплате</a>
                                                {else}
                                                    <button type="submit" class="btn btn-primary btn-block">Оплатить
                                                    </button>
                                                {/if}
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                {if $prolongation_amount && $order->contract->type == 'base'}
                                    <div class="pt-4 text-center">
                                        <form action="account/pay" method="POST"
                                              class="border rounded js-prolongation-form p-2">
                                            <input type="hidden" name="contract_id" value="{$order->contract->id}"/>
                                            <input type="hidden" name="prolongation" value="1"/>
                                            <input type="hidden" name="code" value=""/>
                                            <input type="hidden" name="phone" value="{$user->phone_mobile}"/>
                                            <h3>Продление</h3>
                                            <div class="row">
                                                <div class="col-md-4 col-12">
                                                    <input type="text" readonly="" style="background-color: #fbfbfb;"
                                                           class="form-control text-right" name="amount"
                                                           value="{1 * $prolongation_amount}"
                                                           min="{$prolongation_amount}"/>
                                                </div>
                                                <div class="col-md-6 col-12 pt-1">
                                                    {if $order->contract->type == 'onec'}
                                                        <a href="https://nalichnoe.com/login/"
                                                           class="btn btn-primary btn-block">Перейти&nbsp;к&nbsp;оплате</a>
                                                    {else}
                                                        <button type="submit" class="btn btn-primary btn-block">
                                                            Оплатить
                                                        </button>
                                                    {/if}
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                {/if}
                            </div>
                        </div>
                    </div>
                {/if}

            {/if}


            {*}
            <div class="person_info_box">
              <div class="person_info">
                <div class="person_info_title -fs-26 -gil-m">Займ от {$order->date|date}г.</div>
                <div class="person_info_wrap -fs-18">
                  <div class="order_info_row row">
                    <div class="col-sm-4 col-md-3">
                      <div class="order_item_info">
                        <div class="order_info_title">Номер заявки</div>
                        <div class="order_info_text -gil-m">№{$order->contract->id}</div>
                      </div>
                    </div>
                    <div class="col-sm-4 col-md-3">
                      <div class="order_item_info">
                        <div class="order_info_title">Сумма</div>
                        <div class="order_info_text -gil-m">{$order->contract->amount} руб.</div>
                      </div>
                    </div>
                    <div class="col-sm-4 col-md-3">
                      <div class="order_item_info">
                        <div class="order_info_title">Срок</div>
                        <div class="order_info_text -gil-m">{$order->contract->period}</div>
                      </div>
                    </div>
                    <div class="col-sm-4 col-md-3">
                      <div class="order_item_info">
                        <div class="order_info_title">Статус</div>
                        <div class="order_info_text -gil-m status_{$order->status}">
                          {$statuses[$order->status]}
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            {*}

            {if (!$reject_block && !$user_balance1c && (!$order || $order->status > 5 || $order->status == 3))}
                <div class="new_order_box js-new-order-proposition" data-status="{$order->status}"
                     data-order="{$order->order_id}">
                    <div class="row">
                        {if $error}
                            <div class="col-12">
                                <div class="alert alert-danger">
                                    {$error|escape}
                                </div>
                            </div>
                        {/if}
                        <div class="col-12">
                            <div class="-fs-32 -gil-b text-center pb-3">
                                {if $order->status == 6}
                                    <span class="-red">При переводе возникла ошибка</span>
                                {else}
                                    <span class="-green">У Вас нет открытых займов </span>
                                {/if}
                            </div>
                            {if !$cards}
                                <div class="-fs-24 -gil-b -red text-center pb-3">
                                    Для получения займа необходимо привязать карту
                                    <div class="pt-3">
                                        <a href="/account/cards" class="btn btn-primary">Привязать карту</a>
                                    </div>
                                </div>
                            {/if}
                        </div>
                        {if $cards && $order->contract->status != 9 }
                            <div class="col-md-12">
                                <div class="pt-4 text-center">
                                    <form action="account/pay" method="POST">
                                        <input type="hidden" name="contract_id" value="{$order->contract->id}"/>
                                        <div class="row">
                                            <div class="col-12 pt-1">
                                                {if $need_fields}
                                                    <a href="account/anketa" class="btn btn-primary">Получить новый</a>
                                                {else}
                                                    <button type="button" class="btn btn-primary js-open-repeat-block">
                                                        Получить новый
                                                    </button>
                                                {/if}
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        {/if}
                    </div>
                </div>
                <div class="new_order_box hide js-repeat-block">
                    <form class="calculator js-loan-repeat-form js-calc" method="POST" data-percent="{$loan_percent}">

                        <input type="hidden" name="local_time" class="js-local-time" value=""/>
                        <input type="hidden" name="juicescore_session_id" id="juicescore_session_id" value=""/>

                        <div class="row">
                            <div class="col-md-7">
                                <div class="form-group form-group-one">
                                    <div class="form_row">
                                        <label class="form-group-title -fs-18 -gil-m" for="amount-one">
                                            Выберите сумму:
                                        </label>
                                        <span class="range_res -fs-26 -gil-b js-info-summ" id="demo"></span>
                                    </div>
                                    <div class="amount">
                                        <input type="range" name="amount" min="{$min_summ}" max="{$max_summ}"
                                               value="{$current_summ}" class="slider js-input-summ" id="amount-one">
                                    </div>
                                </div>
                                <div class="form-group form-group-two">
                                    <div class="form_row">
                                        <label class="form-group-title -fs-18 -gil-m" for="amount-two">
                                            Выберите срок:
                                        </label>
                                        <span class="range_res -fs-26 -gil-b js-info-period" id="demo2"></span>
                                    </div>
                                    <div class="amount">
                                        <input type="range" name="period" min="{$min_period}" max="{$max_period}"
                                               value="{$current_period}" class="slider js-input-period" id="amount-two">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-group form-group-res br-10">
                                    <div class="form_row">
                                        <div class="res_title -fs-18 -gil-m">Итого к возврату:</div>
                                        <div class="res_info_sum -fs-20 -gil-b"><span class="js-total-summ"></span> ₽
                                        </div>
                                    </div>
                                    <div class="form_row">
                                        <div class="res_title -fs-18 -gil-m">Срок до:</div>
                                        <div class="res_info_data  -fs-20 -gil-b"><span class="js-total-period">12.12.2020</span>
                                            г.
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <select name="card_id" class="form-control" style="padding: 0!important;">
                                        {foreach $cards as $card}
                                            {if !$card->deleted}
                                                <option value="{$card->id}">{$card->pan} {$card->expdate}</option>
                                            {/if}
                                        {/foreach}
                                    </select>
                                </div>
                                <div class="form-group">
                                    <div class="form_row">
                                        <div class="check mb-0 js-loan-agreement-block">
                                            <input type="checkbox" class="custom-checkbox js-loan-agreement"
                                                   id="check_agreement" name="agreement" value="1"/>
                                            <label for="check_agreement" class="check_box -gil-m">
                                                                                <span>Я ознакомлен и согласен со <a
                                                                                            href="#agreement_list"
                                                                                            class="green-link js-toggle-agreement-list"
                                                                                            data-fancybox>следующим</a></span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                {include file='agreement_list.tpl'}
                                <div class="form-group form-btn">
                                    <a href="#" class="btn btn-secondary -fs-20 -fullwidth js-loan-repeat">Получить
                                        займ</a>

                                    <span class="bottom_text -fs-14 -center">нажимая на кнопку, вы соглашаетесь с
                                                                    <a href="#agreement_list" data-fancybox>договором оферты</a>
                                                                    </span>

                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            {/if}


            <script type="text/javascript">
                var juicyLabConfig = {
                    completeButton: "#next_stage"
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
            <script>
                window.addEventListener('sessionready', function (e) {
                    console.log('sessionready', e.detail.sessionId)
                    $('#juicescore_session_id').val(e.detail.sessionId)
                })
            </script>


        </div>
    </div>
</main>
