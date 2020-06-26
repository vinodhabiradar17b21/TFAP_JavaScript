<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false"%>

<div class="content-header-right text-right">
	<div class="btn-group" role="group"
		aria-label="Button group with nested dropdown">
		<!--Commenting Reset Button- Saurabh -->
		<!-- 			<a href="#" class="btn btn-outline-primary" id="reset-action-btn" data-toggle="tooltip"
				data-placement="bottom" title="Reset" data-original-title="Reset">
				<i class="fa fa-repeat"></i>
			</a> -->
		<a href="javascript:void(0)" id="save-action-btn"
			class="btn btn-outline-primary pageLoderId" data-toggle="tooltip"
			data-placement="bottom" title="Save" data-original-title="Save"
			onclick="submit_form('save');"> <i class="fa fa-floppy-o"></i>
		</a>
	</div>
	<tfap:state-submit-bank />
	<c:if test="${not empty bankSelection}">
		<tfap:modal button_name="label.bank.button"
			modal_title="label.bank.select" modal_Id="modal_bankId_select"
			show_button_close="false" show_button_primary="false">
			<br />
			<div class="">
				<spring:message code="label.state.sent-to" />
				<c:out value="${tfApplication.tfTransaction.tfTran.tftBnkAccn}" />	
				
				<spring:message code='label.selectbank' var="selectfieldLabel" />
				<form:select id="selectedBank"
					path="tfApplication.tfTransaction.tfTran.tftBnkAccn"
					cssErrorClass="border-danger form-control required"
					cssClass="form-control required" required="false"
					disabled="${disableBnkSpecificSelect}">
					<form:option value="" label="${selectfieldLabel}" />
					<form:options items="${productSubBank}" />
				</form:select>
				<br /></br/>
				<div class="modal-footer" style="margin-top: -20px;">
					<button type="button" class="btn btn-outline-primary mr-1"
						id="redirect_to_main" onclick="redirectToMain()"
						href="${pageContext.request.contextPath}/tfApplication/list/view"
						data-dismiss="modal">
						<spring:message code='label.modal.button.close' />
					</button>
					<button type="submit" class="btn btn-primary"
						onclick="selectdBankVal(this)" data-dismiss="modal"
						id="select_banks_btn" title="Continue To apply"
						aria-label="Continue To apply">
						<span aria-hidden="true">Continue To apply</span>
					</button>
				</div>
				<span style="display: none;" id="isDuplicate"><h6>By default, Bank will be selected as Bank of the copied application.</h6></span>
			</div>
		</tfap:modal>
	</c:if>
</div>

<tfap:action-reset />

<tfap:auto-save />

<script type="text/javascript">
		function selectdBankVal(e){
			var selectedBankVal = $('#selectedBank').val();
			$('#selectedBank1').val(selectedBankVal);
			window.location.href = setQueryParamsForBankSelection(selectedBankVal);
		}
		
		function setQueryParamsForBankSelection(bankId) {
			var endpath = '${pageContext.request.getAttribute("endpath")}';
			endpath = endpath.replace('isDuplicate=true','isDuplicate=false');
			var queryParamStart = '?'
			if (endpath && endpath.indexOf(queryParamStart) != -1) {
				queryParamStart = '&';
			}
			return endpath + queryParamStart + 'bankAccnId=' + bankId;
		}
		
		function redirectToMain(e){
			window.location.href="${pageContext.request.contextPath}/tfApplication/list/view";
		}

		$("#selectedBank").on('change', function () {	
		    $('#select_banks_btn').prop('disabled', $('#selectedBank :selected').val() == "");
		    $('#submit_review').prop('disabled', $('#selectedBank :selected').val() == "");
		    $("#tfTransaction\\.tfTran\\.tftBnkAccn").val($('#selectedBank :selected').val());
		    $("#tfTransaction\\.tfTran\\.tftBnkName").val($('#selectedBank :selected').text());
		    retrieveBankSpecific = true;
		});

		$(document).ready(function() {
			$('#modal_bankId_select').modal({backdrop: 'static', keyboard: false}) 
			/*$('#modal_bankId_select').modal('show');*/
			$('#select_banks_btn').prop('disabled', $('#selectedBank :selected').val() == "");
			$('#reset-action-btn').on('click', function(){
				openResetModal();
			});	
		});

		$(".pageLoderId").on('click', function (e) {
			$('#pleaseWaitDialog').modal('show');
		}); 

		//TFAPRW-2345 - show lable on duplicate
		var endpath = '${pageContext.request.getAttribute("endpath")}';
		if(endpath.includes("isDuplicate=true"))
			$('span#isDuplicate').show();
		
</script>