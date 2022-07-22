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
            success: function (data) {},
            error: function (exception) {}
        });
        return false;
    }

    // Interactive Zipcodes
    $('input.zipcode_interactive').blur(function (data) {
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
                if (from === 'tenant_notice') {
                    $('#propertyTNCity').attr('value', data.object.city);
                    $('#propertyTNState').attr('value', data.object.state);
                } else if (from === 'payment_details') {
                    $('#BillingCity').attr('value', data.object.city);
                    $('#BillingState').attr('value', data.object.state);
                    $('#BillingCountry').attr('value', data.object.state);
                } else {
                    $('#propertyCity').attr('value', data.object.city);
                    $('#propertyState').attr('value', data.object.state);
                }

            },
            error: function (exception) {
            }
        });
    }

    $('#SameAsAccountAddress').change(function () {
        if ($(this).prop('checked') === true) {
            $('#BillingAddressSection').hide();
        } else if ($(this).prop('checked') === false) {
            $('#BillingAddressSection').show();
        }

    });


});
