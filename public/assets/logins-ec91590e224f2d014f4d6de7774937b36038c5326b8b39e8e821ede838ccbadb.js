$(document).ready(function () {

    $('#LoginBtn').on('click', function () {
        const email = $('#InputEmail').val();
        const password = $('#InputPassword').val();
        $.ajax({
            url: '/users/sign_in',
            type: 'POST',
            data: {user: {email: email, password: password}},
            success: function (data) {
                if (data.success === true) {
                    window.location.href = data.url;
                }
                if (data.success === false) {
                    $('.error_alert').removeClass('display_none').text('').append(data.message);
                }
            },
            error: function (exception) {
                debugger;
            }
        });
    });

});
