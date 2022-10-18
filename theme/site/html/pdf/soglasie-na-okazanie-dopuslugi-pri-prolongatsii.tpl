<table width="535">
    <tr>
        <td>
            <p style="margin-bottom: 0in;" align="center">
                <strong>Заявление</strong>
            </p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p style="text-indent: 0.38in; " align="left">
                Я, {$lastname|escape} {$firstname|escape} {$patronymic|escape}, 
                дата рождения {$birth|date} 
                паспорт серия {$passport_series|escape}, 
                номер {$passport_number|escape}, 
                выдан {$passport_issued|escape} {$passport_code|escape}, 
                дата выдачи {$passport_date|date}, 
                настоящим подтверждаю, что  мне известны:
            </p>
            <p style="" align="left">
                - условия услуги,  предоставляемой САО "ВСК" (Далее по тексту - Страховая компания), а также  Правила страхования; 
            </p>
            <p style="" align="left">
                -  мое право обратиться в Страховую компанию и отказаться от услуги в течение четырнадцати календарных дней со дня заключения договора страхования.
            </p>
            <p style="" align="left">
                - мое право требовать от Страховой компании  возврата денежных средств, уплаченных мною за оказание услуги, за вычетом стоимости части услуги, фактически оказанной мне до дня получения Страховой компанией заявления об отказе от услуги;            
            </p>
            <p style="" align="left">
                - мое право требовать от Общества возврата денежных средств, уплаченных мною Страховой компании, за вычетом стоимости части услуги, фактически оказанной мне до дня получения Страховой компанией заявления об отказе от такой услуги, при неисполнении Страховой компанией обязанности по возврату денежных средств заемщику.            
            </p>
            <p style="" align="left">
                Оплата услуги производиться за счет собственных средств.
            </p>
            <table style="border-collapse: collapse; width: 42.3411%; height: 80px;">
                <tbody>
                    <tr style="height: 20px;">
                        <td align="left" style="width: 92.2316%; height: 20px;vertical-align:middle;line-height:20px;">
                            Согласен на оказание услуги
                        </td>
                        <td style="border:1px solid #000;width:20px; height: 20px;text-align:center;vertical-align:middle;line-height:20px;">X</td>
                    </tr>
                    <tr style="height: 20px;">
                        <td style="width: 92.2316%; height: 20px;"><span
                                style=""><span
                                    style="">&nbsp;</span></span></td>
                        <td style="height: 20px;">&nbsp;</td>
                    </tr>
                    <tr style="height: 20px;">
                        <td style="width: 92.2316%; height: 20px;vertical-align:middle;line-height:20px;">
                            Не согласен на оказание услуги </td>
                        <td style="border:1px solid #000;width:20px; height: 20px;">&nbsp;</td>
                    </tr>
                    <tr style="height: 20px;">
                        <td style="width: 92.2316%; height: 20px;"><span
                                style=""><span
                                    style="">&nbsp;</span></span></td>
                        <td style="height: 20px;">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width: 92.2316%;"><span style=""><span
                                    style="">&nbsp;</span></span></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width: 92.2316%;"><span style=""><span
                                    style="">&nbsp;</span></span></td>
                        <td>&nbsp;</td>
                    </tr>
                </tbody>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table width="397" cellspacing="0" cellpadding="7">
                <tbody>
                    <tr>
                        <td style="border: none; padding: 0in;" valign="bottom" width="383" height="122">
                            <table style="height: 180px; width: 78.9867%;" width="397" cellspacing="0" cellpadding="7">
                                <tbody>
                                    <tr>
                                        <td style="border: 1px solid #000000; padding: 0in 0.08in;" valign="top"
                                            width="100%" height="98">
                                            <p style="margin-bottom: 0in;">Подписано с использованием ПЭП</p>
                                            <p style="margin-bottom: 0in;">{$lastname|escape} {$firstname|escape} {$patronymic|escape}</p>
                                            <p style="margin-bottom: 0in;">{$insurance->create_date|date}</p>
                                            <p style="margin-bottom: 0in;">Телефон {$phone}</p>
                                            <p style="margin-bottom: 0in;">СМС-код {$asp}</p>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </td>
    </tr>
</table>