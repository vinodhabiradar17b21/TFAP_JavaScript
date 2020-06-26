<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
	

					<tfap:tfapconfirmationmodal
						button_name="label.modal.button.yes"
						modal_title="label.modal.title.confirmation" 
						modal_Id="modal_confirm_discard_list"
						primary_btn_id="btn_confirm_discard_list"
						message="label.modal.message.confirmation.discard"
						callback="discardCallbackList()"/>
			

	
<script type="text/javascript">
	var appId = '';
	var docType = '';
	
	function openDiscardModalList(_tfapId, _docType){
		appId = _tfapId;
		docType = _docType
		$('#modal_confirm_discard_list').modal('show');
	}
	
	function discardCallbackList(){
		$.get("/TFAPortal/tfApplication/state-action/app/discard?tfapid=" + appId+"&doc_type="+docType, function(data, status) {
			var r = JSON.parse(data);
			if(r !== undefined && r.discard == true){
				location.href = r.redirect;
			}
			
		});
	}

</script>