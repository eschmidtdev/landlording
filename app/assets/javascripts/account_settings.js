$(document).ready(function () {

    $(function () {
        $("form[name='personal_info']").validate({
            rules: {
                'accountSetting[LastName]': {required: true},
                'accountSetting[FirstName]': {required: true},
                'accountSetting[PhoneNumber]': {required: true},
            },
            messages: {
                'accountSetting[LastName]': 'Last name is required',
                'accountSetting[FirstName]': 'First name is required',
                'accountSetting[PhoneNumber]': 'Phone number is required'
            },
            submitHandler: function (form, e) {
                ajaxRequest(e);
            }
        });
    });

    function ajaxRequest(e) {
        e.preventDefault();
        disableButton();
        const last_name = $('#accountSettingLastName').val();
        const first_name = $('#accountSettingFirstName').val();
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
                    phone_number: phone_number,
                    company_name: company_name
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
        $('#AccSettingUpdatePassBtn').prop('disabled', false);
    }

    function disableButton() {
        $('#AccSettingUpdatePassBtn').prop('disabled', true);
    }

    function response_handler(data) {
        if (data.success === true || data.success === false) {
            render_message(data);
        }
    }

    function render_message(data) {
        clearErrors();
        $('.error_alert')
            .show()
            .append(data.message)
            .delay(2000)
            .fadeOut(300);
        enableButton();
    }

    function clearErrors() {
        $('.error_alert').text('').addClass('display_none');
    }

});



