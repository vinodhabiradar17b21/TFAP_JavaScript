<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://clib.camelone.com/" prefix="co" %>

<script src="<c:url value="/resources/js/scripts/customNumber/cleave.min.js"/>" type="text/javascript"></script>

<input id="currencyJson" name ="currencyJson" type="hidden" value='${currencyJson}'/>

<%-- <tfap:tfapconfirmationmodal
        button_name="label.modal.button.yes"
        modal_title="label.modal.title.confirmation"
        modal_Id="modal_confirm_initiate_approval"
        primary_btn_id="btn_confirm_initiate_approval"
        message="label.modal.message.confirmation.initiate.approval"
        callback="initiateApprovalCallback()"/> --%>
<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modals_bank_approve"
	show_button_primary="false">
	<div class="row">
		<h4 style="text-align: center;">The application has been initiated for approval.</h4>
	</div>
</tfap:modal>

<tfap:modal button_name="label.bank.button"
			modal_title="label.bank.maker.approver.check" modal_Id="modal_maker_approver_reject_verification_id"
			show_button_close="false" show_button_primary="false">
			<br />
			<div class="modal-content">
				<div class="modal-body">
					<h4 style="text-align: center;">
You are not allowed to modify this transaction as you have previously used another role to process this transaction.</h4>
				</div>
				<div class="modal-footer" style="margin-top: -20px;">
					<button type="button" class="btn btn-outline-primary mr-1"
						id="redirect_to_main_reject" onclick="redirectToMainReject()"
						href="${pageContext.request.contextPath}/tfApplication/list/view"
						data-dismiss="modal">
						<spring:message code='label.modal.button.close' />
					</button>
				</div>
			</div>
</tfap:modal>

<tfap:modal button_name="label.bank.button"
			modal_title="label.bank.maker.approver.check" modal_Id="modal_maker_approver_verification_id"
			show_button_close="false" show_button_primary="false">
			<br />
			<div class="modal-content">
				<div class="modal-body">
					<h4 style="text-align: center;">
You are not allowed to modify this transaction as you have previously used another role to process this transaction.</h4>
				</div>
				<div class="modal-footer" style="margin-top: -20px;">
					<button type="button" class="btn btn-outline-primary mr-1"
						id="redirect_to_main" onclick="redirectToMain()"
						href="${pageContext.request.contextPath}/tfApplication/list/view"
						data-dismiss="modal">
						<spring:message code='label.modal.button.close' />
					</button>
				</div>
			</div>
</tfap:modal>

<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.fail" modal_Id="modals_bank_approve_fail"
	show_button_primary="false">
	<div class="row">
		<h4 style="text-align: center;"><spring:message code="label.bankApproval.fail"/></h4>
	</div>
</tfap:modal>

<!-- Approve Cancellation Modal  -->	
<tfap:tfapconfirmationmodal
	button_name="label.modal.button.yes"
	modal_title="label.modal.title.confirmation" 
	modal_Id="modal_bank_confirm_approve_can"
	primary_btn_id="btn_confirm_approve_can"
	message="label.modal.message.confirmation.approve"
	dismiss_modal="false"
	callback="approveCancellationCallback()"/>
	
<!-- Approve Amendment Modal  -->
<tfap:modal button_name="label.modal.button.submit"
	modal_title="label.modal.title.approval" modal_Id="modal_bank_confirm_approve_amd"
	show_button_primary="true"
	show_button_cancel="true"
	primary_btn_id="modal_bank_confirm_approve_amd_btn"
	modal_size="lg"
	dismiss_modal="false">

	<div class="row">
		<div class="col-12 mb-1">
			<label for="modal_approve_amd_remarks">Remarks</label>
			<textarea id="modal_approve_amd_remarks" class="form-control" rows="3" maxlength="6500"></textarea>
			<span id="modal_approve_amd_remarks.errors" class="red d-none">Remarks is required.</span>
			<span id="modal_approve_amd_remarks.length.errors" class="red d-none">Remarks Length Exceed.</span>
			<span id="modal_approve_amd_remarks.shwiftz.errors" class="red d-none">Remarks is Invalid. Allowed special characters are . , - ( ) / = ' + : ? ! " % & * < > ; { @ # _</span>
		</div>

		<div class="col-6 mb-1">
			<label for="modal_approve_amd_iss_date">Instrument Issue Date</label>
			<div class="form-group">
				<div class="input-group">
					<input id="modal_approve_amd_iss_date" type="text" class="form-control required-date" placeholder="<spring:message code="placeholder.date.input"/>">
					<button type="button" class="btn bg-transparent clear-input d-none" data-clear-input="modal_approve_amd_iss_date" style="margin-left: -40px; z-index: 1051;">
						<i class="fa fa-times"></i>
					</button>
				</div>
				<div id="modal_approve_amd_iss_date_err" class="red d-none"></div>
				<span id="modal_approve_amd_iss_date.errors" class="red d-none">Instrument Issue Date is required.</span>
			</div>
		</div>
		
		
		<div class="col-6 mb-1">
			<label for="modal_approve_amd_exp_date">Expiry Date</label>
			<div class="form-group">
				<div class="input-group">
					<input id="modal_approve_amd_exp_date" type="text" class="form-control" placeholder="<spring:message code="placeholder.date.input"/>">
					<button type="button" class="btn bg-transparent clear-input d-none" data-clear-input="modal_approve_amd_exp_date" style="margin-left: -40px; z-index: 1051;">
						<i class="fa fa-times"></i>
					</button>
				</div>
			</div>
			<div id="modal_approve_amd_exp_date_err" class="red d-none"></div>
				<span id="modal_approve_amd_exp_date.errors" class="red d-none">Expiry Date must be later than the Instrument Issue Date.</span>
		</div>
		
		<div class="col-6 mb-1">
			<label for="modal_approve_amd_bank_refno">Bank Ref. No.</label> 
			<input id="modal_approve_amd_bank_refno" type="text" class="form-control required" maxlength="16">
			<span id="modal_approve_amd_bank_refno.errors" class="red d-none">Bank Ref. No. is required.</span>
			<span id="modal_approve_amd_bank_refno.length.errors" class="red d-none">Bank Ref. No. Length Exceed.</span>
			<div>&nbsp;</div>
			<div style="padding-bottom: 5px">
                <spring:message code="label.modal.initiate.approval.swift.files"/>
            </div>
            <tfap:tfapfileuploadtablocal transactionId="${tfApplication.tfTransaction.tfTran.ttfId}" isDisabled="false"
                                         itemSetId="modal_approve_amd_upload_swift"
                                         attachmentType="pdf" documentType="SWT"
                                         attJson="${attachmentJson}"/>
		</div>
		
		<div class="col-6 mb-1">
			<label for="modal_approve_amd_ccy">Instrument Amount</label>
			<div class="form-group">
				<div class="input-group">
					<input id="modal_approve_amd_amt" type="text" class="form-control decimal-input or2 " data-decimal="2" placeholder="Specify Amount" maxlength="15" >
					<div class="input-group-append or1">
					<div class="">
						<select id="modal_approve_amd_ccy" class="form-control">
						</select>
					</div>
					</div>
				</div>
			</div>
			<div style="padding: 5px">
               <spring:message code="label.modal.initiate.approval.other.files"/>
           	</div>
           	<tfap:tfapfileuploadtablocal transactionId="${tfApplication.tfTransaction.tfTran.ttfId}" isDisabled="false"
                                        itemSetId="modal_approve_amd_upload_files"
                                        attachmentType="pdf" documentType="BTH"
                                        attJson="${attachmentJson}"/>
		</div>	

	</div>
</tfap:modal>
<style>
.picker_2{
	z-index: 1052	
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		initializeDaterangePickerModalApp();
		
		function initializeDaterangePickerModalApp(){
			if($('#modal_approve_amd_iss_date, #modal_approve_amd_exp_date').prop('disabled')){
				return;
			}
			
			$('#modal_approve_amd_iss_date').daterangepicker({
				//minDate: new Date, // TFAPRW-498
				format: 'YYYY-MM-DD',
				singleDatePicker : true,
				calender_style : "picker_2",
				showDropdowns: true,
			}, function(start, end, label) {
				console.log(start.format('DD/MM/YYYY') , end.format('DD/MM/YYYY'), label);
				
				$('[data-clear-input="modal_approve_amd_iss_date"]').removeClass('d-none')
				
				var dtExpiry = $("#modal_approve_amd_exp_date");
			    var minDate = start;
			    dtExpiry.daterangepicker({
			    	format: 'YYYY-MM-DD',
					singleDatePicker : true,
					calender_style : "picker_2",
					showDropdowns: true,
					minDate: minDate
			    });
			    
			});
			
			$('#modal_approve_amd_exp_date').daterangepicker({
				format: 'YYYY-MM-DD',
				singleDatePicker : true,
				calender_style : "picker_2",
				showDropdowns: true,
			}, function(start, end, label) {
				console.log(start.format('DD/MM/YYYY') , end.format('DD/MM/YYYY'), label);
				
				$('[data-clear-input="modal_approve_amd_exp_date"]').removeClass('d-none')
				
				var dtIssue = $("#modal_approve_amd_iss_date");
			    var maxDate = end;
			    
			    //to disable dates later than the TO selected
			    dtIssue.daterangepicker({
			    	format: 'YYYY-MM-DD',
					singleDatePicker : true,
					calender_style : "picker_2",
					showDropdowns: true,
					maxDate: maxDate
			    });
			});
		}
		$('#modal_approve_amd_iss_date').tfapDateValidator({
			format : 1,
			errElem: $('#modal_approve_amd_iss_date_err'),
			minDate: new Date,
			onError: function(){
				initializeDaterangePickerModalApp();
			}
		});
		
		$('[data-clear-input="modal_approve_amd_iss_date"]').on('click', function(){
			$('#modal_approve_amd_iss_date').val('')
			$(this).addClass('d-none');
			initializeDaterangePickerModalApp();
		});
		
		$('[data-clear-input="modal_approve_amd_exp_date"]').on('click', function(){
			$('#modal_approve_amd_exp_date').val('')
			$(this).addClass('d-none');
			initializeDaterangePickerModalApp();
		});
		
		$('#modal_bank_confirm_approve_amd_btn').removeAttr('data-dismiss');
		$('#modal_bank_confirm_approve_amd_btn').removeAttr('data-dismiss');
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

	
	function openBankApproveModal(_tfapId, _docType, _urlModelName, _dataTable) {
		
		//numeralThousandsFormat();
		
		appId = _tfapId;
		docType = _docType;
		urlModelName = _urlModelName;
		dataTable = (_dataTable) ? _dataTable : dataTable;
		var makerApproverCheckflag = '${makerApproverCheck}';

		 $.ajax({
	   			url: "${pageContext.request.contextPath}/tfApplication/validate/recordOwnStatus?tfapId="+appId,
	   			type:"POST",
	   			success: function(result){
	   				var isRecordOpen = result;
	   				if(isRecordOpen!=null && isRecordOpen == 'true'){
	   					swal({
	   						title: '<spring:message code="message.record.tfaprecord.open"/>',
	   						icon: "warning",
	   						buttons: ["<spring:message code='message.record.confirm.cancel'/>","<spring:message code='message.record.confirm.ok'/>"],
	   						dangerMode: true,
	   					})
	   					.then(function(willDelete) {
	   					  if (willDelete) {
	   						openBankApproverModalAddition(appId, docType, makerApproverCheckflag);
	   					  }
	   					});
	   				}else{
	   					openBankApproverModalAddition(appId, docType, makerApproverCheckflag);
	   				}
	   			}
	   		});			
	}


	function openBankApproverModalAddition(appId, docType, makerApproverCheckflag){

			initializedrpdowns();
			initializeModalDetails();
			if(makerApproverCheckflag === 'RESTRICT'){
				$('#modal_maker_approver_verification_id').modal('show');
			}else if(docType == 'LCAMD' || docType == 'LCISS' || docType == 'LCCAN' 
					|| docType == 'BGAMD' || docType == 'BGISS' || docType == 'BGCAN' 
					|| docType == 'SCAMD' || docType == 'SCISS' || docType == 'SCCAN' 
					|| docType == 'SGISS' || docType == 'SGAWB' || docType == 'SGBOL' || docType == 'SGLOI'){
				$('#modal_bank_confirm_approve_amd').modal('show');
			}else{
				$('#modal_bank_confirm_approve_can').modal('show');
			}

		}

	
	
	function initializedrpdowns() {
		var currencyLabels = $("#currencyJson").val();
		currencyLabels =  $.parseJSON(currencyLabels);
	    $('#modal_approve_amd_ccy').append('<option value="">Currency</option>');
		Object.keys(currencyLabels).forEach(function(key){
		    var value = currencyLabels[key];
		    $('#modal_approve_amd_ccy').append('<option value='+key+'>'+value+'</option>');
		});
	}

	function initializeModalDetails() {
		var data = new FormData();
		var remark;
		var bankRefNo;
		var issueDate;		
		var expDate;
		var ccy;
		var amt;
		
		data.append("transactionId", appId);
		data.append("docType", docType);
		
		if(docType == 'LCAMD' || docType == 'LCISS' || docType == 'LCCAN') {
			remark = '${tfApplication.lc.tfDocLcIssuance.tfdlcRemark}';
			bankRefNo = '${tfApplication.lc.tfDocLcIssuance.tfdlcLcRefNo}';
			issueDate = '${tfApplication.lc.tfDocLcIssuance.tfdlcLcIssueDt}';
			expDate = '${tfApplication.lc.tfDocLcIssuance.tfdlcInstrExpDate}';
			ccy = '${tfApplication.lc.tfDocLcIssuance.tfdlcInstrCcy}';
			amt = '${tfApplication.lc.tfDocLcIssuance.tfdlcInstrAmt}';
		} 
		
		if(docType == 'SCAMD' || docType == 'SCISS' || docType == 'SCCAN') {
			remark = '${tfApplication.sblc.tfDocScIssuance.tfdscRemark}';
			bankRefNo = '${tfApplication.sblc.tfDocScIssuance.tfdscApprBankRefNo}';
			issueDate = '${tfApplication.sblc.tfDocScIssuance.tfdscInstrIssDate}';
			expDate = '${tfApplication.sblc.tfDocScIssuance.tfdscInstrExpDate}';
			ccy = '${tfApplication.sblc.tfDocScIssuance.tfdscInstrCcy}';
			amt = '${tfApplication.sblc.tfDocScIssuance.tfdscInstrAmt}';
		} 
		
		if(docType == 'BGAMD' || docType == 'BGISS' || docType == 'BGCAN') {
			remark = '${tfApplication.bg.tfDocBgIssuance.tfdbgRemark}';
			bankRefNo = '${tfApplication.bg.tfDocBgIssuance.tfdbgApprBankRefNo}';
			issueDate = '${tfApplication.bg.tfDocBgIssuance.tfdbgInstrIssDate}';
			expDate = '${tfApplication.bg.tfDocBgIssuance.tfdbgInstrExpDate}';
			ccy = '${tfApplication.bg.tfDocBgIssuance.tfdbgInstrCcy}';
			amt = '${tfApplication.bg.tfDocBgIssuance.tfdbgInstrAmt}';
		}
		
		if(docType == 'SGISS' || docType == 'SGAWB' || docType == 'SGBOL' || docType == 'SGLOI') {
			remark = '${tfApplication.sg.tfDocSgIssuance.tfdsgRemark}';
			bankRefNo = '${tfApplication.sg.tfDocSgIssuance.tfdsgApprBankRefNo}';
			issueDate = '${tfApplication.sg.tfDocSgIssuance.tfdsgInstrIssDate}';
			expDate = '${tfApplication.sg.tfDocSgIssuance.tfdsgInstrExpDate}';
			ccy = '${tfApplication.sg.tfDocSgIssuance.tfdsgInstrCcy}';
			amt = '${tfApplication.sg.tfDocSgIssuance.tfdsgInstrAmt}';
		} 
		
		$('#modal_approve_amd_remarks').val(remark);
		$('#modal_approve_amd_bank_refno').val(bankRefNo);
		$('#modal_approve_amd_iss_date').datepicker({dateFormat: 'yy-mm-dd'}).datepicker('setDate', issueDate);
		$('#modal_approve_amd_exp_date').datepicker({dateFormat: 'yy-mm-dd'}).datepicker('setDate', expDate);
		$('#modal_approve_amd_ccy').val(ccy);
		$('#modal_approve_amd_amt').val(amt);	

		//initialize swift files
		readAllTabItem("modal_approve_amd_upload_swift", false, true);

		//initialize other files
		readAllTabItem("modal_approve_amd_upload_files", false, true);
		
	}
	
	function isSubmitting(state){
		if(state){
			$('#modal_bank_confirm_approve_amd_btn').attr('disabled', 'disabled');
		}else{
			$('#modal_bank_confirm_approve_amd_btn').removeAttr('disabled');
		}
	}
	
	function bankApproveAmendCallback() {		
		var data = new FormData();
		data.append("transactionId", appId);
		data.append("docType", docType);
		data.append("remarks", $('#modal_approve_amd_remarks').val());
		data.append("issueDate", $('#modal_approve_amd_iss_date').val());
		if($('#modal_approve_amd_exp_date').val() !=null && $('#modal_approve_amd_exp_date').val() != '') {
			var expdate = new Date($('#modal_approve_amd_exp_date').val());
			data.append("instrExpDt",expdate);
		} 
		else if(null!=$('#sblc\\.tfDocScIssuance\\.tfdscExpDt').val() && $('#sblc\\.tfDocScIssuance\\.tfdscExpDt').val()!="")
			{
			var expdate =new Date( $('#sblc\\.tfDocScIssuance\\.tfdscExpDt').val());
			data.append("instrExpDt",expdate);
			}
		data.append("bankRefNo", $('#modal_approve_amd_bank_refno').val());
		if(($('#modal_approve_amd_ccy').val() !=null && $('#modal_approve_amd_ccy').val() != '')&&($('#modal_approve_amd_amt').val() !=null && $('#modal_approve_amd_amt').val() != '')) {
			data.append("ccy", $('#modal_approve_amd_ccy').val());
			data.append("amt", $('#modal_approve_amd_amt').val().replace(/,/g, ""));
		}
		else
		{ 
			if(($('#sblctfDocScIssuancetfCurrencyccyCode').val() !=null &&  $('#sblctfDocScIssuancetfCurrencyccyCode').val() != '') && ($('#sblctfDocScIssuancetfdscUndertakingAmt').val() !=null &&  $('#sblctfDocScIssuancetfdscUndertakingAmt').val() != '')) {
				data.append("ccy", $('#sblctfDocScIssuancetfCurrencyccyCode').val());
				data.append("amt", $('#sblctfDocScIssuancetfdscUndertakingAmt').val().replace(/,/g, ""));
			}
		}
		
		$.ajax({
			url : rootUrl + "/bank/initapprove",
			type : 'post',
			cache : false,
		    processData: false,
		    contentType: false,
		    enctype: 'multipart/form-data',
			data : data,
			beforeSend: function(){
				isSubmitting(true);
				$('[id="modal_approve_amd_remarks.errors"]').addClass('d-none');
				$('[id="modal_approve_amd_iss_date.errors"]').addClass('d-none');	
				$('[id="modal_approve_amd_exp_date.errors"]').addClass('d-none');	
				$('[id="modal_approve_amd_bank_refno.errors"]').addClass('d-none');
				$('[id="modal_approve_amd_remarks.length.errors"]').addClass('d-none');
				$('[id="modal_approve_amd_remarks.shwiftz.errors"]').addClass('d-none');
				$('[id="modal_approve_amd_bank_refno.length.errors"]').addClass('d-none');
				
				//initialize swift files
				readAllTabItem("modal_approve_amd_upload_swift", false, true);

				//initialize other files
				readAllTabItem("modal_approve_amd_upload_files", false, true);
						
			},
			success : function(data, textStatus, jQxhr) {				
				data = JSON.parse(data);
				<c:if test="${processed}">
				swal("","Already Processed","warning");
				</c:if>
				if (data.initapprove) {
					redirectUrl = data.redirect;
					$('#modal_bank_confirm_approve_amd').modal('hide');
					$('#modals_bank_approve').modal('show');
				}else if(data.errors.length > 0){
					$.each(data.errors, function(i, error){							
						if(error.key == 'transactionId' || error.key == 'docType'){
							
						}else if(error.key == 'remarks' && error.value == false){
							$('[id="modal_approve_amd_remarks.errors"]').removeClass('d-none');			
						}else if(error.key == 'issueDate'){
							$('[id="modal_approve_amd_iss_date.errors"]').removeClass('d-none');
						}else if(error.key == 'instrExpDt'){
							$('[id="modal_approve_amd_exp_date.errors"]').removeClass('d-none');
						}else if(error.key == 'bankRefNo' && error.value == false){
							$('[id="modal_approve_amd_bank_refno.errors"]').removeClass('d-none');
						}else if(error.key == 'remarks' && error.value == 'length'){
							$('[id="modal_approve_amd_remarks.length.errors"]').removeClass('d-none');			
						}else if(error.key == 'remarks' && error.value == 'shwiftz'){
							$('[id="modal_approve_amd_remarks.shwiftz.errors"]').removeClass('d-none');
						}else if(error.key == 'bankRefNo' && error.value == 'length'){
							$('[id="modal_approve_amd_bank_refno.length.errors"]').removeClass('d-none');
						}
						else if (error.key == 'internalServerError' && error.value == false) {
							$('#modal_bank_confirm_approve_amd').modal('hide');
							$('#modals_bank_approve_fail').modal('show');
						}
					});
					//initialize swift files
					readAllTabItem("modal_approve_amd_upload_swift", false, true);

					//initialize other files
					readAllTabItem("modal_approve_amd_upload_files", false, true);	
				}
			},
			error : function(jqXhr, textStatus, errorThrown) {
				
			},
			complete : function(){
				isSubmitting(false);
			}
		});
	}

	$('#modals_bank_approve').on('hidden.bs.modal', function(e) {
		if (dataTable != '') {
			dataTable.draw();
		} else {
			window.location = redirectUrl;
		}
	});

	$('#modal_bank_confirm_approve_amd').on('hidden.bs.modal', function(e) {
		$('#modal_approve_amd_remarks').val('').change();
		$('#modal_bank_confirm_approve_amd input').val('').change();
		$('#modal_bank_confirm_approve_amd textarea').val('').change();
	});

	$('#modal_bank_confirm_approve_amd_btn').on('click', function(e) {		
			bankApproveAmendCallback();		
	});
	
</script>


<script>
	function approveCancellationCallback(){
		$.get("/TFAPortal/tfApplication/state-action//app/bank/iniapproval?tfapid=" + appId+"&doc_type="+docType, function(data, status) {
			$('#modals_bank_approve').modal('show');
			$('#modal_bank_confirm_approve_can').modal('hide');
			data = JSON.parse(data);
			redirectUrl = data.redirect;
		});
	}
	
	$('#modals_bank_approve').on('hidden.bs.modal', function (e) {
		window.location = redirectUrl;
	})

</script>