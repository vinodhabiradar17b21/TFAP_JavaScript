<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@attribute name="fieldName" type="java.lang.String" required="true" %>
<%@attribute name="fieldKey" type="java.lang.String" required="true" %>
<%@attribute name="required" type="java.lang.Boolean" required="true" %>
<%@attribute name="options" type="java.lang.Object" required="false" %>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false" %>

<spring:message code='${fieldKey}' var="fieldDescription"/>
<spring:bind path="${fieldName}">
	<div class="space_input ${status.error ? 'has-error' : ''}">
		<label for="${fieldName}"><spring:message code="${fieldKey}"/></label>
			<div class="form-control ${required ? 'required' : ''}"  ${isDisabled?'readonly':''}  >
				<ul>
				<form:radiobuttons id="${fieldName}" path="${fieldName}" items="${options}" cssErrorClass="border-danger ${required ? 'required' : ''}" 
					cssClass=" ${required ? 'required' : ''}" disabled="${isDisabled?'true':'false'}" element="li" style="align-items: center;"/>
				</ul>	
			</div>
		<form:errors path="${fieldName}" class="red" /> 
	</div>
</spring:bind>

<STYLE type="text/css">

ul {
  list-style: none; /* Remove default bullets */
}

ul {
    display: block;
    list-style-type: disc;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    padding-inline-start: 0px;
}
</STYLE>