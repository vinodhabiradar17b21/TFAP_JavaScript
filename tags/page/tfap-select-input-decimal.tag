<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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

<script src="<c:url value="/resources/js/scripts/customNumber/jquery.number.js"/>" type="text/javascript"></script>
<c:set var="currSelectId" value="${fn:replace(fieldName2, '.','') }" />
<c:set var="inputNumberId" value="${fn:replace(fieldName, '.','') }" />

<spring:bind path="${fieldName}">
	<div class="form-group ${status.error ? 'has-error' : ''}">
		<div class="space_input">
			<label for="${fieldName}"><spring:message code="${fieldKey}" /></label> 	
		<div class="input-group" >				
				<spring:message code="${placeHolder}" var="fieldpPaceholder"/>
				<form:input id="${inputNumberId}" 
					path="${fieldName}" 
					cssErrorClass="border-danger form-control decimal-input or2 ${not empty required && required ? 'required' : ''}" 
					cssClass="form-control decimal-input or2 ${not empty required && required ? 'required' : ''}" 
					disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}"
					placeHolder="${not empty fieldpPaceholder ? fieldpPaceholder : '' }" 
					maxlength="${not empty maxVal && maxlength ? maxVal : ''}"
					data-decimal="${decimallength}"
					value="${not empty value ? value : '' }"/>
				
				
			<div class="input-group-append ${order == '1' ? 'or1' : 'or3'}">						
				<spring:message code='${fieldKey}' var="fieldDescription" />
					
				<div class="${status.error ? 'has-error' : ''}">

					<form:select 
						id="${currSelectId }" 
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
	</div>
</spring:bind>
<!-- Implement specifics here for currency standards -->
<script type="text/javascript">
	$(document).ready(function(){
		var selectedCurr;
		selectedCurr = $('#${currSelectId}').val();
		var arrCurrNo3Dec = ["BHD", "IQD", "JOD", "KWD", "LYD", "OMR", "TND"];
		if(jQuery.inArray(selectedCurr, arrCurrNo3Dec) >= 0) {
			$("#${inputNumberId}").attr("data-decimal", "3");
		} else {
			$("#${inputNumberId}").attr("data-decimal", "2");
		}
		
		var cont = $("#${inputNumberId}").val();
		var integer =  cont.substring(0, cont.indexOf("."));
		var afterDecimal;
		if($("#${inputNumberId}").attr("data-decimal") == 3) {
			if(cont != '' && cont.indexOf(".") != -1) {
				afterDecimal = cont.substring(cont.indexOf(".")+1, cont.length);
			}
			
			if(afterDecimal == null && integer > 0) {
				$("#${inputNumberId}").val(cont+".000");
			} 
			else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length==1) {
				$("#${inputNumberId}").val(cont+"00");
			}
			else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length==2) {
				$("#${inputNumberId}").val(cont+"0");
			}
			else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length>3) {
				$("#${inputNumberId}").val(cont.substring(0, cont.indexOf(".")+4));
			}	
		}
		
		if($("#${inputNumberId}").attr("data-decimal") == 2) {
			if(cont != '' && cont.indexOf(".") != -1) {
				afterDecimal = cont.substring(cont.indexOf(".")+1, cont.length);
			}
			if(afterDecimal == null && integer > 0) {
				$("#${inputNumberId}").val(cont+".00");
			} 
			else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length==1) {
				$("#${inputNumberId}").val(cont+"0");
			}
			else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length>2) {
				$("#${inputNumberId}").val(cont.substring(0, cont.indexOf(".")+3));
			}
		}
		
		$("#${currSelectId}").on("change", function(){
			selectedCurr = this.value;
			var arrCurrNo3Dec = ["BHD", "IQD", "JOD", "KWD", "LYD", "OMR", "TND"];
			if(jQuery.inArray(selectedCurr, arrCurrNo3Dec) >= 0) {
				$("#${inputNumberId}").attr("data-decimal", "3");
			} else {
				$("#${inputNumberId}").attr("data-decimal", "2");
			}
			$("#${inputNumberId}").removeAttr("onkeyup");
			if(isCurrencyExcempted(selectedCurr)){
				console.log("Currency must have no decimal point...");
				$("#${inputNumberId}").removeAttr("data-decimal");
				$("#${inputNumberId}").attr("onkeypress", "return event.charCode >= 48 && event.charCode <= 57");
				
				if($("#${inputNumberId}").val() !== undefined || $("#${inputNumberId}") != ''){
					var cont = $("#${inputNumberId}").val();
					var modCont = cont.substring(0, cont.indexOf("."));
					$("#${inputNumberId}").val(modCont);
				}
				
			} else {
				if($("#${inputNumberId}").attr("data-decimal") == undefined){
					$("#${inputNumberId}").attr("data-decimal", "2");
				}

				var cont = $("#${inputNumberId}").val();
				var integer =  cont.substring(0, cont.indexOf("."));
				var afterDecimal;
				if($("#${inputNumberId}").attr("data-decimal") == 3) {
					if(cont != '' && cont.indexOf(".") != -1) {
						afterDecimal = cont.substring(cont.indexOf(".")+1, cont.length);
					}
					if(afterDecimal == null && integer > 0) {
						$("#${inputNumberId}").val(cont+".000");
					} 
					else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length==1) {
						$("#${inputNumberId}").val(cont+"00");
					}
					else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length==2) {
						$("#${inputNumberId}").val(cont+"0");
					}
					else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length>3) {
						$("#${inputNumberId}").val(cont.substring(0, cont.indexOf(".")+4));
					}	
				}
				
				if($("#${inputNumberId}").attr("data-decimal") == 2) {
					if(cont != '' && cont.indexOf(".") != -1) {
						afterDecimal = cont.substring(cont.indexOf(".")+1, cont.length);
					}
					if(afterDecimal == null && integer > 0) {
						$("#${inputNumberId}").val(cont+".00");
					} 
					else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length==1) {
						$("#${inputNumberId}").val(cont+"0");
					}
					else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length>2) {
						$("#${inputNumberId}").val(cont.substring(0, cont.indexOf(".")+3));
					}
				}
				
				if($("#${inputNumberId}").attr("onkeypress") !== undefined){
					$("#${inputNumberId}").removeAttr("onkeypress");
					$("#${inputNumberId}").keypress(isCurrencyExceedLength);
					
				}
				//$('#${inputNumberId}').number(true,2);
				
				
			}
			$("#${inputNumberId}").keyup(isCurrencyExceedLength);
		});
		
		$("#${inputNumberId}").keyup(isCurrencyExceedLength);
		
		//currency exemption for decimal points based on ISO Currency standard
		function isCurrencyExcempted(selectVal){
			var arrCurrNoDec = ["XOF", "BIF", "XAF", "CLP", "KMF", "DJF", "XPF", "GNF", "ISK", "JPY", "KRW", "PYG", "RWF", "UGX", "UYI", "VUV", "VND"];
			var isExcemptDecimal = false;
			
			$.each(arrCurrNoDec, function( index, value ){
				if(value == selectVal){
					isExcemptDecimal = true;
				}
				
			});
			
			return isExcemptDecimal;
		}
		
		function isCurrencyExceedLength(){
			var currentLength = $('#${inputNumberId}').val().length;
			var maxLength = parseInt($("#${inputNumberId}").attr("maxlength"));
			currentVal = $('#${inputNumberId}').val();
			var decimalLength = 2;
			var arrCurrNo3Dec = ["BHD", "IQD", "JOD", "KWD", "LYD", "OMR", "TND"];
			if(jQuery.inArray(selectedCurr, arrCurrNo3Dec) >= 0) {
				decimalLength = 3;
			}

			if(currentVal.indexOf(".") == -1 && currentLength + decimalLength >= maxLength)
			{
				$("#${inputNumberId}").val(currentVal.substring(0, currentLength-1));
			}
			if(currentVal.indexOf(".") + decimalLength >= maxLength)
			{
				var modCont = currentVal.substring(0, currentVal.indexOf("."));
				$("#${inputNumberId}").val(modCont);
			}				
		}
	});
	
	
	


</script>