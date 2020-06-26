<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@attribute name="fieldName" type="java.lang.String" required="true" %>
<%@attribute name="required" type="java.lang.Boolean" required="false" %>
<%@attribute name="placeHolder" type="java.lang.String" required="false" %>
<%@attribute name="maxlength" type="java.lang.Boolean" required="false" %>
<%@attribute name="maxVal" type="java.lang.String" required="false" %>

<spring:bind path="${fieldName}">
	<div class="form-group ${status.error ? 'has-error' : ''}">
		<form:input id="${fieldName}" path="${fieldName}" 
			cssErrorClass="border-danger form-control ${not empty required && required ? 'required' : ''}" 
			cssClass="form-control ${not empty required && required ? 'required' : ''}"
			placeHolder="${not empty placeHolder ? placeHolder : '' }" 
			maxlength="${not empty maxVal && maxlength ? maxVal : ''}"
			readonly="true"/>
		<form:errors path="${fieldName}" class="red" /> 
	</div>
</spring:bind>