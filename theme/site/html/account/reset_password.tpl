{$meta_title='Сброс пароля' scope=parent}

{capture name='page_scripts'}
<script>
    $(function(){
        $('#phone').mask("+7(999) 999-9999");
        $('.js-reset-whatsapp').click(function(){
            var _phone = $('.js-reset-password-form #phone').val().replace(/\D+/g,"");
            if (!_phone)
            {
                $('.js-reset-password-form .form-phone').addClass('-error');
            }
            else
            {
                $('.js-reset-password-form .form-phone').removeClass('-error');
                $.ajax({
                    url: '/chats.php?api=whatsapp&method=ressetPassword&phone='+_phone,
                    success: function(resp){
                        $('.js-success-message').html('<p>Сообшение с временным паролем отправлено Вам в мессенджер.</p><a class="btn btn-secondary -fs-14 -fullwidth" href="lk/login">Личный кабинет</a>');
                        $.fancybox.open({
                            src: '#success_modal'
                        })
    
                    }
                })
            }
        })
    });
</script>
{/capture}

{capture name='page_styles'}
    
{/capture}

<main class="main">
  <div class="section section_itop">
    <div class="container">
      <div class="section_row row">
        
        <div class="col-lg-5 offset-lg-3">
          <div class="itop_calc">
            <form class="calculator js-reset-password-form" method="POST">
                <div class="form-group form-phone">
                    <div class="form-group-title -fs-22 -gil-m text-center" for="amount-one">
                        Сброс пароля
                    </div>
                </div>
                
                {if $success}
                <div class="p-3">
                    <div class="alert alert-success">{$success}</div>
                    <a href="/lk/login">Перейти на страницу входа в личный кабинет</a>
                </div>
                
                {else}
                
                <div id="phone_block">
                    <div class="form-group form-phone">
                        <span class="phone_info -fs-14">Ваш номер телефона</span>
                        <input type="text" name="phone" id="phone" class="form-control -fs-18 -gil-m js-mask-phone" value="" required="" />
                        <div class="error_text js-reset-password-error" style="display:none">Укажите номер телефона</div>
                    </div>
                    {*}
                    <div class="form-group form-btn">
                        <button type="button" class="btn btn-whatsapp -fs-14 -fullwidth js-reset-whatsapp">
                            <span>Отправить через</span> <span style="white-space: nowrap;"><img src="theme/site/i/whatsapp.png" width="20" />&nbsp;Whatsapp</span>
                        </button>
                    </div>
                    <br />
                    {*}
                    <div class="form-group form-btn">
                        <button type="submit" class="btn btn-secondary -fs-16 -fullwidth ">Отправить смс</button>
                    </div>
                </div>
                {/if}

            </form>
          </div>
        </div>
      </div>

    </div>
  </div>
</main>
