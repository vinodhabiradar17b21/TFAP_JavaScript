<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@attribute name="popoverText" type="java.lang.String" required="false"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<div class="content-header-right text-right">
	<div class="btn-group" role="group"
		aria-label="Button group with nested dropdown">
				
				<tfap:tfap-user-role-permission userRoles="${userRoles}"
					TFAP_COM_MAKER="true" TFAP_COM_APPROVER="true" TFAP_COM_ADMIN="true" TFAP_ADMIN="true" 
					TFAP_BANK_MAKER="true" TFAP_BANK_APPROVER="true">
					<tfap:state-print/>
					<tfap:state-termscond/>
				</tfap:tfap-user-role-permission>
				<tfap:tfap-user-role-permission userRoles="${userRoles}" TFAP_BANK_APPROVER="true">
					
					<a href="#" id="reject_btn" class="btn btn-outline-primary" 
						data-toggle="tooltip" data-placement="bottom" title="Reject" data-original-title="Reject">
						<i class="fa fa-times-circle"></i>&nbsp; Decline
					</a>
				
					<button type="button" id="approve_btn" class="btn btn-primary" title="Approve">
						<i class="fa fa-check-circle"></i>&nbsp; Accept
					</button>
				</tfap:tfap-user-role-permission>
	</div>
</div>

<tfap:action-bank-approve/>
<tfap:action-bank-initiate-reject/>
<tfap:action-print/>
<script>
var urlModelName = "${rootUrlName}"; // To identify which controller to be hit 01.
	$('#reject_btn').on("click", function(e){

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
   						callRejectAdd();
   					  }
   					});
   				}else{
   					callRejectAdd();	
   				}
   			}
   		});	
		
	});

	function callRejectAdd(){
		var currentAppState = '${tfApplication.tfTransaction.tfTran.state}';
		openInitiateRejectModal('${tfApplication.tfTransaction.tfTran.ttfId}', '${tfApplication.tfTransaction.tfTran.msgType}','REJECTING');
	}
	
	$('#approve_btn').on("click", function(e){

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
   						initaiteApprovalAdd();
   					  }
   					});
   				}else{
   					initaiteApprovalAdd();	
   				}
   			}
   		});	
	
	});

	function initaiteApprovalAdd(){
		var currentAppState = '${tfApplication.tfTransaction.tfTran.state}';
		if(currentAppState == 'IAP'){
			openBankRejectApprovalModal('${tfApplication.tfTransaction.tfTran.ttfId}', '${tfApplication.tfTransaction.tfTran.msgType}', urlModelName);
		}
	}
	
	
</script>
