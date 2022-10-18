<table border="1" width="" cellspacing="1" cellpadding="7" style="font-size:8px;">
    <tbody>
        <tr>
            <td width="190" height="165">
                <p align="center">
                    <img src="{$config->root_url}/theme/site/i/contract_qr.jpg" width="120" height="120">
                </p>
            </td>
            <td width="190">
                <p>ПОЛНАЯ СТОИМОСТЬ ЗАЙМА:</p>
                <p>{$base_percent*365}%</p>
                <p>({($base_percent*365)|percent_string|upper}) ПРОЦЕНТОВ ГОДОВЫХ</p>
            </td>
            <td width="150">
                <p>ПОЛНАЯ СТОИМОСТЬ ЗАЙМА:</p>
                <p>{$return_amount_percents} РУБЛЕЙ 00 КОПЕЕК</p>
                <p>{$return_amount_percents|price_string|upper}</p>
                
            </td>
        </tr>
    </tbody>
</table>
<p><br /><br /></p>
<table width="530" cellspacing="0" cellpadding="1">
    <tbody>
        <tr>
            <td>
                <p><strong>ДОГОВОР ПОТРЕБИТЕЛЬСКОГО ЗАЙМА_№ {$number} ОТ {$contract_date|date}</strong></p>
                <p><strong>ИНДИВИДУАЛЬНЫЕ УСЛОВИЯ</strong></p>
            </td>
        </tr>
        <tr>
            <td colspan="6">
                <p>Заемщик {$lastname} {$firstname} {$patronymic} ({$birth}), паспорт гражданина
                    Российской Федерации; серия {$passport_series} номер {$passport_number}, 
                    выдан {$passport_date}, зарегистрирован по адресу:
                    {$regaddress_full}
                </p>
                <p>Кредитор: Общество с ограниченной ответственностью Микрокредитная компания "На личное+" (сокращенное
                    наименование ООО МКК "На личное+"), ОГРН 1196313019066, созданное и действующее в соответствии с
                    законодательством Российской Федерации. Адрес: 443058, Самарская обл., г. Самара, ул. Победы, 86,
                    оф.2.1</p>
            </td>
        </tr>
        <tr>
            <td>
                <p><strong>Максимальный размер процентов, неустойки (штрафы, пени), иных мер ответственности по
                        договору, </strong>а также платежей за услуги, оказываемые кредитором заемщику за отдельную
                    плату по договору потребительского займа<strong> не может превышать полуторократного размера суммы
                        займа. С даты возникновения просрочки исполнения обязательств Заемщика по возврату суммы займа
                        Кредитор вправе начислять Заемщику неустойку (штрафы, пени) и применять иные меры
                        ответственности только на не погашенную Заемщиком часть суммы основного долга.</strong></p>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
    </tbody>
</table>
<p><br /><br /></p>
<table border="1" width="530" cellspacing="0" cellpadding="2">
    <tbody>
        <tr>
            <td colspan="3" width="530">&nbsp;</td>
        </tr>
        <tr>
            <td width="30">
                <p>№ п/п</p>
            </td>
            <td width="275">
                <p>Условие</p>
            </td>
            <td width="225">
                <p>Содержание условия</p>
            </td>
        </tr>
        <tr>
            <td width="30">
                <p>1</p>
            </td>
            <td width="275">
                <p>Сумма займа</p>
            </td>
            <td width="225">
                <p>{$amount} руб. ({$amount} рублей 00 копеек)</p>
            </td>
        </tr>
        <tr>
            <td width="30">
                <p>2</p>
            </td>
            <td width="275">
                <p>Срок действия договора, срок возврата займа</p>
            </td>
            <td width="225">
                <p>До {$return_date|date} (включительно)</p>
            </td>
        </tr>
        <tr>
            <td width="30">
                <p>3</p>
            </td>
            <td width="275">
                <p>Валюта, в которой предоставляется кредит заем</p>
            </td>
            <td width="225">
                <p>Российские рубли</p>
            </td>
        </tr>
        <tr>
            <td width="30">
                <p>4</p>
            </td>
            <td width="275">
                <p>Процентная ставка (в процентах годовых)</p>
            </td>
            <td width="225">
                365,000 (Триста шестьдесят пять целых ноль тысячных) процентов годовых ({$base_percent} % в день).
            </td>
        </tr>
        <tr>
            <td width="30">
                <p>5</p>
            </td>
            <td width="275">
                Порядок определения курса иностранной валюты при переводе денежных средств кредитором третьему лицу,
                    указанному заемщиком
            </td>
            <td width="225">
                <p>Не применимо</p>
            </td>
        </tr>
        <tr>
            <td width="30">
                <p>5.1</p>
            </td>
            <td width="275">
                Указание на изменение суммы расходов заемщика при увеличении используемой в договоре переменной
                    процентной ставки потребительского займа на один процентный пункт начиная со второго очередного
                    платежа на ближайшую дату после предполагаемой даты заключения договора
            </td>
            <td width="225">
                <p>Не применимо</p>
            </td>
        </tr>
        <tr>
            <td width="30">
                <p>6</p>
            </td>
            <td width="275">
                <p>Количество, размер и периодичность (сроки) платежей заемщика по договору или порядок определения этих
                    платежей</p>
            </td>
            <td width="225">
                <p>Сумма займа и процентов подлежат оплате единовременным платежом в срок, указанный в п. 2
                    Индивидуальных условий.<br />Размер платежа к моменту возврата займа {$return_amount}.00 руб. 
                    ({$return_amount_rouble} {$return_amount_rouble|plural:'рубль':'рублей':'рубля'} 00 {$return_amount_kop|plural:'копейка':'копеек':'копейки'})
                </p>
            </td>
        </tr>
        <tr>
            <td width="30">
                <p>7</p>
            </td>
            <td width="275">
                <p>Порядок изменения количества, размера и периодичности (сроков) платежей заемщика при частичном
                    досрочном возврате займа</p>
            </td>
            <td width="225">
                <p>Проценты начисляются на оставшуюся непогашенную часть суммы займа со дня, следующего за днем
                    частичного погашения. Оставшаяся задолженность в полном объеме должна быть погашена в дату,
                    указанную в п. 2 Индивидуальных условий</p>
            </td>
        </tr>
        <tr>
            <td width="30">
                <p>8</p>
            </td>
            <td width="275">
                <p>Способы исполнения заемщиком обязательств по договору по месту нахождения заемщика</p>
            </td>
            <td width="225">
                <p>1. Внесение наличных денежных средств через терминалы<br />2. Безналичным платежом на расчетный счет
                    р/с 40701810754400000266</p>
                <p>в ПАО Сбербанк, к/с 30101810200000000607, БИК 043601607</p>
                <p>3. Оплата банковской картой в личном кабинете на официальном сайте Кредитора</p>
                <p>https://finfive.ru</p>
            </td>
        </tr>
        <tr>
            <td width="30">
                <p>8.1</p>
            </td>
            <td width="275">
                <p>Бесплатный способ исполнения заемщиком обязательств по договору</p>
            </td>
            <td width="225">
                <p>В безналичном порядке с банковского счета Заемщика на расчетный счет Кредитора.</p>
            </td>
        </tr>
        <tr>
            <td width="30">
                <p>9</p>
            </td>
            <td width="275">
                <p>Обязанность заемщика заключить иные договоры</p>
            </td>
            <td width="225">
                <p>Не применимо</p>
            </td>
        </tr>
        <tr>
            <td width="30">
                <p>10</p>
            </td>
            <td width="275">
                <p>Обязанность заемщика по предоставлению обеспечения исполнения обязательств по договору и требования к
                    такому обеспечению</p>
            </td>
            <td width="225">
                <p>Не применимо</p>
            </td>
        </tr>
        <tr>
            <td width="30">
                <p>11</p>
            </td>
            <td width="275">
                <p>Цели использования заемщиком потребительского займа</p>
            </td>
            <td width="225">
                <p>На потребительские нужды {$amount} руб.</p>
            </td>
        </tr>
        <tr>
            <td width="30">
                <p>12</p>
            </td>
            <td width="275">
                <p>Ответственность заемщика за ненадлежащее исполнение условий договора, размер неустойки (штрафа, пени)
                    или порядок их определения</p>
            </td>
            <td width="225">
                В случае ненадлежащего исполнения Заемщиком обязательств Заемщик выплачивает неустойку в размере не
                    более 20% (Двадцати процентов) годовых, при этом процент, указанный в п.4 Индивидуальных условий
                    начисляется за соответствующий период нарушения обязательств.
            </td>
        </tr>
        <tr>
            <td width="30" height="1">
                <p>13</p>
            </td>
            <td width="275">
                <p>Условие об уступке кредитором третьим лицам прав (требований) по договору</p>
            </td>
            <td width="225">
                1. Кредитор имеет право на полную или частичную уступку прав (требований) по Договору юридическому
                    лицу, осуществляющему профессиональную деятельность по предоставлению потребительских займов;
                    юридическому лицу, осуществляющему деятельность по возврату просроченной задолженности физических
                    лиц в качестве основного вида деятельности; специализированному финансовому обществу(Далее по тексту
                    - Третьи лица.) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;X
                <p>2. Кредитор не вправе переуступить право на взыскание задолженность по Договору Третьим лицам.</p>
            </td>
        </tr>
        <tr>
            <td width="30">
                <p>14</p>
            </td>
            <td width="275">
                <p>Согласие заемщика с общими условиями договора</p>
            </td>
            <td width="225">
                Заемщик подтверждает, что:
                <p>- ознакомлен, понимает, полностью согласен, а также обязуется соблюдать положения Общих условий
                    договора.</p>
                <p>Общие условия предоставления займов размещены на официальном сайте Кредитора
                https://finfive.ru</p>
            </td>
        </tr>
        <tr>
            <td width="30">
                <p>15</p>
            </td>
            <td width="275">
                Услуги, оказываемые кредитором заемщику за отдельную плату и необходимые для заключения договора, их
                    цена или порядок ее определения, а также согласие заемщика на оказание таких услуг
            </td>
            <td width="225">
                <p>Не применимо</p>
            </td>
        </tr>
        <tr>
            <td width="30">
                <p>16</p>
            </td>
            <td width="275">
                <p>Способ обмена информацией между кредитором и заемщиком</p>
            </td>
            <td width="225">
                Способы обмена информации, используемые Кредитором, для уведомления Заемщика:
                <p>простое письмо (ФГУП &laquo;Почта России&raquo;)</p>
                <p>- смс сообщения ;</p>
                <p>- голосовые и иные сообщения, передаваемые по сетям радиотелефонной связи;</p>
                <p>- сообщения на электронную почту, адрес которой, Заемщик указал в анкете-заявлении;</p>
                <p>текстовые, мультимедийные и иные сообщения, передаваемые с использованием таких общедоступных
                    программных средств как: WhatsApp, Viber, а также мессенджеров (программных модулей)</p>
                <p>Способы обмена информации, используемые Заемщиком, для уведомления Кредитора:</p>
                <p>- простое письмо (ФГУП &laquo;Почта России&raquo;);</p>
                <p>- личное обращение в офис Кредитора;</p>
                <p>- посредством телефонного обращения, по номеру телефона, указанному на официальном сайте Кредитора
                https://finfive.ru</p>
            </td>
        </tr>
        <tr>
            <td width="30">
                <p>17</p>
            </td>
            <td width="275">
                <p>Кредитор вправе:</p>
            </td>
            <td width="225">
                Изменять Общие условия договора при условии, что это не повлечет за собой возникновение новых или
                    увеличение размера существующих денежных обязательств Заемщика по договору. Новая редакция Общих
                    условий Договора становится обязательной для сторон на следующей день после официального
                    опубликования на официальном сайте Кредитора https://finfive.ru
            </td>
        </tr>
        <tr>
            <td width="30">
                <p>18</p>
            </td>
            <td width="275">
                <p>Порядок уведомления Заемщика о наличии просроченной задолженности по Договору</p>
            </td>
            <td width="225">
                Информация о наличии просроченной задолженности по Договору направляется Заемщику в срок не позднее 7
                    (Семи) календарных дней с даты возникновения просроченной задолженности одним из ниже перечисленных
                    способов:
                <p>- голосовое сообщение либо смс-сообщение на номер телефона, указанный Заемщиком, как контактный;</p>
                <p>- на электронную почту, адрес которой Заемщик указал в анкете-заявлении.</p>
            </td>
        </tr>
        <tr>
            <td width="30">
                <p>19</p>
            </td>
            <td width="275">
                <p>Предоставление информации после заключения Договора</p>
            </td>
            <td width="225">
                После предоставления займа Заемщик вправе получать по запросу один раз в месяц бесплатно и любое
                    количество раз за плату следующую информацию:
                <p>1) размер текущей задолженности по Договору;</p>
                <p>2) даты и размеры произведенных за предшествующий месяц платежей и предстоящего платежа заемщика по
                    Договору;</p>
                <p>3) иные сведения, указанные в Договоре.</p>
                <p>Плата за предоставление информации осуществляется в размере в соответствии с тарифами, действующими
                    на дату предоставления информации.</p>
            </td>
        </tr>
        <tr>
            <td width="30">
                <p>20</p>
            </td>
            <td width="275">
                <p>
                    Территориальная подсудность по заявлению
                    Кредитора о выдаче судебного приказа или
                    искового заявления, подаваемому Кредитором
                </p>
            </td>
            <td width="225">
                <table cellpadding="0">
                    <tr>
                        <td width="18">
                            <table border="1" width="10" align="center"><tr><td>X</td></tr></table>
                        </td>
                        <td width="180">
                                По заявлению о выдаче
                                судебного приказа\исковому
                                заявлению               
                                {$tribunal->sud}
                                <br /><br />
                                При неподсудности Мировому суду:
                                {$tribunal->mir_sud}
                        </td>
                    </tr>
                    <tr>
                        <td width="18">
                            <table border="1" width="10"><tr><td>&nbsp;</td></tr></table>
                        </td>
                        <td width="180">
                                По общим правилам
                                подсудности, установленным
                                законодательством РФ.
                        </td>
                    </tr>
                </table>
                
                
                
                
            </td>
        </tr>
    </tbody>
</table>
<table width="397" cellspacing="0" cellpadding="7">
    <tbody>
        <tr>
            <td width="383" height="122">
                <table border="1" width="100%" cellspacing="0" cellpadding="7">
                    <tbody>
                        <tr>
                            <td width="100%" height="98">
                                <p>Подписано с использованием ПЭП</p>
                                <p>{$lastname} {$firstname} {$patronymic}</p>
                                <p>{$contract_date|date}</p>
                                <p>Телефон {$phone}</p>
                                <p>СМС-код: {$asp}</p>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
    </tbody>
</table>