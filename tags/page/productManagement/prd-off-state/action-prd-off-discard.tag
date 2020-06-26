<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<tfap:tfapconfirmationmodal button_name="label.modal.button.yes"
	modal_title="label.modal.title.confirmation"
	modal_Id="modal_confirm_discard" primary_btn_id="btn_confirm_discard"
	message="label.modal.message.confirmation.discard"
	callback="discardCallback()" />
	
<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modal_prd_discarded"
	show_button_primary="false" >
	<h4 style="text-align: center;"><spring:message code="label.modal.status.msg.product.offer.discard.success"/></h4>
</tfap:modal>


<tfap:modal button_name="label.bank.button"
			modal_title="label.bank.maker.approver.check" modal_Id="modal_maker_checker_discard_id"
			show_button_close="false" show_button_primary="false">
			<br />
			<div class="modal-content">
				<div class="modal-body">
					<h4 style="text-align: center;"><spring:message code="modal.checker.maker.restrict.message"/></h4>
				</div>
				<div class="modal-footer" style="margin-top: -20px;">
					<button type="button" class="btn btn-outline-primary mr-1"
						id="redirect" onclick="rediscarddirect()"
						href="${pageContext.request.contextPath}/tfApplication/list/view"
						data-dismiss="modal">
						<spring:message code='label.modal.button.close' />
					</button>
				</div>
			</div>
</tfap:modal>


<script type="text/javascript">
	var tfboId = '';
	var dataTable = '';
	
	function rediscarddirect(e){
		window.location.href="/TFAPortal/tfApplication/product-management/prd-offering/list/";
	}


	function openDiscardModal(_tfboId, _dataTable ) {
		tfboId = _tfboId;
		dataTable = (_dataTable)? _dataTable:dataTable;
		var makerCompanyCheck = '${makerComApproverCheck}';
		if(makerCompanyCheck === 'RESTRICT'){
			$('#modal_maker_checker_discard_id').modal('show');
		}else
			$('#modal_confirm_discard').modal('show');
	}

	function discardCallback() {
		$.get("/TFAPortal/tfApplication/product-management/bank/prd/discard?tfboId="
				+ tfboId , function(data, status) {
			data = JSON.parse(data);
			if(data.discard){
				redirectUrl = data.redirect;
	    		$('#modal_prd_discarded').modal('show');	
			}
		});
	}
	
	$('#modal_prd_discarded').on('hidden.bs.modal', function (e) {
		if(dataTable != ''){
			dataTable.draw();
		}else{
			window.location = redirectUrl;
		}
	});

</script>