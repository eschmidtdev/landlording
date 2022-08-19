//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets

// Show loader on submit any ajaxRequest
$(document).on('turbolinks:load', function () {
    const $loading = $('#loader').hide();
    $(document)
        .ajaxStart(function () {
            $loading.show();
        })
        .ajaxStop(function () {
            $loading.hide();
        });
});

$(document).ready(function () {
// Fetch City, State & Country
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
                if (data.success === true) {
                    if (from === 'create_property') {
                        $('#createZipErr').text('');
                        $('#propertyCity').attr('value', data.message.city);
                        $('#propertyState').attr('value', data.message.state);
                    }
                    else if (from === 'update_property'){
                        $('#updateZipErr').text('');
                        $('#EpropertyCity').attr('value', data.message.city);
                        $('#EpropertyState').attr('value', data.message.state);
                    }
                    else if (from === 'account_settings'){
                        $('#updateAccountSettingErr').text('');
                        $('#accountSettingCity').attr('value', data.message.city);
                        $('#accountSettingState').attr('value', data.message.state);
                        $('#accountSettingCountry').attr('value', data.message.county);
                    }
                    else if (from === 'payment_details') {
                        $('#BillingCity').attr('value', data.message.city);
                        $('#BillingState').attr('value', data.message.state);
                        $('#BillingCountry').attr('value', data.message.county);
                    }
                    else if (from === 'create_property_tenant'){
                        $('#createZipErrTN').text('');
                        $('#propertyTNCity').attr('value', data.message.city);
                        $('#propertyTNState').attr('value', data.message.state);
                    }
                    else if (from === 'update_property_tenant'){
                        $('#updateZipErrTN').text('');
                        $('#EpropertyTNCity').attr('value', data.message.city);
                        $('#EpropertyTNState').attr('value', data.message.state);
                    }
                }
                else {
                    if (from === 'payment_details'){
                        $('#IncorrectZipCode').text('').show().text(data.message);
                    }
                    else if (from === 'create_property'){
                        $('#createZipErr').text('').show().text(data.message);
                    }
                    else if (from === 'update_property'){
                        $('#updateZipErr').text('').show().text(data.message);
                    }
                    else if (from === 'account_settings'){
                        $('#updateAccountSettingErr').text('').show().text(data.message);
                    }
                    else if (from === 'update_property_tenant'){
                        $('#updateZipErrTN').text('').show().text(data.message);
                    }
                    else if (from === 'create_property_tenant'){
                        $('#createZipErrTN').text('').show().text(data.message);
                    }

                }
            },
            error: function (exception) {}
        });
    }

});




