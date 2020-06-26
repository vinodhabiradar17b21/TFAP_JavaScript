<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@attribute name="fieldName" type="java.lang.String" required="true" %>
<%@attribute name="fieldKey" type="java.lang.String" required="true" %>
<%@attribute name="required" type="java.lang.Boolean" required="true" %>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false"%>
<%@attribute name="isdisabled" type="java.lang.Boolean" required="false"%>
<%@attribute name="options" type="java.lang.Object" required="true" %>
<%@attribute name="width" type="java.lang.String" required="true" %>
<%@attribute name="labelKey" type="java.lang.String" required="true" %>

<spring:message code='${fieldKey}' var="fieldDescription"/>
<spring:bind path="${fieldName}">
	<div class="space_input ${status.error ? 'has-error' : ''}">
		<label for="${fieldName}"><spring:message code="${fieldKey}"/></label>
		<div class=" form-control ${required ? 'required' : ''}"  ${isdisabled?'readonly':''}  >
			<c:forEach items="${options}" var="opt" >
				<form:checkbox id="${fieldName}" path="${fieldName}" value='${opt.key }' cssErrorClass="border-danger form-control ${required ? 'required' : ''}"
					cssClass="form-control ${required ? 'required' : ''}" disabled="${(not empty isDisabled && isDisabled) || (not empty isdisabled && isdisabled)}" style="display:inline; width:${width}"/>
				<span><spring:message code="${labelKey}.${opt.key }"/></span>
			</c:forEach>
		</div>
		<form:errors path="${fieldName}" class="red" /> 
	</div>
</spring:bind>