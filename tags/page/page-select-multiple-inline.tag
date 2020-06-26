<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@attribute name="fieldName" type="java.lang.String" required="true" %>
<%@attribute name="fieldKey" type="java.lang.String" required="true" %>
<%@attribute name="required" type="java.lang.Boolean" required="true" %>
<%@attribute name="options" type="java.lang.Object" required="false" %>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false" %>
<spring:message code='${fieldKey}' var="fieldDescription"/>
	<div class="form-group ${status.error ? 'has-error' : ''}">
		<form:select id="${fieldName}" path="${fieldName}" size="5" style="overflow-y: scroll;" cssErrorClass="border-danger form-control ${required ? 'required' : ''}" 
		cssClass="form-control ${required ? 'required' : ''}" disabled="${isdisabled?'true':'false'}">
			<form:options items="${options}"/>		
		</form:select>
	</div>
