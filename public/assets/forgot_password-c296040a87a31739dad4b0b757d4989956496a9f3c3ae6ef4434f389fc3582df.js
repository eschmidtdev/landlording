$(document).ready(function(){function e(e){e.preventDefault(),r();const a=$("#ForgotPasswordEmail").val();return $.ajax({url:"/sent/email",type:"POST",data:{user:{email:a}},success:function(e){!0===e.success&&(window.location.href=e.url),!1===e.success&&(s(),$(".error_alert").removeClass("display_none").text("").append(e.message))},error:function(){}}),!1}function r(){$("#ForgotPassword").prop("disabled",!0)}function s(){$("#ForgotPassword").prop("disabled",!1)}$(function(){$("form[name='forgot_password']").validate({rules:{"user[email]":{required:!0,email:!0}},messages:{"user[email]":{required:"Email is required",email:"Email is not valid"}},submitHandler:function(r,s){e(s)}})})});