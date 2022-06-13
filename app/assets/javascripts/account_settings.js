$(document).ready(function () {

    $(function () {
        $("form[name='personal_info']").validate({
            rules: {
                'accountSetting[FirstName]': {required: true},
                'accountSetting[LastName]': {required: true},
                'accountSetting[PhoneNumber]': {required: true},
            }, messages: {
                'accountSetting[FirstName]': 'First name is required',
                'accountSetting[LastName]': 'Last name is required',
                'accountSetting[PhoneNumber]': 'Phone number is required'
            }, submitHandler: function (form, e) {
                ajaxRequest(e);
            }
        });
    });

    $(function () {
        $("form[name='account_change_password']").validate({
            rules: {
                'Setting[CP]': {required: true, minlength: 8},
                'Setting[NP]': {required: true, minlength: 8},
                'Setting[CNP]': {required: true, equalTo: "#SettingCP"},
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
                // ajaxRequest(e);
            }
        });
    });

    function ajaxRequest(e) {
        e.preventDefault();
        disableButton();
        const first_name = $('#accountSettingFirstName').val();
        const last_name = $('#accountSettingLastName').val();
        const phone_number = $('#accountSettingPhoneNumber').val();
        const company_name = $('#accountSettingCompanyName').val();
        const user_id = $('#accountSettingUserID').val();
        $.ajax({
            url: `/account_settings/${user_id}`,
            type: 'PUT',
            data: {
                account_setting: {
                    last_name: last_name,
                    first_name: first_name,
                    company_name: company_name,
                    phone_number: phone_number
                }
            },
            success: function (data) {
                if (data.success === true) {
                    clearErrors();
                    $('.error_alert').removeClass('display_none').text('')
                        .append(data.message)
                        .delay(2000)
                        .fadeOut(300);
                    enableButton();
                }
                if (data.success === false) {
                    $('.error_alert').removeClass('display_none').text('')
                        .append(data.message)
                        .delay(2000)
                        .fadeOut(300);
                    enableButton();
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
    }

});

