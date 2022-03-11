//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

// Auto hide notification div
$(document).ready(function () {
    const $myDiv = $('.alert');
    if ($myDiv.length) {
        $myDiv.show().delay(3000).fadeOut();
    }
});

