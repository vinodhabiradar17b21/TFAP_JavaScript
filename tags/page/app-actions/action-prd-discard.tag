<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
	

					<tfap:tfapconfirmationmodal
						button_name="label.modal.button.yes"
						modal_title="label.modal.title.confirmation" 
						modal_Id="modal_confirm_discard"
						primary_btn_id="btn_confirm_discard"
						message="label.modal.message.confirmation.discard"
						callback="discardCallback()"/>
			

	
<script type="text/javascript">
	var appId = '';
	var docType = '';
	
	function openPrdDiscardModal(_tfapId){
		appId = _tfapId;
		$('#modal_confirm_discard').modal('show');
	}
	
	function discardCallback(){
		$.get("/TFAPortal/tfApplication/state-action-prd/prd/discard?tfapid=" + appId, function(data, status) {
			data = JSON.parse(data);
			redirectUrl = data.redirect;
			window.location = redirectUrl;
		});
	}

</script>