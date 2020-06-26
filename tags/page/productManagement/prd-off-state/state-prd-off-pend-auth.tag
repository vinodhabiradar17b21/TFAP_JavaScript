<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="content-header-right text-right">
	<tfap:tfap-user-role-permission userRoles="${userRoles}"
		TFAP_BANK_PRD_APPROVER="true">
		<div class="btn-group" role="group"
			aria-label="Button group with nested dropdown">
			<a class="btn btn-outline-primary" id="reject-action-btn"
				data-toggle="tooltip" data-placement="bottom"
				title="Request For Modification" data-original-title="Reject"> <i
				class="fa fa-times-circle"></i>&nbsp;
			</a>
			<button type="button" id="submitauth" class="btn btn-primary"
				title="Submit">
				<i class="fa fa-check-square-o"></i>&nbsp; Approved
			</button>
		</div>
	</tfap:tfap-user-role-permission>
</div>

<tfap:action-modification/>
<tfap:action-prd-off-approve/>
	
	
<script type="text/javascript">
	$("#reject-action-btn").on('click', function() {
		openRejectModal('${ProductOfferings.tfBnkOffer.tfboId}')
	});
	
	$(document).ready(function () {
        $("#submitauth").click(function () {
        	openApproveModal('${ProductOfferings.tfBnkOffer.tfboId}')
        });
    });
</script>
