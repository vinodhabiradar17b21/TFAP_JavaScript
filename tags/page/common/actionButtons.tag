<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<%@attribute name="msgType" type="java.lang.String" required="true"%>
<%@attribute name="tranId" type="java.lang.String" required="true"%>
<%@attribute name="status" type="java.lang.String" required="true"%>
<%@attribute name="tncAppId" type="java.lang.String" required="false" description="For the terms and conditions application"%>
<%@attribute name="saveUrl" type="java.lang.String" required="false" description="URL for saving the transaction."%>
<%@attribute name="duplicateUrl" type="java.lang.String" required="false" description="URL for duplicating the transaction."%>
<%@attribute name="printUrl" type="java.lang.String" required="false" description="URL for Print transaction."%>
<%@attribute name="convertUrl" type="java.lang.String" required="false" description="URL for Convertion transaction."%>
<%@attribute name="makerApproverCheck" type="java.lang.String" required="false" description="For restrictions between maker/approver"%>



<style>
.swal-title {
    font-weight: 400; !important;
    font-size: 15px;
}

.swal-icon:first-child {
    margin-top: 5px;
}

.swal-icon--warning__body {
    width: 2px;
    height: 21px;
    top: 10px;
    border-radius: 2px;
    margin-left: -2px;
}

.swal-icon {
    width: 80px;
    height: 54px;
    border-width: 2px;
}

.swal-icon--warning__dot {
    width: 5px;
    height: 5px;
    margin-left: -2px;
}

.swal-footer {
    padding: 0px 0px;
}

</style>

<!-- This action button does not check for the banks, only specific for company. 
	May need to create for the banks separately to avoid confusion -->
	
<!-- Setting variables to be passed to javascript, etc. -->
<c:set var="ctx" value="${pageContext.request.contextPath }"/>


	<!-- Toggle to show default buttons (e.g. save, discard, reject, etc.) -->
	
	<div class="btn-group" role="group" aria-label="Button group with nested dropdown">
		
		<!-- Show print button for status other than NEW -->
		<c:if test="${pageScope.status ne 'NEW'}">
			<a href="${printUrl}" target="_blank" id="print_btn" class="btn btn-outline-primary" data-toggle="tooltip" data-placement="bottom" title="Print" data-original-title="Print">
			<i class="fa fa-print"></i></a>
		</c:if>
		
		<c:if test="${not empty pageScope.tncAppId}">
			<a href="/TFAPortal/tfApplication/product-management/prd-sub/viewtnc?flag=prd&id=${pageScope.tncAppId}"
			id="save-action-btn" target="_blank" class="btn btn-outline-primary" data-toggle="tooltip" data-placement="bottom" title="Terms & Conditions" data-original-title="Terms & Conditions"> T&C </a>
		</c:if>
		
		<!-- Buttons to be shown depending on the status -->
		<c:choose>
			<c:when test="${fn:contains('PAU', pageScope.status) }">
				<!-- Pending Authorization > Request for Modifications-->
				<tfap:tfap-user-role-permission userRoles="${userRoles}" TFAP_COM_APPROVER="true" >
					<a class="btn btn-outline-primary" id="reject-action-btn"
						data-toggle="tooltip" data-placement="bottom" title="Request For Modification"
						data-original-title="Reject">
						<i class="fa fa-times-circle"></i> <!-- Reject -->
					</a>

					<tfap:modal button_name="label.modal.button.continue"
						modal_title="label.modal.title.success" modal_Id="modals_reject"
						show_button_primary="false">
						<div class="row">
							<h4 style="text-align: center;">The application has been requested for modification !</h4>
						</div>
					</tfap:modal>
					
					<tfap:modal button_name="label.modal.button.submit"
							modal_title="label.modal.title.reqForModification" modal_Id="modal_confirm_reject"
							show_button_primary="true"
							show_button_cancel="true"
							primary_btn_id="modal_confirm_reject_btn"
							modal_size="lg">
						
							<div class="row">
								<div class="col-12 mb-1">
									<label for="modal_reject_remarks">Reason</label>
									<textarea id="modal_reject_remarks" class="form-control required" rows="3" maxlength="2000"></textarea>
									<span id="modal_reject_remarks.errors" class="red d-none">Reason is required.</span>
								</div>
							</div>
						</tfap:modal>

			</tfap:tfap-user-role-permission>
				
			</c:when>
			<c:when test="${fn:contains('NEW,DRF', pageScope.status)}">
				<!-- Save Action shown in status - NEW, DRF -->
				<tfap:tfap-user-role-permission userRoles="${userRoles}" TFAP_COM_MAKER="true">
					<a href="javascript:void(0)" id="save-action-btn"
						class="btn btn-outline-primary" data-toggle="tooltip"
						data-placement="bottom" title="Save" data-original-title="Save"
						onclick="saveForm('save','${pageScope.msgType}','${pageScope.tranId }','${pageScope.saveUrl }','${pageScope.makerApproverCheck}');">
							<i class="fa fa-floppy-o"></i></a>
				</tfap:tfap-user-role-permission>
			</c:when>
			<c:when test="${fn:contains('APP', pageScope.status) }">
				<c:if test="${fn:contains('LC, SBLC, BG, SG, ECNEG', pageScope.msgType) }">
				<tfap:tfap-user-role-permission userRoles="${userRoles}" TFAP_COM_MAKER="true">
					<a href="#" id="duplicate_btn" class="btn btn-outline-primary" data-toggle="tooltip" data-placement="bottom" title="Duplicate" data-original-title="Duplicate">
						<i class="fa fa-copy"></i>
					</a>
				</tfap:tfap-user-role-permission>
				</c:if>
				<c:if test="${fn:contains('IFIPR,IFEPR', pageScope.msgType) }">
					<tfap:tfap-user-role-permission userRoles="${userRoles}" TFAP_COM_MAKER="true">
						<c:if test="${isEnableConvertBtn}">
							<a href="#" id="convert_btn" class="btn btn-outline-primary" data-toggle="tooltip" data-placement="bottom" title="Convert" data-original-title="Convert">
								<i class="fa fa-retweet"></i>
							</a>
						</c:if>
					</tfap:tfap-user-role-permission>
				</c:if>
				<c:if test="${fn:contains('IFIPR,IFEPR,IFEPO,IFIPO', pageScope.msgType) }">
					<tfap:tfap-user-role-permission userRoles="${userRoles}" TFAP_COM_MAKER="true">
					<c:if test="${not hasConverted}">
                        <a href="#" id="extension_btn" class="btn btn-outline-primary" data-toggle="tooltip"
						   data-placement="bottom" title="Extension" data-original-title="Extension">
							<i class="fa fa-clock-o"></i>
						</a>					
					</c:if>
						<tfap:action-convert/>
						<tfap:action-extension/>
						<tfap:if-extension></tfap:if-extension>
						<div class="modal fade" id="ifEdataTableCoyAccnModal" role="dialog">
							<div class="modal-dialog  modal-lg">
								<div class="modal-content">
									<tfap:pagetablesetlaccn
											titleKey="label.settlement.settleAccnPopUpHeader"
											tableName="ifEdataTableCoyAccn" rootUrlName="tfApplication">
									</tfap:pagetablesetlaccn>
									<div class="modal-footer">
										<button type="button" class="btn btn-info " data-dismiss="modal">Close</button>
									</div>
								</div>
							</div>
						</div>
						<script type="text/javascript">
							function callbackCSetl2(row) {
								$('#settleCId').val(row.tfabBnkAccn);
							}
						</script>
					</tfap:tfap-user-role-permission>
				</c:if>
			</c:when>
		</c:choose>
			
		<!-- DISCARD BUTTON -->
		<c:choose>
			<c:when test="${fn:contains('PAU,', pageScope.status) }">
			</c:when>
			<c:when test="${fn:contains('NEW,DRF', pageScope.status)}">
				<tfap:tfap-user-role-permission userRoles="${userRoles}" TFAP_COM_MAKER="true">
					<a href="javascript:void(0)" class="btn btn-outline-primary" data-toggle="tooltip"
						data-placement="bottom" title="Discard" data-original-title="Discard"
						id="discard-action-btn" onclick="discardAction('${pageScope.msgType}','${tranId }');">
						<i class="fa fa-trash"></i>
					</a> 
					
					<tfap:tfapconfirmationmodal button_name="label.modal.button.yes"
						modal_title="label.modal.title.confirmation"
						modal_Id="modal_confirm_discard" primary_btn_id="btn_confirm_discard"
						message="label.modal.message.confirmation.discard"
						callback="discardCallback('${pageScope.tranId }', '${pageScope.msgType }')" />
				</tfap:tfap-user-role-permission>
			</c:when>
		</c:choose>
	</div>



<!-- ------------------------------------------ JAVASCRIPTS -------------------------------------- -->
<script type="text/javascript">

function discardAction(msgType, tfapid){
	openDiscardModal(tfapid, msgType);
}

function openDiscardModal(_tfapId, _docType){
	appId = _tfapId;
	docType = _docType
	$('#modal_confirm_discard').modal('show');
}


function discardCallback(appId, docType){
	
	$.get("<spring:url value='/tfApplication/state-action/app/discard?tfapid=" + appId+"&doc_type="+docType +"' />", function(data, status) {
		data = JSON.parse(data);
		if(data.reject == false){
			swal("<spring:message code="error.general.stateChange.message.deleted"/>", "","warning").then(function() {
				//window.location = data.redirect;
            });
		} else {
			window.location = data.redirect;
		}
        
		
    });
}

function saveForm(action, msgType, tfapid, url, restrictions) {
	if(restrictions === 'RESTRICT'){
		$('#modal_verification_id').modal('show');
	}else {
		//Test123
		/* $('#editForm').attr('action', url);
		$('#editForm').submit(); */
		saveValidFunction(tfapid, msgType, url);
	}
}

function saveValidFunction(tfapId, appRefType, rootUrl){

	 //if(tfapId!=null && appRefType!=null && (appRefType == 'SCISS' || appRefType == 'LCISS' || appRefType == 'ECNEG' || appRefType == 'BGISS')){
	   if(tfapId!=null && appRefType!=null){
		 $.ajax({
			url: "${pageContext.request.contextPath}" +"/exptrlcneg/validate/recordOwnStatus?tfapId="+tfapId,
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
						  $('#editForm').attr('action', rootUrl);
						  $('#editForm').submit();
					  }
					});
				}else{
					$('#editForm').attr('action', rootUrl);
					$('#editForm').submit();
				}
			}
		});
	   }
	 else{
		 $('#editForm').attr('action', rootUrl);
		 $('#editForm').submit();
		 
	  }
	
	 }



</script>

<c:if test="${fn:contains('PAU', pageScope.status) }">
	<script type="text/javascript">
		var dataTable = '';
		$("#reject-action-btn").on('click', function() {
			openRejectModal('${pageScope.tranId}', '${pageScope.msgType}', '')
		});
		
		function openRejectModal(_tfapId, _docType, _dataTable){
			appId = _tfapId;
			docType = _docType;
			dataTable = (_dataTable)? _dataTable:dataTable;
			var makerCompanyCheck = '${pageScope.makerApproverCheck}';
			if(makerCompanyCheck === 'RESTRICT'){
				$('#modal_maker_checker_verify_id').modal('show');
			}else
				$('#modal_confirm_reject').modal('show');
		}
		
		function redirect(e){
			window.location.href="${pageContext.request.contextPath}/tfApplication/list/view";
		}

// 		function rejectCallback(){
// 			var url = "<spring:url value='/tfApplication/state-action/app/reject?tfapid=" + appId + "&doc_type=" + docType +"' />";
// 			$.get(url, function(data, status) {
// 				$('#modals_reject').modal('show');
// 				data = JSON.parse(data);
// 				redirectUrl = data.redirect;
// 			});
// 		}
		
		function rejectConfirmCallback() {
			
			var data = new FormData();
		
			data.append("transactionId", appId);
			data.append("docType", docType);
			data.append("remarks", $('#modal_reject_remarks').val());

			$.ajax({
			    url: "<spring:url value='/tfApplication/state-action/app/reject' />",
			    type: 'post',
			    cache: false,
			    contentType: false,
			    processData: false,
			    data: data,
			    beforeSend: function(){
					$('[id="modal_reject_remarks.errors"]').addClass('d-none');
			    },
			    success: function( data, textStatus, jQxhr ){
			    	data = JSON.parse(data);
			        if(data.reject){
			        	redirectUrl = data.redirect;
			        	$('#modal_confirm_reject').modal('hide');
			    		$('#modals_reject').modal('show');		    	
			        }
			        else if(data.errors.length > 0){
						$.each(data.errors, function(i, error){
							if(error.key == 'transactionId' || error.key == 'docType'){
								
							}else if(error.key == 'remarks' && error.value == false){
								$('[id="modal_reject_remarks.errors"]').removeClass('d-none');			
							}
						});
					}
			    },
			    error: function( jqXhr, textStatus, errorThrown ){
			        
			    }
			});
		}
		
		$('#modals_reject').on('hidden.bs.modal', function (e) {
			if(dataTable != ''){
				dataTable.draw();
			}else{
				let redirectUrlModule = redirectUrl.replace("exptrlcneg", "tfApplication");
				redirectUrlModule = redirectUrlModule.replace("ifImpPre/list", "tfApplication/list");
				redirectUrlModule = redirectUrlModule.replace("ifImpPost/list", "tfApplication/list");
				redirectUrlModule = redirectUrlModule.replace("ifExpPre/list", "tfApplication/list");
				redirectUrlModule = redirectUrlModule.replace("ifExpPost/list", "tfApplication/list");
				redirectUrlModule = redirectUrlModule.replace("ifExt/list", "tfApplication/list");
				window.location = redirectUrlModule;
			}
		});
		
		$(document).ready(function(){
			$('#modal_confirm_reject_btn').removeAttr('data-dismiss');
			
			$('#modal_confirm_reject').on('hidden.bs.modal', function(e) {
				$('#modal_confirm_reject input').val('').change();
				$('#modal_confirm_reject textarea').val('').change();
			});	
			
			$('#modal_confirm_reject_btn').on('click', function(e){
				rejectConfirmCallback();
			})
		});
	</script>
</c:if>

<c:if test="${fn:contains('APP', pageScope.status) }">
	<tfap:tfapconfirmationmodal
		button_name="label.modal.button.yes"
		modal_title="label.modal.title.confirmation" 
		modal_Id="modal_confirm_duplicate"
		primary_btn_id="btn_confirm_duplicate"
		message="label.modal.message.confirmation.duplicate"
		callback="duplicateCallback()"/>

	<tfap:modal button_name="label.bank.button"
				modal_title="label.bank.maker.approver.check" modal_Id="modal_maker_approver_duplicate_verification_id"
				show_button_close="false" show_button_primary="false">
				<br />
				<div class="modal-content">
					<div class="modal-body">
						<h4 style="text-align: center;">
You are not allowed to modify this transaction as you have previously used another role to process this transaction.</h4>
					</div>
					<div class="modal-footer" style="margin-top: -20px;">
						<button type="button" class="btn btn-outline-primary mr-1"
							id="redirect_to_main_duplicate" onclick="redirectToMainDuplicate()"
							href="${pageContext.request.contextPath}/tfApplication/list/view"
							data-dismiss="modal">
							Close
						</button>
					</div>
				</div>
	</tfap:modal>
		
	<script>
		$('#duplicate_btn').on("click", function(e){
			 openDuplicateModal('${pageScope.tranId}', '${pageScope.msgType}');
		});
		
		var appId = '';
		var docType = '';
		
		function redirectToMainDuplicate(e){
			window.location.href="${pageContext.request.contextPath}/tfApplication/list/view";
		}
		
		
		function openDuplicateModal(_tfapId, _docType){
			appId = _tfapId;
			docType = _docType
			var makerApproverCheckflag = '${pageScope.makerApproverCheck}';
			if(makerApproverCheckflag === 'RESTRICT'){
				$('#modal_maker_approver_duplicate_verification_id').modal('show');
			}else 
				$('#modal_confirm_duplicate').modal('show');
		}
		
		function duplicateCallback(){
				$.ajax({
				    url: '${pageScope.duplicateUrl}',//rootUrl + "/duplicate-transaction",
				    dataType: 'json',
				    type: 'post',
				    contentType: 'application/json',
				    data: JSON.stringify({
						"tfapid":appId,
						"doc_type":docType
					}),
				    success: function( data, textStatus, jQxhr ){
						redirectUrl = data.redirect+"&isDuplicate=true";
						window.location = redirectUrl;
				    },
				    error: function( jqXhr, textStatus, errorThrown ){
				        
				    }
				});
		}
		
		$('#convert_btn').on("click", function(e){
			onConvertClick('${pageScope.convertUrl}','${tranId}');
		});

		$('#extension_btn').on("click", function(e){
			onExtensionClick('${tranId}', '${msgType}');
		});
		
	</script>
</c:if>

<%-- <c:if test="${pageScope.status ne 'NEW'}">
	<script>
	$('#print_btn').on("click", function(e){
		 window.open("<spring:url value='/tfApplication/print?transactionId=${pageScope.tranId}&docType=${pageScope.msgType}'/>", '_blank');
	});
	</script>
</c:if> --%>