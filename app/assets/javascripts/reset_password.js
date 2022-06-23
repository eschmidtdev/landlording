$(document).ready(function () {

    $(function () {
        debugger;
        $("form[name='reset_password']").validate({
            rules: {
                'user[password]':              {required: true, minlength: 8},
                'user[password_confirmation]': {required: true, equalTo: "#ResetNewPassword"},
                messages: {
                    'user[password]': {
                        required:  'Please provide a password',
                        minlength: 'Password is too short (minimum is 8 characters)'
                    },
                    'user[password_confirmation]': {
                        equalTo:   'Please enter same password',
                        required:  'Please enter confirm password'
                    }

                },
            }, submitHandler: function (form, e) {
                ajaxRequest(e);
            }
        });
    });

    $('#resetEyeNP').click(function () {
        const input = $('.toggle-password-new-pass');
        input.attr('type') === 'password' ? input.attr('type', 'text') : input.attr('type', 'password')
    });

    $('#resetEyeCP').click(function () {
        const input = $('.toggle-password-confirm-pass');
        input.attr('type') === 'password' ? input.attr('type', 'text') : input.attr('type', 'password')
    });

});

