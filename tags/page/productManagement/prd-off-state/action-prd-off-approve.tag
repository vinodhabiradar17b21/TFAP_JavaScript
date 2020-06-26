<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modal_auth_submitted"
	show_button_primary="false">
	<h4 style="text-align: center;">Product offering has been approved!</h4>
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

<tfap:tfapconfirmationmodal
	button_name="label.modal.button.yes"
	modal_title="label.modal.title.confirmation" 
	modal_Id="modal_confirm_submit"
	primary_btn_id="btn_confirm_submit"
	message="label.modal.message.confirmation.submit"
	callback="submitCallback()"/>
	
<script type="text/javascript">
	var tfboId = '';
	var dataTable = '';
	
	function openApproveModal(_tfboId ,_dataTable){
		tfboId = _tfboId;
		dataTable = (_dataTable)? _dataTable:dataTable;
		var makerCompanyCheck = '${makerComApproverCheck}';
		if(makerCompanyCheck === 'RESTRICT'){
			$('#modal_maker_checker_verify_id').modal('show');
		}else
			$('#modal_confirm_submit').modal('show');
	}
	
	function redirect(e){
		window.location.href="/TFAPortal/tfApplication/product-management/prd-offering/list/";
	}

	function submitCallback(){
		$.get("/TFAPortal/tfApplication/product-management/bank/approve?tfboId="+tfboId, function(data, status) {	
			data = JSON.parse(data);
	        if(data.approve){
	        	redirectUrl = data.redirect;
	        	$('#modal_confirm_submit').modal('hide');
	    		$('#modal_auth_submitted').modal('show');		    	
	        }
	        else {
	        	if (data.makerCheckerError) {
	        		$('#modal_maker_checker_verify_id').modal('show');
				}
	        	else {
	        		swal('', 'Error in approving product offering', 'warning');
	        	}
			}
		});
	}
	
	$('#modal_auth_submitted').on('hidden.bs.modal', function (e) {
		if(dataTable != ''){
			dataTable.draw();
		}else{
			window.location = "/TFAPortal/tfApplication/product-management/"+redirectUrl;
		}
	});

	$(document).ready(function(){

	});
</script>