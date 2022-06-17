$(document).ready(function () {
    $(function () {
        $("form[name='registration']").validate({
            rules: {
                'user[FullName]': {required: true},
                'user[email]': {required: true, email: true},
                'user[password]': {required: true, minlength: 8}
            },
            messages: {
                'user[FullName]': {required: 'Full Name is required.'},
                'user[email]': 'Please enter a valid email address',
                'user[password]': {
                    required: 'Please provide a password', minlength: 'Password is too short (minimum is 8 characters)'
                }
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
            data: {user: {full_name: full_name, email: email, password: password}},
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
        $('.success_alert').show().text(data.message);
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
            $('.error_alert').show().text(data.message);
        }

        enableButton();
    }

    function clearErrors() {
        $('.error_alert').text('').addClass('display_none');
        $('.success_alert').text('').addClass('display_none');
        $('#UserExists').text('').addClass('display_none');
        $('#PasswordError').text('').addClass('display_none');
    }

});





