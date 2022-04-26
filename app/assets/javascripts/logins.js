// This file is only responsible for handling "LOGIN" page javascript

$(document).ready(function () {

    $('#LoginBtn').on('click', function () {
        SubmitLoginForm();
    });

    function SubmitLoginForm() {
        const email = $('#InputEmail').val();
        const password = $('#InputPassword').val();
        debugger;
        $.ajax({
            url: '/users/sign_in',
            type: 'POST',
            data: {user: {email: email, password: password}},
            error: function (exception) {
                debugger;
            },
            success: function (data) {
                debugger;
            }
        });
    }

});
