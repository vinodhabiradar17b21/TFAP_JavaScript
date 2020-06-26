<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@attribute name="popoverText" type="java.lang.String" required="false"%>
<%@attribute name="isSubmissionForAuth" type="java.lang.Boolean" required="false"%>

<spring:message code='label.state.submitted.popover' var="dataContent"/>
	
<c:set var="popoverText" value="${(empty popoverText) ? dataContent : popoverText}" />

<div class="btn-group float-md-right mr-1">
	<c:choose>
		<c:when test="${tfApplication.tfTransaction.tfTran.msgType eq 'IBULC' || tfApplication.tfTransaction.tfTran.msgType eq 'IBCOL' || tfApplication.tfTransaction.tfTran.msgType eq 'IBCON' || tfApplication.tfTransaction.tfTran.msgType eq 'IBLCN'}">
		</c:when>
		<c:otherwise>
			<div class="">
				<div class="input-group-text">
					<spring:message code="label.state.sent-to" />
				</div>
			</div>
			<select class="form-control" id="selectedBank" disabled="disabled">
				<option selected="">${tfApplication.tfTransaction.tfTran.tftBnkName}</option>
			</select>
		</c:otherwise>
	</c:choose>
	<c:if test="${isSubmissionForAuth }">
		<c:choose>
			<c:when test="${tfApplication.tfTransaction.tfTran.msgType eq 'IBULC' || tfApplication.tfTransaction.tfTran.msgType eq 'IBCOL'|| tfApplication.tfTransaction.tfTran.msgType eq 'IBCON' || tfApplication.tfTransaction.tfTran.msgType eq 'IBLCN'}">
				<tfap:tfap-user-role-permission userRoles="${userRoles}" TFAP_BANK_APPROVER="true">
					<button type="button" id="submitauth" class="btn btn-primary" title="Submit">
						<i class="fa fa-check-square-o"></i>&nbsp; Submit
					</button>
				</tfap:tfap-user-role-permission>
			</c:when>
			<c:otherwise>
				<tfap:tfap-user-role-permission userRoles="${userRoles}" TFAP_COM_APPROVER="true" >
					<button type="button" id="submitauth" class="btn btn-primary"
						title="Submit">
						<i class="fa fa-check-square-o"></i>&nbsp; Submit
					</button>
				</tfap:tfap-user-role-permission>
			</c:otherwise>
		</c:choose>
	</c:if>
</div>
		
		
	
		
