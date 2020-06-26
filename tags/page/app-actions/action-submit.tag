<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="modal fade text-left" id="modal_confirm_agree" tabindex="-1"
	role="dialog" aria-labelledby="agreemyModalLabel17" style="display: none;"
	aria-hidden="true" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="agreemyModalLabel17">
					<spring:message code="label.modal.title.terms" />
				</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>

			<div class="modal-body" id="cancelModal">
				<div class="text_instruction">
					<strong><spring:message code="label.bankspecific.terms" /></strong><br>
					<fieldset class="checkboxsas">
						<label class="space-checkbox-radio-f"> <input type="checkbox"
							value="" id="terms-checkbox" /> I hereby agree to following terms and
							conditions presented by the bank. <a
							href="#" id="tnc_link"
							class="tnc_link" title="View Terms &amp; Conditions">View Terms
								&amp; Conditions</a>
						</label>
					</fieldset>
				</div>
			</div>
			<div class="modal-footer" style="margin-top: -20px;">
					<button type="button" class="btn btn-outline-primary mr-1"
						data-dismiss="modal">
						<spring:message code="label.modal.button.close" />
					</button>
					<button type="button" id="modal_can_primary" class="btn btn-primary" >
						<spring:message code="label.modal.button.agree" />
					</button>
			</div>
		</div>
	</div>
</div>	

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modal_auth_submitted"
	show_button_primary="false">
	<h4 style="text-align: center;">
The application has been submitted.</h4>
</tfap:modal>

<tfap:modal button_name="label.bank.button"
			modal_title="label.bank.maker.approver.check" modal_Id="modal_maker_approver_verification_id"
			show_button_close="false" show_button_primary="false">
			<br />
			<div class="modal-content">
				<div class="modal-body">
					<h4 style="text-align: center;"><spring:message code="modal.checker.maker.restrict.message"/></h4>
				</div>
				<div class="modal-footer" style="margin-top: -20px;">
					<button type="button" class="btn btn-outline-primary mr-1"
						id="redirect_to_main" onclick="redirectToMain()"
						href="${pageContext.request.contextPath}/tfApplication/list/view"
						data-dismiss="modal">
						<spring:message code='label.modal.button.close' />
					</button>
				</div>
			</div>
</tfap:modal>

<tfap:tfapconfirmationmodal
	button_name="label.modal.button.yes"
	modal_title="label.modal.title.confirmation" 
	modal_Id="modal_confirm_submit"
	primary_btn_id="btn_confirm_submit"
	message="label.modal.message.confirmation.submit"
	callback="submitCallback()"/>
	
<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.error" modal_Id="modal_auth_failed"
	show_button_primary="false">
	<h3 style="text-align: center;">Please try again!</h3>
	<h4 style="text-align: center;">If the error persists, kindly contact the TFAP Support Team using the TFAP ID as reference.</h4>
</tfap:modal>

	
<script type="text/javascript">
$(document).ready(function(){
	var appId = '';
	var docType = '';
	var dataTable = '';
	 $('#modal_can_primary').attr('disabled', 'disabled');
	 
	 $('#terms-checkbox').on('click', function(){
			if($(this).prop('checked')){
				$('#modal_can_primary').removeAttr('disabled');
			}else{
				$('#modal_can_primary').attr('disabled', 'disabled');
			}
	});
	 
});

function openSubmitModal(_tfapId, _docType, _dataTable){
	appId = _tfapId;
	docType = _docType;
	dataTable = (_dataTable)? _dataTable:dataTable;
	var makerComApproverCheck = '${makerComApproverCheck}';

	if(appId!=null && docType!=null){
		openSubmitValid(appId, docType, makerComApproverCheck);
	} 
}

function openSubmitValid(appId, docType, makerComApproverCheck){

	 $.ajax({
			url: "${pageContext.request.contextPath}/tfApplication/validate/recordOwnStatus?tfapId="+appId,
			type:"POST",
			success: function(result){
				var isRecordOpen = result;
				if(isRecordOpen!=null && isRecordOpen == 'true'){
					swal({
						title: '<spring:message code="message.record.tfaprecord.open"/>',
						icon: "warning",
						buttons: ["<spring:message code='message.record.confirm.cancel'/>","<spring:message code='message.record.confirm.ok'/>"],
						dangerMode: true,
					})
					.then(function(willDelete) {
					  if (willDelete) {
						  openSubmitAdditional(appId, docType, makerComApproverCheck);
					  }
					});
				}else{
					openSubmitAdditional(appId, docType, makerComApproverCheck);	
				}
			}
		});	

	}


function openSubmitAdditional(appId ,docType, makerComApproverCheck){
	if(makerComApproverCheck === 'RESTRICT'){
		$('#modal_maker_approver_verification_id').modal('show');
	}else if(appId.substring(0,5)==="LCCAN"){
		openAgreeTerms();
	}else{
		if(docType == 'IBLCN' || docType =='IBCON' || docType =='IBCOL' || docType =='IBULC' || docType =='IMPST' || docType =='ISDEB' || docType =='ISILN' || docType =='ISOTH'){
			$('#modal_confirm_submit').modal('show'); 
		}else{
			openAgreeTerms();
		}
	 //$('#modal_confirm_submit').modal('show'); 
	}
}
	
	
	function openAgreeTerms(){
		$('#tnc_link').attr('href', '/TFAPortal/tfApplication/product-management/prd-sub/redirecttnc?flag=prd&id='+appId);
		$('#modal_confirm_agree').modal('show');
		$('#modal_confirm_agree #modal_can_primary').on('click', function(e){
			e.preventDefault();
			$('#modal_confirm_agree').modal('hide');
			$('#modal_confirm_submit').modal('show'); 
		});
	}
	
	function submitCallback(){
		$("#pageloader").fadeIn();
		
		$.get("/TFAPortal/tfApplication/state-action/app/submitauth?tfapid=" + appId+"&doc_type="+docType, function(data, status) {
			$("#pageloader").fadeOut();
			$('#modal_auth_submitted').modal('show');
			data = JSON.parse(data);
			redirectUrl = data.redirect;
		}).fail(function(){
			$("#pageloader").fadeOut();
			$('#modal_auth_failed').modal('show');
		});
	}
	
	$('#modal_auth_submitted').on('hidden.bs.modal', function (e) {
		if(dataTable != ''){
			dataTable.draw();
		}else{
			window.location = redirectUrl;
		}
	})

</script>