<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="content-header-right">
	<div class="btn-group float-md-right" role="group"
		aria-label="Button group with nested dropdown">
		
		<c:choose>
			<c:when test="${tfApplication.tfTransaction.tfTran.msgType eq 'IBULC' || tfApplication.tfTransaction.tfTran.msgType eq 'IBCOL' || tfApplication.tfTransaction.tfTran.msgType eq 'IBCON' || tfApplication.tfTransaction.tfTran.msgType eq 'IBLCN'}">
				<tfap:tfap-user-role-permission userRoles="${userRoles}"
					TFAP_BANK_ADMIN="true" TFAP_BANK_MAKER="true">
					<div class="btn-group float-md-right" role="group"
			aria-label="Button group with nested dropdown">
			<a class="btn btn-outline-primary" id="reject-action-btn"
				data-toggle="tooltip" data-placement="bottom" title="Request For Modification"
				data-original-title="Reject"><!-- Reject -->
				<i class="fa fa-times-circle"></i>
			</a>&nbsp;
	
			</div>
	</tfap:tfap-user-role-permission>
			</c:when>
			<c:otherwise>
				<tfap:tfap-user-role-permission userRoles="${userRoles}"
					TFAP_COM_MAKER="true" TFAP_COM_ADMIN="true" TFAP_ADMIN="true">
					<div class="btn-group float-md-right" role="group"
			aria-label="Button group with nested dropdown">
			<a class="btn btn-outline-primary" id="reject-action-btn"
				data-toggle="tooltip" data-placement="bottom" title="Request For Modification"
				data-original-title="Reject"><!-- Reject -->
				<i class="fa fa-times-circle"></i>
			</a>&nbsp;
	
			</div>
	</tfap:tfap-user-role-permission>
			</c:otherwise>
			</c:choose>
		
	<c:choose>
			<c:when test="${tfApplication.tfTransaction.tfTran.msgType eq 'IBULC' || tfApplication.tfTransaction.tfTran.msgType eq 'IBCOL' || tfApplication.tfTransaction.tfTran.msgType eq 'IBCON' || tfApplication.tfTransaction.tfTran.msgType eq 'IBLCN'}">
		<tfap:tfap-user-role-permission userRoles="${userRoles}"
		TFAP_BANK_ADMIN="true" TFAP_BANK_MAKER="true">
			<button type="button" id="submitreview" class="btn btn-primary"
				title="Submit For Authorization">
				<i class="fa fa-check-square"></i>&nbsp; Submit For Authorization
			</button>
		</tfap:tfap-user-role-permission>
		</c:when>
			<c:otherwise>
				<tfap:tfap-user-role-permission userRoles="${userRoles}"
					TFAP_COM_MAKER="true" TFAP_COM_ADMIN="true" TFAP_ADMIN="true">
					<button type="button" id="submitreview" class="btn btn-primary"
						title="Submit For Authorization">
						<i class="fa fa-check-square"></i>&nbsp; Submit For Authorization
					</button>
				</tfap:tfap-user-role-permission>
			</c:otherwise>
			</c:choose>
	</div>

	<spring:message code='label.state.bank.popover' var="popoverText"/>
	<tfap:state-submitted-bank popoverText="${popoverText}"/>
	
	

</div>


<tfap:action-reject/>
<tfap:action-submit-for-auth/>
	
<script type="text/javascript">

	$("#submitreview").on('click', function() {
		openSubmitForAuthModal(appId, '${tfApplication.tfTransaction.tfTran.msgType}')
	});
	
	$("#reject-action-btn").on('click', function() {
		openRejectModal(appId, '${tfApplication.tfTransaction.tfTran.msgType}')
	});
	
</script>