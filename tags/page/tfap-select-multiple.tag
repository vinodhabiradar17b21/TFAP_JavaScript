<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@attribute name="fieldName" type="java.lang.String" required="true"%>
<%@attribute name="fieldKey" type="java.lang.String" required="false"%>
<%@attribute name="required" type="java.lang.Boolean" required="true"%>
<%@attribute name="options" type="java.lang.Object" required="false"%>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false" %>
<%@attribute name="isdisabled" type="java.lang.Boolean" required="false" %>
<%@attribute name="addHidden" type="java.lang.Boolean" required="false" %>
<%@attribute name="placeholderClass" type="java.lang.String" required="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="placeholderClass" value="${(empty placeholderClass) ? 'tfap-select2' : placeholderClass}" />

<c:if test="${not empty fieldKey}">
	<spring:message code='${fieldKey}' var="fieldDescription" />
</c:if>
<spring:bind path="${fieldName}">
	<div class="space_input ${status.error ? 'has-error' : ''} form-input">
		<c:if test="${not empty fieldKey}">
			<label for="${fieldName}"><spring:message code="${fieldKey}" /></label>
		</c:if>
		<form:select id="${fieldName}" path="${fieldName}" multiple="multiple"
			cssErrorClass="border-danger ${placeholderClass} form-control ${required ? 'required' : ''}"
			cssClass="${placeholderClass} form-control ${required ? 'required' : ''}"
			disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}">
			<form:options items="${options}" />
		</form:select>
		<form:errors path="${fieldName}" class="red" />
	</div>
	<jsp:doBody></jsp:doBody>
</spring:bind>