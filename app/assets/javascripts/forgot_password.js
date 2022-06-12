$(document).ready(function () {

    $(function () {
        $("form[name='forgot_password']").validate({
            rules: {
                'user[email]': {required: true, email: true}
            }, messages: {
                'user[email]': 'Please enter a valid email address'
            }, submitHandler: function (form, e) {
                ajaxRequest(e);
            }
        });
    });

    function ajaxRequest(e) {
        e.preventDefault();
        disableButton();
        const email = $('#ForgotPasswordEmail').val();
        $.ajax({
            url: '/sent/email',
            type: 'POST',
            data: {user: {email: email}},
            success: function (data) {
                if (data.success === true) {
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
        $('#ForgotPassword').prop('disabled', true);
    }

    function enableButton() {
        $('#ForgotPassword').prop('disabled', false);
    }

    function clearErrors() {
        $('.error_alert').text('').addClass('display_none');
    }
});

