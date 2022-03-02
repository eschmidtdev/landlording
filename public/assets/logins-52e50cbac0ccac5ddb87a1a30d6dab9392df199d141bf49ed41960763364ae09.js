$(document).ready(function () {
    $('#sign-up').on('click', function () {
        $('#sign-in-form').addClass('display-none');
        $('#sign-up-form').removeClass('display-none');
        $('#sign-up').addClass('active-now');
        $('#sign-in').removeClass('active-now');
    });
    $('#sign-in').on('click', function () {
        $('#sign-in-form').removeClass('display-none');
        $('#sign-up-form').addClass('display-none');
        $('#sign-in').addClass('active-now');
        $('#sign-up').removeClass('active-now');
    });
});
