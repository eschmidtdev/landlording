$(document).ready(function () {

    $(function () {
        $("form[name='account_change_password']").validate({
            rules: {
                'Setting[CP]':  {required: true, minlength: 8},
                'Setting[NP]':  {required: true, minlength: 8},
                'Setting[CNP]': {required: true, equalTo: "#SettingNP"},
            },
            messages: {
                'Setting[CP]': {
                    required:  'Current Password is required',
                    minlength: 'Password is too short (minimum is 8 characters)'
                },
                'Setting[NP]': {
                    required:  'New Password is required',
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
        const new_password     = $('#SettingNP').val();
        const current_password = $('#SettingCP').val();
        const confirm_password = $('#SettingCNP').val();
        const user_id          = $('#AccSettingPassUpdateUID').val();
        $.ajax({
            url: `/account_settings/${user_id}/change/password`,
            type: 'PUT',
            data: {
                account_setting: {
                    new_password:     new_password,
                    current_password: current_password,
                    confirm_password: confirm_password
                }
            },
            success: function (data) {},
            error: function (exception) {}
        });
        return false;
    }

    function disableButton() {
        $('#SavePersonalInfo').prop('disabled', true);
    }

    function clearErrors() {
        $('.error_alert').text('').addClass('display_none');
        $('.success_alert').text('').addClass('display_none');
        $('#PassIncorrect').text('').addClass('display_none');
    }

    $('#SettingCP').keyup(function () {
        $('#PassIncorrect').hide();
    });

    $(":input").on("keyup change", function (e) {
        clearErrors();
    });

    $('#accSettingCP').click(function () {
        const input = $('.toggle-password-acc-set-cp');
        input.attr('type') === 'password' ? input.attr('type', 'text') : input.attr('type', 'password')
    });

    $('#accSettingNP').click(function () {
        const input = $('.toggle-password-acc-set-np');
        input.attr('type') === 'password' ? input.attr('type', 'text') : input.attr('type', 'password')
    });

    $('#accSettingCNP').click(function () {
        const input = $('.toggle-password-acc-set-cnp');
        input.attr('type') === 'password' ? input.attr('type', 'text') : input.attr('type', 'password')
    });

});