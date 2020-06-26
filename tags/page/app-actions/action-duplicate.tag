<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<tfap:tfapconfirmationmodal
	button_name="label.modal.button.yes"
	modal_title="label.modal.title.confirmation" 
	modal_Id="modal_confirm_duplicate"
	primary_btn_id="btn_confirm_duplicate"
	message="label.modal.message.confirmation.duplicate"
	callback="duplicateCallback()"/>

<tfap:modal button_name="label.bank.button"
			modal_title="label.bank.maker.approver.check" modal_Id="modal_maker_approver_duplicate_verification_id"
			show_button_close="false" show_button_primary="false">
			<br />
			<div class="modal-content">
				<div class="modal-body">
					<h4 style="text-align: center;">
You are not allowed to modify this transaction as you have previously used another role to process this transaction.</h4>
				</div>
				<div class="modal-footer" style="margin-top: -20px;">
					<button type="button" class="btn btn-outline-primary mr-1"
						id="redirect_to_main_duplicate" onclick="redirectToMainDuplicate()"
						href="${pageContext.request.contextPath}/tfApplication/list/view"
						data-dismiss="modal">
						Close
					</button>
				</div>
			</div>
</tfap:modal>

	
<script type="text/javascript">
	var appId = '';
	var docType = '';
	var urlModelName = '';
	
	function redirectToMainDuplicate(e){
		window.location.href="${pageContext.request.contextPath}/tfApplication/list/view";
	}
	
	
	function openDuplicateModal(_tfapId, _docType, _urlModelName){
		appId = _tfapId;
		docType = _docType
		urlModelName = _urlModelName;
		var makerApproverCheckflag = '${makerComApproverCheck}';
		if(makerApproverCheckflag === 'RESTRICT'){
			$('#modal_maker_approver_duplicate_verification_id').modal('show');
		}else 
			$('#modal_confirm_duplicate').modal('show');
	}
	
	function duplicateCallback(){
			$.ajax({
			    url: rootUrl + '../../'+urlModelName+'/duplicate-transaction',
			    dataType: 'json',
			    type: 'post',
			    contentType: 'application/json',
			    data: JSON.stringify({
					"tfapid":appId,
					"doc_type":docType
				}),
			    success: function( data, textStatus, jQxhr ){
					redirectUrl = data.redirect;
					redirectUrl = redirectUrl+"&isDuplicate=true";
					window.location = redirectUrl;
			    },
			    error: function( jqXhr, textStatus, errorThrown ){
			        
			    }
			});
	}
	
	

</script>