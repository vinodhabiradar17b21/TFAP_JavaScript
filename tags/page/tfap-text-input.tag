<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@attribute name="fieldName" type="java.lang.String" required="true" %>
<%@attribute name="required" type="java.lang.Boolean" required="false" %>
<%@attribute name="placeHolder" type="java.lang.String" required="false" %>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false" %>
<%@attribute name="isdisabled" type="java.lang.Boolean" required="false" %>
<%@attribute name="maxlength" type="java.lang.Boolean" required="false" %>
<%@attribute name="maxVal" type="java.lang.String" required="false" %>
<%@attribute name="value" type="java.lang.String" required="false" %>
<%@attribute name="disabledfield" type="java.lang.Boolean" required="false"%>
<%@attribute name="isOnlyNumeric" type="java.lang.Boolean" required="false"%>
<c:set var="disabledfield"
	value="${(empty disabledfield) ? ' ' : disabledfield}" />
<spring:bind path="${fieldName}">
	<c:choose>
		<c:when test="${not empty disabledfield && disabledfield}">
			<form:input id="${fieldName}" 
				path="${fieldName}" 
				cssErrorClass="border-danger form-control ${not empty required && required ? 'required' : ''}" 
				cssClass="form-control ${not empty required && required ? 'required' : ''}" 
				disabled="true"
				placeHolder="${not empty placeHolder ? placeHolder : '' }" 
				maxlength="${not empty maxVal && maxlength ? maxVal : ''}"
				value="${not empty value ? value : '' }"/>
		</c:when>
		<c:otherwise>
			<form:input id="${fieldName}" 
				path="${fieldName}" 
				cssErrorClass="border-danger form-control ${not empty required && required ? 'required' : ''}" 
				cssClass="form-control ${not empty required && required ? 'required' : ''}" 
				disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}"
				placeHolder="${not empty placeHolder ? placeHolder : '' }" 
				maxlength="${not empty maxVal && maxlength ? maxVal : ''}"
				value="${not empty value ? value : '' }"/>
		</c:otherwise>
	</c:choose>
	
	<form:errors path="${fieldName}" class="red" />
	
</spring:bind>

<script>
<c:if test="${isOnlyNumeric}">
$('[id*="${fieldName}"]').on("keypress keyup blur",function (event) { 
    $(this).val($(this).val().replace(/[^\d\s].+/, ""));
	var inputValue = event.charCode;
	var totalLength = $('[id*="${fieldName}"]').val().length;
	var value = $('[id*="${fieldName}"]').val();
	if (!(inputValue >= 48 && inputValue <= 57) && !(inputValue === 32)) {
		event.preventDefault();
	} else {
		if (value.indexOf(' ') >= 0 && inputValue === 32)
			event.preventDefault();
		else if (totalLength > 14)
			event.preventDefault();
	}

});
</c:if>

</script>