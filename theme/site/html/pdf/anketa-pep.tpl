<table width="530" cellspacing="0" cellpadding="3" border="1">
    <tr>
        <td colspan="5"><strong>1.ПЕРСОНАЛЬНЫЕ ДАННЫЕ</strong></td>
    </tr>
    <tr>
        <td width="10%"> 1.1.</td>
        <td width="22.5%">Фамилия</td>
        <td valign="middle" width="22.5%">{$lastname|escape}</td>
        <td width="22.5%">Менялась ли фамилия?</td>
        <td width="22.5%">&nbsp;</td>
    </tr>
    <tr>
        <td> 1.2.</td>
        <td>Имя</td>
        <td>{$firstname|escape}</td>
        <td>Менялось ли имя?</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td> 1.3.</td>
        <td>Отчество</td>
        <td>{$patronymic|escape}</td>
        <td>Менялось ли отчество?</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td> 1.4.</td>
        <td colspan="2" width="45%">Пол</td>
        <td colspan="2" width="45%">{if $gender == 'male'}мужской{elseif $gender == 'female'}женский{/if}</td>
    </tr>
    <tr>
        <td> 1.5.</td>
        <td colspan="2" width="45%">Гражданство</td>
        <td colspan="2" width="45%">Российская Федерация</td>
    </tr>
    <tr>
        <td> 1.6.</td>
        <td colspan="2" width="45%">Место рождения</td>
        <td colspan="2" width="45%">{$birth_place|escape}</td>
    </tr>
    <tr>
        <td> 1.7.</td>
        <td colspan="2" width="45%">Дата рождения</td>
        <td colspan="2" width="45%">{if $birth}{$birth|date}{/if}</td>
    </tr>
    <tr>
        <td> 1.8.</td>
        <td colspan="2" width="45%">Девичья фамилия матери</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 1.9.</td>
        <td colspan="2" width="45%">Семейный статус</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 1.10.</td>
        <td colspan="2" width="45%">Количество иждевенцев</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 1.11.</td>
        <td colspan="2" width="45%">Образование</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 1.12.</td>
        <td colspan="2" width="45%">ИНН</td>
        <td colspan="2" width="45%">{$inn|escape}</td>
    </tr>
    <tr>
        <td> 1.13.</td>
        <td colspan="2" width="45%">Email</td>
        <td colspan="2" width="45%">{$email|escape}</td>
    </tr>
    <tr>
        <td> 1.14.</td>
        <td colspan="2" width="45%">Кодовое слово</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="4"><strong>2. ДОКУМЕНТЫ</strong></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="4"><strong>ПАСПОРТ ГРАЖДАНИНА РОССИЙСКОЙ ФЕДЕРАЦИИ</strong></td>
    </tr>
    <tr>
        <td> 2.1.</td>
        <td colspan="2" width="45%"> Серия</td>
        <td colspan="2" width="45%">            {$passport_serial|escape}        </td>
    </tr>
    <tr>
        <td> 2.2.</td>
        <td colspan="2" width="45%"> Номер</td>
        <td colspan="2" width="45%">            {$passport_number|escape}        </td>
    </tr>
    <tr>
        <td> 2.3.</td>
        <td colspan="2" width="45%"> Дата выдачи</td>
        <td colspan="2" width="45%">            {if $passport_date}{$passport_date|date}{/if}        </td>
    </tr>
    <tr>
        <td> 2.4.</td>
        <td colspan="2" width="45%"> Кем выдан</td>
        <td colspan="2" width="45%">            {$passport_issued|escape}        </td>
    </tr>
    <tr>
        <td> 2.5.</td>
        <td colspan="2" width="45%"> Код подразделения</td>
        <td colspan="2" width="45%">            {$passport_code|escape}        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="4"><strong>СТРАХОВОЕ СВИДЕТЕЛЬСТВО</strong></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="2" width="45%">&nbsp;</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 2.6.</td>
        <td colspan="2" width="45%"> Страховой номер индивидуального лицевого счета застрахованного лица в системе
            обязательного пенсионного страхования (СНИЛС)
        </td>
        <td colspan="2" width="45%">            {$snils|escape}        </td>
    </tr>
    <tr>
        <td> 2.7.</td>
        <td colspan="2" width="45%"> Дата регистрации</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="2" width="45%">&nbsp;</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="2" width="45%">&nbsp;</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="4"><strong>3. АДРЕСА И КОНТАКТНАЯ ИНФОРМАЦИЯ</strong></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="4"><strong>АДРЕС РЕГИСТРАЦИИ</strong></td>
    </tr>
    <tr>
        <td> 3.1.</td>
        <td colspan="2" width="45%"> Страна места регистрации</td>
        <td colspan="2" width="45%"> Россия</td>
    </tr>
    <tr>
        <td> 3.2.</td>
        <td colspan="2" width="45%"> Индекс</td>
        <td colspan="2" width="45%">            {$regaddress->zip}        </td>
    </tr>
    <tr>
        <td> 3.3.</td>
        <td colspan="2" width="45%"> Регион/Район</td>
        <td colspan="2" width="45%">            {$regaddress->region} {$regaddress->region_type}       </td>
    </tr>
    <tr>
        <td> 3.4.</td>
        <td colspan="2" width="45%"> Город/Нас.пункт</td>
        <td colspan="2" width="45%">            {$regaddress->city} {$regaddress->city_type}        </td>
    </tr>
    <tr>
        <td> 3.5.</td>
        <td colspan="2" width="45%"> Улица</td>
        <td colspan="2" width="45%">            {$regaddress->street}        </td>
    </tr>
    <tr>
        <td> 3.6.</td>
        <td colspan="2" width="45%"> Дом</td>
        <td colspan="2"
            width="45%">            {$regaddress->house}</td>
    </tr>
    <tr>
        <td> 3.7.</td>
        <td colspan="2" width="45%"> Квартира</td>
        <td colspan="2" width="45%">            {$regaddress->room}        </td>
    </tr>
    <tr>
        <td> 3.8.</td>
        <td colspan="2" width="45%"> Телефон</td>
        <td colspan="2" width="45%"> &nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="4"><strong>АДРЕС ФАКТИЧЕСКОГО ПРОЖИВАНИЯ</strong></td>
    </tr>
    <tr>
        <td> 3.9.</td>
        <td colspan="2" width="45%"> Совпадает с регистрацией</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 3.10.</td>
        <td colspan="2" width="45%"> Страна места нахождения</td>
        <td colspan="2" width="45%"> Россия</td>
    </tr>
    <tr>
        <td> 3.2.</td>
        <td colspan="2" width="45%"> Индекс</td>
        <td colspan="2" width="45%">            {$faktaddress->zip}        </td>
    </tr>
    <tr>
        <td> 3.3.</td>
        <td colspan="2" width="45%"> Регион/Район</td>
        <td colspan="2" width="45%">            {$faktaddress->region} {$faktaddress->region_type}       </td>
    </tr>
    <tr>
        <td> 3.4.</td>
        <td colspan="2" width="45%"> Город/Нас.пункт</td>
        <td colspan="2" width="45%">            {$faktaddress->city} {$faktaddress->city_type}        </td>
    </tr>
    <tr>
        <td> 3.5.</td>
        <td colspan="2" width="45%"> Улица</td>
        <td colspan="2" width="45%">            {$faktaddress->street}        </td>
    </tr>
    <tr>
        <td> 3.6.</td>
        <td colspan="2" width="45%"> Дом</td>
        <td colspan="2"
            width="45%">            {$faktaddress->house}</td>
    </tr>
    <tr>
        <td> 3.7.</td>
        <td colspan="2" width="45%"> Квартира</td>
        <td colspan="2" width="45%">            {$faktaddress->room}        </td>
    </tr>
    <tr>
        <td> 3.17.</td>
        <td colspan="2" width="45%"> Телефон</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 3.18.</td>
        <td colspan="2" width="45%"> Мобильный телефон</td>
        <td colspan="2" width="45%">            {$phone|escape}        </td>
    </tr>
    <tr>
        <td> 3.19.</td>
        <td colspan="2" width="45%"> Тип собственности</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 3.20.</td>
        <td colspan="2" width="45%"> Проживание (лет)</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 3.21.</td>
        <td colspan="2" width="45%"> Проживание (Месяцев)</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="4"><strong>4. ДОХОДЫ</strong></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="4"><strong>ПОСТОЯННАЯ ТЕКУЩАЯ ЗАНЯТОСТЬ</strong></td>
    </tr>
    <tr>
        <td> 4.1.</td>
        <td colspan="2" width="45%"> Ежемесячный доход</td>
        <td colspan="2" width="45%">            {$income|escape}        </td>
    </tr>
    <tr>
        <td> 4.2.</td>
        <td colspan="2" width="45%"> Название организации</td>
        <td colspan="2" width="45%">            {$workplace|escape}        </td>
    </tr>
    <tr>
        <td> 4.3.</td>
        <td colspan="2" width="45%"> Адрес организации</td>
        <td colspan="2" width="45%"></td>
    </tr>
    <tr>
        <td> 4.4.</td>
        <td colspan="2" width="45%"> График занятости</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 4.5.</td>
        <td colspan="2" width="45%"> Должность</td>
        <td colspan="2" width="45%">            {$profession|escape}        </td>
    </tr>
    <tr>
        <td> 4.6.</td>
        <td colspan="2" width="45%"> Стаж работы (лет)</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 4.7.</td>
        <td colspan="2" width="45%"> Стаж работы (месяцев)</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 4.8.</td>
        <td colspan="2" width="45%"> Сфера деятельности</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 4.9.</td>
        <td colspan="2" width="45%"> Штат</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 4.10.</td>
        <td colspan="2" width="45%"> ФИО руководителя</td>
        <td colspan="2" width="45%">            {$chief_name|escape}        </td>
    </tr>
    <tr>
        <td> 4.11.</td>
        <td colspan="2" width="45%"> Телефон руководителя</td>
        <td colspan="2" width="45%">            {$chief_phone|escape}        </td>
    </tr>
    <tr>
        <td> 4.12.</td>
        <td colspan="2" width="45%"> Телефон организации</td>
        <td colspan="2" width="45%">            {$workphone|escape}        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="4"><strong>ЛИЧНЫЕ РАСХОДЫ</strong> <strong>(ежемесячные обязательные выплаты по кредитам, алименты,
                коммунальные платежи</strong></td>
    </tr>
    <tr>
        <td> 4.13.</td>
        <td colspan="2" width="45%"> Наличие просроченных задолженностей</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 4.14.</td>
        <td colspan="2" width="45%"> Уточнение</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 4.15.</td>
        <td colspan="2" width="45%"> Сумма расходов</td>
        <td colspan="2" width="45%">            {$expenses|escape}        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="4"><strong>ДОПОЛНИТЕЛЬНЫЙ ДОХОД</strong></td>
    </tr>
    <tr>
        <td> 4.16.</td>
        <td colspan="2" width="45%"> Тип дополнительного дохода</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 4.17.</td>
        <td colspan="2" width="45%"> Сумма дополнительного дохода</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="4"><strong>СОБСТВЕННОСТЬ (если есть)</strong></td>
    </tr>
    <tr>
        <td> 4.18.</td>
        <td colspan="2" width="45%"> Марка автомобиля</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 4.19.</td>
        <td colspan="2" width="45%"> Номер автомобиля</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 4.20.</td>
        <td colspan="2" width="45%"> Адрес</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 4.21.</td>
        <td colspan="2" width="45%"> Цели получения займа</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="4"><strong>5. ФИНАНСОВЫЕ ПОКАЗАТЕЛИ</strong></td>
    </tr>
    <tr>
        <td> 5.1.</td>
        <td colspan="2" width="45%"> Наличие банкротства</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 5.2.</td>
        <td colspan="2" width="45%"> Наличие исполнительный производств</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 5.3.</td>
        <td colspan="2" width="45%"> Достаточность дохода</td>
        <td colspan="2" width="45%"> ДА</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="4"><strong>6. ИНЫЕ СВЕДЕНИЯ</strong></td>
    </tr>
    <tr>
        <td> 6.1.</td>
        <td colspan="2" width="45%"> Степень (уровень) риска и обоснование отнесения Клиента к определенной степени
            (уровню) риска Высокий уровень присваивается при наличии факторов, указанных в Приложении № 2 Правил
            внутреннего контроля. В остальных случаях - обычный
        </td>
        <td colspan="2" width="45%"> &nbsp;
            <table cellpadding="0" style="border-collapse: collapse; width: 90%; height: 54px;" border="0">
                <tr style="">
                    <td style="width: 60%; ">&nbsp;</td>
                    <td style="">&nbsp;</td>
                </tr>
                <tr style="">
                    <td style="width: 60%; ">Обычный</td>
                    <td style="">
                        <table border="1" width="10" align="center">
                            <tr>
                                <td>X</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="">
                    <td style="width: 60%; ">&nbsp;</td>
                    <td style="">&nbsp;</td>
                </tr>
                <tr style="">
                    <td style="width: 60%; ">Высокий</td>
                    <td style="">
                        <table border="1" width="10" align="center">
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td> 6.2.</td>
        <td colspan="2" width="45%"> Степень ( уровень) риска использования услуг Кредитора в целях ОД/ФТ Высокий
            уровень риска присваивается, в случае если хотя бы одному кредитному продукту присвоен &laquo;высокий&raquo;
            уровень риска. Обычный уровень присваивается, в случае если всем кредитным продуктам присвоен &laquo;обычный&raquo;
            уровень риска
        </td>
        <td colspan="2" width="45%">
            <table style="border-collapse: collapse; width: 90%; height: 54px;" border="0">
                <tr style="">
                    <td style="width: 60%; ">&nbsp;</td>
                    <td style="">&nbsp;</td>
                </tr>
                <tr style="">
                    <td style="width: 60%; ">Обычный</td>
                    <td style="">
                        <table border="1" width="10" align="center">
                            <tr>
                                <td>X</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="">
                    <td style="width: 60%; ">&nbsp;</td>
                    <td style="">&nbsp;</td>
                </tr>
                <tr style="">
                    <td style="width: 60%; ">Высокий</td>
                    <td style="">
                        <table border="1" width="10" align="center">
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td> 6.3.*</td>
        <td colspan="2" width="45%"> Цель установления деловых отношений</td>
        <td colspan="2" width="45%"> Заключение договора потребительского займа.</td>
    </tr>
    <tr>
        <td> 6.4.*</td>
        <td colspan="2" width="45%"> Предполагаемый характер деловых отношений</td>
        <td colspan="2" width="45%">
            <table style="border-collapse: collapse; width: 90%; height: 54px;" border="0">
                <tr style="">
                    <td style="width: 60%; ">&nbsp;</td>
                    <td style="">&nbsp;</td>
                </tr>
                <tr style="">
                    <td style="width: 60%; ">Длительный</td>
                    <td style="">
                        <table border="1" width="10" align="center">
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="">
                    <td style="width: 60%; ">&nbsp;</td>
                    <td style="">&nbsp;</td>
                </tr>
                <tr style="">
                    <td style="width: 60%; ">Краткосрочный</td>
                    <td style="">
                        <table border="1" width="10" align="center">
                            <tr>
                                <td>X</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="">
                    <td style="width: 60%; ">&nbsp;</td>
                    <td style="">&nbsp;</td>
                </tr>
                <tr style="">
                    <td style="width: 60%; ">Разовый</td>
                    <td style="">
                        <table border="1" width="10" align="center">
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="">
                    <td style="width: 60%; ">&nbsp;</td>
                    <td style="">&nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td height="12"> 6.5.*</td>
        <td colspan="2" width="45%"> Финансовое положение Финансовое положение Клиента оценивается по следующим
            критериям: - при наличии признаков банкротства &ndash; финансовое положение определяется как кризисное; -
            при наличии задолженности перед любыми кредиторами Клиента, но без признаков банкротства - финансовое
            положение определяется как неустойчивое; - в остальных случаях финансовое положение определяется как
            устойчивое.
        </td>
        <td colspan="2" width="45%">
            <table style="border-collapse: collapse; width: 90%; height: 54px;" border="0">
                <tr style="">
                    <td style="width: 60%; ">&nbsp;</td>
                    <td style="">&nbsp;</td>
                </tr>
                <tr style="">
                    <td style="width: 60%; ">Устойчивый</td>
                    <td style="">
                        <table border="1" width="10" align="center">
                            <tr>
                                <td>X</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="">
                    <td style="width: 60%; ">&nbsp;</td>
                    <td style="">&nbsp;</td>
                </tr>
                <tr style="">
                    <td style="width: 60%; ">Неустойчивый</td>
                    <td style="">
                        <table border="1" width="10" align="center">
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="">
                    <td style="width: 60%; ">&nbsp;</td>
                    <td style="">&nbsp;</td>
                </tr>
                <tr style="">
                    <td style="width: 60%; ">Кризисный</td>
                    <td style="">
                        <table border="1" width="10" align="center">
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table> &nbsp;
        </td>
    </tr>
    <tr>
        <td> 6.6.*</td>
        <td colspan="2" width="45%"> Деловая репутация клиента Неудовлетворительная оценка присваивается при наличии
            двух и более фактов привлечения Клиента к ответственности в судебном или административном порядке за
            календарный год, предшествующий дате обращения в МКК. В остальных случаях Клиенту присваивается &laquo;удовлетворительная&raquo;
            оценка деловой репутации
        </td>
        <td colspan="2" width="45%">
            <table style="border-collapse: collapse; width: 90%; height: 58px;" border="0">
                <tr style="">
                    <td style="width: 60%; ">&nbsp;</td>
                    <td style="">&nbsp;</td>
                </tr>
                <tr style="">
                    <td style="width: 60%; ">Удовлетворительная</td>
                    <td style="">
                        <table border="1" width="10" align="center">
                            <tr>
                                <td>X</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="">
                    <td style="width: 60%; ">&nbsp;</td>
                    <td style="">&nbsp;</td>
                </tr>
                <tr style="">
                    <td style="width: 60%; ">Неудовлетворительная</td>
                    <td style="">
                        <table border="1" width="10" align="center">
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="">
                    <td style="width: 60%; ">&nbsp;</td>
                    <td style="">&nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td> 6.7</td>
        <td colspan="2" width="45%"> Сведения о результатах проверки наличия (отсутствия) в отношении клиента информации
            о его причастности к экстремистской деятельности или терроризму
        </td>
        <td colspan="2" width="45%"> отсутствуют</td>
    </tr>
    <tr>
        <td> 6.8</td>
        <td colspan="2" width="45%"> Сведения о результатах проверки наличия (отсутствия) в отношении клиента информации
            о замораживании (блокировании) денежных средств или иного имущества клиента.
        </td>
        <td colspan="2" width="45%"> отсутствуют</td>
    </tr>
    <tr>
        <td> 6.9</td>
        <td colspan="2" width="45%"> Дата начала отношений с клиентом</td>
        <td colspan="2" width="45%">            {$contract_date|date}        </td>
    </tr>
    <tr>
        <td> 6.10</td>
        <td colspan="2" width="45%"> Дата окончания отношений с клиентом</td>
        <td colspan="2" width="45%"></td>
    </tr>
    <tr>
        <td colspan="5"><strong>7. СВЕДЕНИЯ О ПРЕДСТАВИТЕЛЕ КЛИЕНТА</strong></td>
    </tr>
    <tr>
        <td> 7.1.**</td>
        <td colspan="2" width="45%"> Фамилия</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 7.2.**</td>
        <td colspan="2" width="45%"> Имя</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 7.3.**</td>
        <td colspan="2" width="45%"> Отчество</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 7.4.**</td>
        <td colspan="2" width="45%"> Гражданство</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 7.5.**</td>
        <td colspan="2" width="45%"> Документ, удостоверяющий личность</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 7.6.**</td>
        <td colspan="2" width="45%"> Адрес места жительства (пребывания)</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 7.7.**</td>
        <td colspan="2" width="45%"> ИНН (при наличии)</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 7.8.**</td>
        <td colspan="2" width="45%"> Страховой номер индивидуального лицевого счета застрахованного лица в системе
            обязательного пенсионного страхования (СНИЛС) (при наличии)
        </td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 7.9.**</td>
        <td colspan="2" width="45%"> Номер телефон</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="5"><strong>8. СВЕДЕНИЯ О БЕНЕФИЦИАРНОМ ВЛАДЕЛЬЦЕ</strong></td>
    </tr>
    <tr>
        <td> 8.1.**</td>
        <td colspan="2" width="45%"> Фамилия</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 8.2.**</td>
        <td colspan="2" width="45%"> Имя</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 8.3.**</td>
        <td colspan="2" width="45%"> Отчество</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 8.4.**</td>
        <td colspan="2" width="45%"> Гражданство</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 8.5.**</td>
        <td colspan="2" width="45%"> Документ, удостоверяющий личность</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 8.6.**</td>
        <td colspan="2" width="45%"> Адрес места жительства (пребывания)</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 8.7.***</td>
        <td colspan="2" width="45%"> ИНН (при наличии)</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 8.8.***</td>
        <td colspan="2" width="45%"> Страховой номер индивидуального лицевого счета застрахованного лица в системе
            обязательного пенсионного страхования (СНИЛС) (при наличии)
        </td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 8.9.***</td>
        <td colspan="2" width="45%"> Номер телефон</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 8.10</td>
        <td colspan="2" width="45%"> Меры, принятые по идентификации Бенефициарного владельца</td>
        <td colspan="2" width="45%"> Устный опрос/анкетирование</td>
    </tr>
    <tr>
        <td> 8.11.</td>
        <td colspan="2" width="45%"> Обоснование принятого решения о признании физического лица Бенефициарным
            владельцем
        </td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="4"><strong>9. СВЕДЕНИЯ ВЫГОДОПРИОБРЕТАТЕЛЕ</strong></td>
    </tr>
    <tr>
        <td> 9.1.****</td>
        <td colspan="2" width="45%"> Фамилия</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 9.2.****.</td>
        <td colspan="2" width="45%"> Имя</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 9.3.****</td>
        <td colspan="2" width="45%"> Отчество</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 9.4.****</td>
        <td colspan="2" width="45%"> Гражданство</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 9.5.****</td>
        <td colspan="2" width="45%"> Документ, удостоверяющий личность</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 9.6.****</td>
        <td colspan="2" width="45%"> Адрес места жительства (пребывания)</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 9.7.****</td>
        <td colspan="2" width="45%"> ИНН (при наличии)</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 9.8.****</td>
        <td colspan="2" width="45%"> Страховой номер индивидуального лицевого счета застрахованного лица в системе
            обязательного пенсионного страхования (СНИЛС) (при наличии)
        </td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td> 9.9.****</td>
        <td colspan="2" width="45%"> Номер телефон</td>
        <td colspan="2" width="45%">&nbsp;</td>
    </tr>
    <tr>
        <td height="62"> 10</td>
        <td colspan="4" width="90%"> * Сведения, предусмотренные пунктами 6.3.-6.6. настоящего подпункта, заполняются в
            отношении Клиентов с высокой степенью (уровнем) риска клиента. **Сведения, указанные в п.п.7.1.-7.9.
            указываются, если обратился представитель клиента *** Сведения, указанные в п.п. 8.1-8.9 указываются при
            выявлении Бенефициарного владельца **** Сведения, указанные в п.п.9.1-9.9. указываются при выявлении
            Выгодоприобретателя
        </td>
    </tr>
    <tr>
        <td colspan="5" height="1">
            <table cellspacing="0" cellpadding="7">
                <tr>
                    <td><p style="page-break-after: always"> Относитесь ли Вы к должностным лицам публичных
                            международных организаций, к лицам замещающим (занимающим) государственные должности
                            Российской Федерации, должности членов Совета директоров Центрального банка Российской
                            Федерации, должности федеральной государственной службы, назначение на которые и
                            освобождение от которых осуществляются Президентом Российской Федерации или Правительством
                            Российской Федерации, должности в Центральном банке Российской Федерации, государственных
                            корпорациях и иных организациях, созданных российской Федерацией на основании федеральных
                            законов, включенные в перечни должностей, определяемые Президентом Российской
                            Федерации? </p>
                        <table style="border-collapse: collapse; width: 48.6972%; height: 8px;">
                            <tr>
                                <td style="width: 19.8387%;">ДА</td>
                                <td style="width: 11.4516%; border-style: solid;">&nbsp;</td>
                                <td style="width: 43.7097%; text-align: center;">НЕТ</td>
                                <td style="width: 15.1163%; border-style: solid;">&nbsp;</td>
                            </tr>
                        </table>
                        <p> Является ли Вы супругом/супругой, либо состоите ли Вы в родстве с лицом, являющимся
                            иностранным публичным должностным лицом или занимающим вышеуказанные должности? </p>
                        <table style="border-collapse: collapse; width: 48.6972%; height: 8px;">
                            <tr>
                                <td style="width: 19.8387%;">ДА</td>
                                <td style="width: 11.4516%; border-style: solid;">&nbsp;</td>
                                <td style="width: 43.7097%; text-align: center;">НЕТ</td>
                                <td style="width: 15.1163%; border-style: solid;">&nbsp;</td>
                            </tr>
                        </table>
                        <p>Подписав, настоящее заявление я:</p>
                        <p>1. Подтверждаю, что сведения, содержащиеся в настоящей анкете-заявлении, являются верными и
                            точными. </p>
                        <p> 2.Даю согласие Обществу с ограниченной ответственностью «МИКРОКРЕДИТНАЯ КОМПАНИЯ «БАРВИЛ ХД»
                            (Сокращенное наименование: ООО «МКК «КОМПАНИЯ «БАРВИЛ ХД») , ОГРН1167847454642 , созданное и
                            действующее в соответствии с законодательством Российской Федерации, Адрес: 198332, город
                            Санкт-Петербург, Ленинский пр-кт, д. 80 к. 1 литера А, кв. 188 (Далее по тексту - Общество)
                            на обработку моих персональных данных Ф.И.О; пол;
                            дата рождения; место рождения; реквизиты документа, удостоверяющего личность (паспорт/иной
                            документ), адрес постоянное регистрации и фактического проживания, идентификационной номер
                            налогоплательщика (ИНН); СНИЛС; информация о семейном, социальном, имущественном отношении;
                            контактная информация; данные о профессии, образовании и доходах, фотография,
                            предоставленные Обществу, включая сбор, запись, систематизацию, накопление, хранение,
                            уточнение (обновление, изменение), извлечение, использование, блокирование, удаление,
                            уничтожение передачу (предоставление, доступ) с целью продвижения своих услуг (реклама),
                            информирования меня о необходимости предоставить документы, о действующих договорах займа,
                            заключения и исполнения договора потребительского займа. Обработка персональных данных
                            производиться Обществом с использованием средств автоматизации (автоматизированная
                            обработка) и без использования таковых (неавтоматизированная обработка). <br/> Настоящее
                            согласие предоставлено на 5 лет и может быть отозвано мной путем направления мною
                            соответствующего уведомления. Я уведомлен о том, что Обществ вправе продолжить обработку
                            моих персональных данных без моего согласия в случаях, предусмотренных действующим
                            законодательством. </p>
                        <p> 3. Даю согласие на запрос и получение Обществом из любого бюро кредитных историй кредитного
                            отчета, содержащего в том числе основную часть кредитной истории, определенную в ст. 4
                            Федерального закона от 30.12.2004 г. № 218-ФЗ "О кредитных историях", в целях заключения и
                            исполнения Договора потребительского займа, в том числе оценки кредитоспособности, расчета
                            показателя долговой нагрузки. </p>
                        <p> 4. Понимаю, что Общество имеет права не информировать меня о причинах отказа в
                            предоставлении займа. </p></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<div></div>
<div align="justify">1) Я подтверждаю, что я ознакомлен(а) с Правилами о порядке и условиях предоставления микрозаймов
    физическим лицам ООО МКК «Денежная лента». <br>2) Мне известно, что я вправе сообщить ООО МКК «Денежная лента» о
    своем согласии на получение микрозайма на условиях, указанных в индивидуальных условиях договора микрозайма, в
    течение пяти рабочих дней со дня предоставления мне индивидуальных условий договора микрозайма. Согласием на
    получение микрозайма на условиях, указанных в индивидуальных условиях договора микрозайма, является подписание мною
    указанного договора микрозайма. <br>3) Подтверждаю, что ознакомлен(а) с Правилами предоставления микрозаймов
    физическим лицам ООО «МКК «Барвил ХД». <br>4) Выражаю свое согласие с тем, что принятие ООО «МКК «Барвил ХД» данного
    Заявления к рассмотрению не является обязательством ООО «МКК «Барвил ХД» предоставить мне микрозайм или возместить
    понесенные мною издержки. <br>5) Подтверждаю, что сведения, содержащиеся в данном Заявлении, а также в
    предоставляемых мною документах, являются полными, точными и достоверными во всех отношениях на дату заполнения
    Заявления; <br>6) Подтверждаю, что в настоящее время в отношении меня не ведется производство по делу о банкротстве,
    а также то, что производство по делу о банкротстве в отношении меня не велось в течение 5 (пяти) лет до даты подачи
    настоящего Заявления. <br>7) Подтверждаю факт уведомления меня ООО «МКК «Барвил ХД» о том, что если в течение одного
    года общий размер платежей по всем имеющимся у меня на дату обращения к ООО «МКК «Барвил ХД» о предоставлении
    микрозайма обязательствам по кредитным договорам, договорам займа, включая платежи по предоставляемому микрозайму,
    будет превышать пятьдесят процентов моего годового дохода, для меня существует риск неисполнения мной обязательств
    по договору микрозайма и применения ко мне штрафных санкций. <br>8) Я проинформирован(а) о том, что сведения,
    предоставленные мной в заявлении, могут оказать влияние на индивидуальные условия заключаемого договора микрозайма.
    <br>9) Я подтверждаю, что мне предоставлена информация, достаточная для принятия обоснованного решения о
    целесообразности заключения договора микрозайма на ООО «МКК «Барвил ХД» условиях. <br>10) Подтверждаю, что до
    момента заключения договора микрозайма уведомлена(а) о необходимости внимательно проанализировать свое финансовое
    положение, учитывая, в том числе, следующие факторы: <br>• соразмерность долговой нагрузки с текущим финансовым
    положением; <br>• предполагаемые сроки и суммы поступления денежных средств для исполнения моих обязательств по
    договору микрозайма (периодичность выплаты заработной платы, получения иных доходов) <br>• вероятность наступления
    обстоятельств непреодолимой силы и иных обстоятельств, которые могут привести к невозможности исполнения мной своих
    обязательств по договору микрозайма (вероятность потери работы, задержки получения заработной платы и иных видов
    доходов по не зависящим от меня причинам, состояние здоровья, которое способно негативно повлиять на трудоустройство
    и, соответственно, получение дохода). <br>11) Я проинформирован(а) о том, что при несвоевременном исполнении
    обязательств по договору микрозайма я несу риск возможного увеличения суммы расходов по сравнению с ожидаемой суммой
    расходов. Мне известен размер применяемой неустойки (штрафа, пени) за нарушение обязательств по договору микрозайма.
    <br>12) Клиент дает согласие ООО «МКК «Барвил ХД» на запрос кредитной истории согласно № 218 ФЗ ст.6 п.10 -
    Федерального закона «О кредитных историях», согласие дается с целью заключения и исполнения договора микрозайма.
    Срок действия согласия 6 месяца с даты подписание данного документа, а в случае выдачи кредита действует весь срок
    действия кредитного договора. <br>13) Я,
    <strong>{$lastname|escape} {$firstname|escape} {$patronymic|escape}</strong>, согласен на оказание услуги по
    подключению сервиса «Автоматические платежи» оказываемой ООО «МКК «Барвил ХД» .Я уведомлен о том, что данная услуга
    оказывается ООО «МКК «Барвил ХД» бесплатно
</div>
<table>
    <tr>
        <td colspan="5"><p>Подписано с использованием ПЭП</p>
            <p><strong>{$lastname|escape} {$firstname|escape} {$patronymic|escape}</strong></p>
            <p>Дата: <strong>{$created|date}</strong></p>
            <p>Телефон: <strong>{$phone|escape}</strong></p>
            <p>СМС-код: <strong>{$asp|escape}</strong></p></td>
    </tr>
</table>