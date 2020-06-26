<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.title.conversion.hasrecord" modal_Id="modal_convert_error"
	show_button_primary="false">
	<h4 style="text-align: center;"><spring:message code="message.conversion.hasrecord"/><input type="text" name="convertedTfapId" id="convertedTfapId" readonly/> </h4>
</tfap:modal>
<script type="text/javascript">
function onConvertClick(_urlConvert, _tfapid){
	const jData = {
	        tfapid: _tfapid
	    }
	$.ajax({
		type : "POST",
		url : _urlConvert,
        contentType: 'application/json',
        dataType: 'json',
        data: JSON.stringify(jData),
        success: function( data ){
        	console.log(data);
        	console.log(data.data);
        	if(data.success){
            	console.log(data);
            	redirectUrl = data.redirect;
            	window.location = redirectUrl;
        	}else{
        		if(data.data=='Transport'){
            		swal("","<spring:message code='message.convert.failed'/>" ,"warning");        		
            	}else{
	        		$('#convertedTfapId').val(data.data);
	        		$('#modal_convert_error').modal('show');
            	}
        	}
        },
		error : function(err) {
			
		}
	});	
}

function onConvertClickFromList(tfapid,moduleName){
	var moduleUrl = "";
	if(moduleName == "IFEPR"){
		moduleUrl = "ifExpPre";
	}else if(moduleName == "IFIPR"){
		moduleUrl = "ifImpPre";
	}
	const jData = {
	        tfapid: tfapid
	    }
	
	$.ajax({
		type : "POST",
		url : '/TFAPortal/'+moduleUrl+'/convert',
		contentType: 'application/json',
		dataType: 'json',
		data: JSON.stringify(jData),
		success: function( data ){
        	console.log(data);
        	console.log(data.data);
        	if(data.success){
            	console.log(data);
            	redirectUrl = data.redirect;
            	window.location = redirectUrl;
        	}else{
        		if(data.data=='Transport'){
            		swal("","<spring:message code='message.convert.failed'/>" ,"warning");        		
            	}else{
	        		$('#convertedTfapId').val(data.data);
	        		$('#modal_convert_error').modal('show');
            	}
        	}
        },
		error : function(err) {
			
		}
	});	
}
</script>



