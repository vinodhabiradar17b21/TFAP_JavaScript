<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@attribute name="popoverText" type="java.lang.String" required="false"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<div class="content-header-right text-right">
	<div class="btn-group" role="group"
		aria-label="Button group with nested dropdown">
		<tfap:tfap-user-role-permission userRoles="${userRoles}"
			TFAP_BANK_ONBOARDING_MAKER="true">		
			<a href="#" id="initiate_reject_btn" class="btn btn-outline-primary" 
				data-toggle="tooltip" data-placement="bottom" title="Reject" data-original-title="Reject">
				<i class="fa fa-times-circle"></i>&nbsp; Initiate Rejection
			</a>
				<button type="button" id="initiate_approve_btn" class="btn btn-primary" title="Approve">
				<i class="fa fa-check-circle"></i>&nbsp; Initiate Approve
			</button> 
		</tfap:tfap-user-role-permission>
	</div>
</div>

<tfap:action-prd-bank-initiate-approval/>
<tfap:action-prd-bank-initiate-reject/>

<script>
var urlModelName = "${rootUrlName}"; // To identify which controller to be hit.
	
	$('#initiate_reject_btn').on("click", function(e){
		openInitiateRejectModal('${tfapId}','INITIATE REJ');
	});
	
	$('#initiate_approve_btn').on("click", function(e){
		openBankApproveModal('${tfapId}');
	});

</script>
