$(document).ready(function(){function e(e){e.preventDefault(),n();const t=$("#SettingNP").val(),s=$("#SettingCP").val(),a=$("#SettingCNP").val(),i=$("#AccSettingPassUpdateUID").val();return $.ajax({url:`/account_settings/${i}`,type:"PUT",data:{account_setting:{new_password:t,current_password:s,confirm_password:a,from:"ChangePassword"}},success:function(e){r(e)},error:function(){}}),!1}function t(){$("#SavePersonalInfo").prop("disabled",!1)}function n(){$("#SavePersonalInfo").prop("disabled",!0)}function r(e){i(),!0===e.success&&s(e),!1===e.success&&a(e),t()}function s(e){$("#ChangePassword").trigger("reset"),$(".error_alert").show().append(e.message).delay(2e3).fadeOut(300)}function a(e){"current_password"===e.error&&$("#PassIncorrect").show().text(e.message)}function i(){$(".error_alert").text("").addClass("display_none"),$("#PassIncorrect").text("").addClass("display_none")}$(function(){$("form[name='account_change_password']").validate({rules:{"Setting[CP]":{required:!0,minlength:8},"Setting[NP]":{required:!0,minlength:8},"Setting[CNP]":{required:!0,equalTo:"#SettingNP"}},messages:{"Setting[CP]":{required:"Current Password is required",minlength:"Password is too short (minimum is 8 characters)"},"Setting[NP]":{required:"New Password is required",minlength:"Password is too short (minimum is 8 characters)"},"Setting[CNP]":{required:"Confirm New Password is required"}},submitHandler:function(t,n){e(n)}})}),$("#SettingCP").keyup(function(){$("#PassIncorrect").hide()})});