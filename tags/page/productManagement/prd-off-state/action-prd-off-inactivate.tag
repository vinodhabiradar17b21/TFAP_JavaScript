<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modal_auth_submitted"
	show_button_primary="false">
	<h4 style="text-align: center;">Product offering has been inactivated!</h4>
</tfap:modal>

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modal_avbl_prd"
	show_button_primary="false"
	show_button_cancel="true"
	show_modal_title="false"
	modal_size="md"
	primary_btn_id="modal_avbl_cancellation_dis_primary">
		<h4 style="text-align: center;">An active <a id="modal_avbl_prd_link" href="#">prod offering in progress</a> is already available.</h4>
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
	

	function openInactivateModal(_tfboId, _dataTable) {
		tfboId = _tfboId;
		dataTable = (_dataTable) ? _dataTable : dataTable;
		$.ajax({
					type : "POST",
					url : '/TFAPortal/tfApplication/product-management/getInProgressPrdOffering?tfboId='
							+ tfboId,
					success : function(result) {
						try {
							var jsonRes = JSON.parse(result);
							if (jsonRes.data.existing) {
								$("#modal_avbl_prd_link").attr("href",
										jsonRes.data.redirect);
								$('#modal_avbl_prd').modal('show');
							} else {
								$('#modal_confirm_submit').modal('show');
							}
						} catch (e) {

						}
					},
					error : function(result) {
					}
				});
	}

	function redirect(e) {
		window.location.href = "/TFAPortal/tfApplication/product-management/prd-offering/list/";
	}

	function submitCallback() {
		$.get(
				"/TFAPortal/tfApplication/product-management/bank/prd/inactive?tfboId="
						+ tfboId, function(data, status) {
					data = JSON.parse(data);
					if (data.discard) {
						redirectUrl = data.redirect;
						$('#modal_confirm_submit').modal('hide');
						$('#modal_auth_submitted').modal('show');
					}
				});
	}

	$('#modal_auth_submitted').on('hidden.bs.modal', function(e) {
		if (dataTable != '') {
			dataTable.draw();
		} else {
			window.location = redirectUrl;
		}
	});
</script>