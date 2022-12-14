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
        const state          = $('#BillingState').val();
        const userID         = $('#BillingUserID').val();
        const country        = $('#BillingCountry').val();
        const cardNumber     = $('#BillingCardNumber').val();
        const brand          = getCardBrand(cardNumber)
        const is_address     = !!$('#SameAccountAddress').is(':checked');
        $.ajax({
            url: `/payment_details/${userID}`,
            type: 'PUT',
            data: {
                payment_detail: {
                    cvc:              cvc,
                    city:             city,
                    state:            state,
                    brand:            brand,
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
        } else if (checkbox.not(":checked")) {
            $('#BillingCity').attr('value', '');
            $('#BillingState').attr('value', '');
            $('#BillingCountry').attr('value', '');
            $('#BillingFN').prop('disabled', false).attr('value', '');
            $('#BillingLN').prop('disabled', false).attr('value', '');
            $('#BillingCN').prop('disabled', false).attr('value', '');
            $('#BillingPC').prop('disabled', false).attr('value', '');
            $('#BillingAL1').prop('disabled', false).attr('value', '');
            $('#BillingAL2').prop('disabled', false).attr('value', '');
        }
    });

    function getAccountSettingInfo() {
        const company          = $('#BillingCN');
        const last_name        = $('#BillingLN');
        const first_name       = $('#BillingFN');
        const postal_code      = $('#BillingPC');
        const address_line_one = $('#BillingAL1');
        const address_line_two = $('#BillingAL2');
        const city             = $('#BillingCity');
        const state            = $('#BillingState');
        const country          = $('#BillingCountry');
        $.ajax({
            url: '/payment_details/fetch_landlord',
            type: 'GET',
            data: {
                payment_detail: {},
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
                } else if (data.success === false) {
                    if (data.message === 'Please update Address Line 1 in account settings first.') {
                        $('#BillingAL1Err').text('').append(data.message);
                    } else if (data.message === 'Please update Postal Code in account settings first.') {
                        $('#IncorrectZipCode').text('').append(data.message)
                    }
                }
            },
            error: function (exception) {
            }
        });
    }

    function getCardBrand(num) {

        // first, sanitize the number by removing all non-digit characters.
        num = num.replace(/[^\d]/g,'');

        // MasterCard
        if (num.match(/^5[1-5][0-9]{5,}$/)) {
            return 'MasterCard';

            // Visa
        } else if ( num.match(/^4[0-9]{6,}$/) ) {
            return 'Visa';

            /* AMEX */
        } else if (num.match(/^3[47][0-9]{5,}$/)) {
            return 'AMEX';

            // Discover
        } else if (num.match(/^6(?:011|5[0-9]{2})[0-9]{3,}$/)) {
            return 'Discover';

            // Diners Club
        } else if (num.match(/^3(?:0[0-5]|[68][0-9])[0-9]{4,}$/)){
            return 'Diners Club';

            // JCB
        } else if (num.match(/^(?:2131|1800|35[0-9]{3})[0-9]{3,}$/)){
            return 'JCB';
        }
        return 'UNKNOWN';
    }

    // $('#SameAccountAddress').change(function () {
    //     if ($(this).prop('checked') === true) {
    //         $('#BillingAddressSection').hide();
    //     } else if ($(this).prop('checked') === false) {
    //         $('#BillingAddressSection').show();
    //     }
    //
    // });

});
