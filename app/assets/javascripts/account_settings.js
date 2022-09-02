$(document).ready(function () {

    $(function () {
        $("form[name='personal_info']").validate({
            rules: {
                'accountSetting[City]': {required: true},
                'accountSetting[State]': {required: true},
                'accountSetting[Country]': {required: true},
                'accountSetting[LastName]': {required: true},
                'accountSetting[FirstName]': {required: true},
                'accountSetting[PostalCode]': {required: true},
                'accountSetting[PhoneNumber]': {required: true},
                'accountSetting[AddressLine1]': {required: true}
            },
            messages: {
                'accountSetting[City]': 'City is required',
                'accountSetting[State]': 'State is required',
                'accountSetting[Country]': 'Country is required',
                'accountSetting[LastName]': 'Last Name is required',
                'accountSetting[FirstName]': 'First Name is required',
                'accountSetting[PostalCode]': 'Postal Code is required',
                'accountSetting[PhoneNumber]': 'Phone Number is required',
                'accountSetting[AddressLine1]': 'Address Line 1 is required'
            },
            submitHandler: function (form, e) {
                ajaxRequest(e);
            }
        });
    });

    $("#DeleteBillingDetails").click(function () {
        const userID = $(this).data('user-id');
        ajaxDeleteReq(userID);
    });

    function ajaxRequest(e) {
        e.preventDefault();
        const city = $('#accountSettingCity').val();
        const state = $('#accountSettingState').val();
        const user_id = $('#accountSettingUserID').val();
        const country = $('#accountSettingCountry').val();
        const last_name = $('#accountSettingLastName').val();
        const first_name = $('#accountSettingFirstName').val();
        const phone_number = $('#accountSettingPhoneNumber').val();
        const company_name = $('#accountSettingCompanyName').val();
        const postal_code = $('#accountSettingPostalCode').val();
        const address_line_one = $('#accountSettingAddressLine1').val();
        const address_line_two = $('#accountSettingAddressLine2').val();
        $.ajax({
            url: `/account_settings/${user_id}`,
            type: 'PUT',
            data: {
                account_setting: {
                    city: city,
                    state: state,
                    country: country,
                    last_name: last_name,
                    first_name: first_name,
                    postal_code: postal_code,
                    phone_number: phone_number,
                    company_name: company_name,
                    address_line_one: address_line_one,
                    address_line_two: address_line_two
                }
            },
            success: function (data) {
            },
            error: function (exception) {
            }
        });
        return false;
    }

    function ajaxDeleteReq(id) {
        $.ajax({
            url: `/account_settings/${id}`,
            type: 'DELETE',
            data: {
                account_setting: {
                    id: id
                }
            },
            success: function (data) {
                if (data.success === true) {
                    $('#BillingDetailNotice')
                        .show()
                        .append(data.message)
                        .delay(2000)
                        .fadeOut(300);
                }
                location.reload();
            },
            error: function (exception) {
            }
        });
    }


});



