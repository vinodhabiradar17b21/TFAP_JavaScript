<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@attribute name="popoverText" type="java.lang.String" required="false"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="content-header-right text-right">
	<div class="btn-group" role="group"
		aria-label="Button group with nested dropdown">

		<tfap:state-print/>
		<tfap:state-termscond/>

		<c:if test="${tfApplication.tfTransaction.tfTran.msgType == 'LCISS' || tfApplication.tfTransaction.tfTran.msgType == 'LCAMD' 
          				|| tfApplication.tfTransaction.tfTran.msgType == 'BGISS' || tfApplication.tfTransaction.tfTran.msgType == 'BGAMD'
            			|| tfApplication.tfTransaction.tfTran.msgType == 'SCISS' || tfApplication.tfTransaction.tfTran.msgType == 'SCAMD'}">				
				<tfap:tfap-user-role-permission userRoles="${userRoles}"
					TFAP_COM_MAKER="true">
						<a href="#" id="amend_btn" class="btn btn-outline-primary" data-toggle="tooltip" data-placement="bottom" title="Amend" data-original-title="Amend">
							<i class="fa fa-pencil-square-o"></i>
						</a>
				</tfap:tfap-user-role-permission>
			</c:if>
            <c:if test="${tfApplication.tfTransaction.tfTran.msgType == 'LCISS' || tfApplication.tfTransaction.tfTran.msgType == 'BGISS' || tfApplication.tfTransaction.tfTran.msgType == 'SCISS' || 
                            tfApplication.tfTransaction.tfTran.msgType == 'LCAMD' || tfApplication.tfTransaction.tfTran.msgType == 'BGAMD' || tfApplication.tfTransaction.tfTran.msgType == 'SCAMD' || 
            				tfApplication.tfTransaction.tfTran.msgType == 'SGISS' || tfApplication.tfTransaction.tfTran.msgType == 'SGAWB' || tfApplication.tfTransaction.tfTran.msgType == 'SGBOL' || tfApplication.tfTransaction.tfTran.msgType == 'SGLOI'}">				
				<tfap:tfap-user-role-permission userRoles="${userRoles}"
					TFAP_COM_MAKER="true">
					<a href="#" id="duplicate_btn" class="btn btn-outline-primary" data-toggle="tooltip" data-placement="bottom" title="Duplicate" data-original-title="Duplicate">
						<i class="fa fa-copy"></i>
					</a>
				</tfap:tfap-user-role-permission>
			</c:if>		
			<!-- change made as a part of TFAPP1-134 -->	           
			 <c:if test="${tfApplication.tfTransaction.tfTran.msgType == 'LCISS' || tfApplication.tfTransaction.tfTran.msgType == 'LCAMD' || tfApplication.tfTransaction.tfTran.msgType == 'LCCAN'
			 			  || tfApplication.tfTransaction.tfTran.msgType == 'BGISS' || tfApplication.tfTransaction.tfTran.msgType == 'BGAMD' || tfApplication.tfTransaction.tfTran.msgType == 'BGCAN'
			 			  || tfApplication.tfTransaction.tfTran.msgType == 'SCISS' || tfApplication.tfTransaction.tfTran.msgType == 'SCAMD' || tfApplication.tfTransaction.tfTran.msgType == 'SCCAN'}">				
				<tfap:tfap-user-role-permission userRoles="${userRoles}" TFAP_COM_MAKER="true">
					<c:choose>
					<c:when test="${tfApplication.tfTransaction.tfTran.msgType == 'LCISS' || tfApplication.tfTransaction.tfTran.msgType == 'BGISS' || tfApplication.tfTransaction.tfTran.msgType == 'SCISS'}">
						<button type="button" id="cancel_btn" class="btn btn-primary" title="Cancel&nbsp;${fn:substring(tfApplication.tfTransaction.tfTran.msgType, 0, 2)}">
							<i class="fa fa-times-circle"></i>&nbsp; <spring:message code="label.modal.button.cancel"/>&nbsp;${fn:substring(tfApplication.tfTransaction.tfTran.msgType, 0, 2)}
						</button>
					</c:when>
					<c:when test="${tfApplication.tfTransaction.tfTran.msgType == 'LCAMD' || tfApplication.tfTransaction.tfTran.msgType == 'BGAMD' || tfApplication.tfTransaction.tfTran.msgType == 'SCAMD'}">
						<button type="button" id="cancel_btn" class="btn btn-primary" title="Cancel Amendment">
							<i class="fa fa-times-circle"></i>&nbsp; <spring:message code="label.modal.button.cancelamd"/>
						</button>
					</c:when>
					<c:when test="${tfApplication.tfTransaction.tfTran.msgType == 'LCCAN' || tfApplication.tfTransaction.tfTran.msgType == 'BGCAN' || tfApplication.tfTransaction.tfTran.msgType == 'SCCAN'}">
						<c:if test="${tfApplication.tfTransaction.tfTran.state ne 'APP' && tfApplication.tfTransaction.tfTran.state ne 'REJ'}">
						<button type="button" id="cancel_btn" class="btn btn-primary" title="Cancel Cancellation">
							<i class="fa fa-times-circle"></i>&nbsp; <spring:message code="label.modal.button.cancelcan"/>
						</button>
						</c:if>
					</c:when>
					</c:choose>
				</tfap:tfap-user-role-permission>
			</c:if>
	</div>
</div>

<tfap:action-amend/>
<tfap:action-cancel/>
<tfap:action-bank-reject/>
<tfap:action-duplicate/>
<tfap:action-print/>

<script>
	var urlModelName = "${rootUrlName}"; // To identify which controller to be hit.
	$('#cancel_btn').on("click", function(e){
		openCancelModal('${tfApplication.tfTransaction.tfTran.ttfId}', '${tfApplication.tfTransaction.tfTran.msgType}', urlModelName);
	});
	
	$('#reject_btn').on("click", function(e){
		openBankRejectModal('${tfApplication.tfTransaction.tfTran.ttfId}', '${tfApplication.tfTransaction.tfTran.msgType}');
	});
	
	$('#duplicate_btn').on("click", function(e){
		 openDuplicateModal('${tfApplication.tfTransaction.tfTran.ttfId}', '${tfApplication.tfTransaction.tfTran.msgType}', urlModelName);
	});
	$('#amend_btn').on("click", function(e){
		openAmendModal('${tfApplication.tfTransaction.tfTran.ttfId}', '${tfApplication.tfTransaction.tfTran.msgType}', urlModelName);
	});
</script>
