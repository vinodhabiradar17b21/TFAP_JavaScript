<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="content-header-right">	

	<div class="btn-group float-md-right" role="group"
		aria-label="Button group with nested dropdown">

		<tfap:tfap-user-role-permission userRoles="${userRoles}"
			TFAP_BANK_ONBOARDING_APPROVER="true" >
				<a class="btn btn-outline-primary" id="reject-action-btn"
			data-toggle="tooltip" data-placement="bottom" title="Request For Modification"
			data-original-title="Request For Modification">
			<i class="fa fa-times-circle"></i>&nbsp;
			</a>
		</tfap:tfap-user-role-permission>
			
		<tfap:tfap-user-role-permission userRoles="${userRoles}"
			TFAP_BANK_ONBOARDING_APPROVER="true">
			<button type="button" id="submitauth" class="btn btn-primary"
				title="Submit">
				<i class="fa fa-check-square-o"></i>&nbsp; Submit
			</button>
		</tfap:tfap-user-role-permission>
	</div>
</div>
	
<tfap:action-prd-reject/>
<tfap:action-prd-submit/>
	
	
<script type="text/javascript">
	$(document).ready(function () {
		$("#reject-action-btn").on('click', function() {
			openRejectModal("${tfapId}", "DRF");
		});
		
        $("#submitauth").click(function () {
    		openSubmitModal("${tfapId}");
        });
    });
</script>
