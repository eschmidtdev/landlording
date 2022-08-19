$(document).ready(function () {

    $(function () {
        $("form[name='billing_information']").validate({
            rules: {
                'Billing[FN]':         {required: true},
                'Billing[LN]':         {required: true},
                'Billing[PC]':         {required: true},
                'Billing[AL1]':        {required: true},
                'Billing[EXP]':        {required: true},
                'Billing[CVC]':        {required: true},
                'Billing[City]':       {required: true},
                'Billing[CardNumber]': {required: true},
            },
            messages: {
                'Billing[AL1]':        {required: 'Address is required'},
                'Billing[EXP]':        {required: 'Expiration required'},
                'Billing[City]':       {required: 'City Name is required'},
                'Billing[LN]':         {required: 'Last Name is required'},
                'Billing[FN]':         {required: 'First Name is required'},
                'Billing[PC]':         {required: 'Postal Code is required'},
                'Billing[CVC]':        {required: 'Security Code is required'},
                'Billing[CardNumber]': {required: 'Card Number is required'}
            },
            submitHandler: function (form, e) {
                ajaxRequest(e);
            }
        });
    });

    function ajaxRequest(e) {
        const company        = $('#BillingCN').val();
        const lastName       = $('#BillingLN').val();
        const firstName      = $('#BillingFN').val();
        const postalCode     = $('#BillingPC').val();
        const addressLineOne = $('#BillingAL1').val();
        const addressLineTwo = $('#BillingAL2').val();
        const cvc            = $('#BillingCVC').val();
        const expiration     = $('#BillingEXP').val();
        const city           = $('#BillingCity').val();
        const from           = $('#BillingFrom').val();
        const state          = $('#BillingState').val();
        const userID         = $('#BillingUserID').val();
        const country        = $('#BillingCountry').val();
        const cardNumber     = $('#BillingCardNumber').val();
        const is_address     = $('#SameAsAccountAddress').val();
        $.ajax({
            url: `/payment_details/${userID}`,
            type: 'PUT',
            data: {
                payment_detail: {
                    cvc:              cvc,
                    from:             from,
                    city:             city,
                    state:            state,
                    user_id:          userID,
                    company:          company,
                    country:          country,
                    last_name:        lastName,
                    first_name:       firstName,
                    exp:              expiration,
                    postal_code:      postalCode,
                    card_number:      cardNumber,
                    is_address:       is_address,
                    address_line_two: addressLineTwo,
                    address_line_one: addressLineOne
                }
            },
            success: function (data) {
            },
            error: function (exception) {
            }
        });
        return false;
    }

    $('.fetch-account-address').change(function () {
        const checkbox = $('#SameAccountAddress');
        if (checkbox.is(":checked")) {
            getAccountSettingInfo();
        }
    });

    function getAccountSettingInfo() {
        const company          = $('#BillingCN');
        const last_name        = $('#BillingFN');
        const first_name       = $('#BillingLN');
        const postal_code      = $('#BillingPC');
        const address_line_one = $('#BillingAL1');
        const address_line_two = $('#BillingAL2');
        const city             = $('#BillingCity');
        const state            = $('#BillingState');
        const country          = $('#BillingCountry');
        $.ajax({
            url: '/payment_details/fetch_landlord',
            type: 'PUT',
            data: {
                payment_detail: {
                    city:             city,
                    state:            state,
                    country:          country,
                    company:          company,
                    last_name:        last_name,
                    first_name:       first_name,
                    postal_code:      postal_code,
                    address_line_one: address_line_one,
                    address_line_two: address_line_two
                },
            },
            success: function (data) {
                if (data.success === true) {
                    city.prop('disabled', true).attr('value', data.user.city);
                    state.prop('disabled', true).attr('value', data.user.state);
                    country.prop('disabled', true).attr('value', data.user.country);
                    company.prop('disabled', true).attr('value', data.user.company);
                    last_name.prop('disabled', true).attr('value', data.user.last_name);
                    first_name.prop('disabled', true).attr('value', data.user.first_name);
                    postal_code.prop('disabled', true).attr('value', data.user.postal_code);
                    address_line_one.prop('disabled', true).attr('value', data.user.address_line_one);
                    address_line_two.prop('disabled', true).attr('value', data.user.address_line_two);
                } else if (data.success === false) {}
            },
            error: function (exception) {
            }
        });
    }

    // $('#SameAccountAddress').change(function () {
    //     if ($(this).prop('checked') === true) {
    //         $('#BillingAddressSection').hide();
    //     } else if ($(this).prop('checked') === false) {
    //         $('#BillingAddressSection').show();
    //     }
    //
    // });

    // Interactive Zipcodes
    $('input.zipcode_interactive').blur(function (data) {
        $('#IncorrectZipCode').text('');
        const zipcode = $(this).val();
        const from = $(this).data('from');
        getCityState(zipcode, from)
    });

    function getCityState(zipcode, from) {
        $.ajax({
            url: '/properties/get_zip_data/' + zipcode,
            type: 'GET',
            data: {},
            success: function (data) {
                if (data.success === true) {
                    if (from === 'payment_details') {
                        $('#BillingCity').attr('value', data.message.city);
                        $('#BillingState').attr('value', data.message.state);
                        $('#BillingCountry').attr('value', data.message.county);
                    }
                }else {
                    $('#IncorrectZipCode').text('').show().text(data.message);
                }
            },
            error: function (exception) {
            }
        });
    }

});
