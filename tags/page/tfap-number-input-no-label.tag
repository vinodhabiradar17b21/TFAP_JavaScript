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

<spring:bind path="${fieldName}">

	<form:input id="${fieldName}" path="${fieldName}"
		cssErrorClass="border-danger form-control tfap-number-input ${not empty required && required ? 'required' : ''}"
		cssClass="form-control tfap-number-input ${not empty required && required ? 'required' : ''}"
		disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}"
		placeHolder="${not empty placeHolder ? placeHolder : '' }"
		maxlength="${not empty maxVal && maxlength ? maxVal : ''}"
		value="${not empty value ? value : '' }" />
	<form:errors path="${fieldName}" class="red" />


	<script type="text/javascript">
		$(document).ready(function(){	
			$('.tfap-number-input').on('keypress', tfapNumberInputOnKeyPress);
			$('.tfap-number-input').on('change', tfapNumberInputOnChange);
		})
		
		function tfapNumberInputOnKeyPress(evt){
			console.log('keypress')
			var charCode = (evt.which) ? evt.which : evt.keyCode
			if ((charCode >= 48 && charCode <= 57)) {
				return true;
			}else{
				return false;
			}
		}
		
		function tfapNumberInputOnChange(evt){
			console.log('change')
			if(/[^\d]/.test($(this).val())){
				$(this).val('')
			}
		}
	</script>
</spring:bind>