$(document).ready(function(){function e(){const e=$("#BillingCN").val(),i=$("#BillingLN").val(),t=$("#BillingFN").val(),l=$("#BillingPC").val(),r=$("#BillingAL1").val(),a=$("#BillingAL2").val(),n=$("#BillingCVC").val(),s=$("#BillingEXP").val(),d=$("#BillingCity").val(),u=$("#BillingFrom").val(),o=$("#BillingState").val(),c=$("#BillingUserID").val(),p=$("#BillingCountry").val(),g=$("#BillingCardNumber").val(),B=$("#SameAsAccountAddress").val();return $.ajax({url:`/payment_details/${c}`,type:"PUT",data:{payment_detail:{cvc:n,from:u,city:d,state:o,user_id:c,company:e,country:p,last_name:i,first_name:t,exp:s,postal_code:l,card_number:g,is_address:B,address_line_two:a,address_line_one:r}},success:function(){},error:function(){}}),!1}function i(){const e=$("#BillingCN"),i=$("#BillingFN"),t=$("#BillingLN"),l=$("#BillingPC"),r=$("#BillingAL1"),a=$("#BillingAL2"),n=$("#BillingCity"),s=$("#BillingState"),d=$("#BillingCountry");$.ajax({url:"/payment_details/fetch_landlord",type:"PUT",data:{payment_detail:{city:n,state:s,country:d,company:e,last_name:i,first_name:t,postal_code:l,address_line_one:r,address_line_two:a}},success:function(u){!0===u.success?(n.prop("disabled",!0).attr("value",u.user.city),s.prop("disabled",!0).attr("value",u.user.state),d.prop("disabled",!0).attr("value",u.user.country),e.prop("disabled",!0).attr("value",u.user.company),i.prop("disabled",!0).attr("value",u.user.last_name),t.prop("disabled",!0).attr("value",u.user.first_name),l.prop("disabled",!0).attr("value",u.user.postal_code),r.prop("disabled",!0).attr("value",u.user.address_line_one),a.prop("disabled",!0).attr("value",u.user.address_line_two)):u.success},error:function(){}})}function t(e,i){$.ajax({url:"/properties/get_zip_data/"+e,type:"GET",data:{},success:function(e){"tenant_notice"===i?($("#propertyTNCity").attr("value",e.object.city),$("#propertyTNState").attr("value",e.object.state)):"payment_details"===i?($("#BillingCity").attr("value",e.object.city),$("#BillingState").attr("value",e.object.state),$("#BillingCountry").attr("value",e.object.state)):($("#propertyCity").attr("value",e.object.city),$("#propertyState").attr("value",e.object.state))},error:function(){}})}$(function(){$("form[name='billing_information']").validate({rules:{"Billing[FN]":{required:!0},"Billing[LN]":{required:!0},"Billing[PC]":{required:!0},"Billing[AL1]":{required:!0},"Billing[EXP]":{required:!0},"Billing[CVC]":{required:!0},"Billing[City]":{required:!0},"Billing[CardNumber]":{required:!0}},messages:{"Billing[AL1]":{required:"Address is required"},"Billing[EXP]":{required:"Expiration required"},"Billing[City]":{required:"City Name is required"},"Billing[LN]":{required:"Last Name is required"},"Billing[FN]":{required:"First Name is required"},"Billing[PC]":{required:"Postal Code is required"},"Billing[CVC]":{required:"Security Code is required"},"Billing[CardNumber]":{required:"Card Number is required"}},submitHandler:function(i,t){e(t)}})}),$(".fetch_account_address").change(function(){$(this).is(":checked")&&i()}),$("#SameAccountAddress").change(function(){!0===$(this).prop("checked")?$("#BillingAddressSection").hide():!1===$(this).prop("checked")&&$("#BillingAddressSection").show()}),$("input.zipcode_interactive").blur(function(){t($(this).val(),$(this).data("from"))})});