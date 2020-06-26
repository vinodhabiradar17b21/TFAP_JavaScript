<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modal_rev_submitted"
	show_button_primary="false">
		<h4 style="text-align: center;">The application has been
			submitted for authorization!</h4>
</tfap:modal>

<tfap:modal button_name="label.bank.button"
			modal_title="label.bank.maker.approver.check" modal_Id="modal_maker_approver_verification_id"
			show_button_close="false" show_button_primary="false">
			<br />
			<div class="modal-content">
				<div class="modal-body">
					<h4 style="text-align: center;"><spring:message code="modal.checker.maker.restrict.message"/></h4>
				</div>
				<div class="modal-footer" style="margin-top: -20px;">
					<button type="button" class="btn btn-outline-primary mr-1"
						id="redirect_to_main" onclick="redirectToMain()"
						href="${pageContext.request.contextPath}/tfApplication/list/view"
						data-dismiss="modal">
						<spring:message code='label.modal.button.close' />
					</button>
				</div>
			</div>
</tfap:modal>

<tfap:tfapconfirmationmodal
	button_name="label.modal.button.yes"
	modal_title="label.modal.title.confirmation" 
	modal_Id="modal_confirm_submit_for_auth"
	primary_btn_id="btn_confirm_submit_for_auth"
	message="label.modal.message.confirmation.submit.for.auth"
	callback="submitForAuthCallback()"/>
	
<script type="text/javascript">
	var appId = '';
	var docType = '';
	var dataTable = '';
	
	function openSubmitForAuthModal(_tfapId, _docType, _dataTable){
		appId = _tfapId;
		docType = _docType;
		dataTable = (_dataTable)? _dataTable:dataTable;
		var makerComApproverCheck = '${makerComApproverCheck}';
		if(makerComApproverCheck === 'RESTRICT'){
			$('#modal_maker_approver_verification_id').modal('show');
		}else
			$('#modal_confirm_submit_for_auth').modal('show');
	}
	
	function redirectToMain(e){
		window.location.href="${pageContext.request.contextPath}/tfApplication/list/view";
	}
	
	function submitForAuthCallback(){
		$.get("/TFAPortal/tfApplication/state-action/app/submitreview?tfapid=" + appId+"&doc_type="+docType, function(data, status) {
			$('#modal_rev_submitted').modal('show');
			data = JSON.parse(data);
			redirectUrl = data.redirect;
		});
	}
	
	$('#modal_rev_submitted').on('hidden.bs.modal', function (e) {
		if(dataTable != ''){
			dataTable.draw();
		}else{
			window.location = redirectUrl;
		}
	})

</script>