<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

					<tfap:tfapconfirmationmodal
						button_name="label.modal.button.yes"
						modal_title="label.modal.title.confirmation" 
						modal_Id="modal_confirm_reset"
						primary_btn_id="btn_confirm_reset"
						message="label.modal.message.confirmation.reset"
						callback="resetCallback()"/>

	
	
<script type="text/javascript">
	
	function openResetModal(){
		$('#modal_confirm_reset').modal('show');
	}
	
	function resetCallback(){
		location.reload();
	}

</script>