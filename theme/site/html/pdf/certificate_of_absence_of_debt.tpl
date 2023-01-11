<table width="530" cellspacing="0" cellpadding="1">
    <tbody>   
        <tr>
            <td width="320">
                <div><img  src="{$config->root_url}/theme/site/html/pdf/i/good_money.png" width="310"/></div><br />
            </td>
            <td width="200" align="left">
                <p>ООО МКК «БАРВИЛ ХД»<br>198332, Г.САНКТ-ПЕТЕРБУРГ, ЛЕНИНСКИЙ ПР-КТ, Д 80, КОРП К.1, СТР ЛИТЕРА А, КВ. 188 ИНН 7801323165, КПП 780701001ОГРН 1167847454642<br>mkk-barvil.ru
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
                    {$contract_date|date}                
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

<table width="530" cellspacing="0" cellpadding="1">
    <tbody>
         <tr>   
            <td>
                <p>
                    &nbsp;&nbsp;&nbsp;Договор потребительского кредита<br/>
                    (займа) № {$number} от   {$contract_date|date}              
                </p>
            </td>
        </tr>
    </tbody>
</table>


<table  width="530" cellspacing="0" cellpadding="1">
    <tbody>
        <tr>
            <td colspan="8" width="530" align="center">
                <br /><br /><strong>Уважаемый Клиент!</strong><br />
            </td>
        </tr>
        <tr>
            <td width="530">
                <br>
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;В ответ на Ваш запрос, поступивший в ООО МКК «БАРВИЛ ХД», сообщаем следующее. Заключенный между Вами и ООО МКК «БАРВИЛ ХД» {$contract_date|date} . Договор потребительского кредита № {$number}, считается исполненным. По состоянию на {$todays_date} задолженность по данному Договору отсутствует. 
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
                <br><br><br><br>
                Николаева О.А.
            </td>
        </tr>
    </tbody>
</table>