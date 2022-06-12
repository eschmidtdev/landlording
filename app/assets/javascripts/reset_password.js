$(document).ready(function () {

    $(function () {
        $("form[name='reset_password']").validate({
            rules: {
                'user[password]': {required: true, minlength: 8},
                'user[password_confirmation]': {required: true, equalTo: "#ResetNewPassword"}
            }, submitHandler: function (form, e) {
                ajaxRequest(e);
            }
        });
    });

});

