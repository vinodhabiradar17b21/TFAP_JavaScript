<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<%@attribute name="msgType" type="java.lang.String" required="true"%>
<%@attribute name="tranId" type="java.lang.String" required="true"%>
<%@attribute name="status" type="java.lang.String" required="true"%>
<%@attribute name="makerApproverCheck" type="java.lang.String" required="false" description="For restrictions between maker/approver"%>


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
	<div class="row">
		<h4 style="text-align: center;">You have approved this application.</h4>
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
			<textarea id="modal_approve_amd_remarks" class="form-control " rows="3" maxlength="65535"></textarea>
			<span id="modal_approve_amd_remarks.errors" class="red d-none">Remarks is required.</span>
			<span id="modal_approve_amd_remarks.length.errors" class="red d-none">Remarks Length Exceed.</span>
		</div>

		<div class="col-6 mb-1">
			<label for="modal_approve_amd_iss_date">Instrument Issue Date</label>
			<div class="form-group">
				<div class="input-group">
					<input id="modal_approve_amd_iss_date" type="text" class="form-control" placeholder="<spring:message code="placeholder.date.input"/>">
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
			<input id="modal_approve_amd_bank_refno" type="text" class="form-control" maxlength="16">
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

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modal_approved"
	show_button_primary="false">
	<c:if test="${status eq 'IAP'}">
		<h4 style="text-align: center;"><spring:message code="label.modal.message.success.approve"/></h4>
	</c:if>
	<c:if test="${status eq 'IRJ'}">
		<h4 style="text-align: center;"><spring:message code="label.modal.message.success.reject"/></h4>
	</c:if>
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
	
	function openBankRejectApprovalModal(_tfapId, _docType) {
		 
		appId = _tfapId;
		docType = _docType;

		 $.ajax({
	   			url: "${pageContext.request.contextPath}/tfApplication/validate/recordOwnStatus?tfapId="+appId,
	   			type:"POST",
	   			success: function(result){
	   				var isRecordOpen = result;
	   				if(isRecordOpen!=null && isRecordOpen == 'true'){
	   					swal({
	   						title: '<spring:message code="message.record.tfaprecord.open"/>',
	   						icon: "warning",
	   						buttons: ["<spring:message code='message.record.confirm.cancel'/>","<spring:message code='message.record.confirm.ok'/>"],
	   						dangerMode: true,
	   					})
	   					.then(function(willDelete) {
	   					  if (willDelete) {
	   						openBankRejectApprovalModalAdditional(appId, docType);
	   					  }
	   					});
	   				}else{
	   					openBankRejectApprovalModalAdditional(appId, docType);	
	   				}
	   			}
	   		});	
		
	}

	function openBankRejectApprovalModalAdditional(appId, docType) {
		 
		if(makerApproverCheckflag === 'RESTRICT'){
			$('#modal_maker_approver_verification_id').modal('show');
		}else 
			$('#modal_confirm_approval').modal('show');
		
	}

	function bankApproveRejectCallback() {
		
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
	
	function approvalCallback(){
		if(docType == 'IFEXT' || '${converted}')
			{ 
				let postData = {
					tfapId: appId,
					docType: docType,
					bankInitiateApp: false
				};
				$.ajax({
					type: 'POST',
					url: '<spring:url value="/ifExt/bank/approve"/>',
					headers: {'Content-Type': 'application/json'},
					data: JSON.stringify(postData),
					success: function (data) {
						if(data.success){
							swal('<spring:message code="error.general.stateChange.message"/>', "","warning").then(function() {
				                 window.location.reload(true);
				             });
						}
						else if (data && data.makerApproverSameUser) {
							$('#modal_maker_approver_verification_id').modal('show');
						} else {
							//$('#modal_approved').modal('show');
							redirectUrl = data.redirect;
							if(data.reject != undefined && data.reject == false && redirectUrl == undefined){
								swal('<spring:message code="error.general.stateChange.message"/>', "","warning").then(function() {
					                 window.location.reload(true);
					             });
							} else {
								<c:if test="${status eq 'IAP'}">
								  swal( "<spring:message code='label.modal.message.success.approve'/>", "","success").then(function() {
						                 window.location.reload(true);
						            })
								</c:if>
							}
							
							<c:if test="${status eq 'IRJ'}">
							  swal( "<spring:message code='label.modal.message.success.reject'/>", "","success").then(function() {
					                 window.location.reload(true);
					            })
							</c:if>
							
						}
					}
				});
		} else {
			$.get("/TFAPortal/tfApplication/state-action/app/bank/approve?tfapid=" + appId+"&doc_type="+docType+"&bankInitiateApp=false", function(data, status) {
				data = JSON.parse(data);
				if(data.reject != undefined && data.reject == false ){
					swal('<spring:message code="error.general.stateChange.message"/>', "","warning").then(function() {
		                 window.location.reload(true);
		             });
				}
				else if (data && data.makerApproverSameUser) {
					$('#modal_maker_approver_verification_id').modal('show');
				} else {
					//$('#modal_approved').modal('show');
					redirectUrl = data.redirect;
					if(data.reject != undefined && data.reject == false && redirectUrl == undefined){
						swal('<spring:message code="error.general.stateChange.message"/>', "","warning").then(function() {
			                 window.location.reload(true);
			             });
					} else {
						<c:if test="${status eq 'IAP'}">
						  swal( "<spring:message code='label.modal.message.success.approve'/>", "","success").then(function() {
							  var redirectUrlEcneg = redirectUrl.replace("tfApplication", "exptrlcneg"); 
								window.location = redirectUrlEcneg;
				            })
						</c:if>
					}
					
					<c:if test="${status eq 'IRJ'}">
					  swal( "<spring:message code='label.modal.message.success.reject'/>", "","success").then(function() {
						  var redirectUrlEcneg = redirectUrl.replace("tfApplication", "exptrlcneg"); 
							window.location = redirectUrlEcneg;
			            })
					</c:if>
					
				}
			});
		}
	}
	
	$('#modal_approved').on('hidden.bs.modal', function (e) {
			var redirectUrlEcneg = redirectUrl.replace("tfApplication", "exptrlcneg"); 
			window.location = redirectUrlEcneg;
	});
</script>