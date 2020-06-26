<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<p>
 <label for="">Increase/Decrease BG Amount</label>
  <span class="input-group">
  	<span class="input-group-append input-switch-group">
	  	
		      <label class="input-switch" style="width: 120px; line-height: 35px;"><input type="radio" id="increase" name="change-bg-amt" value="increase"><span>Increase</span></label>
		      <label class="input-switch" style="width: 120px; line-height: 35px;"><input type="radio" id="decrease" name="change-bg-amt" value="decrease"><span>Decrease</span></label>
	  		
	</span>
		<spring:bind path="bg.tfDocBgIssuance.tfdbgUndertakingAmtInc">
			<tfap:tfapdecimalinput-no-label fieldName="bg.tfDocBgIssuance.tfdbgUndertakingAmtInc" maxVal="15" maxlength="true" decimallength="2"/>
		</spring:bind>
		
		<spring:bind path="lc.tfDocLcIssuance.tfdlcAmtAmendDec">
			<tfap:tfapdecimalinput-no-label fieldName="bg.tfDocBgIssuance.tfdbgUndertakingAmtDec" maxVal="15" maxlength="true" decimallength="2"/>
			<span id="tfdlcAmtAmendDec.errors" class="red d-none"><spring:message code = "amd.error.amount"/></span>
		</spring:bind>
  </span>
</p>

<script>
	$(document).ready(function () {
		//$("#increase").prop('checked', true);


		$('#increase, #decrease').on('change', function () {
			if ($(this).val() == 'increase') {
				$('#bg\\.tfDocBgIssuance\\.tfdbgUndertakingAmtInc').show()
				$('#bg\\.tfDocBgIssuance\\.tfdbgUndertakingAmtDec').hide()
				$('#bg\\.tfDocBgIssuance\\.tfdbgUndertakingAmtDec').val('')
			} else if ($(this).val() == 'decrease') {
				$('#bg\\.tfDocBgIssuance\\.tfdbgUndertakingAmtInc').hide()
				$('#bg\\.tfDocBgIssuance\\.tfdbgUndertakingAmtDec').show()
				$('#bg\\.tfDocBgIssuance\\.tfdbgUndertakingAmtInc').val('')
			}
		});

		$("#bg\\.tfDocBgIssuance\\.tfdbgUndertakingAmtDec").mouseleave(function () {
			var val1 = $("#bg\\.tfDocBgIssuance\\.tfdbgUndertakingAmt").val();
			var val2 = $("#bg\\.tfDocBgIssuance\\.tfdbgUndertakingAmtDec").val();
			if (parseFloat(val2) >= parseFloat(val1)) {
				$('[id="tfdlcAmtAmendDec.errors"]').removeClass('d-none');
				$("#bg\\.tfDocBgIssuance\\.tfdbgUndertakingAmtDec").val('');
			}
		});


		var disableCheckbox =
		${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}

		if ($('#bg\\.tfDocBgIssuance\\.tfdbgUndertakingAmtDec').val() == '') {
			$("#increase").trigger("click");
			if (disableCheckbox) {
				$('#increase, #decrease').prop('disabled', true);
			}
		} else if ($('#bg\\.tfDocBgIssuance\\.tfdbgUndertakingAmtInc').val() == '') {
			$("#decrease").trigger("click");
			if (disableCheckbox) {
				$('#increase, #decrease').prop('disabled', true);
			}
		}

	});
</script>