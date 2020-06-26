<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@attribute name="fieldName" type="java.lang.String" required="true"%>
<%@attribute name="fieldKey" type="java.lang.String" required="true"%>
<%@attribute name="required" type="java.lang.Boolean" required="true"%>
<%@attribute name="options" type="java.lang.Object" required="false"%>
<spring:bind path="${fieldName}">
	<form:hidden path="${fieldName}" />
</spring:bind>