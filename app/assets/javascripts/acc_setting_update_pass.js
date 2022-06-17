$(document).ready(function () {

    $(function () {
        $("form[name='account_change_password']").validate({
            rules: {
                'Setting[CP]': {required: true, minlength: 8},
                'Setting[NP]': {required: true, minlength: 8},
                'Setting[CNP]': {required: true, equalTo: "#SettingNP"},
            }, messages: {
                'Setting[CP]': {
                    required: 'Current Password is required',
                    minlength: 'Password is too short (minimum is 8 characters)'
                },
                'Setting[NP]': {
                    required: 'New Password is required',
                    minlength: 'Password is too short (minimum is 8 characters)'
                },
                'Setting[CNP]': {required: 'Confirm New Password is required'},
            }, submitHandler: function (form, e) {
                ajaxReqUpdatePassword(e);
            }
        });
    });

    function ajaxReqUpdatePassword(e) {
        e.preventDefault();
        disableButton();
        const current_password = $('#SettingCP').val();
        const new_password = $('#SettingNP').val();
        const confirm_password = $('#SettingCNP').val();
        const user_id = $('#AccSettingPassUpdateUID').val();
        $.ajax({
            url: `/account_settings/${user_id}`,
            type: 'PUT',
            data: {
                account_setting: {
                    current_password: current_password,
                    new_password: new_password,
                    confirm_password: confirm_password,
                    from: 'ChangePassword'
                }
            },
            success: function (data) {
                if (data.success === true) {
                    clearErrors();
                    $("#ChangePassword").trigger("reset");
                    $('.error_alert').removeClass('display_none').text('')
                        .append(data.message)
                        .delay(2000)
                        .fadeOut(300);
                    enableButton();
                }
                if (data.success === false) {
                    clearErrors();
                    if (data.error === 'current_password') {
                        $('#PassIncorrect').text('').removeClass('display_none').text(data.message);
                    }
                    // $('.error_alert').removeClass('display_none').text('')
                    //     .append(data.message)
                    //     .delay(2000)
                    //     .fadeOut(300);
                    // enableButton();
                }
            },
            error: function (exception) {
            }
        });
        return false;
    }

    function disableButton() {
        $('#SavePersonalInfo').prop('disabled', true);
    }

    function enableButton() {
        $('#SavePersonalInfo').prop('disabled', false);
    }

    function clearErrors() {
        $('.error_alert').text('').addClass('display_none');
        $('#PassIncorrect').text('').addClass('display_none');
    }

});