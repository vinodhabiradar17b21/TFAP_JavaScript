<%@tag description="Page Tag" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap" %>

<tfap:tfapconfirmationmodal
        button_name="label.modal.button.yes"
        modal_title="label.modal.title.confirmation"
        modal_Id="modal_confirm_processing"
        primary_btn_id="btn_confirm_processing"
        message="label.modal.message.confirmation.processing"
        callback="processingCallback()"/>

<script type="text/javascript">
    var appId = '';

    function openProcessingModal(_tfapId) {
        appId = _tfapId;
        $('#modal_confirm_processing').modal('show');
    }

    function processingCallback() {            
    	$.get("/TFAPortal/tfApplication/state-action-prd/prd/process?tfapid=" + appId, function (data, status) {
            data = JSON.parse(data);
            redirectUrl = data.redirect;
        });
    }

	$('#modal_confirm_processing').on('hidden.bs.modal', function (e) {
/* 		if(dataTable != ''){
			dataTable.draw();
		}else{ */
			window.location = redirectUrl;
		/* } */
	});

</script>