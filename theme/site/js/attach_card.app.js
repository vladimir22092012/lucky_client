function AttachCardApp()
{
    var app = this;
    
    var _init = function(){
        
        $('.js-attach-card').click(function(e){
            e.preventDefault();
            
            var $this = $(this);
            
            var _user_id = $this.data('user');
            
            if ($this.hasClass('loading'))
                return false;
            
            $.ajax({
                url: 'ajax/best2pay.php',
                async: false,
                data: {
                    'action': 'attach_card',
                    'user_id': _user_id
                },
                beforeSend: function(){
                    $this.addClass('loading');
                },
                success: function(resp){
                    if (!!resp.error)
                    {
                        alert(resp.error);
                    }
                    else
                    {
                        location.href = resp.link;
                    }
                    $this.removeClass('loading');
                }
            })
        });
        
    };
    
    ;(function(){
        _init();
    })();
};

$(function(){
    if ($('.js-attach-card').length > 0)
        new AttachCardApp();
});