$(document).ready(function () {

    $(function () {
        $("form[name='property_form']").validate({
            rules: {
                'property[City]':                 {required: true},
                'property[SAL1]':                 {required: true},
                'property[State]':                {required: true},
                'property[TSAL1]':                {required: true},
                'property[TNCity]':               {required: true},
                'property[TNState]':              {required: true},
                'property[PostalCode]':           {required: true},
                'property[TNPostalCode]':         {required: true},
                'property[property_type]':        {required: true},
                'property[LandlordContactName]':  {required: true},
                'property[LandlordContactPhone]': {required: true},
                'property[LandlordContactEmail]': {required: true},
            },
            messages: {
                'property[TNCity]':               {required: 'City is required'},
                'property[TNState]':              {required: 'State is required'},
                'property[State]':                {required: 'Please select state'},
                'property[City]':                 {required: 'City name is required'},
                'property[TNPostalCode]':         {required: 'Postal Code is required'},
                'property[PostalCode]':           {required: 'Postal Code is required'},
                'property[property_type]':        {required: 'Please select property type'},
                'property[SAL1]':                 {required: 'Street Address Line 1 is required'},
                'property[LandlordContactName]':  {required: 'Landlord Contact Name is required'},
                'property[LandlordContactEmail]': {required: 'Landlord Contact Email is required'},
                'property[LandlordContactPhone]': {required: 'Landlord Contact Phone is required'},
                'property[TSAL1]':                {required: 'Tenant Notice Address Street Line 1 is required'},

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

    // Interactive Zipcodes
    $('input.zipcode_interactive').blur(function (data) {
        const zipcode = $(this).val();
        const from = $(this).data('from');
        getCityState(zipcode, from)
    });

    // Enable Disable Tenant Area
    $('.currently-leased').change(function () {
        const value = $(this).val();
        if (value === 'true') {
            $('#TenantSection').show();
        } else if (value === 'false') {
            $('#TenantSection').hide();
        }

    });

    // Enable Disable Tenant Notice Area
    $('.asked-for-property').change(function () {
        const value = $(this).val();
        if (value === 'true') {
            $('#TenantNoticeSection').hide();
        } else if (value === 'false') {
            $('#TenantNoticeSection').show();
        }

    });

    function ajaxRequest(e) {
        e.preventDefault();
        disableButton();
        const city = $('#propertyCity').val();
        const address_line_one              = $('#propertySAL1').val();
        const address_line_two              = $('#propertySAL2').val();
        const state                         = $('#propertyState').val();
        const tenant_notice_street_line_one = $('#propertyTSAL1').val();
        const tenant_notice_street_line_two = $('#propertyTSAL2').val();
        const user_id                       = $('#PropertyUserID').val();
        const tenant_notice_city            = $('#propertyTNCity').val();
        const tenant_notice_state           = $('#propertyTNState').val();
        const bed_one                       = $('#propertyBedroomA').val();
        const bed_two                       = $('#propertyBedroomB').val();
        const postal_code                   = $('#propertyPostalCode').val();
        const property_type                 = $('#propertyPropertyType').val();
        const tenant_notice_postal_code     = $('#propertyTNPostalCode').val();
        const name                          = $('#propertyNewTenantName').val();
        const phone_number                  = $('#propertyNewTenantPhone').val();
        const email                         = $('#propertyNewTenantEmail').val();
        const lease_end_date                = $('#propertyNewLeaseEndDate').val();
        const currently_leased              = $('.currently-leased:checked').val();
        const lease_start_date              = $('#propertyNewLeaseStartDate').val();
        const property_for_notice           = $('.asked-for-property:checked').val();
        const landlord_contact_name         = $('#propertyLandlordContactName').val();
        const landlord_contact_phone        = $('#propertyLandlordContactPhone').val();
        const landlord_contact_email        = $('#propertyLandlordContactEmail').val();
        const saved_landlord                = !!$('#propertyLandlordInfo').is(':checked');
        $.ajax({
            url: '/properties',
            type: 'POST',
            data: {
                property: {
                    city:                          city,
                    state:                         state,
                    user_id:                       user_id,
                    bed_one:                       bed_one,
                    bed_two:                       bed_two,
                    postal_code:                   postal_code,
                    property_type:                 property_type,
                    saved_landlord:                saved_landlord,
                    address_line_one:              address_line_one,
                    address_line_two:              address_line_two,
                    currently_leased:              currently_leased,
                    tenant_notice_city:            tenant_notice_city,
                    tenant_notice_state:           tenant_notice_state,
                    property_for_notice:           property_for_notice,
                    landlord_contact_name:         landlord_contact_name,
                    landlord_contact_phone:        landlord_contact_phone,
                    landlord_contact_email:        landlord_contact_email,
                    tenant_notice_postal_code:     tenant_notice_postal_code,
                    tenant_notice_street_line_one: tenant_notice_street_line_one,
                    tenant_notice_street_line_two: tenant_notice_street_line_two,
                },
                tenant: {
                    name:             name,
                    email:            email,
                    phone_number:     phone_number,
                    lease_end_date:   lease_end_date,
                    lease_start_date: lease_start_date
                }
            },
            success: function (data) {},
            error: function (exception) {}
        });
        return false;
    }

    function getLandLordInfo(state) {
        const landlord_contact_name = $('#propertyLandlordContactName');
        const landlord_contact_phone = $('#propertyLandlordContactPhone');
        const landlord_contact_email = $('#propertyLandlordContactEmail');
        $.ajax({
            url: '/properties/fetch_landlord',
            type: 'GET',
            data: {
                property: {
                    saved_landlord: state
                }
            },
            success: function (data) {
                if (data.success === true) {
                    landlord_contact_name.prop('disabled', true).attr('value', data.user.name);
                    landlord_contact_phone.prop('disabled', true).attr('value', data.user.phone);
                    landlord_contact_email.prop('disabled', true).attr('value', data.user.email);
                } else if (data.success === false) {
                    response_handler(data)
                }
            },
            error: function (exception) {
            }
        });
    }

    function getCityState(zipcode, from) {
        $.ajax({
            url: '/properties/get_zip_data/' + zipcode,
            type: 'GET',
            data: {},
            success: function (data) {
                if (from === 'tenant_notice') {
                    $('#propertyTNCity').attr('value', data.object.city);
                    $('#propertyTNState').attr('value', data.object.state);
                } else {
                    $('#propertyCity').attr('value', data.object.city);
                    $('#propertyState').attr('value', data.object.state);
                }

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

});

