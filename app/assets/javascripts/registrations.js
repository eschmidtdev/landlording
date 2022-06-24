$(document).ready(function () {
    $(function () {
        $("form[name='registration']").validate({
            rules: {
                'user-TOS'     : {required: true},
                'user[FullName]': {required: true},
                'user[email]'   : {required: true, email: true},
                'user[password]': {required: true, minlength: 8}
            },
            messages: {
                'user[email]':    'Please enter a valid email address',
                'user[FullName]': {required: 'Full Name is required.'},
                'user[password]': {
                    required: 'Please provide a password',
                    minlength: 'Password is too short (minimum is 8 characters)'
                },
                'user-TOS':       'Please indicate that you have accepted Terms and Conditions'
            },
            submitHandler: function (form, e) {
                ajaxRequest(e);
            }
        });
    });

    function ajaxRequest(e) {
        e.preventDefault();
        disableButton();
        const email = $('#RegEmail').val();
        const password = $('#RegPass').val();
        const full_name = $('#FullName').val();
        $.ajax({
            url: '/users',
            type: 'POST',
            data: {
                user: {
                    email: email,
                    password: password,
                    full_name: full_name
                }
            },
            success: function (data) {
                response_handler(data);
            },
            error: function (exception) {
            }
        });
        return false;
    }

    function enableButton() {
        $('#SignupBtn').prop('disabled', false).text('Sign Up');
    }

    function disableButton() {
        $('#SignupBtn').prop('disabled', true).text('Submitting...');
    }

    function response_handler(data) {
        if (data.success === true) {
            render_response(data);
            $('#RegistrationForm')[0].reset();
        }
        if (data.success === false) {
            render_conditional_response(data)
        }
    }

    function render_response(data) {
        clearErrors();
        enableButton();
        $('.success_alert').text('').show().text(data.message);
    }

    function render_conditional_response(data) {
        clearErrors();
        if (data.method === 'user_exists?') {
            $('#UserExists').show().text(data.message);
        }
        if (data.method === 'password_clashing?') {
            $('#PasswordError').show().text(data.message);
        }
        if (data.method === 'params_missing?') {
            $('.error_alert').text('').show().text(data.message);
        }

        enableButton();
    }

    function clearErrors() {
        $('.error_alert').text('').hide();
        $('.success_alert').text('').hide();
        $('#UserExists').text('').hide();
        $('#PasswordError').text('').hide();
    }

    $('#RegEmail').keyup(function () {
        $('#UserExists').hide();
    });
    $('#RegPass').keyup(function () {
        $('#PasswordError').hide();
    });

    $('#registrationEye').click(function () {
        const input = $('.toggle-password-registration');
        input.attr('type') === 'password' ? input.attr('type', 'text') : input.attr('type', 'password')
    });

});





