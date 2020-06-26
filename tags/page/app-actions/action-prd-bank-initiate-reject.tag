<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>


<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modals_bank_reject"
	show_button_primary="false">
	<div class="row">
		<h4 style="text-align: center;">Initiated rejection for the subscription!</h4>
	</div>
</tfap:modal>
<tfap:modal button_name="label.bank.button"
			modal_title="label.bank.maker.approver.check" modal_Id="modal_maker_approver_verification_id"
			show_button_close="false" show_button_primary="false">
			<br />
			<div class="modal-content">
				<div class="modal-body">
					<h4 style="text-align: center;">
You are not allowed to modify this transaction as you have previously used another role to process this transaction.</h4>
				</div>
				<div class="modal-footer" style="margin-top: -20px;">
					<button type="button" class="btn btn-outline-primary mr-1"
						id="redirect_to_main" onclick="redirectToMain()"
						href="${pageContext.request.contextPath}/tfApplication/product-management/prd-approval-list/view"
						data-dismiss="modal">
						<spring:message code='label.modal.button.close' />
					</button>
				</div>
			</div>
</tfap:modal>


<tfap:modal button_name="label.modal.button.submit"
	modal_title="label.reject.reason" modal_Id="modal_confirm_initiate_reject"
	show_button_primary="true"
	show_button_cancel="true"
	primary_btn_id="modal_confirm_initiate_reject_btn"
	modal_size="lg">

	<div class="row">
		<div class="col-12 mb-1">
			<label for="modal_reject_remarks">Reason for rejection</label>
			<textarea id="modal_reject_remarks" class="form-control required" rows="3" ></textarea>
			<span id="modal_reject_remarks.errors" class="red d-none">Reason is required.</span>
		</div>
	</div>
</tfap:modal>

<script>

var appId = '';
var action = '';
function openInitiateRejectModal(_tfapId){
	appId = _tfapId;
	var makerApproverCheckflag = '${makerApproverCheck}';
	if(makerApproverCheckflag === 'RESTRICT'){
		$('#modal_maker_approver_verification_id').modal('show');
	}else 
		$('#modal_confirm_initiate_reject').modal('show');
}

function redirectToMain(e){
	window.location.href="${pageContext.request.contextPath}/tfApplication/product-management/prd-approval-list/view";
}

function rejectConfirmCallback() {
	
	var data = new FormData();
	//var action = 'REJECTING';

	data.append("transactionId", appId);
	data.append("remarks", $('#modal_reject_remarks').val());
	/* $.each($('#modal_reject_upload_files')[0].files, function(i, file){
		data.append("files", $('#modal_reject_upload_files')[0].files[i]);
	}) */

	$.ajax({
	    url:  "/TFAPortal/tfApplication/state-action-prd/prd/bank/inirejection",
	    type: 'post',
	    cache: false,
	    contentType: false,
	    processData: false,
	    data: data,
	    beforeSend: function(){
	    	//isSubmitting(true);
			$('[id="modal_reject_remarks.errors"]').addClass('d-none');
	    },
	    success: function( data, textStatus, jQxhr ){
	    	data = JSON.parse(data);
	        if(data.reject){
	        	redirectUrl = data.redirect;
	        	$('#modal_confirm_initiate_reject').modal('hide');
	    		$('#modals_bank_reject').modal('show');		    	
	        }
	        else if(data.errors.length > 0){
				$.each(data.errors, function(i, error){
					if(error.key == 'transactionId'){
						console.log("error with transactionId");
					}else if(error.key == 'remarks' && error.value == false){
						$('[id="modal_reject_remarks.errors"]').removeClass('d-none');			
					}
				});
			}
	    },
	    error: function( jqXhr, textStatus, errorThrown ){
	        
	    }
	});
}


$('#modals_bank_reject').on('hidden.bs.modal', function (e) {
	/* if(dataTable != ''){
		dataTable.draw();
	}else{ */
		window.location = redirectUrl;
	/* } */
})

$(document).ready(function(){
	$('#modal_confirm_initiate_reject_btn').removeAttr('data-dismiss');
	
	$('#modal_confirm_initiate_reject').on('hidden.bs.modal', function(e) {
		$('#modal_confirm_initiate_reject input').val('').change();
		$('#modal_confirm_initiate_reject textarea').val('').change();
	});	
	
	$('#modal_confirm_initiate_reject_btn').on('click', function(e){
		rejectConfirmCallback();
	})
});

/* function isSubmitting(state){
	if(state){
		$('#modal_confirm_initiate_reject_btn').attr('disabled', 'disabled');
	}else{
		$('#modal_confirm_initiate_reject_btn').removeAttr('disabled');
	}
}
 */
</script>