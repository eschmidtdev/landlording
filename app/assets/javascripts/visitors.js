$(document).ready(function () {
    $('.hover_able').hover(function () {
        $(this).attr('src', '/assets/visitors/active_arrow.svg');
    }, function () {
        $(this).attr('src', '/assets/visitors/inactive_arrow.svg');
    });
});