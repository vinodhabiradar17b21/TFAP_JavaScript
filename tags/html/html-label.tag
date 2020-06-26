<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@attribute name="labelKey" type="java.lang.String" required="true" %>
<div class="form-group">
	<label><spring:message code="${labelKey}"/></label>
</div>
