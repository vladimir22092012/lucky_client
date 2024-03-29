<h4 align="center">ДОГОВОР ПОТРЕБИТЕЛЬСКОГО ЗАЙМА_№ {$number} ОТ {$contract_date|date}</h4>
<div>
</div>
<table border="1" width="" cellspacing="1" cellpadding="7" style="font-size:8px;">
    <tbody>
    <tr>
        <td width="180" height="180">
            <p align="center">
                <img src="{$config->root_dir}/theme/site/html/pdf/i/qr-code.png" width="120" height="120">
            </p>
        </td>
        <td width="180" height="180" align="center">
            <p>ПОЛНАЯ СТОИМОСТЬ ЗАЙМА:</p>
            <p>{($base_percent*365)|number_format:3:',':''}%</p>
            <p>({($base_percent*365)|percent_string|upper} ПРОЦЕНТОВ ГОДОВЫХ)</p>
        </td>
        <td width="180" height="180" align="center">
            <p>ПОЛНАЯ СТОИМОСТЬ ЗАЙМА:</p>
            <p>{($return_amount_percents)|number_format:3:',':''} РУБЛЕЙ 00 КОПЕЕК</p>
            <p>({$return_amount_percents|price_string|upper})</p>
        </td>
    </tr>
    </tbody>
</table>
<div>

</div>
<div align="justify">Общество с ограниченной ответственностью «МИКРОКРЕДИТНАЯ КОМПАНИЯ «БАРВИЛ ХД» (Сокращенное
    наименование: ООО «МКК
    «БАРВИЛ ХД») , ОГРН1167847454642 , созданное и действующее в соответствии с законодательством Российской Федерации,
    Адрес: 198332, город Санкт-Петербург, Ленинский пр-кт, д. 80 к. 1 литера А, кв. 188 далее – «Общество»), именуемое в
    дальнейшем «Кредитор» (Займодавец, Общество), в лице генерального директора Николаевой Ольги Александровны,
    действующей на основании Устава, с одной стороны, и {$lastname} {$firstname} {$patronymic} ({$birth}), паспорт
    гражданина
    Российской Федерации; серия {$passport_series} номер {$passport_number},
    выдан {$passport_issued} {$passport_date|date}г, зарегистрирован по адресу: {$regaddress_full}, именуемый(-ая) в
    дальнейшем «Заемщик», с другой стороны, вместе именуемые в
    дальнейшем «Стороны», заключили настоящий Договор потребительского кредита (займа) (далее – Договор), на следующих
    индивидуальных условиях, представленных в таблице.
    Кредитор предоставляет Заемщику денежные средства (далее – «Заем»), а Заемщик обязуется возвратить полученную сумму
    и уплатить проценты за пользование Займом в соответствии с Правилами предоставления займов, Общими условиями
    договора потребительского займа, Индивидуальными условиями договора потребительского займа и иными документами
    Кредитора.
</div>
<div>

</div>
<div align="justify">В связи с тем, что срок возврата микрозайма не превышает одного года, Кредитор:<br><br>1. Не вправе
    начислять проценты, неустойку (штрафы, пени) иные меры ответственности по настоящему Договору, а также
    платежи за услуги, оказываемые Кредитором Заемщику за отдельную плату, после того, как сумма начисленных процентов,
    неустойки (штрафа, пени), иных мер ответственности по настоящему Договору, а также платежей за услуги, оказываемые
    Кредитором Заемщику за отдельную плату, достигнет полуторакратного размера суммы предоставленного
    микрозайма.<br><br>2. После возникновения просрочки исполнения обязательства Заемщика по возврату суммы займа и
    (или) уплате
    причитающихся процентов вправе начислять заемщику - физическому лицу неустойку (штрафы, пени) и иные меры
    ответственности только на не погашенную Заемщиком часть суммы основного долга.
</div>
<div>

</div>
<h5 align="center">ИНДИВИДУАЛЬНЫЕ УСЛОВИЯ ДОГОВОРА ПОТРЕБИТЕЛЬСКОГО ЗАЙМА_№ {$number} ОТ {$contract_date|date}</h5>

<table border="1" cellpadding="7" align="left">
    <thead>
    <tr>
        <th width="15%"><strong>№ п/п</strong></th>
        <th width="40%"><strong>Условие</strong></th>
        <th width="45%"><strong>Содержание условия</strong></th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td width="15%">1</td>
        <td width="40%">Сумма займа или лимит кредитования и порядок изменения</td>
        <td width="45%">По настоящему Договору потребительского займа (далее - Договор) Кредитор передает Заемщику
            денежные
            средства в размере {$amount} руб. ({$amount} рублей 00 копеек). (далее - Сумма займа, Заем)
        </td>
    </tr>
    <tr>
        <td>2</td>
        <td>Срок действия договора, срок возврата займа</td>
        <td>Настоящий договор вступает в силу с момента его подписания Сторонами и действует до полного исполнения
            Заемщиком принятых обязательств по возврату Суммы Займа и процентов за пользование Займом.<br>Срок возврата
            суммы займа до {$return_date|date} г.
        </td>
    </tr>
    <tr>
        <td>3</td>
        <td>Валюта, в которой предоставляется заем</td>
        <td>Российский рубль</td>
    </tr>
    <tr>
        <td>4</td>
        <td>Процентная ставка (процентные ставки) в процентах годовых, а при применении переменной процентной ставки –
            порядок ее определения, соответствующий требованиям Федерального закона от 21 декабря 2013 года № 353-ФЗ «О
            потребительском кредите (займе)», ее значение на дату предоставления заемщику индивидуальных условий
        </td>
        <td>(292 процента) годовых. (0.80 процент(а/ов) в день) при пользовании Заемщиком денежными средствами.
            Проценты начисляются со дня следующего за днем предоставления займа и до полного исполнения Заемщиком
            обязательств по займу.
        </td>
    </tr> 
    <tr>
        <td>5</td>
        <td>Порядок определения курса иностранной валюты при
            переводе денежных средств кредитором третьему лицу,
            указанному заемщиком
        </td>
        <td>Не применимо</td>
    </tr>
    <tr>
        <td>5.1</td>
        <td>Указание на изменение суммы расходов заемщика при увеличении используемой в договоре переменной
            процентной ставки потребительского займа на один
            процентный пункт начиная со второго очередного
        </td>
        <td>Не применимо</td>
    </tr>
    <tr>
        <td>6</td>
        <td>Количество, размер и периодичность (сроки) платежей
            заемщика по договору или порядок определения этих
            платежей
        </td>
        <td>Количество платежей – 1 (Один)<br>Размер платежа - {$return_amount} ({$return_amount|price_string|upper}
            ).<br>Размер платежа состоит из Суммы микрозайма в размере {$amount} ({$amount|price_string|upper})<br>и
            процентов за пользование микрозаймом в размере {$return_amount_percents}
            ({$return_amount_percents|price_string|upper}).<br>Дата платежа – {$return_date|date} г.<br>Данное
            условие является графиком платежей по данному договору.<br>Возврат всей суммы займа и процентов за
            пользование им производится
            Заемщиком не позднее срока возврата займа, указанного в строке 2 настоящих
            Индивидуальных условий
        </td>
    </tr>
    <tr>
        <td>7</td>
        <td>Порядок изменения количества, размера и
            периодичности (сроков) платежей заемщика при
            частичном досрочном возврате займа
        </td>
        <td>Проценты начисляются на оставшуюся непогашенную часть суммы займа со дня,
            следующего за днем частичного погашения. Оставшаяся задолженность в полном объеме должна быть погашена в
            дату, указанную в п.2 Индивидуальных условий
        </td>
    </tr>
    <tr>
        <td>8</td>
        <td>Указание на изменение суммы расходов заемщика при увеличении используемой в договоре переменной
            процентной ставки потребительского займа на один
            процентный пункт начиная со второго очередного
        </td>
        <td>1. Внесение наличных денежных средств
            через терминалы<br><br>2. Безналичным платежом на расчетный
            счет р/с 40701810200070000015
            в АО «МИнБанк», к/с
            30101810300000000600, БИК 044525600<br><br>3. Оплата банковской картой в личном
            кабинете на официальном сайте Кредитора
            mkk-barvil.ru
        </td>
    </tr>
    <tr>
        <td>8.1</td>
        <td>Бесплатный способ исполнения заемщиком
            обязательств по договору
        </td>
        <td>В безналичном порядке с банковского счета
            Заемщика на расчетный счет Кредитора.<br><br>В отделениях Почты России.
        </td>
    </tr>
    <tr>
        <td>9</td>
        <td>Обязанность заемщика заключить иные договоры</td>
        <td>Не применимо</td>
    </tr>
    <tr>
        <td>10</td>
        <td>Обязанность заемщика по предоставлению
            обеспечения исполнения обязательств по договору и
            требования к такому обеспечению
        </td>
        <td>Не применимо</td>
    </tr>
    <tr>
        <td>11</td>
        <td>Цели использования заемщиком потребительского займа</td>
        <td>На потребительские нужды {$amount|number_format:2:',':''} руб.</td>
    </tr>
    <tr>
        <td>12</td>
        <td>Ответственность заемщика за ненадлежащее
            исполнение условий договора, размер неустойки
            (штрафа, пени) или порядок их определения
        </td>
        <td>В случае ненадлежащего исполнения Заемщиком обязательств Заемщик
            выплачивает неустойку в размере не более 20% (Двадцати процентов) годовых, при этом процент, указанный в п.4
            Индивидуальных условий начисляется за соответствующий период нарушения обязательств.
        </td>
    </tr>
    <tr>
        <td>13</td>
        <td>Условие об уступке кредитором третьим лицам прав
            (требований) по договору
        </td>
        <td>Заемщик разрешает Кредитору уступить права (требования) к Заёмщику по
            настоящему Договору третьему лицу путем заключения Договора уступки прав
            (требований), условия которого не подлежат согласованию с Заёмщиком. О
            переходе прав (требований) к Заёмщику третьему лицу Кредитор уведомляет
            Заёмщика любым из способов, указанных в п. 16 настоящего Договора не позднее
            30 (тридцати) рабочих дней с момента уступки прав (требований).Согласен(а):
            <br>&#9632;ДА &#9633;НЕТ
        </td>
    </tr>
    <tr>
        <td>14</td>
        <td>Согласие заемщика с общими условиями договора</td>
        <td>Заемщик подтверждает, что:<br>- ознакомлен, понимает, полностью согласен,
            а также обязуется соблюдать положения
            Общих условий договора.
            Общие условия предоставления займов
            размещены на официальном сайте Кредитора
            mkk-barvil.ru
        </td>
    </tr>
    <tr>
        <td>15</td>
        <td>Услуги, оказываемые кредитором заемщику за
            отдельную плату и необходимые для заключения
            договора, их цена или порядок ее определения, а также
            согласие заемщика на оказание таких услуг
        </td>
        <td>Не применимо</td>
    </tr>
    <tr>
        <td>16</td>
        <td>Способ обмена информацией между кредитором и
            заемщиком
        </td>
        <td>Способы обмена информации,
            используемые Кредитором, для уведомления
            Заемщика:<br>- простое письмо (ФГУП «Почта России»)<br>- смс сообщения ;<br>- голосовые и иные сообщения,
            передаваемые по сетям радиотелефонной
            связи;<br>- сообщения на электронную почту, адрес
            которой, Заемщик указал в анкете-
            заявлении;<br>- текстовые, мультимедийные и иные
            сообщения, передаваемые с использованием
            таких общедоступных программных средств
            как: WhatsApp, Viber, Telegram, а также мессенджеров
            (программных модулей)<br><br>Способы обмена информации, используемые
            Заемщиком, для уведомления Кредитора:<br>- простое письмо (ФГУП «Почта России»);
        </td>
    </tr>
    <tr>
        <td>17</td>
        <td>Кредитор вправе:</td>
        <td>Изменять Общие условия договора при условии, что это не повлечет за собой возникновение новых или увеличение
            размера существующих денежных
            обязательств Заемщика по договору. Новая редакция Общих условий Договора
            становится обязательной для сторон на следующей день после официального
            опубликования на официальном сайте Кредитора mkk-barvil.ru
        </td>
    </tr>
    <tr>
        <td>18</td>
        <td>Порядок уведомления Заемщика о наличии просроченной задолженности по Договору</td>
        <td>Информация о наличии просроченной задолженности по Договору направляется
            Заемщику в срок не позднее 7 (Семи) календарных дней с даты возникновения
            просроченной задолженности одним из нижеперечисленных способов:<br>- голосовое сообщение либо смс-сообщение
            на номер телефона, указанный Заемщиком,
            как контактный;<br>- на электронную почту, адрес которой
            Заемщик указал в анкете-заявлении.
        </td>
    </tr>
    <tr>
        <td>19</td>
        <td>Порядок уведомления Заемщика о наличии просроченной задолженности по Договору</td>
        <td>Подписывая Договор, Заемщик подтверждает
            и гарантирует, что:<br>1) заключает Договор добровольно, без понуждения, не в силу стечения тяжелых
            обстоятельств, а условия Договора, в том числе размер процентов, пеней и штрафа
            (если таковые предусмотрены Договором), Заемщика устраивают и не являются для
            него заведомо невыполнимыми, либо крайне невыгодными (кабальными);<br><br>2) действует от своего имени и в
            своих интересах и не действует к выгоде третьих
            лиц;<br><br>3) полностью контролирует свои действия, и у Заемщика отсутствует лицо, которое имеет
            возможность контролировать его действия;<br><br>4) для заключения Договора он предоставил Кредитору
            достоверные данные о размере и источниках своего дохода, а также достоверные персональные и иные данные;<br><br>5)
            не является ограниченно дееспособным и подтверждает, что имеет все правомочия на заключение
            Договора;<br><br>6) Заемщик заявляет и гарантирует, что предоставленная информация является
            достоверной и третьи лица не имеют к ней доступа, (так же банковские карты);<br><br>7) Заемщику понятны
            условия Индивидуальные и Общие условия Договора
            займа иными нормативными актами Кредитора, в том числе сумма, подлежащая
            возврату, размер процентной ставки. Заемщик признает такой размер процентов
            абсолютно обоснованным, исходя из высокой степени риска выдачи Займа без
            обеспечения;<br><br>8) Заёмщик гарантирует, что его финансовое положение является стабильным; факторы,
            которые могут повлечь существенное ухудшение материального положения, либо банкротство Заёмщика отсутствуют.
            В противном случае, получение займа может быть расценено Кредитором как мошенничество.<br><br>9) Заемщик
            гарантирует, что содержание всех документов Кредитора связанных с
            предоставлением, использованием и возвратом займа разъяснены, понятны и не
            требуют дополнительного разъяснения.
        </td>
    </tr>
    <tr>
        <td>20</td>
        <td>Прочие условия</td>
        <td>Договор считается заключенным с момента выдачи Займа и считается прекращенным с момента исполнения Заемщиком
            всех принятых на себя обязательств по Договору. Договор, подписанный в личном кабинете посредством аналога
            собственноручной подписи Заемщика, имеет одинаковую юридическую силу, что и Договор, подписанный
            собственноручной подписью Заемщика. Заемщик настоящим подтверждает, что с Правилами предоставления займов
            ООО «МКК «Барвил ХД» и с Общими условиями договора займа и иными документами Кредитора, ознакомился и
            согласен. Также Заемщик проинформирован о том, что имеет правоознакомиться с Правилами предоставления займов
            (микрозаймов) ООО «МКК «Барвил ХД» на сайте mkk-barvil.ru
        </td>
    </tr>
    <tr>
        <td>21</td>
        <td>Способы получения суммы микрозайма</td>
        <td>Сумма микрозайма (займа) предоставляется заемщику - путем перечисления денежных средств на карточный счет,
            банковскую карту *{$short_active_card} Заемщика указанной им в личном кабинете
            на сайте mkk-barvil.ru
        </td>
    </tr>
    <tr>
        <td>22</td>
        <td>Реквизиты Заемщика</td>
        <td>Дата рождения: {$birth|date}<br>Паспорт:  {$passport_serial} выдан {$passport_issued}<br>Код
            подразделения: {$subdivision_code}<br>Адрес регистрации: {$regaddress_full}<br>Банковская карта:
            № {$active_card}<br>Заемщик: {$lastname} {$firstname} {$patronymic}<br>Электронная почта: {$email}
        </td>
    </tr>
    <tr>
        <td>23</td>
        <td>Предоставление информации после заключения Договора</td>
        <td>После предоставления займа Заемщик вправе получать по запросу один раз в месяц бесплатно и любое
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
        <td>24</td>
        <td>Территориальная подсудность по заявлению
            Кредитора о выдаче судебного приказа или искового
            заявления, подаваемому Кредитором
        </td>
        <td>Все споры, которые возникают между Сторонами по поводу или в
            связи с настоящим договором будут разрешатся следующим образом: Поискам Кредитора: - по месту получения
            заемщиком оферты (предложения заключить договор) по адресу: 198332, город Санкт-
            Петербург, Ленинский пр-кт, д. 80 к. 1 литера А, кв. 188, т.е. в судебном
            участке № 99 Санкт-Петербурга (198205, Санкт-Петербург, ул.
            Партизана Германа, д. 14/117, литера А) / Красносельском
            районном суде Санкт-Петербурга (198320, г. Санкт-Петербург, г.
            Красное Село, ул. Суворова, д. 3), в соответствии с действующим
            законодательством. По искам Заемщика к Кредитору о защите
            прав потребителей: - в соответствии с действующим законодательством
            РФ
        </td>
    </tr>
    </tbody>
</table>
<div>

</div>
<table align="center">
    <tr>
        <td width="20%"></td>
        <td width="60%"><strong>АДРЕСА И РЕКВИЗИТЫ СТОРОН</strong></td>
        <td width="10%"></td>
    </tr>
</table>
<div>

</div>
<table>
    <tr>
        <td width="50%"><u>Кредитор:</u></td>
        <td width="50%"><u>Заемщик:</u></td>
    </tr>
    <tr>
        <td width="50%"></td>
        <td width="50%"></td>
    </tr>
    <tr>
        <td width="50%">Общество с ограниченной ответственностью «МИКРОКРЕДИТНАЯ КОМПАНИЯ «БАРВИЛ ХД»</td>
        <td width="50%">Ф.И.О.: {$lastname|upper} {$firstname|upper} {$patronymic|upper}</td>
    </tr>
    <tr>
        <td width="50%"></td>
        <td width="50%"></td>
    </tr>
    <tr>
        <td width="50%">Юридический адрес: 198332, город Санкт-Петербург, Ленинский пр-кт, д. 80 к. 1 литера А, кв.
            188
        </td>
        <td width="50%">Паспорт гражданина РФ: {$passport_serial} выдан {$passport_issued}</td>
    </tr>
    <tr>
        <td width="50%"></td>
        <td width="50%"></td>
    </tr>
    <tr>
        <td width="50%">ОГРН: 1167847454642; ИНН/КПП 7801323165 / 780701001;
            р/с 40701810200070000015
        </td>
        <td width="50%">Код подразделения: {$subdivision_code}</td>
    </tr>
    <tr>
        <td width="50%"></td>
        <td width="50%"></td>
    </tr>
    <tr>
        <td width="50%">в АО «МИнБанк»;<br>к/с 30101810300000000600;<br>БИК 044525600<br>Свидетельство МФО:
            1703140008262 от 15.05.2017<br>Сайт: https://mkk-barvil.ru<br>E-mail: mkkbarvil@yandex.ru<br>Телефон: +7
            812- 604-28-78
        </td>
        <td width="50%">Адрес регистрации: {$regaddress_full}<br>Телефон: {$phone_mobile}
        </td>
    </tr>
</table>
<div>

</div>
<table style="width: 100%">
    <tr>
        <td width="35%"><img src="{$config->root_dir}/theme/site/html/pdf/i/sign_print.png" width="400"></td>
        <td width="30%">Дата {$contract_date|date}</td>
        <td width="45%">Подписано с использованием ПЭП<br>{$lastname} {$firstname} {$patronymic}
            <br>Дата: {$contract_date|date}<br>Телефон: {$phone}<br>СМС-код: {$asp}</td>
    </tr>
</table>
<div>
<br><br><br><br><br><br><br><br><br><br><br><br><br>
</div>
<table>
    <tr>
        <td style="width: 30%"></td>
        <td style="width: 30%"></td>
        <td>Сервер с персональными данными находится на территории РФ, адрес: Санкт-Петербург, Заставская ул., 33. Данные защищены</td>
    </tr>
</table>