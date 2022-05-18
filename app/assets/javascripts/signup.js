$(document).ready(function () {
    $(function () {
        $("form[name='registration']").validate({
            rules: {
                'user[name]': {required: true},
                'user[email]': {required: true, email: true},
                'user[password]': {required: true, minlength: 8}
            },
            messages: {
                'user[name]': {
                    required: "Full Name is required.",
                },
                'user[email]': "Please enter a valid email address",
                'user[password]': {
                    required: "Please provide a password",
                    minlength: "Password is too short (minimum is 8 characters)"
                }
            },
            submitHandler: function (form) {
                form.submit();
            }
        });
    });

});
