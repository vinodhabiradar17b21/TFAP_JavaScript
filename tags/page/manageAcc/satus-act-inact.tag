<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@attribute name="status" type="java.lang.String" required="true"%>

<c:choose>
	<c:when test="${status eq 'A'}">
		<div class="status_pill_badge badge-success status${status}">
			<spring:message code="label.manageAccount.status.activate" />
		</div>
	</c:when>
	<c:otherwise>
		<div class="status_pill_badge bg-secondary status${status}">
			<spring:message code="label.manageAccount.status.inactivate" />
		</div>
	</c:otherwise>
</c:choose>