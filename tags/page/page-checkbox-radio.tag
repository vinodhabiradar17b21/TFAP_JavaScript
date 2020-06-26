<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@attribute name="fieldName" type="java.lang.String" required="true" %>
<%@attribute name="fieldKey" type="java.lang.String" required="true" %>
<%@attribute name="required" type="java.lang.Boolean" required="true" %>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false"%>
<%@attribute name="isdisabled" type="java.lang.Boolean" required="false"%>
<spring:bind path="${fieldName}">
	<li class="${status.error ? 'has-error' : ''}">
		<label for="${fieldName}">
			<form:checkbox value='0' id="${fieldName}" path="${fieldName}" disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}"/>
			<span><spring:message code="${fieldKey}"/></span>
			<jsp:doBody />
		</label>
		<%-- <form:errors path="${fieldName}" class="text-danger" />  --%>
	</li>
</spring:bind>