<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@attribute name="fieldName" type="java.lang.String" required="true" %>
<%@attribute name="fieldKey" type="java.lang.String" required="false"%>
<%@attribute name="required" type="java.lang.Boolean" required="false" %>
<%@attribute name="placeHolder" type="java.lang.String" required="false" %>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false" %>
<%@attribute name="isdisabled" type="java.lang.Boolean" required="false" %>
<%@attribute name="maxlength" type="java.lang.Boolean" required="false" %>
<%@attribute name="maxVal" type="java.lang.String" required="false" %>
<%@attribute name="value" type="java.lang.String" required="false" %>
<%@attribute name="decimallength" type="java.lang.String" required="true" %>

<spring:bind path="${fieldName}">
	<div class="form-group ${status.error ? 'has-error' : ''}">
		<c:if test="${not empty fieldKey}">
			<label for="${fieldName}"><spring:message code="${fieldKey}" /></label>
		</c:if>
		<form:input id="${fieldName}" 
			path="${fieldName}" 
			cssErrorClass="border-danger form-control decimal-input ${not empty required && required ? 'required' : ''}" 
			cssClass="form-control decimal-input ${not empty required && required ? 'required' : ''}" 
			disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}"
			placeHolder="${not empty placeHolder ? placeHolder : '' }" 
			maxlength="${not empty maxVal && maxlength ? maxVal : '' }"
			data-decimal="${decimallength}"
			value="${not empty value ? value : '' }"/>
		<form:errors path="${fieldName}" class="red" />
	</div>
</spring:bind>