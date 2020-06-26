<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@attribute name="fieldName" type="java.lang.String" required="true" %>
<%@attribute name="fieldKey" type="java.lang.String" required="false"%>
<%@attribute name="required" type="java.lang.Boolean" required="false" %>
<%@attribute name="placeHolder" type="java.lang.String" required="false" %>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false" %>
<%@attribute name="isdisabled" type="java.lang.Boolean" required="false" %>
<%@attribute name="maxlength" type="java.lang.Boolean" required="false" %>
<%@attribute name="maxVal" type="java.lang.String" required="false" %>
<%@attribute name="value" type="java.lang.String" required="false" %>
<%@attribute name="decimallength" type="java.lang.String" required="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script src="<c:url value="/resources/js/scripts/customNumber/jquery.number.js"/>" type="text/javascript"></script>
<c:set var="inputNumberId" value="${fn:replace(fieldName, '.','') }" />

<spring:bind path="${fieldName}">

	<form:input id="${inputNumberId}" 
					path="${fieldName}" 
					cssErrorClass="border-danger form-control decimal-input or2 ${not empty required && required ? 'required' : ''}" 
					cssClass="form-control decimal-input or2 ${not empty required && required ? 'required' : ''}" 
					disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}"
					placeHolder="${not empty fieldpPaceholder ? fieldpPaceholder : '' }" 
					maxlength="${not empty maxVal && maxlength ? maxVal : ''}"
					data-decimal="${decimallength}"
					value="${not empty value ? value : '' }"/>
	<form:errors path="${fieldName}" class="red" />

</spring:bind>
<script type="text/javascript">
	$(document).ready(function(){
		$("#${inputNumberId}").keyup(isCurrencyExceedLength);    
		function isCurrencyExceedLength(){
			var currentLength = $('#${inputNumberId}').val().length;
			var maxLength = parseInt($("#${inputNumberId}").attr("maxlength"));
			currentVal = $('#${inputNumberId}').val();

			if(currentVal.indexOf(".") == -1 && currentLength == maxLength)
			{
				$("#${inputNumberId}").val(currentVal.substring(0, currentLength-1));
			}
			if(currentVal.indexOf(".") + 2 >= maxLength)
			{
				var modCont = currentVal.substring(0, currentVal.indexOf("."));
				$("#${inputNumberId}").val(modCont);
			}				
		}
	});
</script>