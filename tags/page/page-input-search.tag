<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@attribute name="fieldName" type="java.lang.String" required="true" %>
<%@attribute name="fieldKey" type="java.lang.String" required="true" %>
<%@attribute name="required" type="java.lang.Boolean" required="false" %>
<%@attribute name="placeHolder" type="java.lang.String" required="false" %>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false" %>
<%@attribute name="dataTarget" type="java.lang.String" required="false" %>

<spring:bind path="${fieldName}">
		<label for="${fieldName}"><spring:message code="${fieldKey}"/></label>
		<div class="input-group">
			<form:input id="${fieldName}" type = "text" path="${fieldName}" cssErrorClass="border-danger form-control ${not empty required && required ? 'required' : ''}" 
				cssClass="form-control ${not empty required && required ? 'required' : ''}" disabled="${not empty isDisabled && isDisabled? 'true':'false'}"
				placeHolder="${not empty placeHolder ? placeHolder : '' }"/>
			<div class="input-group-append">
			  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="${dataTarget}"><i class="fa fa-search" data-toggle="tooltip"  data-placement="bottom" title="Search HS Code"></i></button>
			</div>
		</div>		
		<form:errors path="${fieldName}" class="red" /> 
</spring:bind>