<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@attribute name="fieldName" type="java.lang.String" required="true"%>
<%@attribute name="fieldKey" type="java.lang.String" required="false"%>
<%@attribute name="required" type="java.lang.Boolean" required="true"%>
<%@attribute name="options" type="java.lang.Object" required="false"%>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false"%>
<%@attribute name="isdisabled" type="java.lang.Boolean" required="false"%>
<%@attribute name="addFieldLabel" type="java.lang.Boolean" required="false"%>
<%@attribute name="addDefaultOption" type="java.lang.Boolean" required="false"%>

<c:if test="${not empty fieldKey}">
    <spring:message code='${fieldKey}' var="fieldSelectDescription" />
</c:if>

<spring:bind path="${fieldName}">
	
	<div class="${status.error ? 'has-error' : ''}">
		<div class="space_input">
			<c:if test="${not empty addFieldLabel && addFieldLabel}">
			 	<label for="${fieldName}"><spring:message code="${fieldKey}" /></label> 
			</c:if>
			<form:select  id="${fieldName}" path="${fieldName}"
				cssErrorClass="border-danger form-control ${required ? 'required' : ''}"
				cssClass="form-control ${required ? 'required' : ''}"
				disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}">
				<c:if test="${(empty addDefaultOption)||(not empty addDefaultOption && addDefaultOption)}">
					<form:option value="" label="Please select ${fieldSelectDescription}" />
				</c:if>
				<form:options items="${options}" />
			</form:select>
		</div>
		<form:errors path="${fieldName}" class="red" />
		
	</div>
	
</spring:bind>