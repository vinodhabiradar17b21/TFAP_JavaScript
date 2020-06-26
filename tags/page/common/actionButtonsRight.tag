<%@tag description="Page Tag" pageEncoding="UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@attribute name="msgType" type="java.lang.String" required="true"%>
<%@attribute name="tranId" type="java.lang.String" required="true"%>
<%@attribute name="modelNameUrl" type="java.lang.String" required="true"%>
<%@attribute name="submitUrl" type="java.lang.String" required="false"%>
<%@attribute name="makerApproverCheck" type="java.lang.String" required="false" description="For restrictions between maker/approver"%>
<%@attribute name="status" type="java.lang.String" required="false"%>

<style>
.swal-title {
    font-weight: 400; !important;
    font-size: 15px;
}

.swal-icon:first-child {
    margin-top: 5px;
}

.swal-icon--warning__body {
    width: 2px;
    height: 21px;
    top: 10px;
    border-radius: 2px;
    margin-left: -2px;
}

.swal-icon {
    width: 80px;
    height: 54px;
    border-width: 2px;
}

.swal-icon--warning__dot {
    width: 5px;
    height: 5px;
    margin-left: -2px;
}

.swal-footer {
    padding: 0px 0px;
}

</style>

<c:set var="ctx" value="${pageContext.request.contextPath }"/>
<c:set var="modelUrl" value="${(not empty modelNameUrl) ? modelNameUrl : 'exptrlcneg'}"/>

<c:choose>
	<c:when test="${fn:contains('NEW,DRF', pageScope.status) }">
		<tfap:tfap-user-role-permission userRoles="${userRoles}" TFAP_COM_MAKER="true">
			<button type="button" id="submit_review" class="btn btn-primary"
				title="Submit For Review" onclick="submitForm('submit','${pageScope.msgType}','${pageScope.tranId }','${pageScope.submitUrl }','${pageScope.makerApproverCheck}');" >
				<i class="fa fa-check-square-o"></i>&nbsp; Submit For Authorization
			</button>
		</tfap:tfap-user-role-permission>
	</c:when>
	<c:when test="${fn:contains('PAU', pageScope.status) }">
		<tfap:tfap-user-role-permission userRoles="${userRoles}" TFAP_COM_APPROVER="true" >
			<button type="button" id="submitauth" class="btn btn-primary"
				title="Submit" onclick="submitForm('submit_bank', '${pageScope.msgType}','${pageScope.tranId }','${pageScope.submitUrl }','${pageScope.makerApproverCheck}')">
				<i class="fa fa-check-square-o"></i>&nbsp; Submit
			</button>
		</tfap:tfap-user-role-permission>
	</c:when>
	<c:when test="${fn:contains('SUB', pageScope.status) }">
		<tfap:tfap-user-role-permission userRoles="${userRoles}" TFAP_BANK_MAKER="true">
			<button type="button" id="received_btn" class="btn btn-primary" title="Received">
				<i class="fa fa-check-circle"></i>&nbsp; Received
			</button>
		</tfap:tfap-user-role-permission>
		<tfap:actionRecieval status="${pageScope.status }" msgType="${pageScope.msgType}" tranId="${pageScope.tranId }" makerApproverCheck="${pageScope.makerApproverCheck}"
		modelNameUrl="${modelNameUrl}"/>
		
	</c:when>
	<c:when test="${fn:contains('RCV', pageScope.status) }">
		<tfap:tfap-user-role-permission userRoles="${userRoles}" TFAP_BANK_MAKER="true" >
			<button type="button" id="process_btn" class="btn btn-primary" title="Process">
				<i class="fa fa-check-circle"></i>&nbsp; Process
			</button>
		</tfap:tfap-user-role-permission>	
	</c:when>
	<c:when test="${fn:contains('PRO', pageScope.status) }">
		<tfap:tfap-user-role-permission userRoles="${userRoles}" TFAP_BANK_MAKER="true" >
			<a href="#" id="initiate_reject_btn" class="btn btn-outline-primary" 
				data-toggle="tooltip" data-placement="bottom" title="Reject" data-original-title="Reject">
				<i class="fa fa-times-circle"></i>&nbsp; Initiate Rejection
			</a>
				<button type="button" id="initiate_approve_btn" class="btn btn-primary" title="Approve">
				<i class="fa fa-check-circle"></i>&nbsp; Initiate Approve
			</button> 
		</tfap:tfap-user-role-permission>
		<tfap:actionInitiateApproval status="${pageScope.status }" msgType="${pageScope.msgType}" tranId="${pageScope.tranId }" makerApproverCheck="${pageScope.makerApproverCheck}"
		modelNameUrl="${modelNameUrl}"/>
		<tfap:actionInitiateRejection status="${pageScope.status }" msgType="${pageScope.msgType}" tranId="${pageScope.tranId }"
									  makerApproverCheck="${pageScope.makerApproverCheck}" modelNameUrl="${modelNameUrl}"/>
	</c:when>
	<c:when test="${fn:contains('IRJ,IAP', pageScope.status) }">
		<tfap:tfap-user-role-permission userRoles="${userRoles}" TFAP_BANK_APPROVER="true">
			<div class="btn-group" role="group" aria-label="Button group with nested dropdown">
				<a href="#" id="reject_btn" class="btn btn-outline-primary" 
					data-toggle="tooltip" data-placement="bottom" title="Reject" data-original-title="Reject">
					<i class="fa fa-times-circle"></i>&nbsp; Decline
				</a>
			
				<button type="button" id="approve_btn" class="btn btn-primary" title="Approve">
					<i class="fa fa-check-circle"></i>&nbsp; Accept
				</button>
			</div>
			<tfap:actionBankApprove status="${pageScope.status }" msgType="${pageScope.msgType}" tranId="${pageScope.tranId }"/>
			<tfap:actionBankDecline status="${pageScope.status }" msgType="${pageScope.msgType}"
									tranId="${pageScope.tranId }"
									modelNameUrl="${modelNameUrl}"/>
		</tfap:tfap-user-role-permission>
	</c:when>
</c:choose>



<!-- MODALS -->
<div class="modal fade text-left" id="modal_confirm_agree" tabindex="-1"
	role="dialog" aria-labelledby="agreemyModalLabel17" style="display: none;"
	aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="agreemyModalLabel17">
					<spring:message code="label.modal.title.terms" />
				</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>

			<div class="modal-body" id="cancelModal">
				<div class="text_instruction">
					<strong><spring:message code="label.bankspecific.terms" /></strong><br>
					<fieldset class="checkboxsas">
						<label class="space-checkbox-radio-f"> <input type="checkbox"
							value="" id="terms-checkbox" /> I hereby agree to following terms and
							conditions presented by the bank. <a
							href="#" id="tnc_link"
							class="tnc_link" title="View Terms &amp; Conditions">View Terms
								&amp; Conditions</a>
						</label>
					</fieldset>
				</div>
			</div>
			<div class="modal-footer" style="margin-top: -20px;">
					<button type="button" class="btn btn-outline-primary mr-1"
						data-dismiss="modal">
						<spring:message code="label.modal.button.close" />
					</button>
					<button type="button" id="modal_can_primary" class="btn btn-primary" >
						<spring:message code="label.modal.button.agree" />
					</button>
			</div>
		</div>
	</div>
</div>

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modal_auth_submitted"
	show_button_primary="false">
	<h4 style="text-align: center;">
The application has been submitted.</h4>
</tfap:modal>

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modal_pau_submitted"
	show_button_primary="false">
	<h4 style="text-align: center;"><spring:message code="label.modal.success.pau.submitted"/></h4>
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
	callback="submitCallback()"/>
	
<tfap:tfapconfirmationmodal
	button_name="label.modal.button.yes"
	modal_title="label.modal.title.confirmation" 
	modal_Id="modal_confirm_submit"
	primary_btn_id="btn_confirm_submit"
	message="label.modal.message.confirmation.submit"
	callback="submitCallback()"/>

<c:if test="${fn:contains('RCV', pageScope.status) }">
	<tfap:tfapconfirmationmodal
        button_name="label.modal.button.yes"
        modal_title="label.modal.title.confirmation"
        modal_Id="modal_confirm_processing"
        primary_btn_id="btn_confirm_processing"
        message="label.modal.message.confirmation.processing"
        callback="processingCallback()"/>
</c:if>

<script type="text/javascript">

$(document).ready(function(){
	var appId = '';
	var docType = '';
	var dataTable = '';
	 $('#modal_can_primary').attr('disabled', 'disabled');
	 
	 $('#terms-checkbox').on('click', function(){
			if($(this).prop('checked')){
				$('#modal_can_primary').removeAttr('disabled');
			}else{
				$('#modal_can_primary').attr('disabled', 'disabled');
			}
	});
	 
	 if("${AUTH_SUBMIT_SUCCESS}" && "${AUTH_SUBMIT_SUCCESS}" == "false"){
		 swal('<spring:message code="label.bankInitApproval.fail"/>', "","warning").then(function() {
             window.location.href="${REDIRECT_URL}";
         });		
	 }
	
});

function submitForm(action, msgType, tfapid, url, restrictions) {
	if(action == 'submit'){

		if(restrictions === 'RESTRICT'){
			$('#modal_verification_id').modal('show');
		}else {

			//Call Ajax for checking the related tfap Id
		/*	if(msgType !=null && msgType== 'IFIPO')
				sumbitDoubleCheckFunction(tfapid, msgType, url);
			else*/
				draftSubmitFunction(tfapid, msgType, url);
			
			/* $('#editForm').attr('action', url);
			$('#editForm').submit(); */
		}
	} else if(action == 'submit_bank'){
		openSubmitModal(tfapid, msgType, restrictions);
	}
}


/*function sumbitDoubleCheckFunction(tfapid, msgType, url){
	 $.ajax({
			url: "${pageContext.request.contextPath}" +"/tfApplication/doubleCheckConfirm?tfapId="+tfapid,
			type:"POST",
			success: function(result){
				var isRecordOpen = result;
				if(isRecordOpen!=null && isRecordOpen == 'true'){
					swal({
						title: '<spring:message code="message.application.doubleconfirm.sanctiondata.subject"/>',
						icon: "warning",
						buttons: ["<spring:message code='message.record.confirm.cancel'/>","<spring:message code='message.record.confirm.ok'/>"],
						dangerMode: true,
					})
					.then(function(willDelete) {
					  if (willDelete) {
						  draftSubmitFunction(tfapid, msgType, url);
					  }
					});
				}else{
					 draftSubmitFunction(tfapid, msgType, url);
				}
			}
		});
 }*/
	

function draftSubmitFunction(tfapId, appRefType, rootUrl){
	// if(tfapId!=null && appRefType!=null && (appRefType == 'SCISS' || appRefType == 'LCISS' || appRefType == 'ECNEG')){
	 if(tfapId!=null && appRefType!=null && appRefType != 'RFGRP'){
		 $.ajax({
			url: "${pageContext.request.contextPath}" +"/exptrlcneg/validate/recordOwnStatus?tfapId="+tfapId,
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
						  $('#editForm').attr('action', rootUrl);
						  $('#editForm').submit();
					  }
					});
				}else{
					
					$("#modal_confirm_submit_for_auth").modal("show");
				}
			}
		});
	   }
	// else if(tfapId!=null && appRefType!=null && appRefType == 'RFGRP'){
	 else if(tfapId!=null && appRefType!=null && appRefType == 'RFGRP'){
		 $.ajax({
			url: "${pageContext.request.contextPath}" +"/exptrlcneg/validate/recordOwnStatus?tfapId="+tfapId,
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
						  $('#editForm').attr('action', rootUrl);
						  $('#editForm').submit();
					  }
					});
				}else{
					$('#editForm').attr('action', rootUrl);
					$('#editForm').submit();
				}
			}
		});
	   }
	/*  else{
		 $("#modal_confirm_submit_for_auth").modal("show");
	  } */
}
	 

function openSubmitModal(_tfapId, _docType, _restrictions){

	var appId = _tfapId;
	var docType = _docType;


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
						  if(_restrictions === 'RESTRICT'){
								$('#modal_maker_approver_verification_id').modal('show');
							}else {
									openAgreeTerms(appId);
							}
					  }
					});
				}else{
					if(_restrictions === 'RESTRICT'){
						$('#modal_maker_approver_verification_id').modal('show');
					}else {
							openAgreeTerms(appId);
					}
				}
			}
		});	
	
	
	
}

function openAgreeTerms(appId){
	$('#tnc_link').attr('href', '${ctx}/tfApplication/product-management/prd-sub/redirecttnc?flag=prd&id='+appId);
	$('#modal_confirm_agree').modal('show');
	$('#modal_confirm_agree #modal_can_primary').on('click', function(e){
		e.preventDefault();
		$('#modal_confirm_agree').modal('hide');
		$('#modal_confirm_submit').modal('show'); 
	});
}

function submitCallback(){

	$('#editForm').attr('action', '${pageScope.submitUrl}');
	$('#editForm').submit();
	
}

$('#received_btn').on("click", function(e){
	var currentAppState = '${pageScope.status}';
	var docType = '${pageScope.msgType}';
	if(currentAppState == 'SUB'){
		if(docType == 'IFIPR' || docType == 'IFEPR' || docType == 'IFIPO' || docType == 'IFEPO'){	
			openBankRecieveModal('${pageScope.tranId}', docType, '${modelUrl}');
		}
		else {
			receivedCallback('${pageScope.tranId}', docType);
		}
	} 
});

function receivedCallback(_tfapId, _docType) {
    var appId = _tfapId;
    var docType = _docType;

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
						    receivedCallBackAddition(appId, docType);
					  }
					});
				}else{
				    receivedCallBackAddition(appId, docType);
				}
			}
		});		

}


function receivedCallBackAddition(appId, docType){
	$.get("${ctx}/tfApplication/state-action/app/received?tfapid=" + appId + "&doc_type=" + docType, function (data, status) {
		data = JSON.parse(data);
		if(data.reject == false){
			swal("<spring:message code="error.general.stateChange.message"/>", "","warning").then(function() {
                 window.location.reload(true);
            });
		} else {
			var redirectUrl = data.redirect;
	        var redirectUrlEcneg = redirectUrl.replace("tfApplication", '${modelUrl}');
			window.location = redirectUrlEcneg;
		}
    });
}


$('#process_btn').on("click", function(e){

	var appId = "${pageScope.tranId}";
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
						  openProcessingModal('${pageScope.tranId}', '${pageScope.msgType}');
					  }
					});
				}else{
					openProcessingModal('${pageScope.tranId}', '${pageScope.msgType}');
				}
			}
		});	
});

function openProcessingModal(_tfapId, _docType, _dataTable) {
    appId = _tfapId;
    docType = _docType;
	$('#modal_confirm_processing').modal('show');
}

function processingCallback() {
	$.get("${ctx}/tfApplication/state-action/app/process?tfapid=" + appId + "&doc_type=" + docType, function (data, status) {
        data = JSON.parse(data);
        if(data.reject == false){
        	swal("<spring:message code="error.general.stateChange.message"/>", "","warning").then(function() {
                window.location.reload(true);
            });
        } else {
        	redirectUrl = data.redirect;
        }
        
        
    });
	
	$('#modal_confirm_processing').on('hidden.bs.modal', function (e) {
		var redirectUrlEcneg = redirectUrl.replace("tfApplication", '${modelUrl}');
	    window.location = redirectUrlEcneg;
		
	});
}

$('#initiate_reject_btn').on("click", function(e){
	//openInitiateRejectModal('${pageScope.tranId}', '${pageScope.msgType}','INITIATE REJ');
	const appId = "${pageScope.tranId}";
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
						  openInitiateRejectModal('${pageScope.tranId}', '${pageScope.msgType}','INITIATE REJ');
					  }
					});
				}else{
					openInitiateRejectModal('${pageScope.tranId}', '${pageScope.msgType}','INITIATE REJ');	
				}
			}
		});	
	
});

$('#initiate_approve_btn').on("click", function(e){
	var currentAppState = '${pageScope.status}';
	if(currentAppState == 'PRO'){
		//openBankApproveModal('${pageScope.tranId}', '${pageScope.msgType}', '${modelUrl}');
		
		var appId = "${pageScope.tranId}";
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
	   						openBankApproveModal('${pageScope.tranId}', '${pageScope.msgType}', '${modelUrl}');
	   					  }
	   					});
	   				}else{
	   					openBankApproveModal('${pageScope.tranId}', '${pageScope.msgType}', '${modelUrl}');	
	   				}
	   			}
	   	});	
		
	}
});

$('#reject_btn').on("click", function(e){
	var currentAppState = '${pageScope.status}';
	openInitiateRejectModal('${pageScope.tranId}', '${pageScope.msgType}','REJECTING');

	
	
});


$('#approve_btn').on("click", function(e){
	var currentAppState = '${pageScope.status}';

	if(currentAppState == 'IRJ'){
		openBankRejectApprovalModal('${pageScope.tranId}', '${pageScope.msgType}');
	}
	
	if(currentAppState == 'IAP'){
		openBankRejectApprovalModal('${pageScope.tranId}', '${pageScope.msgType}');
	}
	
});


</script>


