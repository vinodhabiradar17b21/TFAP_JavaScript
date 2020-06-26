<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modals_bank_reject"
	show_button_primary="false">
	<div class="row">
		<h4 style="text-align: center;">Previous action has been rejected</h4>
	</div>
</tfap:modal>

<tfap:modal button_name="label.modal.button.submit"
	modal_title="label.modal.title.rejection" modal_Id="modal_bank_confirm_reject"
	show_button_primary="true"
	show_button_cancel="true"
	primary_btn_id="modal_bank_confirm_reject_btn"
	modal_size="lg">

	<div class="row">
		<div class="col-12 mb-1">
			<label for="modal_reject_remarks">Reason</label>
			<textarea id="modal_reject_remarks" class="form-control required" rows="3" ></textarea>
			<span id="modal_reject_remarks.errors" class="red d-none">Reason is required.</span>
		</div>
	</div>
</tfap:modal>


<script type="text/javascript">
	$(document).ready(function() {
		$('#modal_bank_confirm_reject_btn').removeAttr('data-dismiss');
	});
</script>

<script type="text/javascript">
	var appId = '';
	var docType = '';
	var dataTable = '';
	var action = 'REJECT';

	
	function openBankRejectModal(_tfapId, _docType,_dataTable) {
		appId = _tfapId;
		docType = _docType;
		dataTable = (_dataTable) ? _dataTable : dataTable;
		$('#modal_bank_confirm_reject').modal('show');
	}

	function bankRejectCallback() {
		var data = new FormData();
	
		data.append("transactionId", appId);
		data.append("docType", docType);
		data.append("remarks", $('#modal_reject_remarks').val());
		data.append("action", action);
		/* $.each($('#modal_reject_upload_files')[0].files, function(i, file){
			data.append("files", $('#modal_reject_upload_files')[0].files[i]);
		}) */

		$.ajax({
		    url: rootUrl + "/bank/reject",
		    type: 'post',
		    cache: false,
		    contentType: false,
		    processData: false,
		    data: data,
		    beforeSend: function(){
		    	isSubmitting(true);
				$('[id="modal_reject_remarks.errors"]').addClass('d-none');
		    },
		    success: function( data, textStatus, jQxhr ){
		    	data = JSON.parse(data);
		        if(data.reject){
		        	redirectUrl = data.redirect;
		        	$('#modal_bank_confirm_reject').modal('hide');
		    		$('#modals_bank_reject').modal('show');		    	
		        }
		        else if(data.errors.length > 0){
					$.each(data.errors, function(i, error){
						if(error.key == 'transactionId' || error.key == 'docType'){
							
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

	$('#modals_bank_reject').on('hidden.bs.modal', function(e) {
		if (dataTable != '') {
			dataTable.draw();
		} else {
			window.location = redirectUrl;
		}
	});
	
	$('#modal_bank_confirm_reject').on('hidden.bs.modal', function(e) {
		$('#modal_bank_confirm_reject input').val('').change();
		$('#modal_bank_confirm_reject textarea').val('').change();
	});
	
	$('#modal_bank_confirm_reject_btn').on('click', function(e){
		bankRejectCallback();
	})
	
	function isSubmitting(state){
		if(state){
			$('#modal_bank_confirm_reject_btn').attr('disabled', 'disabled');
		}else{
			$('#modal_bank_confirm_reject_btn').removeAttr('disabled');
		}
	}
</script>