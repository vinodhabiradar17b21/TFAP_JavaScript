<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@attribute name="popoverText" type="java.lang.String" required="false"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modal_confirm_initiate_approval"
	show_button_primary="false">
	<div class="row">
		<h4 style="text-align: center;">This Product Subscription has been Initiated for Approval!</h4>
	</div>
</tfap:modal>

<tfap:modal button_name="label.bank.button"
	modal_title="label.bank.maker.approver.check" modal_Id="modal_maker_approver_reject_verification_id"
	show_button_close="false" show_button_primary="false">
	<br />
	<div class="modal-content">
		<div class="modal-body">
			<h4 style="text-align: center;">
You are not allowed to modify this transaction as you have previously used another role to process this transaction.</h4>
		</div>
		<div class="modal-footer" style="margin-top: -20px;">
			<button type="button" class="btn btn-outline-primary mr-1"
				id="redirect_to_main_reject" onclick="redirectToMainReject()"
				href="${pageContext.request.contextPath}/tfApplication/product-management/prd-approval-list/view"
				data-dismiss="modal">
				<spring:message code='label.modal.button.close' />
			</button>
		</div>
	</div>
</tfap:modal>

<!-- Approve Subscription Modal  -->
<tfap:modal button_name="label.modal.button.submit"
	modal_title="label.modal.title.approval" modal_Id="modal_bank_confirm_approve_subscription"
	show_button_primary="true"
	show_button_cancel="true"
	primary_btn_id="modal_bank_confirm_approve_subscription_btn"
	modal_size="xs"
	dismiss_modal="false">
		
	<div class="row">
		<div class="col-12 mb-1">
			<h4 style="text-align: center;">Do you wish to approve this Product Subscription?</h4>
		</div>
	</div>
	<div class="row">
		<div class="col-12 mb-1">
			<label for="modal_approve_custrefno">Customer Ref. No. <i class="fa fa-info-circle font-medium-1" data-toggle="tooltip" data-placement="bottom" title="" 
			data-original-title="<spring:message code="label.header.product.sub.approval.info" />"></i></label> 
			<input id="modal_approve_custrefno" type="text" class="form-control" maxlength="35">
		</div>
	</div>
</tfap:modal>


<script type="text/javascript">
    var appId = '';

    function openBankApproveModal(_tfapId) {
        appId = _tfapId;
        
		var makerApproverCheckflag = '${makerApproverCheck}';
		if(makerApproverCheckflag === 'RESTRICT'){
			$('#modal_maker_approver_reject_verification_id').modal('show');
		}else
			//$('#modal_confirm_initiate_approval').modal('show');
			$('#modal_bank_confirm_approve_subscription').modal('show');
    }
    
    function redirectToMainReject(e){
    	window.location.href="${pageContext.request.contextPath}/tfApplication/product-management/prd-approval-list/view";
    }

    function initiateApprovalCallback() {
		var data = {
				"tfapId": appId,
				"customerRefNo": $('#modal_approve_custrefno').val()
		};

		$.ajax({
			url : "/TFAPortal/tfApplication/state-action-prd/prd/bank/iniapproval",
		    type: 'post',
		    dataType: 'json',
		    contentType: "application/json",
		    data: JSON.stringify(data),
			beforeSend: function(){

			},
			success : function(data, textStatus, jQxhr) {						
				if (data.success) {
					redirectUrl = data.redirect;
					$('#modal_bank_confirm_approve_subscription').modal('hide');
					$('#modal_confirm_initiate_approval').modal('show');
				}else{
					
				}
			},
			error : function(jqXhr, textStatus, errorThrown) {
				
			}
		});
    	
    	
    	
    	
    	
    	
    	
    	/* $.get("/TFAPortal/tfApplication/state-action-prd/prd/bank/iniapproval?tfapid=" + appId, function (data, status) {
            data = JSON.parse(data);
            redirectUrl = data.redirect;
        }); */
    }
    
	$('#modal_bank_confirm_approve_subscription_btn').on('click', function(e) {
		initiateApprovalCallback();
	});

	$('#modal_confirm_initiate_approval').on('hidden.bs.modal', function (e) {
/* 		if(dataTable != ''){
			dataTable.draw();
		}else{ */
			window.location = redirectUrl;
		/* } */
	});

</script>