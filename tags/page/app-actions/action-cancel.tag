<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modals_cancel"
	show_button_primary="false">
		<h4 style="text-align: center;">
The application has been submitted.</h4>
</tfap:modal>
	
<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modal_avbl_cancellation"
	show_button_primary="false"
	show_button_cancel="true"
	show_modal_title="false"
	modal_size="md"
	primary_btn_id="modal_avbl_cancellation_dis_primary">
		<h4 style="text-align: center;">An cancellation request was already created for this application. Select this <a id="modal_avbl_cancellation_link" href="#">link</a> to open the existing request.</h4>
</tfap:modal>


<tfap:modal button_name="label.bank.button"
			modal_title="label.bank.maker.approver.check" modal_Id="modal_maker_approver_cancel_verification_id"
			show_button_close="false" show_button_primary="false">
			<br />
			<div class="modal-content">
				<div class="modal-body">
					<h4 style="text-align: center;">
You are not allowed to modify this transaction as you have previously used another role to process this transaction.</h4>
				</div>
				<div class="modal-footer" style="margin-top: -20px;">
					<button type="button" class="btn btn-outline-primary mr-1"
						id="redirect_to_main_cancel" onclick="redirectToMainCancel()"
						href="${pageContext.request.contextPath}/tfApplication/list/view"
						data-dismiss="modal">
						Close
					</button>
				</div>
			</div>
</tfap:modal>


<div class="modal fade text-left" id="modal_confirm_cancel" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel17" style="display: none;"
	aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title font-weight-bold" id="myModalLabel17">
					<spring:message code='label.modal.title.cancel' />
				</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body" id="cancelModal">
				<%@include file="/WEB-INF/views/tfApplication/lcCancellation/lcCancellationFormContent.jspf"%>
			</div>	
			<div class="modal-footer" style="margin-top: -20px;">
					<button type="button" class="btn btn-outline-primary mr-1"
						data-dismiss="modal">
						<spring:message code='label.modal.button.close' />
					</button>
					<button type="button" id="modal_can_primary" class="btn btn-primary" >
						<spring:message code='label.modal.button.submitForReview' />
					</button>
			</div>
		</div>
	</div>
</div>	

<script type="text/javascript">
	var appId = '';
	var docType = '';
	var dataTable = '';
	var urlModelName = '';
	
	function redirectToMainCancel(e){
		window.location.href="${pageContext.request.contextPath}/tfApplication/list/view";
	}
	function openCancelModal(_tfapId, _docType, _urlModelName, _dataTable){
		appId = _tfapId;
		docType = _docType;
		dataTable = (_dataTable)? _dataTable:dataTable;
		urlModelName = _urlModelName;
		var makerApproverCheckflag = '${makerComApproverCheck}';
		if(makerApproverCheckflag === 'RESTRICT'){
			$('#modal_maker_approver_cancel_verification_id').modal('show');
		}else {
			$.ajax({
				type : "POST",
				url : rootUrl + '../../'+urlModelName+'/gettranbyrelated?doc_type='+docType.substring(0,2)+'CAN&tfapid='+appId,
				success : function(result) {
				    try {
						var jsonRes = JSON.parse(result);
						if(jsonRes.data.isAvailable){
							$("#modal_avbl_cancellation_link").attr("href", jsonRes.redirect);
							$('#modal_avbl_cancellation').modal('show');
						}else{
							$('#modal_confirm_cancel').modal('show');
						}
				    } catch (e) {
				    	
				    }
				},
				error : function(result) {
				}
			});
		}
	}
	
	$(document).ready(function(){
		
		$('#modal_confirm_cancel #modal_can_primary').on('click', function(e){
				e.preventDefault();
				var formData = {
					'lcCancel.tfDocLcCancellation.tfdlccCustomerIns' : $('[name=lcCancel\\.tfDocLcCancellation\\.tfdlccCustomerIns]').val(),
					'lcCancel.tfDocLcCancellation.tfdlccCanReason' : $('[name=lcCancel\\.tfDocLcCancellation\\.tfdlccCanReason]').val(),
					'lcCancel.tfDocLcCancellation.tfdlccChargeAccnNo' : $('[name=lcCancel\\.tfDocLcCancellation\\.tfdlccChargeAccnNo]').val(),
					'lcCancel.tfDocLcCancellation.tfdlccChargeAccnCcy' : $('[name=lcCancel\\.tfDocLcCancellation\\.tfdlccChargeAccnCcy]').val(),
					'lcCancel.tfDocLcCancellation.tfdlccOthCustInstr' : $('[name=lcCancel\\.tfDocLcCancellation\\.tfdlccOthCustInstr]').val()
				};
				$.ajax({
					type : "POST",
					data : formData,
					url: rootUrl + "../../"+urlModelName+"/cancel?doc_type=LCCAN&tfapid="+appId,
					success : function(result) {
					    try {
							var jsonRes = JSON.parse(result);
							
							$('#modal_confirm_cancel').modal('hide');
							if(jsonRes.success){
								redirectUrl = jsonRes.redirect;
								$('#modals_cancel').modal('show');
							}else{
								
							}
					    } catch (e) {
					    	$('#cancelModal').html(result);
					    }
	
					},
					error : function(result) {
						
					}
				});
		});
		
		$('#modals_cancel').on('hidden.bs.modal', function (e) {
			window.location = redirectUrl;
		});
		
	
		$('#modal_avbl_cancellation').on('hidden.bs.modal', function (e) {
			$("#modal_avbl_cancellation_link").attr("href", "#");
		});
		
		
		$('#modal_confirm_cancel').on('shown.bs.modal', function(){
			$.ajax({
				type : "GET",
				url: rootUrl + "../../"+urlModelName+"/get-tnc-id?doc_type="+docType+"&tfapid="+appId,
				success : function(result) {
				    if(result.success){
				    	
				    }
				},
				error : function(result) {
					
				}
			});
		});
	});
</script>