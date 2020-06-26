<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<%@attribute name="fieldName" type="java.lang.String" required="true"%>
<%@attribute name="fieldKey" type="java.lang.String" required="true"%>
<%@attribute name="fieldName2" type="java.lang.String" required="true"%>
<%@attribute name="fieldKey2" type="java.lang.String" required="false"%>
<%@attribute name="fieldId" type="java.lang.String" required="true"%>
<%@attribute name="maxlength" type="java.lang.Boolean" required="false" %>
<%@attribute name="maxVal" type="java.lang.String" required="false" %>
<%@attribute name="placeHolder" type="java.lang.String" required="false" %>
<%@attribute name="selectFieldDescription" type="java.lang.String" required="false" %>
<%@attribute name="required" type="java.lang.String" required="false" %>
<%@attribute name="order" type="java.lang.String" required="false" %>
<%@attribute name="items"  type="java.lang.Object" required="false" %>
<%@attribute name="decimallength" type="java.lang.String" required="true" %>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false" %>
<%@attribute name="fieldKey3" type="java.lang.String" required="false"%>
<%@attribute name="fieldName3" type="java.lang.String" required="false"%>
<%@attribute name="value3" type="java.lang.String" required="false"%>
<style>		
	.or1{
		order: 1
	}
	
	.or2{
		order: 2
	}
	
	.or3{
		order: 3
	}
	
	.or4{
		order: 4
	}		
</style>

<spring:bind path="${fieldName}">

	<div class="form-group ${status.error ? 'has-error' : ''}">
		<div class="input-group" >				
				<spring:message code="${placeHolder}" var="fieldpPaceholder"/>
				<form:input id="${fieldName}" 
					path="${fieldName}" 
					cssErrorClass="border-danger form-control decimal-input or2 ${not empty required && required ? 'required' : ''}" 
					cssClass="form-control decimal-input or2 ${not empty required && required ? 'required' : ''}" 
					disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}"
					placeHolder="${not empty fieldpPaceholder ? fieldpPaceholder : '' }" 
					maxlength="${not empty maxVal && maxlength ? maxVal : ''}"
					data-decimal="${decimallength}"
					value="${not empty value ? value : '' }"/>
			
			<c:if test="${not empty fieldKey3}">				
				<div class="input-group-prepend" style="width: 54%">
					<span class="input-group-text" style="width: 100%">
						<form:checkbox value="${value3}" id="${fieldName3}" path="${fieldName3}" disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}"/>&nbsp;	
						<spring:message code="${fieldKey3}"/> &nbsp;
					</span>
					<span class="input-group-text-append">
						<input type="text" placeholder="please specify" hidden="true" id='${fieldName3}otherTxt'>					
					</span>
				</div>
			</c:if>
			
			<div class="input-group-append">						
				<spring:message code='${fieldKey}' var="fieldDescription" />
					
				<div class="${status.error ? 'has-error' : ''}">

					<form:select 
						id="${fieldName2}" 
						path="${fieldName2}"
						cssErrorClass="border-danger form-control ${required ? 'required' : ''}"
						cssClass="form-control ${required ? 'required' : ''}"
						disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}">
						
						<spring:message code='${selectFieldDescription}' var="selectfieldLabel"/>
						<form:option value="" label="${selectfieldLabel}"/>
						<form:options items="${items}" />
					</form:select>
							
				</div>
				
			</div>
			
			
			
		</div>

		<div class="group-validation">
			<form:errors path="${fieldName}" class="red" />
			<form:errors path="${fieldName2}" class="red" />
			<form:errors path="${fieldName3}" class="red" />
		</div>
	</div>
	

</spring:bind>