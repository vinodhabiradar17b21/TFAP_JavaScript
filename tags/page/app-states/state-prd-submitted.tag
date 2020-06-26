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
			<button type="button" id="received_btn" class="btn btn-primary"
				title="Received">
				<i class="fa fa-check-circle"></i>&nbsp; Received
			</button>
		</tfap:tfap-user-role-permission>
	</div>
</div>

<tfap:action-prd-received/>


<script>
	$('#received_btn').on("click", function(e){
		receivedCallback('${tfapId}');
	});
</script>
