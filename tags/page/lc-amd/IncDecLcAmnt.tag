<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<p>
 <label for="">Increase/Decrease LC Amount</label>
  <span class="input-group">
  	<span class="input-group-append input-switch-group">
	  	
		      <label class="input-switch w110"><input type="radio" name="change-lc-amt" id="increase" value="increase"><span>Increase</span></label>
		      <label class="input-switch w110"><input type="radio" name="change-lc-amt" id="decrease" value="decrease"><span>Decrease</span></label>
	  		
	</span>
		<spring:bind path="lc.tfDocLcIssuance.tfdlcAmtAmendInc">
			<tfap:tfapdecimalinput-no-label fieldName="lc.tfDocLcIssuance.tfdlcAmtAmendInc" maxVal="15" maxlength="true" decimallength="2"/>
		</spring:bind>
		
		<spring:bind path="lc.tfDocLcIssuance.tfdlcAmtAmendDec">
			<tfap:tfapdecimalinput-no-label fieldName="lc.tfDocLcIssuance.tfdlcAmtAmendDec" maxVal="15" maxlength="true" decimallength="2"/>
			<span id="tfdlcAmtAmendDec.errors" class="red d-none"><spring:message code = "amd.error.amount"/></span>
		</spring:bind>
  </span>
</p>

<script>
	$(document).ready(function(){
		//$("#increase").prop('checked', true);
		
		
		$('#increase, #decrease').on('change', function(){
			if($(this).val()=='increase'){
				$('#lc\\.tfDocLcIssuance\\.tfdlcAmtAmendInc').show()
				$('#lc\\.tfDocLcIssuance\\.tfdlcAmtAmendDec').hide()
				$('#lc\\.tfDocLcIssuance\\.tfdlcAmtAmendDec').val('')
			}else if($(this).val()=='decrease'){
				$('#lc\\.tfDocLcIssuance\\.tfdlcAmtAmendInc').hide()
				$('#lc\\.tfDocLcIssuance\\.tfdlcAmtAmendDec').show()
				$('#lc\\.tfDocLcIssuance\\.tfdlcAmtAmendInc').val('')
			}
			
		});
		
		$("#lc\\.tfDocLcIssuance\\.tfdlcAmtAmendDec").mouseleave(function(){
			var val1 = $("#lc\\.tfDocLcIssuance\\.tfdlcAmt").val();
			var val2 = $("#lc\\.tfDocLcIssuance\\.tfdlcAmtAmendDec").val();
			if(parseFloat(val2) >= parseFloat(val1)){
				$('[id="tfdlcAmtAmendDec.errors"]').removeClass('d-none');
				$("#lc\\.tfDocLcIssuance\\.tfdlcAmtAmendDec").val('');
			}
		});
		
		
		
		var disableCheckbox = ${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}

			
			if($('#lc\\.tfDocLcIssuance\\.tfdlcAmtAmendDec').val() == ''){
				$("#increase").trigger("click");
				if(disableCheckbox){
					$('#increase, #decrease').prop('disabled', true);					
				}
			}else if($('#lc\\.tfDocLcIssuance\\.tfdlcAmtAmendInc').val() == ''){
				$("#decrease").trigger("click");
				if(disableCheckbox){
					$('#increase, #decrease').prop('disabled', true);					
				}
			}

	});
</script>