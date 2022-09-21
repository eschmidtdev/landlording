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

    $(function () {
        $("form[name='edit_property_form']").validate({
            rules: {
                'Eproperty[City]':                 {required: true},
                'Eproperty[State]':                {required: true},
                'Eproperty[TSAL1]':                {required: true},
                'Eproperty[TNCity]':               {required: true},
                'Eproperty[TNState]':              {required: true},
                'Eproperty[PostalCode]':           {required: true},
                'Eproperty[TNPostalCode]':         {required: true},
                'Eproperty[LandlordContactName]':  {required: true},
                'Eproperty[LandlordContactPhone]': {required: true},
                'Eproperty[LandlordContactEmail]': {required: true},
            },
            messages: {
                'Eproperty[TNCity]':               {required: 'City is required'},
                'Eproperty[TNState]':              {required: 'State is required'},
                'Eproperty[State]':                {required: 'Please select state'},
                'Eproperty[City]':                 {required: 'City name is required'},
                'Eproperty[TNPostalCode]':         {required: 'Postal Code is required'},
                'Eproperty[PostalCode]':           {required: 'Postal Code is required'},
                'Eproperty[LandlordContactName]':  {required: 'Landlord Contact Name is required'},
                'Eproperty[LandlordContactEmail]': {required: 'Landlord Contact Email is required'},
                'Eproperty[LandlordContactPhone]': {required: 'Landlord Contact Phone is required'},
                'Eproperty[TSAL1]':                {required: 'Tenant Notice Address Street Line 1 is required'},

            },
            submitHandler: function (form, e) {
                EditajaxRequest(e);
            }
        });
    });

    // Enable Disable Tenant Area
    $('.currently-leased').change(function () {
        const value = $(this).val();
        if (value === 'true') {
            $('#TenantSection').fadeIn(250);
            $('#EditTenantSection').removeClass('display_none').fadeIn(250);
        } else if (value === 'false') {
            $('#TenantSection').fadeOut(250);
            $('#EditTenantSection').fadeOut(250);
        }
    });

    // Enable Disable Tenant Notice Area
    $('.asked-for-property').change(function () {
        const value = $(this).val();
        if (value === 'true') {
            $('#TenantNoticeSection').fadeOut(250);
            $('#EditTenantNoticeSection').fadeOut(250);
        } else if (value === 'false') {
            $('#TenantNoticeSection').fadeIn(250);
            $('#EditTenantNoticeSection').removeClass('display_none').fadeIn(250);
        }

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

    $('#EpropertyLandlordInfo').change(function () {
        const checkbox = $('#EpropertyLandlordInfo');

        if (checkbox.is(":checked")) {
            getEditLandLordInfo('true');
        } else if (checkbox.not(":checked")) {
            const landlord_contact_name = $('#EpropertyLandlordContactName');
            const landlord_contact_phone = $('#EpropertyLandlordContactPhone');
            const landlord_contact_email = $('#EpropertyLandlordContactEmail');
            landlord_contact_name.prop( 'disabled', false ).attr('value', '');
            landlord_contact_phone.prop( 'disabled', false ).attr('value', '');
            landlord_contact_email.prop( 'disabled', false ).attr('value', '');
        }
    });



    // Show Additional Tenant Section
    $('#SwitchAdditionalTenant').click(function () {
        $(this).hide();
        $('#AdditionalTenantSection').fadeIn(250);
    });

    function ajaxRequest(e) {
        e.preventDefault();
        const city                          = $('#propertyCity').val();
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
        const additional_tenant_name        = $('#ADpropertyNewTenantName').val();
        const additional_tenant_phone       = $('#ADpropertyNewTenantPhone').val();
        const additional_tenant_email       = $('#ADpropertyNewTenantEmail').val();
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
                    lease_start_date: lease_start_date,
                    additional_tenant_name:  additional_tenant_name,
                    additional_tenant_phone: additional_tenant_phone,
                    additional_tenant_email: additional_tenant_email,
                }
            },
            success: function (data) {},
            error: function (exception) {}
        });
        return false;
    }

    function EditajaxRequest(e) {
        e.preventDefault();
        const id                   = $('#EpropertyID').val();
        const city                          = $('#EpropertyCity').val();
        const address_line_one              = $('#EpropertySAL1').val();
        const address_line_two              = $('#EpropertySAL2').val();
        const state                         = $('#EpropertyState').val();
        const tenant_notice_street_line_one = $('#EpropertyTSAL1').val();
        const tenant_notice_street_line_two = $('#EpropertyTSAL2').val();
        const user_id                       = $('#EPropertyUserID').val();
        const tenant_notice_city            = $('#EpropertyTNCity').val();
        const tenant_notice_state           = $('#EpropertyTNState').val();
        const bed_one                       = $('#EpropertyBedroomA').val();
        const bed_two                       = $('#EpropertyBedroomB').val();
        const postal_code                   = $('#EpropertyPostalCode').val();
        const property_type                 = $('#EpropertyPropertyType').val();
        const tenant_notice_postal_code     = $('#EpropertyTNPostalCode').val();
        const name                          = $('#EpropertyNewTenantName').val();
        const additional_tenant_name        = $('#ADpropertyNewTenantName').val();
        const phone_number                  = $('#EpropertyNewTenantPhone').val();
        const email                         = $('#EpropertyNewTenantEmail').val();
        const lease_end_date                = $('#EpropertyNewLeaseEndDate').val();
        const currently_leased              = $('.currently-leased:checked').val();
        const additional_tenant_phone       = $('#ADpropertyNewTenantPhone').val();
        const additional_tenant_email       = $('#ADpropertyNewTenantEmail').val();
        const lease_start_date              = $('#EpropertyNewLeaseStartDate').val();
        const property_for_notice           = $('.asked-for-property:checked').val();
        const landlord_contact_name         = $('#EpropertyLandlordContactName').val();
        const landlord_contact_phone        = $('#EpropertyLandlordContactPhone').val();
        const landlord_contact_email        = $('#EpropertyLandlordContactEmail').val();
        const saved_landlord                = !!$('#EpropertyLandlordInfo').is(':checked');


        $.ajax({
            url: `/properties/${id}`,
            type: 'PUT',
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
                    name:                    name,
                    email:                   email,
                    phone_number:            phone_number,
                    lease_end_date:          lease_end_date,
                    lease_start_date:        lease_start_date,
                    additional_tenant_name:  additional_tenant_name,
                    additional_tenant_phone: additional_tenant_phone,
                    additional_tenant_email: additional_tenant_email,
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
                    landlord_contact_name.prop('disabled', true).attr('value', data.message.name);
                    landlord_contact_phone.prop('disabled', true).attr('value', data.message.phone);
                    landlord_contact_email.prop('disabled', true).attr('value', data.message.email);
                } else if (data.success === false) {
                    if (data.method === 'add_email') {
                        $('.landlord_email_error').text('').show().text(data.message);
                    } else if (data.method === 'add_phone') {
                        $('.landlord_phone_error').text('').show().text(data.message);
                    } else if (data.method === 'add_name') {
                        $('.landlord_name_error').text('').show().text(data.message);
                    }
                }
            },
            error: function (exception) {
            }
        });
    }

    function getEditLandLordInfo(state) {
        const landlord_contact_name = $('#EpropertyLandlordContactName');
        const landlord_contact_phone = $('#EpropertyLandlordContactPhone');
        const landlord_contact_email = $('#EpropertyLandlordContactEmail');
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
                    landlord_contact_name.prop('disabled', true).attr('value', data.message.name);
                    landlord_contact_phone.prop('disabled', true).attr('value', data.message.phone);
                    landlord_contact_email.prop('disabled', true).attr('value', data.message.email);
                } else if (data.success === false) {
                    if (data.method === 'add_email') {
                        $('.landlord_email_error').text('').show().text(data.message);
                    } else if (data.method === 'add_phone') {
                        $('.landlord_phone_error').text('').show().text(data.message);
                    } else if (data.method === 'add_name') {
                        $('.landlord_name_error').text('').show().text(data.message);
                    }
                }
            },
            error: function (exception) {
            }
        });
    }

});
