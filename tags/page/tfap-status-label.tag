<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@attribute name="status" type="java.lang.String" required="true"%>

<c:choose>
	<c:when test="${status eq 'NEW'}">
		<div class="status_pill_badge badge-success status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'DRF'}">
		<div class="status_pill_badge badge-primary status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'PCH'}">
		<div class="status_pill_badge badge-primary status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'PAU'}">
		<div class="status_pill_badge badge-primary status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'SUB'}">
		<div class="status_pill_badge badge-secondary status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'PRO'}">
		<div class="status_pill_badge badge-secondary status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'IRJ'}">
		<div class="status_pill_badge badge-secondary status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'IAP'}">
		<div class="status_pill_badge badge-secondary status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'APP'}">
		<div class="status_pill_badge badge-success status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'CAN'}">
		<div class="status_pill_badge bg-red status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'REJ'}">
		<div class="status_pill_badge bg-red status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'ACK'}">
		<div class="status_pill_badge badge-light status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'DIS'}">
		<div class="status_pill_badge badge-light status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'RCV'}">
		<div class="status_pill_badge badge-secondary status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'AMD'}">
		<div class="status_pill_badge badge-secondary status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'EXT'}">
		<div class="status_pill_badge badge-secondary status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'CNT'}">
		<div class="status_pill_badge badge-secondary status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'PED'}">
		<div class="status_pill_badge badge-secondary status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'A'}">
		<div class="status_pill_badge badge-success status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'P'}">
		<div class="status_pill_badge badge-warning status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'R'}">
		<div class="status_pill_badge badge-danger status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	
	<c:when test="${status eq 'D'}">
		<div class="status_pill_badge badge-success status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'M'}">
		<div class="status_pill_badge badge-success status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>
	<c:when test="${status eq 'I'}">
		<div class="status_pill_badge badge-success status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:when>	
	<c:otherwise>
		<div class="status_pill_badge badge-light status${status}">
			<spring:message code="label.application.status.${status}" />
		</div>
	</c:otherwise>
	
</c:choose>


