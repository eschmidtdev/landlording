$(document).ready(function () {

    // Form Validation
    $(function () {
        $("form[name='registration']").validate({
            rules: {
                'user-TOS':       {required: true},
                'user[FullName]': {required: true},
                'user[email]':    {required: true, email: true},
                'user[password]': {required: true, minlength: 8}
            },
            messages: {
                'user[email]': {
                    required: 'Email is required',
                    email:    'Email is not valid'
                },
                'user[FullName]': {required: 'Full Name is required.'},
                'user[password]': {
                    required: 'Please provide a password',
                    minlength: 'Password is too short (minimum is 8 characters)'
                },
                'user-TOS': 'Please indicate that you have accepted Terms and Conditions'
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
        const password   = $('#RegPass').val();
        const email      = $('#RegEmail').val();
        const first_name = $('#FullName').val();
        $.ajax({
            url: '/users',
            type: 'POST',
            data: {
                user: {
                    email:     email,
                    password:  password,
                    first_name: first_name
                }
            },
            success: function (data) {
                if (data.success === true) {
                    clearErrors();
                    enableButton();
                    window.location.href = data.url;
                    $('#RegistrationForm')[0].reset();
                }
                if (data.success === false) {
                    if (data.message === 'Email has already been taken. Try Another') {
                        $('#UserExists').removeClass('display_none').show().append(data.message);
                        enableButton();
                    }
                }
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





