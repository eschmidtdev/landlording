$(document).ready(function () {

    $(function () {
        $("form[name='property_form']").validate({
            rules: {
                'property[City]':                 {required: true},
                'property[SAL1]':                 {required: true},
                'property[State]':                {required: true},
                'property[PostalCode]':           {required: true},
                'property[property_type]':        {required: true},
                'property[LandlordContactName]':  {required: true},
                'property[LandlordContactPhone]': {required: true},
                'property[LandlordContactEmail]': {required: true},
            },
            messages: {
                'property[State]':                {required: 'Please select state'},
                'property[City]':                 {required: 'City name is required'},
                'property[PostalCode]':           {required: 'Postal Code is required'},
                'property[property_type]':        {required: 'Please select property type'},
                'property[LandlordContactName]':  {required: 'Landlord Contact Name is required'},
                'property[SAL1]':                 {required: 'Street Address Line 1 is required'},
                'property[LandlordContactEmail]': {required: 'Landlord Contact Email is required'},
                'property[LandlordContactPhone]': {required: 'Landlord Contact Phone is required'}
            },
            submitHandler: function (form, e) {
                ajaxRequest(e);
            }
        });
    });

    function ajaxRequest(e) {
        return
        e.preventDefault();
        disableButton();
        const property_type = $('#propertyPropertyType').val();
        const address_line_one = $('#propertySAL1').val();
        const address_line_two = $('#propertySAL2').val();
        const postal_code = $('#propertyPostalCode').val();
        const city = $('#propertyCity').val();
        const state = $('#propertyState').val();
        const bed_one = $('#propertyBedroomA').val();
        const bed_two = $('#propertyBedroomB').val();
        const landlord_contact_name = $('#propertyLandlordContactName').val();
        const landlord_contact_phone = $('#propertyLandlordContactPhone').val();
        const landlord_contact_email = $('#propertyLandlordContactEmail').val();
        const saved_landlord = $('#propertyLandlordInfo').val();
        const currently_leased = $('#InputEmail').val();
        const property_for_notice = $('#InputEmail').val();
        $.ajax({
            url: '/users/sign_in',
            type: 'POST',
            data: {
                user: {
                    email: email,
                    password: password
                }
            },
            success: function (data) {
                response_handler(data)
            },
            error: function (exception) {
            }
        });
        return false;
    }

    function enableButton() {
        $('#SavePropertyBtn').prop('disabled', false);
    }

    function disableButton() {
        $('#SavePropertyBtn').prop('disabled', true);
    }

    function response_handler(data) {
        clearErrors();
        enableButton();
        if (data.success === true) {
            window.location.href = data.url;
        }
        if (data.success === false) {
            $('.error_alert').text('').show().append(data.message);
        }
    }

    function clearErrors() {
        $('.error_alert').text('').hide();
    }

    $(":input").on("keyup change", function (e) {
        clearErrors();
    })

    $('#sessionEye').click(function () {
        const input = $('.toggle-password-session');
        input.attr('type') === 'password' ? input.attr('type', 'text') : input.attr('type', 'password')
    });

});

