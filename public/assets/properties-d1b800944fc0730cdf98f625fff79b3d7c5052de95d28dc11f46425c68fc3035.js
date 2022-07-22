$(document).ready(function(){function e(e){e.preventDefault();const r=$("#propertyCity").val(),t=$("#propertySAL1").val(),o=$("#propertySAL2").val(),a=$("#propertyState").val(),p=$("#propertyTSAL1").val(),n=$("#propertyTSAL2").val(),d=$("#PropertyUserID").val(),i=$("#propertyTNCity").val(),l=$("#propertyTNState").val(),c=$("#propertyBedroomA").val(),s=$("#propertyBedroomB").val(),y=$("#propertyPostalCode").val(),u=$("#propertyPropertyType").val(),_=$("#propertyTNPostalCode").val(),v=$("#propertyNewTenantName").val(),C=$("#propertyNewTenantPhone").val(),q=$("#propertyNewTenantEmail").val(),L=$("#propertyNewLeaseEndDate").val(),f=$(".currently-leased:checked").val(),m=$("#propertyNewLeaseStartDate").val(),h=$(".asked-for-property:checked").val(),T=$("#propertyLandlordContactName").val(),N=$("#propertyLandlordContactPhone").val(),S=$("#propertyLandlordContactEmail").val(),P=!!$("#propertyLandlordInfo").is(":checked");return $.ajax({url:"/properties",type:"POST",data:{property:{city:r,state:a,user_id:d,bed_one:c,bed_two:s,postal_code:y,property_type:u,saved_landlord:P,address_line_one:t,address_line_two:o,currently_leased:f,tenant_notice_city:i,tenant_notice_state:l,property_for_notice:h,landlord_contact_name:T,landlord_contact_phone:N,landlord_contact_email:S,tenant_notice_postal_code:_,tenant_notice_street_line_one:p,tenant_notice_street_line_two:n},tenant:{name:v,email:q,phone_number:C,lease_end_date:L,lease_start_date:m}},success:function(){},error:function(){}}),!1}function r(e){const r=$("#propertyLandlordContactName"),t=$("#propertyLandlordContactPhone"),o=$("#propertyLandlordContactEmail");$.ajax({url:"/properties/fetch_landlord",type:"GET",data:{property:{saved_landlord:e}},success:function(e){!0===e.success?(r.prop("disabled",!0).attr("value",e.user.name),t.prop("disabled",!0).attr("value",e.user.phone),o.prop("disabled",!0).attr("value",e.user.email)):e.success},error:function(){}})}function t(e,r){$.ajax({url:"/properties/get_zip_data/"+e,type:"GET",data:{},success:function(e){"tenant_notice"===r?($("#propertyTNCity").attr("value",e.object.city),$("#propertyTNState").attr("value",e.object.state)):($("#propertyCity").attr("value",e.object.city),$("#propertyState").attr("value",e.object.state))},error:function(){}})}$(function(){$("form[name='property_form']").validate({rules:{"property[City]":{required:!0},"property[SAL1]":{required:!0},"property[State]":{required:!0},"property[TSAL1]":{required:!0},"property[TNCity]":{required:!0},"property[TNState]":{required:!0},"property[PostalCode]":{required:!0},"property[TNPostalCode]":{required:!0},"property[property_type]":{required:!0},"property[LandlordContactName]":{required:!0},"property[LandlordContactPhone]":{required:!0},"property[LandlordContactEmail]":{required:!0}},messages:{"property[TNCity]":{required:"City is required"},"property[TNState]":{required:"State is required"},"property[State]":{required:"Please select state"},"property[City]":{required:"City name is required"},"property[TNPostalCode]":{required:"Postal Code is required"},"property[PostalCode]":{required:"Postal Code is required"},"property[property_type]":{required:"Please select property type"},"property[SAL1]":{required:"Street Address Line 1 is required"},"property[LandlordContactName]":{required:"Landlord Contact Name is required"},"property[LandlordContactEmail]":{required:"Landlord Contact Email is required"},"property[LandlordContactPhone]":{required:"Landlord Contact Phone is required"},"property[TSAL1]":{required:"Tenant Notice Address Street Line 1 is required"}},submitHandler:function(r,t){e(t)}})}),$("#propertyLandlordInfo").change(function(){const e=$("#propertyLandlordInfo");if(e.is(":checked"))r("true");else if(e.not(":checked")){const e=$("#propertyLandlordContactName"),r=$("#propertyLandlordContactPhone"),t=$("#propertyLandlordContactEmail");e.prop("disabled",!1).attr("value",""),r.prop("disabled",!1).attr("value",""),t.prop("disabled",!1).attr("value","")}}),$("input.zipcode_interactive").blur(function(){t($(this).val(),$(this).data("from"))}),$(".currently-leased").change(function(){const e=$(this).val();"true"===e?$("#TenantSection").show():"false"===e&&$("#TenantSection").hide()}),$(".asked-for-property").change(function(){const e=$(this).val();"true"===e?$("#TenantNoticeSection").hide():"false"===e&&$("#TenantNoticeSection").show()})});