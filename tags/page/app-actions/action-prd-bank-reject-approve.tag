<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>


<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modals_bank_approve_reject"
	show_button_primary="false">
	<div class="row">
		<h4 style="text-align: center;">Subscription has been rejected!</h4>
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
				Close
			</button>
		</div>
	</div>
</tfap:modal>

<tfap:tfapconfirmationmodal
	button_name="label.modal.button.yes"
	modal_title="label.modal.title.confirmation" 
	modal_Id="modal_bank_confirm_approve_reject"
	primary_btn_id="modal_bank_confirm_approve_reject_btn"
	message="label.modal.message.confirmation.approve"
	dismiss_modal="false"
	callback="bankApproveRejectCallback()"/>


<script type="text/javascript">
	var appId = '';
	var action_approve = 'APPROVE';
	var makerApproverCheckflag = '${makerApproverCheck}';

	function redirectToMain(e){
		window.location.href="${pageContext.request.contextPath}/tfApplication/product-management/prd-approval-list/view";
	}

	function openBankRejectApprovalModal(_tfapId) {
		appId = _tfapId;
		if(makerApproverCheckflag === 'RESTRICT'){
			$('#modal_maker_approver_verification_id').modal('show');
		}else 
			$('#modal_bank_confirm_approve_reject').modal('show');
	}

	function bankApproveRejectCallback() {
		$.get("/TFAPortal/tfApplication/state-action-prd/prd/reject?tfapid=" + appId, function (data, status) {
            data = JSON.parse(data);
            redirectUrl = data.redirect;
            $('#modal_bank_confirm_approve_reject').modal('hide');
			$('#modals_bank_approve_reject').modal('show');
        });
	}

	$('#modals_bank_approve_reject').on('hidden.bs.modal', function(e) {
		/* if (dataTable != '') {
			dataTable.draw();
		} else { */
			window.location = redirectUrl;
		/* } */
	});
	
	$('#modal_bank_confirm_approve_reject_btn').on('click', function(e){
		bankApproveRejectCallback();
	})
</script>