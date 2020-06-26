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
					<c:if test="${reqType eq 'Subscription'}">
						<button type="button" id="process_btn" class="btn btn-primary" title="Process">
							<i class="fa fa-check-circle"></i>&nbsp; Process
						</button>
					</c:if>
				</tfap:tfap-user-role-permission>
				
				<tfap:tfap-user-role-permission userRoles="${userRoles}"
					TFAP_COM_ADMIN="true">
					<c:if test="${reqType eq 'Link'}">
						<button type="button" id="reject_btn" class="btn btn-outline-primary" title="Reject">
							<i class="fa fa-times-circle"></i>&nbsp; Reject
						</button>
						<button type="button" id="approve_btn" class="btn btn-primary" title="Approve">
							<i class="fa fa-check-circle"></i>&nbsp; Approve
						</button>					
					</c:if>
				</tfap:tfap-user-role-permission>
	</div>
</div>

<tfap:action-prd-process/>
<tfap:action-prd-com-approve/>
<tfap:action-prd-com-reject/>


<script>
	$('#process_btn').on("click", function(e){
		openProcessingModal('${tfapId}');
	});
	
	$('#approve_btn').on("click", function(e){
		openComApproveModal('${tfapId}');
	});
	
	$('#reject_btn').on("click", function(e){
		openComRejectModal('${tfapId}');
	});
</script>
