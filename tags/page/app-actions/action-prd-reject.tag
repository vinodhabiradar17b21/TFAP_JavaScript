<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modals_reject"
	show_button_primary="false">
		<c:choose>
			<c:when test="${productSubscriptionDTO.reqType eq 'Link'}">
				<h4 style="text-align: center;">The application has been returned for modification.</h4>
			</c:when>
			<c:otherwise>
				<h4 style="text-align: center;">Previous action has been declined!</h4>
			</c:otherwise>
		</c:choose>
</tfap:modal>

<tfap:modal button_name="label.bank.button"
			modal_title="label.bank.maker.approver.check" modal_Id="modal_maker_checker_verify_id"
			show_button_close="false" show_button_primary="false">
			<br />
			<div class="modal-content">
				<div class="modal-body">
					<h4 style="text-align: center;">You are not allowed to modify this transaction as you have previously used another role to process this transaction.</h4>
				</div>
				<div class="modal-footer" style="margin-top: -20px;">
					<button type="button" class="btn btn-outline-primary mr-1"
						id="redirect" onclick="redirect()"
						href="${pageContext.request.contextPath}/tfApplication/product-management/prd-approval-list/view"
						data-dismiss="modal">
						<spring:message code='label.modal.button.close' />
					</button>
				</div>
			</div>
</tfap:modal>

<c:choose>
	<c:when test="${productSubscriptionDTO.reqType eq 'Link'}">
		<tfap:modal button_name="label.modal.button.submit"
			modal_title="label.modal.title.reqForModification" modal_Id="modal_confirm_reject"
			show_button_primary="true"
			show_button_cancel="true"
			primary_btn_id="modal_confirm_reject_btn"
			modal_size="lg">
		
			<div class="row">
				<div class="col-12 mb-1">
					<label for="modal_reject_remarks"><spring:message code="label.modal.sub.title.reqForModification.reason"/></label>
					<textarea id="modal_reject_remarks" class="form-control required" rows="3" ></textarea>
					<span id="modal_reject_remarks.errors" class="red d-none">Reason is required.</span>
				</div>
			</div>
		</tfap:modal>
	</c:when>
	<c:otherwise>
		<tfap:modal button_name="label.modal.button.submit"
			modal_title="label.modal.title.decline" modal_Id="modal_confirm_reject"
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
	</c:otherwise>
</c:choose>
	
	
<script type="text/javascript">
	var appId = '';
	
	function openRejectModal(_tfapId, _newState){
		appId = _tfapId;
		newState = _newState;
		
		var makerApproverCheck = '${makerApproverCheck}';
		if(makerApproverCheck === 'RESTRICT'){
			$('#modal_maker_checker_verify_id').modal('show');
		}else
			$('#modal_confirm_reject').modal('show');
	}
	
	function redirect(e){
		window.location.href="${pageContext.request.contextPath}/tfApplication/product-management/prd-approval-list/view";
	}
	
	function rejectConfirmCallback() {
		
		var data = new FormData();
	
		data.append("transactionId", appId);
		data.append("remarks", $('#modal_reject_remarks').val());
		data.append("newState", newState);

		$.ajax({
		    url: "/TFAPortal/tfApplication/state-action-prd/prd/reqformod",
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
						if(error.key == 'transactionId' || error.key == 'newState'){
							
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
		/* if(dataTable != ''){
			dataTable.draw();
		}else{ */
			window.location = redirectUrl;
		/* } */
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