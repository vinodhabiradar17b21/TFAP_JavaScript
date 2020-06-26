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

<spring:bind path="${fieldName}">

	<div class="form-group ${status.error ? 'has-error' : ''}">
	
		<c:if test="${not empty fieldKey}">
			<label for="${fieldName}"><spring:message code="${fieldKey}"/></label>
		</c:if>
		
		<div class="input-group" >
				
			<form:input 
				id="${fieldName}" 
				path="${fieldName}" 
				cssErrorClass="border-danger form-control  or2 ${not empty required && required ? 'required' : ''}" 
				cssClass="form-control or2 ${not empty required && required ? 'required' : ''}" 
				disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}"
				placeHolder="${not empty placeHolder ? placeHolder : '' }" 
				maxlength="${not empty maxVal && maxlength ? maxVal : ''}" />
				
				
			<div class="input-group-append ${order == '1' ? 'or1' : 'or3'}">
						
				<spring:message code='${fieldKey}' var="fieldDescription" />
					
				<div class="${status.error ? 'has-error' : ''}">

					<form:select 
						id="${fieldName2}" 
						path="${fieldName2}"
						cssErrorClass="border-danger form-control ${required ? 'required' : ''}"
						cssClass="form-control ${required ? 'required' : ''}"
						disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}">
						
						<spring:message code='${selectFieldDescription}' var="selectfieldLabel"/>
						<form:option value="" label="Select ${selectfieldLabel}"/>
						<form:options items="${items}" />
					</form:select>
							
				</div>
				
			</div>
		</div>
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
		
		</style>
		<div class="group-validation">
			<form:errors path="${fieldName}" class="red" />
			<form:errors path="${fieldName2}" class="red" />
		</div>
	</div>

</spring:bind>