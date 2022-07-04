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

    $('#propertyLandlordInfo').change(function () {
        const checkbox = $('#propertyLandlordInfo');

        if (checkbox.is(":checked")) {
            getLandLordInfo('true');
        } else if (checkbox.not(":checked")) {
            const landlord_contact_name = $('#propertyLandlordContactName');
            const landlord_contact_phone = $('#propertyLandlordContactPhone');
            const landlord_contact_email = $('#propertyLandlordContactEmail');
            landlord_contact_name.prop( 'disabled', false ).attr('value', '');
            landlord_contact_phone.prop( 'disabled', false ).attr('value', '');
            landlord_contact_email.prop( 'disabled', false ).attr('value', '');
        }

    });

    function ajaxRequest(e) {
        e.preventDefault();
        disableButton();
        const city = $('#propertyCity').val();
        const address_line_one       = $('#propertySAL1').val();
        const address_line_two       = $('#propertySAL2').val();
        const state                  = $('#propertyState').val();
        const user_id                = $('#PropertyUserID').val();
        const bed_one                = $('#propertyBedroomA').val();
        const bed_two                = $('#propertyBedroomB').val();
        const postal_code            = $('#propertyPostalCode').val();
        const property_type          = $('#propertyPropertyType').val();
        const name                   = $('#propertyNewTenantName').val();
        const phone_number           = $('#propertyNewTenantPhone').val();
        const email                  = $('#propertyNewTenantEmail').val();
        const lease_end_date         = $('#propertyNewLeaseEndDate').val();
        const currently_leased       = $('.currently-leased:checked').val();
        const lease_start_date       = $('#propertyNewLeaseStartDate').val();
        const property_for_notice    = $('.asked-for-property:checked').val();
        const landlord_contact_name  = $('#propertyLandlordContactName').val();
        const landlord_contact_phone = $('#propertyLandlordContactPhone').val();
        const landlord_contact_email = $('#propertyLandlordContactEmail').val();
        const saved_landlord         = !!$('#propertyLandlordInfo').is(':checked')
        $.ajax({
            url: '/properties',
            type: 'POST',
            data: {
                property: {
                    city:                   city,
                    state:                  state,
                    user_id:                user_id,
                    bed_one:                bed_one,
                    bed_two:                bed_two,
                    postal_code:            postal_code,
                    property_type:          property_type,
                    saved_landlord:         saved_landlord,
                    address_line_one:       address_line_one,
                    address_line_two:       address_line_two,
                    currently_leased:       currently_leased,
                    property_for_notice:    property_for_notice,
                    landlord_contact_name:  landlord_contact_name,
                    landlord_contact_phone: landlord_contact_phone,
                    landlord_contact_email: landlord_contact_email
                },
                tenant: {
                    name:             name,
                    email:            email,
                    phone_number:     phone_number,
                    lease_end_date:   lease_end_date,
                    lease_start_date: lease_start_date
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

    function getLandLordInfo(state) {
        const landlord_contact_name = $('#propertyLandlordContactName');
        const landlord_contact_phone = $('#propertyLandlordContactPhone');
        const landlord_contact_email = $('#propertyLandlordContactEmail');
        $.ajax({
            url: '/properties/get_landlord',
            type: 'GET',
            data: {
                property: {
                    saved_landlord: state
                }
            },
            success: function (data) {
                landlord_contact_name.prop('disabled', true).attr('value', data.user.name);
                landlord_contact_phone.prop('disabled', true).attr('value', data.user.phone);
                landlord_contact_email.prop('disabled', true).attr('value', data.user.email);
            },
            error: function (exception) {
            }
        });
    }

    function enableButton() {
        $('#SavePropertyBtn').prop('disabled', false);
    }

    function disableButton() {
        $('#SavePropertyBtn').prop('disabled', true);
    }

    function response_handler(data) {
        enableButton();
        if (data.success === true) {
            $("form[name='property_form']")[0].reset();
            $('html, body').animate({scrollTop: 0}, 'slow');
            $('.success_alert')
                .text('')
                .show()
                .append(data.message)
                .delay(3000)
                .fadeOut(300);
        }
    }

});

