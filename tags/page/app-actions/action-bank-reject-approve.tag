<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modals_bank_approve_reject"
	show_button_primary="false">
	<h4 style="text-align: center;"><spring:message code="label.modal.message.bank.success.reject"/></h4>
</tfap:modal>
<tfap:modal button_name="label.bank.button"
	modal_title="label.bank.maker.approver.check" modal_Id="modal_maker_approver_verification_id"
	show_button_close="false" show_button_primary="false">
	<br />
	<div class="modal-content">
		<div class="modal-body">
			<h4 style="text-align: center;">
You are not allowed to modify this transaction as you have previously used another role to process this transaction. </h4>
		</div>
		<div class="modal-footer" style="margin-top: -20px;">
			<button type="button" class="btn btn-outline-primary mr-1"
				id="redirect_to_main" onclick="redirectToMain()"
				href="${pageContext.request.contextPath}/tfApplication/list/view"
				data-dismiss="modal">
				Close
			</button>
		</div>
	</div>
</tfap:modal>

<%--vincent/20191119 - No need for Bank approver to enter remarks--%>
<tfap:tfapconfirmationmodal
        button_name="label.modal.button.yes"
        modal_title="label.modal.title.confirmation"
        modal_Id="modal_bank_confirm_approve_reject"
        primary_btn_id="modal_bank_confirm_approve_reject_btn"
        message="label.modal.message.confirmation.approve"
        callback="bankApproveRejectCallback()"/>
<%--<tfap:modal button_name="label.modal.button.submit"--%>
<%--	modal_title="label.modal.title.rejection.approval" modal_Id="modal_bank_confirm_approve_reject"--%>
<%--	show_button_primary="true"--%>
<%--	show_button_cancel="true"--%>
<%--	primary_btn_id="modal_bank_confirm_approve_reject_btn"--%>
<%--	modal_size="lg">--%>

<%--	<div class="row">--%>
<%--		<div class="col-12 mb-1">--%>
<%--			<label for="modal_reject_approve_remarks">Reason</label>--%>
<%--			<textarea id="modal_reject_approve_remarks" class="form-control required" rows="3" ></textarea>--%>
<%--			<span id="modal_reject_approve_remarks.errors" class="red d-none">Reason is required.</span>--%>
<%--		</div>--%>
<%--	</div>--%>
<%--</tfap:modal>--%>


<script type="text/javascript">
	$(document).ready(function() {
		$('#modal_bank_confirm_approve_reject_btn').removeAttr('data-dismiss');
	});
</script>

<script type="text/javascript">
	var appId = '';
	var docType = '';
	var dataTable = '';
	var action_approve = 'APPROVE';
	var makerApproverCheckflag = '${makerApproverCheck}';

	function redirectToMain(e){
		window.location.href="${pageContext.request.contextPath}/tfApplication/list/view";
	}

	function openBankRejectApprovalModal(_tfapId, _docType ,_dataTable) {
		appId = _tfapId;
		docType = _docType;
		dataTable = (_dataTable) ? _dataTable : dataTable;
		if(makerApproverCheckflag === 'RESTRICT'){
			$('#modal_maker_approver_verification_id').modal('show');
		}else 
			$('#modal_bank_confirm_approve_reject').modal('show');
	}

	function bankApproveRejectCallback() {

		var data = new FormData();

		data.append("transactionId", appId);
		data.append("docType", docType);
		data.append("action", action_approve);
		$.ajax({
		    url: rootUrl + "/bank/reject",
		    type: 'post',
		    cache: false,
		    contentType: false,
		    processData: false,
		    data: data,
		    success: function( data, textStatus, jQxhr ){
		    	data = JSON.parse(data);
		        if(data.reject){
		        	redirectUrl = data.redirect;
		        	$('#modal_bank_confirm_approve_reject').modal('hide');
		    		$('#modals_bank_approve_reject').modal('show');
		        }
		        else if(data.errors.length > 0){
					$.each(data.errors, function(i, error){
						if(error.key == 'transactionId' || error.key == 'docType'){

						}else if(error.key == 'remarks' && error.value == false){
							$('[id="modal_reject_approve_remarks.errors"]').removeClass('d-none');
						}
					});
				}
		    },
		    error: function( jqXhr, textStatus, errorThrown ){

		    }
		});
	}

	// vincent/20191119 - This is no longer required. For bank approver to enter remarks
	function bankApproveRejectCallbackWithRemarks() {
		
		var data = new FormData();
	
		data.append("transactionId", appId);
		data.append("docType", docType);
		data.append("remarks", $('#modal_reject_approve_remarks').val());
		data.append("action", action_approve);
		/* $.each($('#modal_reject_upload_files')[0].files, function(i, file){
			data.append("files", $('#modal_reject_upload_files')[0].files[i]);
		}) */

		$.ajax({
		    url: rootUrl + "/bank/reject",
		    type: 'post',
		    cache: false,
		    contentType: false,
		    processData: false,
		    data: data,
		    beforeSend: function(){
		    	//isApproveSubmitting(true);
				$('[id="modal_reject_approve_remarks.errors"]').addClass('d-none');
		    },
		    success: function( data, textStatus, jQxhr ){
		    	data = JSON.parse(data);
		        if(data.reject){
		        	redirectUrl = data.redirect;
		        	$('#modal_bank_confirm_approve_reject').modal('hide');
		    		$('#modals_bank_approve_reject').modal('show');		    	
		        }
		        else if(data.errors.length > 0){
					$.each(data.errors, function(i, error){
						if(error.key == 'transactionId' || error.key == 'docType'){
							
						}else if(error.key == 'remarks' && error.value == false){
							$('[id="modal_reject_approve_remarks.errors"]').removeClass('d-none');			
						}
					});
				}
		    },
		    error: function( jqXhr, textStatus, errorThrown ){
		        
		    }
		});
	}

	$('#modals_bank_approve_reject').on('hidden.bs.modal', function(e) {
		if (dataTable != '') {
			dataTable.draw();
		} else {
			window.location = redirectUrl;
		}
	});
	
	$('#modal_bank_confirm_approve_reject').on('hidden.bs.modal', function(e) {
		$('#modal_bank_confirm_approve_reject input').val('').change();
		$('#modal_bank_confirm_approve_reject textarea').val('').change();
	});
	
	$('#modal_bank_confirm_approve_reject_btn').on('click', function(e){
		bankApproveRejectCallback();
	})
	
	function isApproveSubmitting(state){
		if(state){
			$('#modal_bank_confirm_approve_reject_btn').attr('disabled', 'disabled');
		}else{
			$('#modal_bank_confirm_approve_reject_btn').removeAttr('disabled');
		}
	}
</script>