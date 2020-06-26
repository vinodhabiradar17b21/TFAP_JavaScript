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
<%@attribute name="fieldKey3" type="java.lang.String" required="false"%>
<%@attribute name="fieldName3" type="java.lang.String" required="false"%>
<%@attribute name="value3" type="java.lang.String" required="false"%>
<%@attribute name="billCur" type="java.lang.String" required="false"%>
<script src="<c:url value="/resources/js/scripts/customNumber/jquery.number.js"/>" type="text/javascript"></script>
<c:set var="currSelectId" value="${fn:replace(fieldName2, '.','') }" />
<c:set var="inputNumberId" value="${fn:replace(fieldName, '.','') }" />

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
						<form:checkbox value="${value3}" id="${fieldName3}" path="${fieldName3}" />&nbsp;	
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

<script type="text/javascript">
$(document).ready(function(){
	var selectedCurr = $('[id="${fieldName2}"]').val();
	var arrCurrNo3Dec = ["BHD", "IQD", "JOD", "KWD", "LYD", "OMR", "TND"];
	if(jQuery.inArray(selectedCurr, arrCurrNo3Dec) >= 0) {
		$('[id="${fieldName}"]').attr("data-decimal", "3");
	} else {
		$('[id="${fieldName}"]').attr("data-decimal", "2");
	}
	
	var cont = $('[id="${fieldName}"]').val();
	var integer =  0;
	
	if(cont != undefined){
		integer = cont.substring(0, cont.indexOf("."));
	}
	
	
	var afterDecimal;
	if($('[id="${fieldName}"]').attr("data-decimal") == 3) {
		if(cont != '' && cont.indexOf(".") != -1) {
			afterDecimal = cont.substring(cont.indexOf(".")+1, cont.length);
		}
		
		if(afterDecimal == null && integer > 0) {
			$('[id="${fieldName}"]').val(cont+".000");
		} 
		else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length==1) {
			$('[id="${fieldName}"]').val(cont+"00");
		}
		else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length==2) {
			$('[id="${fieldName}"]').val(cont+"0");
		}
		else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length>3) {
			$('[id="${fieldName}"]').val(cont.substring(0, cont.indexOf(".")+4));
		}	
	}
	
	if($('[id="${fieldName}"]').attr("data-decimal") == 2) {
		if(cont != '' && cont.indexOf(".") != -1) {
			afterDecimal = cont.substring(cont.indexOf(".")+1, cont.length);
		}
		if(afterDecimal == null && integer > 0) {
			$('[id="${fieldName}"]').val(cont+".00");
		} 
		else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length==1) {
			$('[id="${fieldName}"]').val(cont+"0");
		}
		else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length>2) {
			$('[id="${fieldName}"]').val(cont.substring(0, cont.indexOf(".")+3));
		}
	}
	
	
	$('[id="${fieldName2}"]').on("change", function(){
		selectedCurr = this.value;
		var arrCurrNo3Dec = ["BHD", "IQD", "JOD", "KWD", "LYD", "OMR", "TND"];
		if(jQuery.inArray(selectedCurr, arrCurrNo3Dec) >= 0) {
			$('[id="${fieldName}"]').attr("data-decimal", "3");
		} else {
			$('[id="${fieldName}"]').attr("data-decimal", "2");
		}
		$('[id="${fieldName}"]').removeAttr("onkeyup");
		if(isCurrencyExcempted(selectedCurr)){
			console.log("Currency must have no decimal point...");
			$('[id="${fieldName}"]').removeAttr("data-decimal");
			$('[id="${fieldName}"]').attr("onkeypress", "return event.charCode >= 48 && event.charCode <= 57");
			
			if($('[id="${fieldName}"]').val() !== undefined || $('[id="${fieldName}"]') != ''){
				var cont = $('[id="${fieldName}"]').val();
				var modCont = cont.substring(0, cont.indexOf("."));
				$('[id="${fieldName}"]').val(modCont);
			}
			
		} else {
			if($('[id="${fieldName}"]').attr("data-decimal") == undefined){
				$('[id="${fieldName}"]').attr("data-decimal", "2");
			}

			var cont = $('[id="${fieldName}"]').val();
			var integer =  cont.substring(0, cont.indexOf("."));
			var afterDecimal;
			if($('[id="${fieldName}"]').attr("data-decimal") == 3) {
				if(cont != '' && cont.indexOf(".") != -1) {
					afterDecimal = cont.substring(cont.indexOf(".")+1, cont.length);
				}
				if(afterDecimal == null && integer > 0) {
					$('[id="${fieldName}"]').val(cont+".000");
				} 
				else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length==1) {
					$('[id="${fieldName}"]').val(cont+"00");
				}
				else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length==2) {
					$('[id="${fieldName}"]').val(cont+"0");
				}
				else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length>3) {
					$('[id="${fieldName}"]').val(cont.substring(0, cont.indexOf(".")+4));
				}	
			}
			
			if($('[id="${fieldName}"]').attr("data-decimal") == 2) {
				if(cont != '' && cont.indexOf(".") != -1) {
					afterDecimal = cont.substring(cont.indexOf(".")+1, cont.length);
				}
				if(afterDecimal == null && integer > 0) {
					$('[id="${fieldName}"]').val(cont+".00");
				} 
				else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length==1) {
					$('[id="${fieldName}"]').val(cont+"0");
				}
				else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length>2) {
					$('[id="${fieldName}"]').val(cont.substring(0, cont.indexOf(".")+3));
				}
			}
			
			if($('[id="${fieldName}"]').attr("onkeypress") !== undefined){
				$('[id="${fieldName}"]').removeAttr("onkeypress");
				$('[id="${fieldName}"]').keypress(isCurrencyExceedLength);
				
			}
			//$('#${inputNumberId}').number(true,2);
			
			
		}
		$('[id="${fieldName}"]').keyup(isCurrencyExceedLength);
	});
	
	$('[id="${fieldName}"]').keyup(isCurrencyExceedLength);
	
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

	// $('[id*="${fieldName}"]').keyup(isCurrencyExceedLength);

	function isCurrencyExceedLength(){
		var currentLength = $('[id="${fieldName}"]').val().length;
		var maxLength = parseInt($('[id="${fieldName}"]').attr("maxlength"));
		currentVal = $('[id="${fieldName}"]').val();

		var decimalLength = 2;
		var arrCurrNo3Dec = ["BHD", "IQD", "JOD", "KWD", "LYD", "OMR", "TND"];
		if(jQuery.inArray(selectedCurr, arrCurrNo3Dec) >= 0) {
			decimalLength = 3;
		}
		//if(currentVal.indexOf(".") == -1 && currentLength == maxLength)
		if(currentVal.indexOf(".") == -1 && currentLength + decimalLength >= maxLength)
		{
			$('[id="${fieldName}"]').val(currentVal.substring(0, currentLength-1));
		}
		if(currentVal.indexOf(".") + decimalLength >= maxLength)
		{
			var modCont = currentVal.substring(0, currentVal.indexOf("."));
			$('[id="${fieldName}"]').val(modCont);
		}
			
	}
	
	if($('[id*="${fieldName3}"]').prop('checked')){
		$('[id*="${fieldName2}"]').prop('disabled', false);
		$('[id*="${fieldName}"]').prop('disabled', false);
	}

	$('[id="${fieldName3}"]').click( function(event) {
		if($(this).prop('checked')){
			$('[id*="${fieldName2}"]').prop('disabled', false);
			
			if($('[id*="${fieldName2}"]').val() == ''){
				$('[id*="${fieldName2}"]').val($('[name*="${billCur}"]').val());
			} 
			
			$('[id*="${fieldName}"]').prop('disabled', false);
			var checkedVal = $('[id*="${fieldName3}"]').val();
			var othrtext = $('[id*="${fieldName3}otherTxt"]').val();
			if(checkedVal == 'OTHR' || othrtext == checkedVal)
			{
				$('[id*="${fieldName3}otherTxt"]').prop('hidden', false);
			} 
			
			selectedCurr = $('[id="${fieldName2}"]').val();
			var arrCurrNo3Dec = ["BHD", "IQD", "JOD", "KWD", "LYD", "OMR", "TND"];
			if(jQuery.inArray(selectedCurr, arrCurrNo3Dec) >= 0) {
				$('[id="${fieldName}"]').attr("data-decimal", "3");
			} else {
				$('[id="${fieldName}"]').attr("data-decimal", "2");
			}
			$('[id="${fieldName}"]').removeAttr("onkeyup");
			if(isCurrencyExcempted(selectedCurr)){
				console.log("Currency must have no decimal point...");
				$('[id="${fieldName}"]').removeAttr("data-decimal");
				$('[id="${fieldName}"]').attr("onkeypress", "return event.charCode >= 48 && event.charCode <= 57");
				
				if($('[id="${fieldName}"]').val() !== undefined || $('[id="${fieldName}"]') != ''){
					var cont = $('[id="${fieldName}"]').val();
					var modCont = cont.substring(0, cont.indexOf("."));
					$('[id="${fieldName}"]').val(modCont);
				}
				
			} else {
				if($('[id="${fieldName}"]').attr("data-decimal") == undefined){
					$('[id="${fieldName}"]').attr("data-decimal", "2");
				}

				var cont = $('[id="${fieldName}"]').val();
				var integer =  cont.substring(0, cont.indexOf("."));
				var afterDecimal;
				if($('[id="${fieldName}"]').attr("data-decimal") == 3) {
					if(cont != '' && cont.indexOf(".") != -1) {
						afterDecimal = cont.substring(cont.indexOf(".")+1, cont.length);
					}
					if(afterDecimal == null && integer > 0) {
						$('[id="${fieldName}"]').val(cont+".000");
					} 
					else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length==1) {
						$('[id="${fieldName}"]').val(cont+"00");
					}
					else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length==2) {
						$('[id="${fieldName}"]').val(cont+"0");
					}
					else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length>3) {
						$('[id="${fieldName}"]').val(cont.substring(0, cont.indexOf(".")+4));
					}	
				}
				
				if($('[id="${fieldName}"]').attr("data-decimal") == 2) {
					if(cont != '' && cont.indexOf(".") != -1) {
						afterDecimal = cont.substring(cont.indexOf(".")+1, cont.length);
					}
					if(afterDecimal == null && integer > 0) {
						$('[id="${fieldName}"]').val(cont+".00");
					} 
					else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length==1) {
						$('[id="${fieldName}"]').val(cont+"0");
					}
					else if((afterDecimal != undefined || afterDecimal != null) && afterDecimal.length>2) {
						$('[id="${fieldName}"]').val(cont.substring(0, cont.indexOf(".")+3));
					}
				}
				
				if($('[id="${fieldName}"]').attr("onkeypress") !== undefined){
					$('[id="${fieldName}"]').removeAttr("onkeypress");
					$('[id="${fieldName}"]').keypress(isCurrencyExceedLength);
					
				}
				//$('#${inputNumberId}').number(true,2);
				
				
			}
			$('[id="${fieldName}"]').keyup(isCurrencyExceedLength);
			
		} else {
			$('[id*="${fieldName2}"]').val('');
			$('[id*="${fieldName}"]').val('');
			$('[id*="${fieldName2}"]').prop('disabled', true);
			$('[id*="${fieldName}"]').prop('disabled', true);
			$('[id*="${fieldName3}otherTxt"]').prop('hidden', true);
		}
		
	});

});




var othAmt;
$('[id*="${fieldName}"]').on("keyup",function (event) { 
	othAmt = $('[id*="${fieldName}"]').val();
});

$('[id*="${fieldName3}otherTxt"]').click( function(event) {
	$('[id*="${fieldName3}otherTxt"]').prop('hidden', false);
	$('[id*="${fieldName2}"]').prop('disabled', false);
	$('[id*="${fieldName}"]').prop('disabled', false);
	$('[id*="${fieldName3}otherTxt"]').focus();
	$('[id*="${fieldName2}"]').val($('[name*="${billCur}"]').val());	
	$('[id*="${fieldName}"]').val(othAmt);	
});

$('[id*="${fieldName3}otherTxt"]').on("keyup",function (event) { 
	var othrtext = $('[id*="${fieldName3}otherTxt"]').val();
	$('[id*="${fieldName3}"]').val(othrtext);
	var totalLength = $('[id*="${fieldName}"]').val().length + $('[id*="${fieldName2}"]').val().length + $('[id*="${fieldName3}otherTxt"]').val().length;
	if (totalLength > 34) {
		event.preventDefault();
		swal("","<spring:message code='label.impbills.charges.length.error'/>" ,"error");
	}
});

// $('[id*="${fieldName}"]').on("keypress",function (event) { 
// 	var totalLength = $('[id*="${fieldName}"]').val().length + $('[id*="${fieldName2}"]').val().length + $('[id*="${fieldName3}otherTxt"]').val().length;
// 	if (totalLength > 34) {
// 		event.preventDefault();
// 		swal("","<spring:message code='label.impbills.charges.length.error'/>" ,"error");
// 	}
// });

// $('[id*="${fieldName2}"]').on("change",function (event) { 
// 	selectedCurr = this.value;
// 	var arrCurrNo3Dec = ["BHD", "IQD", "JOD", "KWD", "LYD", "OMR", "TND"];
// 	if(jQuery.inArray(selectedCurr, arrCurrNo3Dec) >= 0) {
// 		$('[id*="${fieldName}"]').attr("data-decimal", "3");
// 	} else {
// 		$('[id*="${fieldName}"]').attr("data-decimal", "2");
// 	}
	
// 	var totalLength = $('[id*="${fieldName}"]').val().length + $('[id*="${fieldName2}"]').val().length + $('[id*="${fieldName3}"]').val().length;
// 	if (totalLength > 35) {
// 		swal("","<spring:message code='label.impbills.charges.length.error'/>" ,"error");
// 	}
// });
</script>

