$(document).ready(function(){function e(e){e.preventDefault(),a();const t=$("#accountSettingLastName").val(),n=$("#accountSettingFirstName").val(),s=$("#accountSettingPhoneNumber").val(),i=$("#accountSettingCompanyName").val(),u=$("#accountSettingUserID").val();return $.ajax({url:`/account_settings/${u}`,type:"PUT",data:{account_setting:{last_name:t,first_name:n,phone_number:s,company_name:i}},success:function(e){c(e)},error:function(){}}),!1}function t(e){$.ajax({url:`/account_settings/${e}`,type:"DELETE",data:{account_setting:{id:e}},success:function(e){!0===e.success&&$("#BillingDetailNotice").show().append(e.message).delay(2e3).fadeOut(300),location.reload()},error:function(){}})}function n(){$("#AccSettingUpdatePassBtn").prop("disabled",!1)}function a(){$("#AccSettingUpdatePassBtn").prop("disabled",!0)}function c(e){!0!==e.success&&!1!==e.success||s(e)}function s(e){i(),$(!0===e.success?".success_alert":".error_alert").text("").show().append(e.message).delay(2e3).fadeOut(300),n()}function i(){$(".error_alert").text("").addClass("display_none")}$(function(){$("form[name='personal_info']").validate({rules:{"accountSetting[LastName]":{required:!0},"accountSetting[FirstName]":{required:!0},"accountSetting[PhoneNumber]":{required:!0}},messages:{"accountSetting[LastName]":"Last Name is required","accountSetting[FirstName]":"First Name is required","accountSetting[PhoneNumber]":"Phone Number is required"},submitHandler:function(t,n){e(n)}})}),$("#DeleteBillingDetails").click(function(){t($(this).data("user-id"))})});