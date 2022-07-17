$(document).ready(function(){function e(e){e.preventDefault(),o();const r=$("#propertyCity").val(),t=$("#propertySAL1").val(),a=$("#propertySAL2").val(),p=$("#propertyState").val(),n=$("#PropertyUserID").val(),d=$("#propertyBedroomA").val(),l=$("#propertyBedroomB").val(),i=$("#propertyPostalCode").val(),c=$("#propertyPropertyType").val(),s=$("#propertyNewTenantName").val(),y=$("#propertyNewTenantPhone").val(),u=$("#propertyNewTenantEmail").val(),v=$("#propertyNewLeaseEndDate").val(),_=$(".currently-leased:checked").val(),m=$("#propertyNewLeaseStartDate").val(),f=$(".asked-for-property:checked").val(),L=$("#propertyLandlordContactName").val(),C=$("#propertyLandlordContactPhone").val(),h=$("#propertyLandlordContactEmail").val(),q=!!$("#propertyLandlordInfo").is(":checked");return $.ajax({url:"/properties",type:"POST",data:{property:{city:r,state:p,user_id:n,bed_one:d,bed_two:l,postal_code:i,property_type:c,saved_landlord:q,address_line_one:t,address_line_two:a,currently_leased:_,property_for_notice:f,landlord_contact_name:L,landlord_contact_phone:C,landlord_contact_email:h},tenant:{name:s,email:u,phone_number:y,lease_end_date:v,lease_start_date:m}},success:function(){},error:function(){}}),!1}function r(e){const r=$("#propertyLandlordContactName"),t=$("#propertyLandlordContactPhone"),o=$("#propertyLandlordContactEmail");$.ajax({url:"/properties/fetch_landlord",type:"GET",data:{property:{saved_landlord:e}},success:function(e){!0===e.success?(r.prop("disabled",!0).attr("value",e.user.name),t.prop("disabled",!0).attr("value",e.user.phone),o.prop("disabled",!0).attr("value",e.user.email)):!1===e.success&&response_handler(e)},error:function(){}})}function t(e){$.ajax({url:"/properties/get_zip_data/"+e,type:"GET",data:{},success:function(e){$("#propertyCity").attr("value",e.object.city),$("#propertyState").attr("value",e.object.state)},error:function(){}})}function o(){$("#SavePropertyBtn").prop("disabled",!0)}$(function(){$("form[name='property_form']").validate({rules:{"property[City]":{required:!0},"property[SAL1]":{required:!0},"property[State]":{required:!0},"property[PostalCode]":{required:!0},"property[property_type]":{required:!0},"property[LandlordContactName]":{required:!0},"property[LandlordContactPhone]":{required:!0},"property[LandlordContactEmail]":{required:!0}},messages:{"property[State]":{required:"Please select state"},"property[City]":{required:"City name is required"},"property[PostalCode]":{required:"Postal Code is required"},"property[property_type]":{required:"Please select property type"},"property[LandlordContactName]":{required:"Landlord Contact Name is required"},"property[SAL1]":{required:"Street Address Line 1 is required"},"property[LandlordContactEmail]":{required:"Landlord Contact Email is required"},"property[LandlordContactPhone]":{required:"Landlord Contact Phone is required"}},submitHandler:function(r,t){e(t)}})}),$("#propertyLandlordInfo").change(function(){const e=$("#propertyLandlordInfo");if(e.is(":checked"))r("true");else if(e.not(":checked")){const e=$("#propertyLandlordContactName"),r=$("#propertyLandlordContactPhone"),t=$("#propertyLandlordContactEmail");e.prop("disabled",!1).attr("value",""),r.prop("disabled",!1).attr("value",""),t.prop("disabled",!1).attr("value","")}}),$("input.zipcode_interactive").blur(function(){t($(this).val())}),$(".currently-leased").change(function(){const e=$(this).val();"true"===e?$("#TenantSection").show():"false"===e&&$("#TenantSection").hide()})});