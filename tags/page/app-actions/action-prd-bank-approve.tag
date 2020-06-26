<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modals_bank_approve"
	show_button_primary="false">
	<div class="row px-2">
		<h4 style="text-align: center;">Subscription has been approved!</h4>
	</div>
</tfap:modal>

<tfap:modal button_name="label.bank.button"
			modal_title="label.bank.maker.approver.check" modal_Id="modal_maker_approver_verification_id"
			show_button_close="false" show_button_primary="false">
			<br />
			<div class="modal-content">
				<div class="modal-body">
					<h4 style="text-align: center;">
You are not allowed to modify this transaction as you have previously used another role to process this transaction.</h4>
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

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.fail" modal_Id="modals_bank_approve_fail"
	show_button_primary="false">
	<div class="row">
		<h4 style="text-align: center;"><spring:message code="label.bankApproval.fail"/></h4>
	</div>
</tfap:modal>

<!-- Approve Cancellation Modal  -->	
<tfap:tfapconfirmationmodal
	button_name="label.modal.button.yes"
	modal_title="label.modal.title.confirmation" 
	modal_Id="modal_bank_confirm_approve_can"
	primary_btn_id="btn_confirm_approve_can"
	message="label.modal.message.confirmation.approve"
	dismiss_modal="false"
	callback="approveCancellationCallback()"/>

<script type="text/javascript">
	var appId = '';

	function redirectToMain(e){
		window.location.href="${pageContext.request.contextPath}/tfApplication/product-management/prd-approval-list/view";
	}

	
	function openBankApproveModal(_tfapId) {
		appId = _tfapId;
		
		var makerApproverCheckflag = '${makerApproverCheck}';
		if(makerApproverCheckflag === 'RESTRICT'){
			$('#modal_maker_approver_verification_id').modal('show');
		}else{
			$('#modal_bank_confirm_approve_can').modal('show');
		}
	}
	
	function approveCancellationCallback(){
    	$.get("/TFAPortal/tfApplication/state-action-prd/prd/bank/approve?tfapid=" + appId, function (data, status) {
            data = JSON.parse(data);
            redirectUrl = data.redirect;
            $('#modal_bank_confirm_approve_can').modal('hide');
			$('#modals_bank_approve').modal('show');
        });
	}

	$('#modals_bank_approve').on('hidden.bs.modal', function(e) {
		/* if (dataTable != '') {
			dataTable.draw();
		} else { */
			window.location = redirectUrl;
		/* } */
	});

</script>