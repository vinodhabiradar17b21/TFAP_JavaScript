<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modal_auth_submitted"
	show_button_primary="false">
	<h4 style="text-align: center;">
The application has been submitted.</h4>
</tfap:modal>

<tfap:modal button_name="label.bank.button"
			modal_title="label.bank.maker.approver.check" modal_Id="modal_maker_approver_verification_id"
			show_button_close="false" show_button_primary="false">
			<br />
			<div class="modal-content">
				<div class="modal-body">
					<h4 style="text-align: center;">You are not allowed to modify this transaction as you have previously used another role to process this transaction.</h4>
				</div>
				<div class="modal-footer" style="margin-top: -20px;">
					<button type="button" class="btn btn-outline-primary mr-1"
						id="redirect_to_main" onclick="redirectToMain()"
						href="${pageContext.request.contextPath}/tfApplication/product-management/prd-approval-list/view"
						data-dismiss="modal">
						<spring:message code='label.modal.button.close' />
					</button>
				</div>
			</div>
</tfap:modal>

<tfap:tfapconfirmationmodal
	button_name="label.modal.button.yes"
	modal_title="label.modal.title.confirmation" 
	modal_Id="modal_confirm_submit"
	primary_btn_id="btn_confirm_submit"
	message="label.modal.message.confirmation.submit"
	callback="submitCallback()"/>

	
<script type="text/javascript">
	$(document).ready(function(){
		var appId = '';
	});
	
	function openSubmitModal(_tfapId){
		appId = _tfapId;
		
		var makerApproverCheck = '${makerApproverCheck}';
		if(makerApproverCheck === 'RESTRICT'){
			$('#modal_maker_approver_verification_id').modal('show');
		}else{
		 	$('#modal_confirm_submit').modal('show'); 
		}
	}
	
	function submitCallback(){
		$.get("/TFAPortal/tfApplication/state-action-prd/prd/submitauth?tfapid=" + appId, function(data, status) {
			$('#modal_auth_submitted').modal('show');
			data = JSON.parse(data);
			redirectUrl = data.redirect;
		});
	}
	
	$('#modal_auth_submitted').on('hidden.bs.modal', function (e) {
/* 		if(dataTable != ''){
			dataTable.draw();
		}else{ */
			window.location = redirectUrl;
		/* } */
	})

</script>