<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@attribute name="fieldName" type="java.lang.String" required="true" %>
<%@attribute name="fieldKey" type="java.lang.String" required="false" %>
<%@attribute name="required" type="java.lang.Boolean" required="true" %>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false" %>
<%@attribute name="isdisabled" type="java.lang.Boolean" required="false" %>

<spring:bind path="${fieldName}">
	<div class="form-group ${status.error ? 'has-error' : ''}">
		<c:if test="${not empty fieldKey}">
			<label for="${fieldName}"><spring:message code="${fieldKey}" /></label>
		</c:if>
		<form:input id="${fieldName}" path="${fieldName}" cssErrorClass="border-danger form-control ${required ? 'required' : ''}" cssClass="form-control 
		 ${required ? 'required' : ''}" disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}"/>
		<form:errors path="${fieldName}" class="red" /> 
	</div>
</spring:bind>