<table width="530" cellspacing="0" cellpadding="1">
    <tbody>   
        <tr>
            <td width="320">
                <div><img  src="{$config->root_url}/theme/site/html/pdf/i/good_money.png" width="310"/></div><br />
            </td>
            <td width="200" align="left">
                <p>
                    ООО МКК «БАРВИЛ ХД»<br> 
                    198332, Г.САНКТ-ПЕТЕРБУРГ, ЛЕНИНСКИЙ ПР-КТ, Д 80, КОРП К.1, СТР ЛИТЕРА А, КВ. 188 ИНН 7801323165, КПП 780701001ОГРН 1167847454642
                    mkk-barvil.ru<br>
                </p>
            </td>
        </tr>
    </tbody>
</table>

<table width="530" cellspacing="0" cellpadding="1">
    <tbody>
         <tr>   
            <td>
                <p>
                    Исх.  № {$number}<br/>
                    {$contract_date|date} <br/>               
                </p>
            </td>
        </tr>
    </tbody>
</table>


<table width="530" cellspacing="0" cellpadding="1">
    <tbody>   
        <tr>
            <td width="320"></td>
            <td width="200">
                <p>{$lastname} {$firstname} {$patronymic}</p>
                <p><strong>Паспорт серия:</strong> {$passport_series} №: {$passport_number}</p>
                <p><strong>Выдан :</strong>{$passport_issued}</p>
                <p><strong>Адресс регистрации :</strong>{$regaddress_full}</p>
            </td>
        </tr>
    </tbody>
</table>


<table  width="530" cellspacing="0" cellpadding="1">
    <tbody>
        <tr>
            <td colspan="8" width="530" align="center">
                <br /><br /><strong>УВЕДОМЛЕНИЕ</strong><br />
                <br />Уважаемый(-ая) {$lastname} {$firstname} {$patronymic}<br />
            </td>
        </tr>
        <tr>
            <td width="530">
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{$contract_date|date} ООО МКК «БАРВИЛ ХД» в соответствии с Кредитным договором № {$number} Вам были предоставлены средства в сумме {$amount} {$amount|price_string|upper} на условиях срочности возвратности и платности.
            </td>
        </tr>
        <tr>
            <td width="530">
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Согласно индивидуальным условиям договора и кредитор передает Заемщику денежные средства в размере 12 000 (Двенадцать тысяч) руб. 00 копеек (далее - Сумма займа, Займ), со сроком возврата суммы займа до 28 Июля 2022 г., процентная ставка (процентные ставки) 365% (триста шестьдесят пять процентов) годовых. Проценты начисляются со дня предоставления займа и до полного исполнения Заемщиком обязательств по займу и составляют 16 920 (ШЕСТНАДЦАТЬ ТЫСЯЧ ДЕВЯТЬСОТ ДВАДЦАТЬ) РУБЛЕЙ 00 КОПЕЕК. Пунктом 12 индивидуальных условий установлены дополнительные штрафы при нарушении Заемщиком сроков возврата займа и процентов Заемщик: неустойка в размере 0,054% от основной суммы займа за каждый день просрочки составляют 777 (СЕМЬСОТ СЕМЬДЕСЯТ СЕМЬ) РУБЛЕЙ 60 КОПЕЕК.
            </td>
        </tr>
        <tr>
            <td width="530">
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;С {$return_date} Вы перестали производить платежи в счет погашения задолженности и возврата заемных средств по Кредитному договору.
            </td>
        </tr>
        <tr>
            <td width="530">
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;По состоянию на {$todays_date} сумма простроченной задолженности составляет {$total_amount} {$total_amount|price_string|upper} из них:
            </td>
        </tr>
        <tr>
            <td width="530">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-	сумма основного долга - {$amount} {$amount|price_string|upper};
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-	проценты за пользование кредитом - {$loan_percents_summ} {$loan_percents_summ|price_string|upper};
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-	пени на основной долг - {$sum_of_the_songs} {$sum_of_the_songs|price_string|upper};
            </td>
        </tr>
        <tr>
            <td width="530" >
              <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Обращаем внимание, что сумма задолженности указана по состоянию на 25.11.2022 г. и на момент получения уведомления может отличаться от указанной выше суммы, в связи с начислением процентов и неустойки. Сумму задолженности необходимо уточнить на день оплаты.</strong>
            </td>
        </tr>
        <tr>
            <td width="530" >
             <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;На основании изложенного, для урегулирования вопроса о Ваших дальнейших платежах по Кредитному договору и во избежание негативных последствий,<span style="text-decoration: underline;"> просим Вас в течении 3 (Трех) дней с момента предъявления данного Уведомления оплатить просроченную задолженность</span> или связаться с сотрудником компании по телефону 8 812 604 28 78 звонок бесплатный.</strong>
            </td>
        </tr>
        <tr>
            <td width="530" >
             <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;При обращении в компанию мы совместно рассмотрим причины допущенного Вами нарушения и придем к приемлемому для обеих сторон решению.</strong>
            </td>
        </tr>
        <tr>
            <td width="530">
                <br>
                <br>
                Обращаем внимание, что ООО МКК «БАРВИЛ ХД» не открывает расчетные или лицевые счета.
            </td>
        </tr>

              
        <tr>
            <td width="150">
            <br><br>
               <br>
                С уважением,
                <br>
                Генеральный директор 
            </td>
            <td width="250">
               
            </td>
            <td width="150">
                <br><br>
                Николаева О.А.
            </td>
        </tr>
    </tbody>
</table>