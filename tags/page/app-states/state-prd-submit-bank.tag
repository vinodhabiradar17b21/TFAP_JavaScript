<%@tag description="Page Tag" pageEncoding="UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<tfap:tfap-user-role-permission userRoles="${userRoles}"
	TFAP_BANK_ONBOARDING_MAKER="true">
	<button type="button" id="submit_review" class="btn btn-primary"
		title="Submit For Authorization">
		<i class="fa fa-check-square-o"></i>&nbsp; Submit For Authorization
	</button>
</tfap:tfap-user-role-permission>

<tfap:modal button_name="label.bank.button"
	modal_title="label.bank.maker.approver.check" modal_Id="modal_verification_id"
	show_button_close="false" show_button_primary="false">
	<br />
	<div class="modal-content">
		<div class="modal-body">
			<h4 style="text-align: center;">You are not allowed to modify this transaction as you have previously used another role to process this transaction.</h4>
		</div>
		<div class="modal-footer" style="margin-top: -20px;">
			<button type="button" class="btn btn-outline-primary mr-1"
				id="redirect_to_main" onclick="redirectToMainSub()"
				href="/TFAPortal/tfApplication/product-management/prd-approval-list/view"
				data-dismiss="modal">
				<spring:message code='label.modal.button.close' />
			</button>
		</div>
	</div>
</tfap:modal>


<script type="text/javascript">
 
function redirectToMainSub(e){
	window.location.href="/TFAPortal/tfApplication/product-management/prd-approval-list/view";
}
    function submit_form(action) {
        if (action == 'submit') {
     
        	var makerApproverCheck = '${makerApproverCheck}';
    		if(makerApproverCheck === 'RESTRICT'){
    			$('#modal_verification_id').modal('show');
    		}else{
    			$.get("/TFAPortal/tfApplication/state-action-prd/prd/submitreview?tfapid=" + '${tfapId}', function(data, status) {
    				data = JSON.parse(data);
    				redirectUrl = data.redirect;
    				window.location = redirectUrl;
    			});
    			
    		}
    			
        } else {
/*     		var makerApproverCheck = '${makerApproverCheck}';
    		if(makerApproverCheck === 'RESTRICT'){
    			$('#modal_verification_id').modal('show');
    		}else {
    			$('#editForm').attr('action', rootUrl + '/draft/save?tfapid=' + '${tfapId}');
    			$('#editForm').submit();
    		}
 */
        }
       // $('#editForm').submit();
    }

    $(document).ready(function () {
/*         $("#submit_review").click(function () {
            submit_form('submit');
        }); */
        
        $("#submit_review").click(function() {
        	openSubmitForAuthModal("${tfapId}");
		});
    });
</script>