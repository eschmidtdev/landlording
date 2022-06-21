//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets

// Auto hide notification div
// $(document).on('turbolinks:load', function () {
//     $('.alert').delay(2000).slideUp(500, function () {
//         $('.alert').alert('close');
//     });
// });

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

$(document).on('click', '.password-eye', function () {
    const input = $('.toggle-password');
    input.attr('type') === 'password' ? input.attr('type', 'text') : input.attr('type', 'password')

});



