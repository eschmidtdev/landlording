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
                'Billing[State]':      {required: true},
                'Billing[Country]':    {required: true},
                'Billing[CardNumber]': {required: true},
            },
            messages: {
                'Billing[State]':      {required: 'State is required'},
                'Billing[AL1]':        {required: 'Address is required'},
                'Billing[EXP]':        {required: 'Expiration required'},
                'Billing[City]':       {required: 'City Name is required'},
                'Billing[LN]':         {required: 'Last Name is required'},
                'Billing[FN]':         {required: 'First Name is required'},
                'Billing[PC]':         {required: 'Postal Code is required'},
                'Billing[Country]':    {required: 'Country Name is required'},
                'Billing[CVC]':        {required: 'Security Code is required'},
                'Billing[CardNumber]': {required: 'Card Number is required'}
            },
            submitHandler: function (form, e) {
                ajaxRequest(e);
            }
        });
    });

    function ajaxRequest(e) {
        e.preventDefault();
        disableButton();
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
        $.ajax({
            url: `/payment_details/${userID}`,
            type: 'PUT',
            data: {
                payment_detail: {
                    cvc:              cvc,
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
                    address_line_two: addressLineTwo,
                    address_line_one: addressLineOne
                }
            },
            success: function (data) {
                clearErrors();
                response_handler(data);
                enableButton();
            },
            error: function (exception) {
            }
        });
        return false;
    }

    function enableButton() {
        $('#SaveBillingInfo').prop('disabled', false);
    }

    function disableButton() {
        $('#SaveBillingInfo').prop('disabled', true);
    }

    function  response_handler(data){
        if (data.success === true){
            render_response(data)
        }
    }

    function render_response(data){
        $('.error_alert')
            .show()
            .append(data.message)
            .delay(2000)
            .fadeOut(300);
    }

    function clearErrors(){
        $('.error_alert').text('').addClass('display_none');
    }

});