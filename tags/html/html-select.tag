<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@attribute name="fieldName" type="java.lang.String" required="true" %>
<%@attribute name="fieldKey" type="java.lang.String" required="true" %>
<%@attribute name="required" type="java.lang.Boolean" required="true" %>
<%@attribute name="options" type="java.lang.Object" required="false" %>
<spring:message code='${fieldKey}' var="fieldDescription"/>
<spring:bind path="${fieldName}">
	<div class="form-group ${status.error ? 'has-error' : ''}">
		<label for="${fieldName}"><spring:message code="${fieldKey}"/></label>
		<form:select id="${fieldName}" path="${fieldName}" cssErrorClass="border-danger form-control ${required ? 'required' : ''}" cssClass="form-control ${required ? 'required' : ''}" disabled="${isdisabled?'true':'false'}">
			<form:option value="" label="Select ${fieldDescription}"/>
			<form:options items="${options}"/>		
		</form:select>
		<form:errors path="${fieldName}" class="red" /> 
	</div>
</spring:bind>