;function MainApp()
{
    var app = this;

    app.DEBUG = 1;

    app.$phone;

    var _init = function(){

        app.$phone = $('.js-loan-phone');
        app.$phone_error = $('.js-loan-phone-error');
        app.$phone.mask("+7(999)999-9999");




        $('.js-loan-phone').on('paste', function(e){

        let phone_number = e.originalEvent.clipboardData.getData('text');

        phone_number = phone_number.match(/\d+/g).join([]);

        if(phone_number.length > 10)
        {
        final_number = phone_number.slice(-10);
         $(this).val(final_number);
        }
        else
        {
        phone_number = Number(phone_number);
        $(this).val(phone_number);
        }
        app.$phone.mask("+7(999)999-9999");
        });

        $('.js-loan-start').click(function(e){
            e.preventDefault();

            var $btn = $(this);

            var _phone = app.$phone.val();

            var _agreement = $('.js-loan-agreement').is(':checked');

            var _error = 0;
            if (_phone == '')
            {
                app.$phone.closest('.form-phone').addClass('-error');
                app.$phone_error.text('Укажите номер телефона').show();
                app.$phone.focus();

                _error = 1;
            }
            else
            {
                app.$phone.closest('.form-phone').removeClass('-error');
                app.$phone_error.text('').hide();
            }

            if (!_agreement)
            {
                $('.js-loan-agreement-block').addClass('-error');

                _error = 1;
            }
            else
            {
                $('.js-loan-agreement-block').removeClass('-error');
            }

            if (!_error)
            {
                $.ajax({
                    url: 'ajax/check_phone.php',
                    data: {
                        phone: _phone
                    },
                    beforeSend: function(){
                        $btn.addClass('loading');
                    },
                    success: function(resp){
                        if (!!app.DEBUG)
                            console.log(resp);

                        if (!!resp.user_exists)
                        {
                            $btn.removeClass('loading');
                            $('.js-error-phone-number').text(_phone);
                            $.fancybox.open({
                                src: '#user_exists_modal'
                            });
                        }
                        else if (!!resp.incorrect)
                        {
                            $btn.removeClass('loading');
                            app.$phone.closest('.form-phone').addClass('-error');
                            app.$phone_error.text('Проверьте правильность номера').show();
                            app.$phone.focus();
                        }
                        else if (!!resp.not_found)
                        {
                            if (!$('#service_insurance').is(':checked'))
                                $('#service_insurance + label').click();
                            if (!$('#service_reason').is(':checked'))
                                $('#service_reason + label').click();                
                            $('[name="service_insurance"]').val(1);
                            $('[name="service_reason"]').val(1);
                            setTimeout(function(){
                                // отправляем смс
                                new SmsApp(_phone, _success_callback);                                
                            }, 50);
                        }
                        else if (!!resp.error)
                        {
                            $btn.removeClass('loading');
                            $('#error_modal .error-message').html(resp.error);
                            $.fancybox.open({
                                src: '#error_modal'
                            });
                        }
                        else
                        {
                            console.error(resp);
                        }
                    }
                });
            }
        });

    };

    var _success_callback = function(code){
console.info('_success_callback');
        $('.js-loan-code').val(code);
        $('.js-loan-start-form').submit();
    };


    var _init_agreement_list = function(){
        $('.js-toggle-agreement-list').click(function(e){
            e.preventDefault();

            $('#agreement_list').slideToggle()
        })
    }

    var _init_promo_code = function(){
        $('.js-toggle-promo-code').click(function(e){
            e.preventDefault();

            $('#promo_code').slideToggle()
        })
    }

    var _init_toggle_services = function(){
        $('.js-loan-phone').blur(function(){

console.log($(this).val())

            if (-1 !== $.inArray($(this).val(), ['+7(963) 914-3424', '+7(913) 909-6454', '+7(905) 303-2893', '+7(905) 897-7170', '+7(996) 727-6234', '+7(927) 262-4886']))
            {
                $('#service_insurance').removeAttr('disabled');
                $('#service_reason').removeAttr('disabled');
//                $('[name="service_insurance"]').val(0);
//                $('[name="service_reason"]').val(0);
            }
            else
            {
//                $('#service_insurance').attr('disabled', true);
//                $('#service_reason').attr('disabled', true);
//                $('[name="service_insurance"]').val(1);
//                $('[name="service_reason"]').val(1);
            }
        });

        $('#service_reason').change(function(){
            if ($(this).is(':checked'))
                $('[name="service_reason"]').val(1);
            else
                $('[name="service_reason"]').val(0);
        });
        $('#service_insurance').change(function(){
            if ($(this).is(':checked'))
                $('[name="service_insurance"]').val(1);
            else
                $('[name="service_insurance"]').val(0);
        });
    }

    ;(function(){
        _init();
        _init_agreement_list();
        _init_promo_code();
        _init_toggle_services();
    })();
};

$(function(){
    if ($('.js-loan-start').length > 0)
        new MainApp();
});
