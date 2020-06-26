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
			TFAP_BANK_PRD_MAKER="true">
			<a href="javascript:void(0)" id="save-action-btn"
				class="btn btn-outline-primary" data-toggle="tooltip"
				data-placement="bottom" title="Save" data-original-title="Save"
				onclick="submit_form('save');"> <i class="fa fa-floppy-o"></i>
			</a>
			<tfap:state-sub-for-review />
		</tfap:tfap-user-role-permission>
	</div>
</div>

<script type="text/javascript">

		function redirectToMain(e){
			window.location.href="/TFAPortal/tfApplication/product-management/prd-offering/list/";
		}


</script>