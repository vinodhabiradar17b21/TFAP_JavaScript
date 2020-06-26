<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>


<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modals_com_reject"
	show_button_primary="false">
	<div class="row">
		<h4 style="text-align: center;">Product Link has been rejected!</h4>
	</div>
</tfap:modal>

<tfap:tfapconfirmationmodal
	button_name="label.modal.button.yes"
	modal_title="label.modal.title.confirmation" 
	modal_Id="modal_com_confirm_reject"
	primary_btn_id="modal_com_confirm_reject_btn"
	message="label.modal.message.confirmation.reject"
	dismiss_modal="false"
	callback="comRejectCallback()"/>


<script type="text/javascript">
	var appId = '';

	function redirectToMain(e){
		window.location.href="${pageContext.request.contextPath}/tfApplication/product-management/prd-approval-list/view";
	}

	function openComRejectModal(_tfapId) {
		appId = _tfapId;
		
		$('#modal_com_confirm_reject').modal('show');
	}

	function comRejectCallback() {
		$.get("/TFAPortal/tfApplication/state-action-prd/prd/reject?tfapid=" + appId, function (data, status) {
            data = JSON.parse(data);
            redirectUrl = data.redirect;
            $('#modal_com_confirm_reject').modal('hide');
			$('#modals_com_reject').modal('show');
        });
	}

	$('#modals_com_reject').on('hidden.bs.modal', function(e) {
		/* if (dataTable != '') {
			dataTable.draw();
		} else { */
			window.location = redirectUrl;
		/* } */
	});
	
/* 	$('#modal_com_confirm_reject_btn').on('click', function(e){
		comRejectCallback();
	}) */
</script>