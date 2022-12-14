$(document).ready(function () {

    $(function () {
        $("form[name='session']").validate({
            rules: {
                'user[email]':    {required: true, email: true},
                'user[password]': {required: true, minlength: 8}
            },
            messages: {
                'user[email]': 'Please enter a valid email address',
                'user[password]': {
                    required:  'Please provide a password',
                    minlength: 'Password is too short (minimum is 8 characters)'
                }
            },
            submitHandler: function (form, e) {
                ajaxRequest(e);
            }
        });
    });

    // ---------- Define Functions ----------

    function ajaxRequest(e) {
        e.preventDefault();
        disableButton();
        const email    = $('#InputEmail').val();
        const password = $('#InputPassword').val();
        $.ajax({
            url: '/users/sign_in',
            type: 'POST',
            data: {
                user: {
                    email:    email,
                    password: password
                }
            },
            success: function (data) {
                response_handler(data)
            },
            error: function (exception) {
            }
        });
        return false;
    }

    function enableButton() {
        $('#LoginBtn').prop('disabled', false);
    }

    function disableButton() {
        $('#LoginBtn').prop('disabled', true);
    }

    function response_handler(data) {
        clearErrors();
        enableButton();
        if (data.success === true) {
            window.location.href = data.url;
        }
        if (data.success === false) {
            $('.error_alert').text('').show().append(data.message);
        }
    }

    $(":input").on("keyup change", function (e) {
        clearErrors();
    });

    function clearErrors() {
        $('.error_alert').text('').hide();
    }

    $('#sessionEye').click(function () {
        const input = $('.toggle-password-session');
        input.attr('type') === 'password' ? input.attr('type', 'text') : input.attr('type', 'password')
    });

});

