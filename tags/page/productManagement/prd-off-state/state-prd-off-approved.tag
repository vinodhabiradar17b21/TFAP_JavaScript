<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@attribute name="popoverText" type="java.lang.String" required="false"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<div class="content-header-right text-right">
	<div class="btn-group" role="group"
		aria-label="Button group with nested dropdown">

		<tfap:tfap-user-role-permission userRoles="${userRoles}"
			TFAP_BANK_PRD_MAKER="true">
			<a href="#" id="amend_btn" class="btn btn-outline-primary"
				data-toggle="tooltip" data-placement="bottom" title="Modify"
				data-original-title="Amend"> <i class="fa fa-pencil-square-o"></i>
			</a>
		</tfap:tfap-user-role-permission>

		<tfap:tfap-user-role-permission userRoles="${userRoles}"
			TFAP_BANK_PRD_APPROVER="true">
			<button type="button" id="inactivate_btn" class="btn btn-primary"
				title="Inactivate">
				<i class="fa fa-times-circle"></i>&nbsp; InActivate
			</button>
		</tfap:tfap-user-role-permission>
	</div>
</div>

<%-- <tfap:action-amend/>
<tfap:action-cancel/>
<tfap:action-bank-reject/> --%>
<tfap:action-prd-inactivate />

<tfap:action-prd-modify/>

<script>
	$('#inactivate_btn').on("click", function(e) {
		openInactivateModal('${ProductOfferings.tfBnkOffer.tfboId}');
	});
	
	$('#amend_btn').on("click", function(e) {
		openModifyModal('${ProductOfferings.tfBnkOffer.tfboId}');
	});
</script>
