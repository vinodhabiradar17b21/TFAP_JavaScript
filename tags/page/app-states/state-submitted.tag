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
	</div>
	
	<tfap:tfap-user-role-permission userRoles="${userRoles}"
			TFAP_COM_MAKER="true" 
			TFAP_COM_APPROVER="true"
			TFAP_COM_ADMIN="true"
			TFAP_ADMIN="true">
			<tfap:state-submitted-bank/>
		</tfap:tfap-user-role-permission>

		<c:choose>
			<c:when test="${tfApplication.tfTransaction.tfTran.msgType eq 'IBULC' || tfApplication.tfTransaction.tfTran.msgType eq 'IBCOL' || tfApplication.tfTransaction.tfTran.msgType eq 'IBCON' || tfApplication.tfTransaction.tfTran.msgType eq 'IBLCN'}">
			</c:when>
			<c:otherwise>
				<tfap:tfap-user-role-permission userRoles="${userRoles}"
					TFAP_BANK_MAKER="true">

					<button type="button" id="received_btn" class="btn btn-primary"
						title="Received">
						<i class="fa fa-check-circle"></i>&nbsp; Received
					</button>
				</tfap:tfap-user-role-permission>
			</c:otherwise>
		</c:choose>
</div>

<tfap:action-received/>
<tfap:action-print/>

<script>
	
	$('#received_btn').on("click", function(e){
		receivedCallback('${tfApplication.tfTransaction.tfTran.ttfId}', '${tfApplication.tfTransaction.tfTran.msgType}');
	});
	
</script>
