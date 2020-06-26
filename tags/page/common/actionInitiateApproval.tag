<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@attribute name="modelNameUrl" type="java.lang.String" required="true"%>
<%@attribute name="msgType" type="java.lang.String" required="true"%>
<%@attribute name="tranId" type="java.lang.String" required="true"%>
<%@attribute name="status" type="java.lang.String" required="true"%>
<%@attribute name="makerApproverCheck" type="java.lang.String" required="false" description="For restrictions between maker/approver"%>

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modals_bank_approve"
	show_button_primary="false">
	<div class="row">
		<h4 style="text-align: center;">The application has been initiated for approval.</h4>
	</div>
</tfap:modal>

<tfap:modal button_name="label.bank.button"
			modal_title="label.bank.maker.approver.check" modal_Id="modal_maker_approver_reject_verification_id"
			show_button_close="false" show_button_primary="false">
			<br />
			<div class="modal-content">
				<div class="modal-body">
					<h4 style="text-align: center;">You have Initiated Rejection/Approved for this application. As the approver, you are not allowed to Initiate Reject/Approve your own application.</h4>
				</div>
				<div class="modal-footer" style="margin-top: -20px;">
					<button type="button" class="btn btn-outline-primary mr-1"
						id="redirect_to_main_reject" onclick="redirectToMainReject()"
						href="${pageContext.request.contextPath}/tfApplication/list/view"
						data-dismiss="modal">
						<spring:message code='label.modal.button.close' />
					</button>
				</div>
			</div>
</tfap:modal>

<tfap:modal button_name="label.bank.button"
			modal_title="label.bank.maker.approver.check" modal_Id="modal_maker_approver_verification_id"
			show_button_close="false" show_button_primary="false">
			<br />
			<div class="modal-content">
				<div class="modal-body">
					<h4 style="text-align: center;">You have Initiated Approval/Approved for this application. As the approver, you are not allowed to Initiate Approve/Approve your own application.</h4>
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
<div class="modal fade text-left" id="modal_approval" tabindex="-1"
	 role="dialog" aria-labelledby="modals_initiate_approval"
	 aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-lg" role="document">
		<%-- modalApprovalForm.jsp --%>
		<div id="modal_approval_content"></div>
	</div>
</div>

<style>
.picker_2{
	z-index: 1052	
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$('#modal_bank_confirm_approve_amd_btn').removeAttr('data-dismiss');
		$('#modal_bank_confirm_approve_amd_btn').removeAttr('data-dismiss');
	});
</script>

<script type="text/javascript">
	var appId = '';
	var docType = '';
	var dataTable = '';
	var urlModelName = '';

	function redirectToMain(e){
		window.location.href="${pageContext.request.contextPath}/tfApplication/list/view";
	}

	
	function openBankApproveModal(_tfapId, _docType, _urlModelName, _dataTable) {
		appId = _tfapId;
		docType = _docType;
		urlModelName = _urlModelName;
		dataTable = (_dataTable) ? _dataTable : dataTable;
		var makerApproverCheckflag = '${pageScope.makerApproverCheck}';
		initializeModalDetails();
		if(makerApproverCheckflag === 'RESTRICT'){
			$('#modal_maker_approver_verification_id').modal('show');
		}else if(docType == 'ECNEG'  || docType == 'LCAMD' || docType == 'LCISS' || docType == 'BGAMD' ||
				docType == 'BGISS' || docType == 'SCAMD' || docType == 'SCISS' || 
				docType == 'SGISS' || docType == 'SGAWB' || docType == 'SGBOL' || docType == 'SGLOI' ||
				docType == 'RFGRP' || docType == 'RFSUB' || docType == 'RFDRW' || docType == 'RFSDR' ||
				docType == 'IFIPR' || docType == 'IFEPR' || docType == 'IFIPO' || docType == 'IFEPO' ||
				docType == 'IFEXT'){
			let postData = {
				tfapId: _tfapId,
				docType: _docType,
				urlModelName: _urlModelName
			};
			$.ajax({
				type: 'POST',
				url: '<spring:url value="/${modelNameUrl}/initiateApproval/modal/show"/>',
				headers: {'Content-Type': 'application/json'},
				data: JSON.stringify(postData),
				success: function (data) {
					$('#modal_approval_content').html(data);
					$('#modal_approval').modal('show');
				}
			});
		}else if(docType == 'LCCAN' || docType == 'BGCAN' || docType == 'SCCAN'){
			$('#modal_bank_confirm_approve_can').modal('show');
		}else{
			$('#modal_bank_confirm_approve_can').modal('show');
		}
	}
	
	function initializeModalDetails() {
		var data = new FormData();
		var remark;
		var bankRefNo;
		var issueDate;
		
		data.append("transactionId", appId);
		data.append("docType", docType);
		

		$('#modal_approve_amd_remarks').val(remark);
		$('#modal_approve_amd_bank_refno').val(bankRefNo);
		$('#modal_approve_amd_iss_date').datepicker({dateFormat: 'yy-mm-dd'}).datepicker('setDate', issueDate);
	}
	
	function isSubmitting(state){
		if(state){
			$('#modal_bank_confirm_approve_amd_btn').attr('disabled', 'disabled');
		}else{
			$('#modal_bank_confirm_approve_amd_btn').removeAttr('disabled');
		}
	}
	
	function bankApproveAmendCallback() {
		
		var data = new FormData();

		data.append("transactionId", appId);
		data.append("docType", docType);
		data.append("remarks", $('#modal_approve_amd_remarks').val());
		data.append("issueDate", $('#modal_approve_amd_iss_date').val());
		data.append("bankRefNo", $('#modal_approve_amd_bank_refno').val());
		
		if($("#insideswt").length){
			data.append("swtfileAlreadyExist", true);
        }
		if($("#insidebht").length){
			data.append("bhtfileAlreadyExist", true);
        }
		
		$.each($('#modal_approve_amd_upload_swift')[0].files, function(i, file){
			data.append("swiftFiles", $('#modal_approve_amd_upload_swift')[0].files[i]);
		})
		$.each($('#modal_approve_amd_upload_files')[0].files, function(i, file){
			data.append("files", $('#modal_approve_amd_upload_files')[0].files[i]);
		})		
			
		$.ajax({
			url : '${pageContext.request.contextPath}/'+urlModelName+"/bank/initapprove",
			type : 'post',
			cache : false,
		    processData: false,
		    contentType: false,
		    enctype: 'multipart/form-data',
			data : data,
			beforeSend: function(){
				isSubmitting(true);
				$('[id="modal_approve_amd_remarks.errors"]').addClass('d-none');			
				$('[id="modal_approve_amd_iss_date.errors"]').addClass('d-none');	
				$('[id="modal_approve_amd_bank_refno.errors"]').addClass('d-none');
				$('[id="modal_approve_amd_upload_swift.errors"]').addClass('d-none');
				$('[id="modal_approve_amd_upload_files.errors"]').addClass('d-none');
				$('[id="modal_approve_amd_remarks.length.errors"]').addClass('d-none');
				$('[id="modal_approve_amd_bank_refno.length.errors"]').addClass('d-none');
			},
			success : function(data, textStatus, jQxhr) {				
				data = JSON.parse(data);
				
				if (data.initapprove) {
					redirectUrl = data.redirect;
					$('#modal_bank_confirm_approve_amd').modal('hide');
					$('#modals_bank_approve').modal('show');
				}else if(data.errors.length > 0){
					$.each(data.errors, function(i, error){
						if(error.key == 'transactionId' || error.key == 'docType'){
							
						}else if(error.key == 'remarks' && error.value == false){
							$('[id="modal_approve_amd_remarks.errors"]').removeClass('d-none');			
						}else if(error.key == 'issueDate'){
							$('[id="modal_approve_amd_iss_date.errors"]').removeClass('d-none');
						}else if(error.key == 'instrExpDt'){
							$('[id="modal_approve_amd_exp_date.errors"]').addClass('d-none');	
						}else if(error.key == 'bankRefNo' && error.value == false){
							$('[id="modal_approve_amd_bank_refno.errors"]').removeClass('d-none');
						}else if(error.key == 'swiftFiles'){
							$('[id="modal_approve_amd_upload_swift.errors"]').removeClass('d-none');
						}else if(error.key == 'files'){
							$('[id="modal_approve_amd_upload_files.errors"]').removeClass('d-none');
						}else if(error.key == 'remarks' && error.value == 'length'){
							$('[id="modal_approve_amd_remarks.length.errors"]').removeClass('d-none');			
						}else if(error.key == 'bankRefNo' && error.value == 'length'){
							$('[id="modal_approve_amd_bank_refno.length.errors"]').removeClass('d-none');
						}
						else if (error.key == 'internalServerError' && error.value == false) {
							$('#modal_bank_confirm_approve_amd').modal('hide');
							$('#modals_bank_approve_fail').modal('show');
						}
					});
				}
			},
			error : function(jqXhr, textStatus, errorThrown) {
				
			},
			complete : function(){
				isSubmitting(false);
			}
		});
	}

	$('#modals_bank_approve').on('hidden.bs.modal', function(e) {
		if (dataTable != '') {
			dataTable.draw();
		} else {
			window.location = redirectUrl;
		}
	});

	$('#modal_bank_confirm_approve_amd').on('hidden.bs.modal', function(e) {
		$('#modal_approve_amd_remarks').val('').change();
		$('#modal_bank_confirm_approve_amd input').val('').change();
		$('#modal_bank_confirm_approve_amd textarea').val('').change();
	});

	$('#modal_bank_confirm_approve_amd_btn').on('click', function(e) {
		var remarks = $("#modal_approve_amd_remarks").val();
		var issDate = $("#modal_approve_amd_iss_date").val();
		var bankRefNo = $("#modal_approve_amd_bank_refno").val();
		
		var proceed = true;
		if(remarks == undefined || remarks == ''){
			proceed = false;
			$('[id="modal_approve_amd_remarks.errors"]').removeClass('d-none');
		}
		
		if(issDate == undefined || issDate == ''){
			proceed = false;
			$('[id="modal_approve_amd_iss_date.errors"]').removeClass('d-none');
		}
		
		if(bankRefNo == undefined || bankRefNo == ''){
			proceed = false;
			$('[id="modal_approve_amd_bank_refno.errors"]').removeClass('d-none');
		}
		
		if(proceed == true){
			bankApproveAmendCallback();
		}
		
		
	});
	
</script>


<script>
	function approveCancellationCallback(){
		$.get("${pageContext.request.contextPath }/tfApplication/state-action/app/bank/iniapproval?tfapid=${pageScope.tranId}&doc_type=${pageScope.msgType}", function(data, status) {
			$('#modals_bank_approve').modal('show');
			$('#modal_bank_confirm_approve_can').modal('hide');
			data = JSON.parse(data);
			redirectUrl = data.redirect;
		});
	}

	$('#modals_bank_approve').on('hidden.bs.modal', function (e) {
		var redirectUrlEcneg = redirectUrl.replace("tfApplication", "exptrlcneg"); 
	    window.location = redirectUrlEcneg;
	});
	

</script>

<script>
$(document).ready(function() {
	$('#modal_approve_amd_upload_swift').bind('change', function() {
		  if(this.files[0].size>15728640){
			  $('[id="modal_approve_amd_upload_swift.size.errors"]').removeClass('d-none');
			  $('#modal_approve_amd_upload_swift').val('');
		  }
		});
	
	$('#modal_approve_amd_upload_files').bind('change', function() {
		  if(this.files[0].size>15728640){
			  $('[id="modal_approve_amd_upload_files.size.errors"]').removeClass('d-none');
			  $('#modal_approve_amd_upload_files').val('');
		  }
		});
});

</script>
<script>

function openBankRejectApprovalModal(_tfapId, _docType ,_dataTable) {
	var appId = _tfapId;
	var docType = _docType;
	var dataTable = (_dataTable) ? _dataTable : dataTable;
	var makerApproverCheckflag = '${pageScope.makerApproverCheck}';
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
		var redirectUrlEcneg = redirectUrl.replace("tfApplication", "exptrlcneg"); 
		window.location = redirectUrlEcneg;
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
	$.get("/TFAPortal/tfApplication/state-action/app/bank/approve?tfapid=" + appId+"&doc_type="+docType+"&bankInitiateApp=true", function(data, status) {
		//$('#modal_approved').modal('show');
		data = JSON.parse(data);
		redirectUrl = data.redirect;
		<c:if test="${status eq 'IAP'}">
		  swal( "<spring:message code="label.modal.message.success.approve"/>", "","success").then(function() {
              window.location = redirectUrl;
          })
	</c:if>
	<c:if test="${status eq 'IRJ'}">
	  swal( "<spring:message code="label.modal.message.success.reject"/>", "","success").then(function() {
          window.location = redirectUrl;
      })
	</c:if>
	});
}

$('#modal_approved').on('hidden.bs.modal', function (e) {
		var redirectUrlEcneg = redirectUrl.replace("tfApplication", "exptrlcneg"); 
		window.location = redirectUrlEcneg;
});
</script>