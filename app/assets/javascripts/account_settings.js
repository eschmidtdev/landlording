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
                }
                if (data.success === false) {
                    enableButton();
                    $('.error_alert').removeClass('display_none').text('')
                        .append(data.message)
                        .delay(2000)
                        .fadeOut(300);
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

