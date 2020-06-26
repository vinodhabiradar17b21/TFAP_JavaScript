<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false"%>

<div class="content-header-right text-right">
	<div class="btn-group" role="group"
		aria-label="Button group with nested dropdown">

 		<tfap:tfap-user-role-permission userRoles="${userRoles}"
					TFAP_BANK_ONBOARDING_MAKER="true">
			<a href="javascript:void(0)" class="btn btn-outline-primary" data-toggle="tooltip"
				data-placement="bottom" title="Discard" data-original-title="Discard"
				id="discard-action-btn">
				<i class="fa fa-trash"></i>
			</a> 
 		</tfap:tfap-user-role-permission>


<%--   		<tfap:tfap-user-role-permission userRoles="${userRoles}"
 			TFAP_BANK_ONBOARDING_MAKER="true">  --%>
			<!-- <a href="javascript:void(0)" id="save-action-btn"
				class="btn btn-outline-primary" data-toggle="tooltip"
				data-placement="bottom" title="Save" data-original-title="Save"
				onclick="submit_form('save');"><i class="fa fa-floppy-o"></i></a> -->
<%-- 		</tfap:tfap-user-role-permission>		 --%>

		<tfap:state-prd-submit-bank/>
	</div>
</div>

<tfap:action-prd-discard/>
<tfap:action-prd-submit-for-auth/>

<script type="text/javascript">
	$(document).ready(function() {
		$("#discard-action-btn").click(function() {
			openPrdDiscardModal("${tfapId}");
		});

	});
</script>