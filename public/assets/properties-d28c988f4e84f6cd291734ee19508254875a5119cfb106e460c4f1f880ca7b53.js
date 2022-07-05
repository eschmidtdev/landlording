$(document).ready(function(){function e(e){e.preventDefault(),o();const r=$("#propertyCity").val(),t=$("#propertySAL1").val(),p=$("#propertySAL2").val(),d=$("#propertyState").val(),n=$("#PropertyUserID").val(),l=$("#propertyBedroomA").val(),i=$("#propertyBedroomB").val(),s=$("#propertyPostalCode").val(),y=$("#propertyPropertyType").val(),c=$("#propertyNewTenantName").val(),u=$("#propertyNewTenantPhone").val(),m=$("#propertyNewTenantEmail").val(),_=$("#propertyNewLeaseEndDate").val(),v=$(".currently-leased:checked").val(),L=$("#propertyNewLeaseStartDate").val(),f=$(".asked-for-property:checked").val(),C=$("#propertyLandlordContactName").val(),q=$("#propertyLandlordContactPhone").val(),h=$("#propertyLandlordContactEmail").val(),P=!!$("#propertyLandlordInfo").is(":checked");return $.ajax({url:"/properties",type:"POST",data:{property:{city:r,state:d,user_id:n,bed_one:l,bed_two:i,postal_code:s,property_type:y,saved_landlord:P,address_line_one:t,address_line_two:p,currently_leased:v,property_for_notice:f,landlord_contact_name:C,landlord_contact_phone:q,landlord_contact_email:h},tenant:{name:c,email:m,phone_number:u,lease_end_date:_,lease_start_date:L}},success:function(e){a(e)},error:function(){}}),!1}function r(e){const r=$("#propertyLandlordContactName"),t=$("#propertyLandlordContactPhone"),o=$("#propertyLandlordContactEmail");$.ajax({url:"/properties/get_landlord",type:"GET",data:{property:{saved_landlord:e}},success:function(e){r.prop("disabled",!0).attr("value",e.user.name),t.prop("disabled",!0).attr("value",e.user.phone),o.prop("disabled",!0).attr("value",e.user.email)},error:function(){}})}function t(){$("#SavePropertyBtn").prop("disabled",!1)}function o(){$("#SavePropertyBtn").prop("disabled",!0)}function a(e){t(),$("form[name='property_form']")[0].reset(),$("html, body").animate({scrollTop:0},"slow"),$(!0===e.success?".success_alert":".error_alert").text("").show().append(e.message).delay(3e3).fadeOut(300)}$(function(){$("form[name='property_form']").validate({rules:{"property[City]":{required:!0},"property[SAL1]":{required:!0},"property[State]":{required:!0},"property[PostalCode]":{required:!0},"property[property_type]":{required:!0},"property[LandlordContactName]":{required:!0},"property[LandlordContactPhone]":{required:!0},"property[LandlordContactEmail]":{required:!0}},messages:{"property[State]":{required:"Please select state"},"property[City]":{required:"City name is required"},"property[PostalCode]":{required:"Postal Code is required"},"property[property_type]":{required:"Please select property type"},"property[LandlordContactName]":{required:"Landlord Contact Name is required"},"property[SAL1]":{required:"Street Address Line 1 is required"},"property[LandlordContactEmail]":{required:"Landlord Contact Email is required"},"property[LandlordContactPhone]":{required:"Landlord Contact Phone is required"}},submitHandler:function(r,t){e(t)}})}),$("#propertyLandlordInfo").change(function(){const e=$("#propertyLandlordInfo");if(e.is(":checked"))r("true");else if(e.not(":checked")){const e=$("#propertyLandlordContactName"),r=$("#propertyLandlordContactPhone"),t=$("#propertyLandlordContactEmail");e.prop("disabled",!1).attr("value",""),r.prop("disabled",!1).attr("value",""),t.prop("disabled",!1).attr("value","")}})});