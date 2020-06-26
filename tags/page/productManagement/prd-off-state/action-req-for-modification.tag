<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modals_reject"
	show_button_primary="false">
	<div class="row">
		<h4 style="text-align: center;">The application has been requested for modification !</h4>
	</div>
</tfap:modal>

<tfap:modal button_name="label.bank.button"
			modal_title="label.bank.maker.approver.check" modal_Id="modal_maker_checker_verify_id"
			show_button_close="false" show_button_primary="false">
			<br />
			<div class="modal-content">
				<div class="modal-body">
					<h4 style="text-align: center;"><spring:message code="modal.checker.maker.restrict.message"/></h4>
				</div>
				<div class="modal-footer" style="margin-top: -20px;">
					<button type="button" class="btn btn-outline-primary mr-1"
						id="redirect" onclick="redirect()"
						href="${pageContext.request.contextPath}/tfApplication/list/view"
						data-dismiss="modal">
						<spring:message code='label.modal.button.close' />
					</button>
				</div>
			</div>
</tfap:modal>

<tfap:modal button_name="label.modal.button.submit"
	modal_title="label.modal.title.reqForModification" modal_Id="modal_confirm_reject"
	show_button_primary="true"
	show_button_cancel="true"
	primary_btn_id="modal_confirm_reject_btn"
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
	var tfboId = '';
	var dataTable = '';
	
	function openRejectModal(_tfboId, _dataTable){
		tfboId = _tfboId;
		dataTable = (_dataTable)? _dataTable:dataTable;
		var makerCompanyCheck = '${makerComApproverCheck}';
		if(makerCompanyCheck === 'RESTRICT'){
			$('#modal_maker_checker_verify_id').modal('show');
		}else
			$('#modal_confirm_reject').modal('show');
	}
	
	function redirect(e){
		window.location.href="/TFAPortal/tfApplication/product-management/prd-offering/list/";
	}


	function rejectConfirmCallback() {
		
		var data = new FormData();
	
		data.append("tfboId", tfboId);
		data.append("remarks", $('#modal_reject_remarks').val());

		$.ajax({
		    url: "/TFAPortal/tfApplication/product-management/bank/modify",
		    type: 'post',
		    cache: false,
		    contentType: false,
		    processData: false,
		    data: data,
		    beforeSend: function(){
				$('[id="modal_reject_remarks.errors"]').addClass('d-none');
		    },
		    success: function( data, textStatus, jQxhr ){
		    	data = JSON.parse(data);
		        if(data.reject){
		        	redirectUrl = data.redirect;
		        	$('#modal_confirm_reject').modal('hide');
		    		$('#modals_reject').modal('show');		    	
		        }
		        else if(data.errors.length > 0){
					$.each(data.errors, function(i, error){
						if(error.key == 'tfboId'){
							
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
	
	$('#modals_reject').on('hidden.bs.modal', function (e) {
		if(dataTable != ''){
			dataTable.draw();
		}else{
			window.location = "/TFAPortal/tfApplication/product-management/"+redirectUrl;
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