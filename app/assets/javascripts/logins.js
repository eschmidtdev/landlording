// This file is only responsible for handling "LOGIN" page javascript

$(document).ready(function () {
    // Declaring variables
    let SignUpButton = $('#sign-up');
    let SignInButton = $('#sign-in');
    let SignInForm   = $('#sign-in-form');
    let SignUpForm   = $('#sign-up-form');

    // Functionality for SignUp button
    SignUpButton.on('click', function () {
        SignInForm.addClass('display-none');
        SignUpForm.removeClass('display-none');
        SignUpButton.addClass('active-now');
        SignInButton.removeClass('active-now');
    });

    // Functionality for SignIn button
    SignInButton.on('click', function () {
        SignInForm.removeClass('display-none');
        SignUpForm.addClass('display-none');
        SignInButton.addClass('active-now');
        SignUpButton.removeClass('active-now');
    });
});
