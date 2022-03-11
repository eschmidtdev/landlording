// This file is only responsible for handling "LOGIN" page javascript

$(document).ready(function () {
    // Declaring variables
    let SignUpButton = $('#sign-up');
    let SignInButton = $('#sign-in');
    let SignInForm   = $('#sign-in-form');
    let SignUpForm   = $('#sign-up-form');

    // Functionality for SignUp button
    SignUpButton.on('click', function () {
        // Calling SignIn Function
        SignInFunction();
    });

    // Functionality for SignIn button
    SignInButton.on('click', function () {
        // Calling SignUp Function
        SignUpFunction();
    });

    // Define SignInFunction
    function SignInFunction() {
        SignInForm.addClass('display-none');
        SignUpForm.removeClass('display-none');
        SignUpButton.addClass('active-now');
        SignInButton.removeClass('active-now');
    }

    // Define SignUpFunction
    function SignUpFunction() {
        SignInForm.removeClass('display-none');
        SignUpForm.addClass('display-none');
        SignInButton.addClass('active-now');
        SignUpButton.removeClass('active-now');
    }

});
