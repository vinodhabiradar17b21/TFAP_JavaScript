<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@attribute name="fieldName" type="java.lang.String" required="true" %>
<%@attribute name="fieldKey" type="java.lang.String" required="true" %>
<%@attribute name="required" type="java.lang.Boolean" required="true" %>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false" %>
<%@attribute name="isdisabled" type="java.lang.Boolean" required="false" %>
<%@attribute name="maxlength" type="java.lang.Boolean" required="false" %>
<%@attribute name="maxVal" type="java.lang.String" required="false" %>
<%@attribute name="placeHolder" type="java.lang.String" required="false" %>

<spring:bind path="${fieldName}">
	<div class="form-group ${status.error ? 'has-error' : ''}">
		<label for="${fieldName}"></label>
		<form:textarea id="${fieldName}" path="${fieldName}" rows="3"
			cssErrorClass="border-danger form-control ${required ? 'required' : ''}"
			cssClass="form-control ${required ? 'required' : ''}"
			disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}"
			placeholder="${placeHolder}"
			maxlength="${not empty maxVal && maxlength ? maxVal : ''}"  />
	</div>
</spring:bind>

