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
<tfap:action-bank-initiate-reject/>
<tfap:action-bank-reject-approve/>
<tfap:action-print/>

<script>
var urlModelName = "${rootUrlName}"; // To identify which controller to be hit.
	$('#reject_btn').on("click", function(e){
		var currentAppState = '${tfApplication.tfTransaction.tfTran.state}';
		openInitiateRejectModal('${tfApplication.tfTransaction.tfTran.ttfId}', '${tfApplication.tfTransaction.tfTran.msgType}','REJECTING');
	});
	
	$('#approve_btn').on("click", function(e){
		openBankRejectApprovalModal('${tfApplication.tfTransaction.tfTran.ttfId}', '${tfApplication.tfTransaction.tfTran.msgType}');
	});
	
</script>
