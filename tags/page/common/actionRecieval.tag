<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@attribute name="modelNameUrl" type="java.lang.String" required="true"%>
<%@attribute name="msgType" type="java.lang.String" required="true"%>
<%@attribute name="tranId" type="java.lang.String" required="true"%>
<%@attribute name="status" type="java.lang.String" required="true"%>
<%@attribute name="makerApproverCheck" type="java.lang.String" required="false" description="For restrictions between maker/approver"%>

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.fail" modal_Id="modals_bank_recieval_fail"
	show_button_primary="false">
	<div class="row">
		<h4 style="text-align: center;"><spring:message code="label.bankReceival.fail"/></h4>
	</div>
</tfap:modal>

<!-- Recieve Cancellation Modal  -->	
<tfap:tfapconfirmationmodal
	button_name="label.modal.button.yes"
	modal_title="label.modal.title.confirmation" 
	modal_Id="modal_bank_confirm_recieve_can"
	primary_btn_id="btn_confirm_recieve_can"
	message="label.modal.message.confirmation.receive"
	dismiss_modal="false"
	callback="recieveCancellationCallback()"/>
	
<!-- Recieve Amendment Modal  -->
<div class="modal fade text-left" id="modal_recieval" tabindex="-1"
	 role="dialog" aria-labelledby="modals_bank_recieval"
	 aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-lg" role="document">
		<%-- modalRecievalForm.jsp --%>
		<div id="modal_recieval_content"></div>
	</div>
</div>

<style>
.picker_2{
	z-index: 1052	
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$('#modal_bank_confirm_recieve_amd_btn').removeAttr('data-dismiss');
		$('#modal_bank_confirm_recieve_amd_btn').removeAttr('data-dismiss');
	});
</script>

<script type="text/javascript">
	var appId = '';
	var docType = '';
	var dataTable = '';
	var urlModelName = '';

	function redirectToMain(e){
		window.location.href="${pageContext.request.contextPath}/tfApplication/list/view";
	}

	
	function openBankRecieveModal(_tfapId, _docType, _urlModelName, _dataTable) {
		appId = _tfapId;
		docType = _docType;
		urlModelName = _urlModelName;
		dataTable = (_dataTable) ? _dataTable : dataTable;
		var makerApproverCheckflag = '${pageScope.makerApproverCheck}';
		initializeModalDetails();
		let postData = {
			tfapId: _tfapId,
			docType: _docType,
			urlModelName: _urlModelName
		};
		$.ajax({
			type: 'POST',
			url: '<spring:url value="/${modelNameUrl}/recieval/modal/show"/>',
			headers: {'Content-Type': 'application/json'},
			data: JSON.stringify(postData),
			success: function (data) {
				$('#modal_recieval_content').html(data);
				$('#modal_recieval').modal('show');
			}
		});
	}
	
	function initializeModalDetails() {
		var data = new FormData();
		var remark;
		var bankRefNo;
		var issueDate;
		
		data.append("transactionId", appId);
		data.append("docType", docType);		

		$('#modal_recieve_amd_bank_refno').val(bankRefNo);
	}
	
	function isSubmitting(state){
		if(state){
			$('#modal_bank_confirm_recieve_amd_btn').attr('disabled', 'disabled');
		}else{
			$('#modal_bank_confirm_recieve_amd_btn').removeAttr('disabled');
		}
	}
	
	function bankRecieveAmendCallback() {
		
		var data = new FormData();

		data.append("transactionId", appId);
		data.append("docType", docType);
		data.append("bankRefNo", $('#modal_recieve_amd_bank_refno').val());
		$.ajax({
			url : '${pageContext.request.contextPath}/'+urlModelName+"/bank/recieve",
			type : 'post',
			cache : false,
		    processData: false,
		    contentType: false,
		    enctype: 'multipart/form-data',
			data : data,
			beforeSend: function(){
				isSubmitting(true);
				$('[id="modal_recieve_amd_bank_refno.errors"]').addClass('d-none');
				$('[id="modal_recieve_amd_bank_refno.length.errors"]').addClass('d-none');
			},
			success : function(data, textStatus, jQxhr) {				
				data = JSON.parse(data);
				
				if (data.recieve) {
					redirectUrl = data.redirect;
					$('#modal_bank_confirm_recieve_amd').modal('hide');
					$('#modals_bank_recieve').modal('show');
				}else if(data.errors.length > 0){
					$.each(data.errors, function(i, error){
						if(error.key == 'transactionId' || error.key == 'docType'){							
						}else if(error.key == 'bankRefNo' && error.value == false){
							$('[id="modal_recieve_amd_bank_refno.errors"]').removeClass('d-none');
						}else if(error.key == 'bankRefNo' && error.value == 'length'){
							$('[id="modal_recieve_amd_bank_refno.length.errors"]').removeClass('d-none');
						}
						else if (error.key == 'internalServerError' && error.value == false) {
							$('#modal_bank_confirm_recieve_amd').modal('hide');
							$('#modals_bank_recieve_fail').modal('show');
						}
					});
				}
			},
			error : function(jqXhr, textStatus, errorThrown) {
				
			},
			complete : function(){
				isSubmitting(false);
			}
		});
	}

	$('#modals_bank_recieve').on('hidden.bs.modal', function(e) {
		if (dataTable != '') {
			dataTable.draw();
		} else {
			window.location = redirectUrl;
		}
	});

	$('#modal_bank_confirm_recieve_amd_btn').on('click', function(e) {
		var bankRefNo = $("#modal_recieve_amd_bank_refno").val();
		
		var proceed = true;
		if(bankRefNo == undefined || bankRefNo == ''){
			proceed = false;
			$('[id="modal_recieve_amd_bank_refno.errors"]').removeClass('d-none');
		}
		
		if(proceed == true){
			bankRecieveAmendCallback();
		}
	});
	
</script>


<script>
	function recieveCancellationCallback(){
		$.get("${pageContext.request.contextPath }/tfApplication/state-action/app/bank/recieve?tfapid=${pageScope.tranId}&doc_type=${pageScope.msgType}", function(data, status) {
			$('#modals_bank_recieve').modal('show');
			$('#modal_bank_confirm_recieve_can').modal('hide');
			data = JSON.parse(data);
			redirectUrl = data.redirect;
		});
	}

	$('#modals_bank_recieve').on('hidden.bs.modal', function (e) {
		var redirectUrlEcneg = redirectUrl.replace("tfApplication", "exptrlcneg"); 
	    window.location = redirectUrlEcneg;
	});
	

</script>
<script>                          

function approvalCallback(){
	$.get("/TFAPortal/tfApplication/state-action/app/bank/recieve?tfapid=" + appId+"&doc_type="+docType+"&bankInitiateApp=true", function(data, status) {
		//$('#modal_approved').modal('show');
		data = JSON.parse(data);
		redirectUrl = data.redirect;
		<c:if test="${status eq 'IAP'}">
		  swal( "<spring:message code="label.modal.message.success.approve"/>", "","success").then(function() {
              window.location = redirectUrl;
          })
	</c:if>
	<c:if test="${status eq 'IRJ'}">
	  swal( "<spring:message code="label.modal.message.success.reject"/>", "","success").then(function() {
          window.location = redirectUrl;
      })
	</c:if>
	});
}

$('#modal_recieved').on('hidden.bs.modal', function (e) {
		var redirectUrlEcneg = redirectUrl.replace("tfApplication", "exptrlcneg"); 
		window.location = redirectUrlEcneg;
});
</script>