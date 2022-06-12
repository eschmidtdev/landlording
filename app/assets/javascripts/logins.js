$(document).ready(function () {

    $(function () {
        $("form[name='session']").validate({
            rules: {
                'user[email]': {required: true, email: true},
                'user[password]': {required: true, minlength: 8}
            }, messages: {
                'user[email]': 'Please enter a valid email address',
                'user[password]': {
                    required: 'Please provide a password',
                    minlength: 'Password is too short (minimum is 8 characters)'
                }
            }, submitHandler: function (form, e) {
                ajaxRequest(e);
            }
        });
    });

    function ajaxRequest(e) {
        e.preventDefault();
        disableButton();
        const email = $('#InputEmail').val();
        const password = $('#InputPassword').val();
        $.ajax({
            url: '/users/sign_in',
            type: 'POST',
            data: {user: {email: email, password: password}},
            success: function (data) {
                if (data.success === true) {
                    clearErrors();
                    window.location.href = data.url;
                }
                if (data.success === false) {
                    enableButton();
                    $('.error_alert').removeClass('display_none').text('').append(data.message);
                }
            },
            error: function (exception) {
            }
        });
        return false;
    }

    function disableButton() {
        $('#LoginBtn').prop('disabled', true);
    }

    function enableButton() {
        $('#LoginBtn').prop('disabled', false);
    }

    function clearErrors() {
        $('.error_alert').text('').addClass('display_none');
    }
});

