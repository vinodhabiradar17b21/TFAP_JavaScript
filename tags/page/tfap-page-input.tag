<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@attribute name="fieldName" type="java.lang.String" required="true"%>
<%@attribute name="fieldKey" type="java.lang.String" required="false"%>
<%@attribute name="required" type="java.lang.Boolean" required="false"%>
<%@attribute name="placeHolder" type="java.lang.String" required="false"%>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false"%>
<%@attribute name="isdisabled" type="java.lang.Boolean" required="false"%>
<%@attribute name="addHidden" type="java.lang.Boolean" required="false"%>
<%@attribute name="maxlength" type="java.lang.Integer" required="false"%>
<%@attribute name="isName" type="java.lang.Boolean" required="false"%>
<%@attribute name="isAlphaNumeric" type="java.lang.Boolean"
	required="false"%>
<%@attribute name="isMobileNumber" type="java.lang.Boolean"
	required="false"%>
<%@attribute name="isOnlyNumeric" type="java.lang.Boolean"
	required="false"%>
<%@attribute name="fieldId" type="java.lang.String"
	required="false"%>
<%@attribute name="uppercase" type="java.lang.String" required="false" %>

<c:set var="isAlphaNumeric"
	value="${(empty isAlphaNumeric) ? false : isAlphaNumeric}" />
<c:set var="isUpperCase" value="${(empty uppercase) ? false : true}"/>

<spring:bind path="${fieldName}">
	<div class=" ${status.error ? 'has-error' : ''}">
		<div class="space_input">
			<c:if test="${not empty fieldKey}">
				<label for="${fieldName}"><spring:message code="${fieldKey}" /></label>
			</c:if>
			<form:input id="${(not empty fieldId)?fieldId:fieldName}" path="${fieldName}"
				cssErrorClass="border-danger form-control ${not empty required && required ? 'required' : ''}"
				cssClass="form-control ${not empty required && required ? 'required' : ''}"
				disabled="${(not empty isDisabled && isDisabled) || (not empty isdisabled && isdisabled) || (not empty addHidden && addHidden)? 'true':'false'}"
				placeHolder="${not empty placeHolder ? placeHolder : '' }"
				maxlength="${not empty maxlength ? maxlength : ''}"
				style="${empty uppercase ? '' : 'text-transform:uppercase' }"/>
			<c:if test="${addHidden}">
				<form:hidden id="${fieldName}" path="${fieldName}" />
			</c:if>
			<form:errors path="${fieldName}" class="red" />
		</div>
	</div>
</spring:bind>

<script>
	<c:if test="${isAlphaNumeric}">
	$('[id*="${fieldName}"]').bind('keyup', function (event) { 
		        $(this).val($(this).val().replace(/[^0-9a-zA-Z\s]/g, ''));
				var key = "${fieldName}";
				var inputValue = event.charCode;
				if (!(inputValue >= 48 && inputValue <= 57)
						&& !(inputValue >= 65 && inputValue <= 90)
						&& !(inputValue >= 97 && inputValue <= 122)
						&& (inputValue != 32 && inputValue != 0)) {
					event.preventDefault();
				}
				if (key.toLowerCase().indexOf("code") >= 0) {
					if (inputValue === 32) {
						event.preventDefault();
					}
				}
			});
	</c:if>
	<c:if test="${isMobileNumber}">
	$('[id*="${fieldName}"]').keypress(
			function(event) {
				var inputValue = event.charCode;
				var totalLength = $('[id*="${fieldName}"]').val().length;
				var value = $('[id*="${fieldName}"]').val();
				if (!(inputValue >= 48 && inputValue <= 57)
						&& !(inputValue === 43) && !(inputValue === 32)) {
					event.preventDefault();
				} else {
					if (totalLength > 2 && inputValue === 43)
						event.preventDefault();
					else if (value.indexOf('+') >= 0 && inputValue === 43)
						event.preventDefault();
					else if (value.indexOf(' ') >= 0 && inputValue === 32)
						event.preventDefault();
					else if (totalLength > 14)
						event.preventDefault();
				}

			});
	</c:if>

	<c:if test="${isName}">
	$('[id*="${fieldName}"]').on("keypress keyup blur",function (event) { 
		  $(this).val($(this).val().replace(/[^0-9a-zA-Z\s'_()&\.-]/g, ''));

			});
	</c:if>
	
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
	<c:if test="${isUpperCase}">
		$('[id="${fieldName}"]').on("keyup", function(event) {
			$(this).val($(this).val().toUpperCase());
			
		});
	</c:if>
</script>