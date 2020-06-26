<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modals_com_approve"
	show_button_primary="false">
	<h4 style="text-align: center;">Product Link has been approved!</h4>
</tfap:modal>

<!-- Approve TnC Modal  -->	
<tfap:modal button_name="label.modal.button.agree"
	modal_title="label.modal.title.product.subscription.terms" modal_Id="modal_prd_link"
	show_button_primary="true"
	show_button_cancel="true"
	button_cancel_name="label.modal.button.cancel"
	show_modal_title="true"
	modal_size="md"
	dismiss_modal="false"
	primary_btn_id="modal_prd_link_btn_primary">

		<div class="row d-none" id="modal_prd_link_terms_hidden">
				<div class="col-12">
					<strong class="prd_link_modal_tnc_prd_name"></strong>
				</div>
				<div class="col-12 mt-1 mb-1 prd_link_modal_tnc_prd_tnc_list">
					<div class="row prd_link_modal_tnc_prd_tnc d-none">
						<div class="col-6"><span class="prd_link_modal_tnc_bnk_name"></span></div>
						<div class="col-6"><a href="#" class="prd_link_modal_tnc_bnk_tnc" title="View Terms & Conditions">Terms &amp; Conditions</a></div>
	 				</div>
				</div>
		</div>
		<div id="modal_prd_link_terms_body">
			
		</div>
		
		<div class="mb-1">
			<div class="text_instruction">
				<strong>Terms</strong><br>
				<fieldset class="checkboxsas">
					<label class="space-checkbox-radio-f"> <input type="checkbox" id="terms-checkbox">
						<spring:message code="modal.product.subscription.agree.tnc.message"/>
					</label>
				</fieldset>
			</div>
		</div>
</tfap:modal>

<script type="text/javascript">
var rootUrl = '/TFAPortal/tfApplication';
var appId = '';

$(document).ready(function(){
	 $('#modal_prd_link_btn_primary').attr('disabled', 'disabled');
});

$('#modal_prd_link').on('shown.bs.modal', function(){
	$.get(rootUrl + "/product-management/prd/tncdata?tfpslAccnidBnk=" + '${productSubscriptionDTO.bankIds[0]}' + "&tfpslPrdId=" + '${productIds[0]}', function (data, status) {
		data = JSON.parse(data);
        
		if(data.success){
			var hiddenElem = $('#modal_prd_link_terms_hidden').clone().removeClass('d-none');
			$(hiddenElem).find('.prd_link_modal_tnc_prd_name').first().text(data.productName);
			
			var tncElem = $(hiddenElem).find('.prd_link_modal_tnc_prd_tnc').first().clone().removeClass('d-none');
   			$(tncElem).find('.prd_link_modal_tnc_bnk_name').text(data.bankName);
   			
   			var url = rootUrl + "/product-management/prd-sub/viewtnc?flag=sub&id="+data.offerTncId;
   			$(tncElem).find('.prd_link_modal_tnc_bnk_tnc').attr('href', url);
    		$(hiddenElem).find('.prd_link_modal_tnc_prd_tnc_list').first().append(tncElem);
    		
    		$('#modal_prd_link_terms_body').append(hiddenElem);
		}
    });
});

$('#modal_prd_link_btn_primary').on('click', function(e){	
	$.get("/TFAPortal/tfApplication/state-action-prd/prd/bank/approve?tfapid=" + appId, function (data, status) {
        data = JSON.parse(data);
        redirectUrl = data.redirect;
    	$('#modal_prd_link').modal('hide');
		$('#modals_com_approve').modal('show');
    });
});

function openComApproveModal(_tfapId) { //to parse through the bankId and productId if cant get from this page
	appId = _tfapId;

	$('#modal_prd_link').modal('show');
}

$('#modals_com_approve').on('hidden.bs.modal', function(e) {
	window.location = redirectUrl;
});

$('#modal_prd_link').on('hidden.bs.modal', function(){
	$('#modal_prd_link_terms_body').empty();
	$('#terms-checkbox').prop('checked', false).trigger('change');
});

$('#terms-checkbox').on('change', function(){
	if($(this).prop('checked')){
		$('#modal_prd_link_btn_primary').removeAttr('disabled');
	}else{
		$('#modal_prd_link_btn_primary').attr('disabled', 'disabled');
	}
});

</script>