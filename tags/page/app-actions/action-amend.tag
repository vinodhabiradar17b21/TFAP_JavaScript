<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<tfap:tfapconfirmationmodal
	button_name="label.modal.button.yes"
	modal_title="label.modal.title.confirmation" 
	modal_Id="modal_confirm_amend"
	primary_btn_id="btn_confirm_amend"
	message="label.modal.message.confirmation.amend"
	callback="amendCallback()"/>

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modal_avbl_amendment"
	show_button_primary="false"
	show_button_cancel="true"
	show_modal_title="false"
	modal_size="md"
	primary_btn_id="modal_avbl_amendment_dis_primary">
		<h4 style="text-align: center;">An amendment request was already created for this application. Select this <a id="modal_avbl_amendment_link" href="#">link</a> to open the existing request.</h4>
</tfap:modal>

<tfap:modal button_name="label.bank.button"
			modal_title="label.bank.maker.approver.check" modal_Id="modal_maker_approver_amend_verification_id"
			show_button_close="false" show_button_primary="false">
			<br />
			<div class="modal-content">
				<div class="modal-body">
					<h4 style="text-align: center;">
You are not allowed to modify this transaction as you have previously used another role to process this transaction.</h4>
				</div>
				<div class="modal-footer" style="margin-top: -20px;">
					<button type="button" class="btn btn-outline-primary mr-1"
						id="redirect_to_main_amend" onclick="redirectToMainAmend()"
						href="${pageContext.request.contextPath}/tfApplication/list/view"
						data-dismiss="modal">
						Close
					</button>
				</div>
			</div>
</tfap:modal>
	
<script type="text/javascript">
	var appId = '';
	var urlModelName = '';
	
	function redirectToMainAmend(e){
		window.location.href="${pageContext.request.contextPath}/tfApplication/list/view";
	}

	
	function openAmendModal(_tfapId, prod, _urlModelName){
		appId = _tfapId;
		urlModelName = _urlModelName;
		var makerApproverCheckflag = '${makerComApproverCheck}';
		if(makerApproverCheckflag === 'RESTRICT'){
			$('#modal_maker_approver_amend_verification_id').modal('show');
		}else{
			$.ajax({
				type : "POST",
				url : rootUrl + '../../'+urlModelName+'/gettranbyrelated?doc_type='+prod.substring(0,2)+'AMD&tfapid='+appId,
				success : function(result) {
				    try {
						var jsonRes = JSON.parse(result);
						if(jsonRes.data.isAvailable){
							$("#modal_avbl_amendment_link").attr("href", jsonRes.redirect);
							$('#modal_avbl_amendment').modal('show');
						}else{
							$('#modal_confirm_amend').modal('show');
						}
				    } catch (e) {
				    	
				    }
				},
				error : function(result) {
					
				}
			});	
		}
	}
	
	function amendCallback(){
		$.ajax({
            url: rootUrl + "../../"+urlModelName+"/amd-lc-tran",
            dataType: 'json',
            type: 'post',
            contentType: 'application/json',
            data: JSON.stringify({
                "tfapid":appId,
                "doc_type":'LCAMD'	// Not removed horcoded value, to make sure existing products work - Need to optimize later
            }),
            success: function( data, textStatus, jQxhr ){
                console.log(data)
                redirectUrl = data.redirect;
                window.location = redirectUrl;
            },
            error: function( jqXhr, textStatus, errorThrown ){
                
            }
        });
	}
	
	
	$('#modal_avbl_amendment').on('hidden.bs.modal', function (e) {
		$("#modal_avbl_amendment_link").attr("href", "#");
	});
	
</script>