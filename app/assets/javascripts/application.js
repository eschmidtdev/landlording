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
