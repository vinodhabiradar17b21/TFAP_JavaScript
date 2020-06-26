<%@tag description="Page Tag" pageEncoding="UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>


<button type="button" id="submit_review" class="btn btn-primary"
	title="Submit For Review">
	<i class="fa fa-check-square-o"></i>&nbsp; Submit For Review
</button>

<tfap:modal button_name="label.bank.button"
	modal_title="label.bank.maker.approver.check"
	modal_Id="modal_verification_id" show_button_close="false"
	show_button_primary="false">
	<br />
	<div class="modal-content">
		<div class="modal-body">
			<h4 style="text-align: center;"><spring:message code="modal.checker.maker.restrict.message"/></h4>
		</div>
		<div class="modal-footer" style="margin-top: -20px;">
			<button type="button" class="btn btn-outline-primary mr-1"
				id="redirect_to_main" onclick="redirectToMainSub()"
				href="/TFAPortal/tfApplication/list/view" data-dismiss="modal">
				<spring:message code='label.modal.button.close' />
			</button>
		</div>
	</div>
</tfap:modal>


<script type="text/javascript">

	function redirectToMainSub(e) {
		window.location.href = "/TFAPortal/tfApplication/product-management/prd-offering/list/";
	}
	function submit_form(action) {
		if (action == 'submit') {

			var makerComApproverCheck = '${makerComApproverCheck}';
			if (makerComApproverCheck === 'RESTRICT') {
				$('#modal_verification_id').modal('show');
			} else {
				$('#ProductOfferingId')
						.attr('action',
								'/TFAPortal/tfApplication/product-management/draft/submit');
				$('#ProductOfferingId').submit();
			}

		} else {
			var makerComApproverCheck = '${makerComApproverCheck}';
			if (makerComApproverCheck === 'RESTRICT') {
				$('#modal_verification_id').modal('show');
			} else {
				$('#ProductOfferingId')
						.attr('action',
								'/TFAPortal/tfApplication/product-management/prd-det/save');
				$('#ProductOfferingId').submit();
			}

		}
	}

	$(document).ready(
			function() {
				$("#submit_review").click(function() {
					submit_form('submit');
				});
				$('#submit_review').prop('disabled',
						$('#selectedBank :selected').val() == "");
			});
</script>