<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<tfap:tfapconfirmationmodal
        button_name="label.modal.button.yes"
        modal_title="label.modal.title.confirmation"
        modal_Id="modal_confirm_approval"
        primary_btn_id="btn_confirm_approval"
        message="label.modal.message.confirmation.approve"
        callback="approvalCallback()"/>
        
<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modals_bank_approve"
	show_button_primary="false">
		<h4 style="text-align: center;">You have approved this application.</h4>
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
						href="${pageContext.request.contextPath}/tfApplication/list/view"
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

<!-- Approve Amendment Modal  -->
<tfap:modal button_name="label.modal.button.submit"
	modal_title="label.modal.title.approval" modal_Id="modal_bank_confirm_approve_amd"
	show_button_primary="true"
	show_button_cancel="true"
	primary_btn_id="modal_bank_confirm_approve_amd_btn"
	modal_size="lg"
	dismiss_modal="false">

	<div class="row">
		<div class="col-12 mb-1">
			<label for="modal_approve_amd_remarks">Remarks</label>
			<textarea id="modal_approve_amd_remarks" class="form-control required" rows="3" maxlength="65535"></textarea>
			<span id="modal_approve_amd_remarks.errors" class="red d-none">Remarks is required.</span>
			<span id="modal_approve_amd_remarks.length.errors" class="red d-none">Remarks Length Exceed.</span>
		</div>

		<div class="col-6 mb-1">
			<label for="modal_approve_amd_iss_date">Instrument Issue Date</label>
			<div class="form-group">
				<div class="input-group">
					<input id="modal_approve_amd_iss_date" type="text" class="form-control required-date" placeholder="<spring:message code="placeholder.date.input"/>">
					<button type="button" class="btn bg-transparent clear-input d-none" data-clear-input="modal_approve_amd_iss_date" style="margin-left: -40px; z-index: 1051;">
						<i class="fa fa-times"></i>
					</button>
				</div>
				<div id="modal_approve_amd_iss_date_err" class="red d-none"></div>
				<span id="modal_approve_amd_iss_date.errors" class="red d-none">Instrument Issue Date is required.</span>
			</div>
		</div>

		<div class="col-6 mb-1">
			<label for="modal_approve_amd_bank_refno">Bank Ref. No.</label> 
			<input id="modal_approve_amd_bank_refno" type="text" class="form-control required" maxlength="16">
			<span id="modal_approve_amd_bank_refno.errors" class="red d-none">Bank Ref. No. is required.</span>
			<span id="modal_approve_amd_bank_refno.length.errors" class="red d-none">Bank Ref. No. Length Exceed.</span>
		</div>

		<div class="col-12 mb-1">
			<label for="modal_approve_amd_upload_swift">Upload SWIFT Message</label>
			<div class="form-control_browse">
				<input id="modal_approve_amd_upload_swift" type="file" class="form-control-file">
			</div>
			<span id="modal_approve_amd_upload_swift.errors" class="red d-none">SWIFT Message is required.</span>
			<span id="modal_approve_amd_upload_swift.size.errors" class="red d-none">Maximum allowed file size is 15MB.</span>
		</div>

		<div class="col-12 mb-1">
			<label for="modal_approve_amd_upload_files">Upload Files</label>
			<div class="form-control_browse">
				<input id="modal_approve_amd_upload_files" type="file" class="form-control-file" multiple>
			</div>
			<span id="modal_approve_amd_upload_files.errors" class="red d-none">Files are required.</span>
			<span id="modal_approve_amd_upload_files.size.errors" class="red d-none">Maximum allowed file size is 15MB.</span>
		</div>

	</div>
</tfap:modal>

<style>
.picker_2{
	z-index: 1052	
}
</style>
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
			$('#modal_confirm_approval').modal('show');
	}

	$('#modals_bank_approve').on('hidden.bs.modal', function(e) {
		window.location = redirectUrl;
	});	
	
	function approvalCallback(){
		var data = new FormData();
		initializeModalDetails(data);
		$.ajax({
			url : rootUrl + '../../'+urlModelName+"/bank/approve",
			type : 'post',
			cache : false,
		    processData: false,
		    contentType: false,
		    enctype: 'multipart/form-data',
			data : data,
			beforeSend: function(){
				
			},
			success : function(data, textStatus, jQxhr) {
				data = JSON.parse(data);
				
				if (data.approve) {
					redirectUrl = data.redirect;
					$('#modal_bank_confirm_approve_can').modal('hide');
					$('#modals_bank_approve').modal('show');
				}
			},
			error : function(jqXhr, textStatus, errorThrown) {
				
			}
		});
		
	}
	
	function initializeModalDetails(data) {
		var remark;
		var bankRefNo;
		var issueDate;
		
		data.append("transactionId", appId);
		data.append("docType", docType);
		
		if(docType == 'LCAMD' || docType == 'LCISS') {
			remark = '${tfApplication.lc.tfDocLcIssuance.tfdlcRemark}';
			bankRefNo = '${tfApplication.lc.tfDocLcIssuance.tfdlcLcRefNo}';
			issueDate = '${tfApplication.lc.tfDocLcIssuance.tfdlcLcIssueDt}';
		} 
		
		if(docType == 'SCAMD' || docType == 'SCISS') {
			remark = '${tfApplication.sblc.tfDocScIssuance.tfdscRemark}';
			bankRefNo = '${tfApplication.sblc.tfDocScIssuance.tfdscApprBankRefNo}';
			issueDate = '${tfApplication.sblc.tfDocScIssuance.tfdscInstrIssDate}';
		} 
		
		if(docType == 'BGAMD' || docType == 'BGISS') {
			remark = '${tfApplication.bg.tfDocBgIssuance.tfdbgRemark}';
			bankRefNo = '${tfApplication.bg.tfDocBgIssuance.tfdbgApprBankRefNo}';
			issueDate = '${tfApplication.bg.tfDocBgIssuance.tfdbgInstrIssDate}';
		}
		
		if(docType == 'SGISS' || docType == 'SGAWB' || docType == 'SGBOL' || docType == 'SGLOI') {
			remark = '${tfApplication.sg.tfDocSgIssuance.tfdsgRemark}';
			bankRefNo = '${tfApplication.sg.tfDocSgIssuance.tfdsgApprBankRefNo}';
			issueDate = '${tfApplication.sg.tfDocSgIssuance.tfdsgInstrIssDate}';
		} 
		$('#modal_approve_amd_remarks').val(remark);
		$('#modal_approve_amd_bank_refno').val(bankRefNo);
		$('#modal_approve_amd_iss_date').datepicker({dateFormat: 'yy-mm-dd'}).datepicker('setDate', issueDate);

		var attachments = '${tfApplication.tfTransactionAttachement.tfTranAtt}';
		<c:forEach var="rec" items="${tfApplication.tfTransactionAttachement.tfTranAtt}">
			if('${rec.TMstAttType}' == 'SWT')
			{
				var attId = '${rec.tftatAttId}';
				var fileName = '${rec.tftatOriFname}';
				if(!$("#insideswt").length)
					$('#swtfile').append('<div id="insideswt"><li class="attachment-item"><span><a href="/TFAPortal/tfApplication/attachment/download-attachment?tftId='+appId+'&attId='+attId+'">'+fileName+'</a></span><i class="fa fa-spinner fa-spin fa-lg fa-fw hidden"></i></div>');
			}
			if('${rec.TMstAttType}' == 'BTH')
			{
				var attId = '${rec.tftatAttId}';
				var fileName = '${rec.tftatOriFname}';
				if(!$("#insidebht").length)
					$('#bhtfile').append('<div id="insidebht"><li class="attachment-item"><span><a href="/TFAPortal/tfApplication/attachment/download-attachment?tftId='+appId+'&attId='+attId+'">'+fileName+'</a></span><i class="fa fa-spinner fa-spin fa-lg fa-fw hidden"></i></div>');
			}
		</c:forEach>	
	}
	
</script>