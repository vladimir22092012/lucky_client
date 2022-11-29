<table width="530">
    <tbody>
        <tr>
            <td>
                <p style="text-indent: 0.38in; margin-bottom: 0.14in;" align="center"><span><span
                            style="font-size: medium;"><strong>Уведомление</strong></span></span></p>
                <p style="text-indent: 0.38in; margin-bottom: 0.14in;" align="center"><span><span
                            style="font-size: medium;"><strong>о
                                показателе долговой нагрузки </strong></span></span></p>
                <p style="margin-bottom: 0in;" align="center"> </p>
                <p style="margin-bottom: 0in;" align="justify"> </p>
                <p style="margin-top: 0.19in; margin-bottom: 0in; line-height: 100%;" align="justify"> </p>
                <p style="margin-bottom: 0in; line-height: 150%;" align="justify"><span
                            style="font-size: medium;">Я, {$lastname} {$firstname} {$patronymic},  серия {$passport_serial} номер {$passport_number}, 
                    выдан {$passport_date}, зарегистрирован по адресу:
                    {$regaddress_full}, подтверждаю, что мне
                            известно:</span></p>
                <p style="text-indent: 0.38in; margin-bottom: 0.14in;" align="justify"><span
                            style="font-size: medium;">-
                            показатель долговой нагрузки (Далее по тексту - ПДН) в отношении меня составляет
                            {$pdn}%</span></p>
                <p style="text-indent: 0.38in; margin-bottom: 0.14in;" align="justify"><span
                            style="font-size: medium;">- в случае не предоставления мной,
                                документов,
                                подтверждающих мой доход Общество рассчитывает ПДН на основе данных Федеральной службы
                                государственной
                                статистики о среднедушевом доходе в регионе моего местонахождения или
                                пребывания.</span>
                </p>
                <p style="margin-bottom: 0in; line-height: 150%;" align="justify"> </p>
            </td>
        </tr>
    </tbody>
</table>

<table cellpadding="5" border="1" style="width: 40%">
    <tr>
        <td>
            <div>Подписано с использованием ПЭП</div>
            <div lang="ru-RU">{$lastname|escape} {$firstname|escape} {$patronymic|escape}</div>
            <div>{$created|date}</div>
            <div>Телефон {$phone}</div>
            <div>СМС-код: {$asp}</div>
        </td>
    </tr>
</table>