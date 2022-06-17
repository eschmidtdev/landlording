$(document).ready(function () {

    $(function () {
        $("form[name='account_change_password']").validate({
            rules: {
                'Setting[CP]': {required: true, minlength: 8},
                'Setting[NP]': {required: true, minlength: 8},
                'Setting[CNP]': {required: true, equalTo: "#SettingNP"},
            },
            messages: {
                'Setting[CP]': {
                    required: 'Current Password is required',
                    minlength: 'Password is too short (minimum is 8 characters)'
                },
                'Setting[NP]': {
                    required: 'New Password is required',
                    minlength: 'Password is too short (minimum is 8 characters)'
                },
                'Setting[CNP]': {required: 'Confirm New Password is required'},
            },
            submitHandler: function (form, e) {
                ajaxReqUpdatePassword(e);
            }
        });
    });

    function ajaxReqUpdatePassword(e) {
        e.preventDefault();
        disableButton();
        const new_password = $('#SettingNP').val();
        const current_password = $('#SettingCP').val();
        const confirm_password = $('#SettingCNP').val();
        const user_id = $('#AccSettingPassUpdateUID').val();
        $.ajax({
            url: `/account_settings/${user_id}`,
            type: 'PUT',
            data: {
                account_setting: {
                    new_password: new_password,
                    current_password: current_password,
                    confirm_password: confirm_password,
                    from: 'ChangePassword'
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
        $('#SavePersonalInfo').prop('disabled', false);
    }

    function disableButton() {
        $('#SavePersonalInfo').prop('disabled', true);
    }

    function response_handler(data) {
        clearErrors();
        if (data.success === true) {
            render_response(data);
        }
        if (data.success === false) {
            render_conditional_response(data);
        }
        enableButton();
    }

    function render_response(data) {
        $("#ChangePassword").trigger("reset");
        $('.error_alert')
            .show()
            .append(data.message)
            .delay(2000)
            .fadeOut(300);
    }

    function render_conditional_response(data) {
        if (data.error === 'current_password') {
            $('#PassIncorrect').show().text(data.message);
        }
    }

    function clearErrors() {
        $('.error_alert').text('').addClass('display_none');
        $('#PassIncorrect').text('').addClass('display_none');
    }

    $('#SettingCP').keyup(function () {
        $('#PassIncorrect').hide();
    });

});