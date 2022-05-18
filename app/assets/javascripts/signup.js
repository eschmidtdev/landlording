$(document).ready(function () {
    $(function () {
        $("form[name='registration']").validate({
            rules: {
                'user[name]': 'required',
                'user[email]': {required: true, email: true},
                'user[password]': {required: true, minlength: 8}
            },
            messages: {
                'user[name]': {
                    required: "Full Name is required.",
                },
                'user[email]': 'Please enter a valid email address',
                'user[password]': {
                    required: 'Please provide a password',
                    minlength: 'Password is too short (minimum is 8 characters)'
                }
            },
            submitHandler: function (form, e) {
                debugger;
                ajaxRequest(e);
            }
            // other options
        });
    });

    function ajaxRequest(e) {
        e.preventDefault();
        const name = $('#UserName').val();
        const email = $('#RegEmail').val();
        const password = $('#RegPass').val();
        debugger;
        $.ajax({
            url: '/users',
            type: 'POST',
            data: {user: {name: name, email: email, password: password}},
            success: function (data) {
                debugger;
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
        return false;
    }

    function disableButton() {
        $('#SignupBtn').prop('disabled', true).text('Submitting...');
    }

});





