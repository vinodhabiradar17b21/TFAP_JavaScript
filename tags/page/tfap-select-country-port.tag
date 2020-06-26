<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<%@attribute name="fieldName" type="java.lang.String" required="true"%>
<%@attribute name="fieldKey" type="java.lang.String" required="true"%>
<%@attribute name="fieldName2" type="java.lang.String" required="true"%>
<%@attribute name="fieldKey2" type="java.lang.String" required="false"%>
<%@attribute name="fieldName3" type="java.lang.String" required="true"%>
<%@attribute name="fieldId" type="java.lang.String" required="true"%>
<%@attribute name="selectFieldDescription" type="java.lang.String" required="false" %>
<%@attribute name="selectFieldDescription2" type="java.lang.String" required="false" %>
<%@attribute name="required" type="java.lang.String" required="false" %>
<%@attribute name="countries"  type="java.lang.Object" required="false" %>
<%@attribute name="ports"  type="java.lang.Object" required="false" %>


<spring:bind path="${fieldName}">

	<div class="form-group ${status.error ? 'has-error' : ''}">
	
		<c:if test="${not empty fieldKey}">
			<label for="${fieldName}"><spring:message code="${fieldKey}"/></label>
		</c:if>
		
		<div class="input-group" >
				
			<form:select 
				id="${fieldName}" 
				path="${fieldName}"
				cssErrorClass="border-danger form-control ${required ? 'required' : ''}"
				cssClass="form-control ${required ? 'required' : ''}"
				disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}">
					
				<spring:message code='${selectFieldDescription}' var="selectfieldLabel"/>
				<form:option value="" label="Select ${selectfieldLabel}"/>
				<form:options items="${countries}" />
			</form:select>

			<form:select 
				id="${fieldName2}" 
				path="${fieldName2}"
				cssErrorClass="border-danger form-control ${required ? 'required' : ''}"
				cssClass="form-control ${required ? 'required' : ''}"
				disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}">

				<spring:message code='${selectFieldDescription2}' var="selectfieldLabel2" />
				<form:option value="" label="Please Select ${selectfieldLabel} First" data-select-first="true"/>
				<form:option value="" label="Select ${selectfieldLabel2}" />
				<form:options items="${ports}" />
				<form:option value="_Other" label="Other"/>
			</form:select>
			
			<form:input 
				id="${fieldName3}"
				path="${fieldName3}" 
				cssErrorClass="border-danger form-control ${required ? 'required' : ''}"
				cssClass="form-control d-none ${required ? 'required' : ''}"
				disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}"
				placeholder="${selectfieldLabel2}"/>

		</div>
		
		<div class="group-validation">
			<form:errors path="${fieldName}" class="red" />
			<form:errors path="${fieldName2}" class="red" />
		</div>
	</div>
	
</spring:bind>

<script type="text/javascript">
	$(document).ready(function(){
		
		if($('[id="${fieldName}"]').val() == ''){
			showSelectFirst(true);
		}else{
			showSelectFirst(false, true);
		}
		
		
		if($('[id="${fieldName2}"]').val() != ''){
			var val = $('[id="${fieldName2}"]').val();
			
			if(val == '_Other'){
				$('[id="${fieldName3}"]').removeClass('d-none');
			}else{
				$('[id="${fieldName3}"]').addClass('d-none');
			}
		}
		
		
		$('[id="${fieldName}"]').on('change', function(e){
			
			$('[id="${fieldName2}"]').find('option:not([value=""]):not([value="_Other"])').remove();
			
			var country = $(this).val();
			
			if(country == ''){
				showSelectFirst(true);
			}else{
				$.ajax({
		            url: '/TFAPortal/principleaccount/portsbycountry?countryCode='+country,
		            type: "GET",
		            success: function(data) { 
				 		data = JSON.parse(data)
		            	
		            	var each = $.each(data, function(i, port){
		            		var option = $('<option>');
					 		$(option).val(port.key);
					 		$(option).text(port.value);
					 		
					 		$('[id="${fieldName2}"]').append(option);
		            	});
				 		
				 		$.when(each).then(function(){
				 			var optionOther = $('[id="${fieldName2}"]').find('option[value="_Other"]');
							var optionOtherClone = optionOther.clone();
							$(optionOther).remove();
							$('[id="${fieldName2}"]').append(optionOtherClone);
							
							showSelectFirst(false);
				 		});
		            	
		            },
		            complete : function(){
		            	
		            }

		        });	
			}
		});
		
		$('[id="${fieldName2}"]').on('change', function(e){
			$('[id="${fieldName3}"]').val('');
			
			var val = $('[id="${fieldName2}"]').val();
			
			if(val == '_Other'){
				$('[id="${fieldName3}"]').removeClass('d-none');
			}else{
				$('[id="${fieldName3}"]').addClass('d-none');
			}
		});
		
		function showSelectFirst(show, keepField2Val){
			if(show){
				$('[id="${fieldName2}"]').find('option[value=""][data-select-first="true"]').show();
				$('[id="${fieldName2}"]').find('option[value=""]:not([data-select-first="true"])').hide();
				$('[id="${fieldName2}"] option[value=""][data-select-first="true"]').prop('selected', true).trigger('change');
				$('[id="${fieldName2}"]').find('option[value="_Other"]').hide();
			}else{
				$('[id="${fieldName2}"]').find('option[value=""][data-select-first="true"]').hide();
				$('[id="${fieldName2}"]').find('option[value=""]:not([data-select-first="true"])').show();
				
				if(!keepField2Val){
					$('[id="${fieldName2}"] option[value=""]:not([data-select-first="true"])').prop('selected', true).trigger('change');
				}
				
				$('[id="${fieldName2}"]').find('option[value="_Other"]').show();
			}
		}
		
		
	});
	
	
</script>

