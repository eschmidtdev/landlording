$(document).ready(function () {
    $(function () {
        $("form[name='registration']").validate({
            rules: {
                'user[name]': 'required',
                'user[email]': {required: true, email: true},
                'user[password]': {required: true, minlength: 8}
            }, messages: {
                'user[name]': {
                    required: "Full Name is required.",
                },
                'user[email]': 'Please enter a valid email address',
                'user[password]': {
                    required: 'Please provide a password', minlength: 'Password is too short (minimum is 8 characters)'
                }
            }, submitHandler: function (form, e) {
                ajaxRequest(e);
            }
            // other options
        });
    });

    function ajaxRequest(e) {
        e.preventDefault();
        const name = $('#UserName').val();
        const email = $('#RegEmail').val();
        const password = $('#RegPass').val();
        $.ajax({
            url: '/users',
            type: 'POST',
            data: {user: {name: name, email: email, password: password}},
            success: function (data) {
                if (data.success === true) {
                    window.location.href = data.url;
                }
                if (data.success === false) {
                    clearErrors();
                    if (data.method === 'user_exists?') {
                        $('#UserExists').text('').removeClass('display_none').text(data.message);
                    }
                    if (data.method === 'password_clashing?') {
                        $('#PasswordError').text('').removeClass('display_none').text(data.message);
                    }
                    if (data.method === 'params_missing?') {
                        $('.error_alert').text('').removeClass('display_none').text(data.message);
                    }
                }
            },
            error: function (exception) {
            }
        });
        return false;
    }

    function clearErrors() {
        $('.error_alert').addClass('display_none');
        $('#UserExists').text('').addClass('display_none');
        $('#PasswordError').text('').addClass('display_none');
    }

    function disableButton() {
        $('#SignupBtn').prop('disabled', true).text('Submitting...');
    }

});





