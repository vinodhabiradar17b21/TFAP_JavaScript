<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<tfap:modal button_name="label.modal.button.submit"
	modal_title="label.modal.title.rejection" modal_Id="modal_confirm_reject"
	show_button_primary="true"
	show_button_cancel="true"
	primary_btn_id="modal_confirm_reject_btn"
	modal_size="lg">

	<div class="row">
		<div class="col-12 mb-1">
			<label for="modal_reject_remarks">Reason</label>
			<textarea id="modal_reject_remarks" class="form-control required" rows="3" ></textarea>
			<span id="modal_compbill_reject_remarks.errors" class="red d-none">Reason is required.</span>
		</div>
	</div>
</tfap:modal>
	

<div class="modal fade text-left" id="modal_viewdiscrep_add" tabindex="-1"
	role="dialog" style="display: none;" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div id="modal_viewdiscrep_add_body"></div>
	</div>
</div>

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modals_compbill_accept"
	show_button_primary="false">
	<div class="row">
		<div class="col-12 mb-1">
			<h4>You have accepted the bill!</h4>
		</div>
	</div>
</tfap:modal>

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.fail" modal_Id="modals_compbill_accept_error"
	show_button_primary="false">
	<div class="row">
		<div class="col-12 mb-1">
			<h4>Error while accepting the bill!</h4>
		</div>
	</div>
</tfap:modal>

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modals_reject"
	show_button_primary="false">
	<div class="row">
		<div class="col-12 mb-1">
			<h4>Bill has been rejected!</h4>
		</div>
	</div>
</tfap:modal>

<script type="text/javascript">
	var appId = '';
	var docType = '';
	var dataTable = '';
	
	function openCompBillRejectModal(_tfapId, _docType, _dataTable){
		appId = _tfapId;
		docType = _docType;
		dataTable = (_dataTable)? _dataTable:dataTable;		
		$('#modal_confirm_reject').modal('show');
	}
	
	function redirect(){
		window.location.href="${pageContext.request.contextPath}/tfImpBillSummary/list/view";
	}
	
	function rejectConfirmCallback() {
		
		var data = new FormData();
		var path = "";
		data.append("transactionId", appId);
		data.append("docType", docType);
		data.append("action", "reject");
		data.append("remarks", $('#modal_reject_remarks').val());
		if(docType == 'IBLCN' || docType == 'IBULC')
			path = "../../importBillLc/updateBill"
		else
			path = "../../tfImpBillCol/updateBill"
			
		$.ajax({
		    url: path,
		    type: 'post',
		    cache: false,
		    contentType: false,
		    processData: false,
		    data: data,
		    beforeSend: function(){
				$('[id="modal_compbill_reject_remarks.errors"]').addClass('d-none');
		    },
		    success: function( data, textStatus, jQxhr ){
		    	data = JSON.parse(data);
		        if(data.success){
		        	$('#modal_confirm_reject').modal('hide');
		    		$('#modals_reject').modal('show');		    	
		        }
		        else if(data.errors.length > 0){
					$.each(data.errors, function(i, error){
						if(error.key == 'transactionId' || error.key == 'docType'){
							
						}else if(error.key == 'remarks' && error.value == false){
							$('[id="modal_compbill_reject_remarks.errors"]').removeClass('d-none');			
						}
					});
				}
		    },
		    error: function( jqXhr, textStatus, errorThrown ){
		        
		    }
		});
	}
	
	function acceptBill(_tfapId, _docType, _dataTable) {
		
		var data = new FormData();
		var path = "";
		data.append("transactionId", _tfapId);
		data.append("docType", _docType);
		data.append("action", "accept");
		dataTable = (_dataTable)? _dataTable:dataTable;		
		if(_docType == 'IBLCN' || _docType == 'IBULC')
			path = "../../importBillLc/updateBill"
		else
			path = "../../tfImpBillCol/updateBill"
			
		$.ajax({
		    url: path,
		    type: 'post',
		    cache: false,
		    contentType: false,
		    processData: false,
		    data: data,
		    success: function( data, textStatus, jQxhr ){
		    	data = JSON.parse(data);
		    	if(data.success) 
	    			$('#modals_compbill_accept').modal('show');	
		    	else
	    			$('#modals_compbill_accept_error').modal('show');	
		    },
		    error: function( jqXhr, textStatus, errorThrown ){
		        
		    }
		});
	}
	$('#modals_reject, #modals_compbill_accept').on('hidden.bs.modal', function (e) {
		if(dataTable != ''){
			dataTable.draw();
		}else{
			window.location = redirectUrl;
		}
	})
	
	$(document).ready(function(){
		$('#modal_confirm_reject_btn').removeAttr('data-dismiss');
		
		$('#modal_confirm_reject').on('hidden.bs.modal', function(e) {
			$('#modal_confirm_reject input').val('').change();
			$('#modal_confirm_reject textarea').val('').change();
		});	
		
		$('#modal_confirm_reject_btn').on('click', function(e){
			rejectConfirmCallback();
		})
	});
</script>