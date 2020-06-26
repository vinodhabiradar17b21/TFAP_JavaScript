<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@attribute name="popoverText" type="java.lang.String" required="false"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<div class="content-header-right text-right">
	<div class="btn-group" role="group"
		aria-label="Button group with nested dropdown">
				
		<tfap:state-print/>	
		<tfap:state-termscond/>
	</div>
	<tfap:tfap-user-role-permission userRoles="${userRoles}" TFAP_BANK_MAKER="true" >
		<c:if test="${tfApplication.tfTransaction.tfTran.msgType ne 'IMPST' && tfApplication.tfTransaction.tfTran.msgType ne 'ISDEB' && tfApplication.tfTransaction.tfTran.msgType ne 'ISILN' && tfApplication.tfTransaction.tfTran.msgType ne 'ISOTH'}">
				<!-- <a href="#" id="reject_btn" class="btn btn-outline-primary" 
					data-toggle="tooltip" data-placement="bottom" title="Reject" data-original-title="Reject">
					<i class="fa fa-times-circle"></i>&nbsp; Reject
				</a> -->
			
				<!-- <button type="button" id="approve_btn" class="btn btn-primary" title="Approve">
					<i class="fa fa-check-circle"></i>&nbsp; Approve
				</button> -->
				
				<a href="#" id="initiate_reject_btn" class="btn btn-outline-primary" 
					data-toggle="tooltip" data-placement="bottom" title="Reject" data-original-title="Reject">
					<i class="fa fa-times-circle"></i>&nbsp; Initiate Rejection
				</a>
					<button type="button" id="initiate_approve_btn" class="btn btn-primary" title="Approve">
					<i class="fa fa-check-circle"></i>&nbsp; Initiate Approve
				</button> 
				<!-- 					<button type="button" id="initiate_reject_btn" class="btn btn-primary" title="Approve">
					<i class="fa fa-check-circle"></i>&nbsp; Initiate Rejection
				</button> -->
		</c:if>
	</tfap:tfap-user-role-permission>
</div>
<tfap:action-bank-initiate-approval/>
<tfap:action-bank-initiate-reject/>
<tfap:action-print/>

<script>
var urlModelName = "${rootUrlName}"; // To identify which controller to be hit.
	
	$('#initiate_reject_btn').on("click", function(e){
		openInitiateRejectModal('${tfApplication.tfTransaction.tfTran.ttfId}', '${tfApplication.tfTransaction.tfTran.msgType}','INITIATE REJ');
	});
	/* 
	$('#initiate_approve_btn').on("click", function(e){
		openBankApproveModal('${tfApplication.tfTransaction.tfTran.ttfId}', '${tfApplication.tfTransaction.tfTran.msgType}');
	});
 	*/
	$('#initiate_approve_btn').on("click", function(e){
		var currentAppState = '${tfApplication.tfTransaction.tfTran.state}';
		if(currentAppState == 'PRO'){
			openBankApproveModal('${tfApplication.tfTransaction.tfTran.ttfId}', '${tfApplication.tfTransaction.tfTran.msgType}', urlModelName);
		}
	});
</script>
