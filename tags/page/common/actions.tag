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
<%@attribute name="showSubmitToBank" type="java.lang.Boolean" required="true"%>
<%@attribute name="showBankSelection" type="java.lang.Boolean" required="true"%>
<%@attribute name="selectedBank" type="java.lang.String" required="true"%>
<%@attribute name="isBankSelectionEnabled" type="java.lang.Boolean" required="false"%>
<%@attribute name="modelNameUrl" type="java.lang.String" required="true"%>
<%@attribute name="hideDefaultButtons" required="false" type="java.lang.Boolean" description="Default buttons such as save"%>
<%@attribute name="saveUrl" type="java.lang.String" required="false" description="URL for saving the transaction."%>
<%@attribute name="submitUrl" type="java.lang.String" required="false" description="URL for submission of transaction."%>
<%@attribute name="duplicateUrl" type="java.lang.String" required="false" description="URL for duplicating of transaction."%>
<%@attribute name="printUrl" type="java.lang.String" required="false" description="URL for print transaction."%>
<%@attribute name="convertUrl" type="java.lang.String" required="false" description="URL for Convertion transaction."%>
<%@attribute name="makerApproverCheck" type="java.lang.String" required="false" description="For restrictions between maker/approver"%>
<%@attribute name="tncAppId" type="java.lang.String" required="false" description="For the terms and conditions application"%>

<c:set var="ctx" value="${pageContext.request.contextPath }"/>
<div class="content-header-right text-right">
	
	<tfap:actionButtons status="${pageScope.status }"
							msgType="${pageScope.msgType }" tranId="${pageScope.tranId}" duplicateUrl="${pageScope.duplicateUrl }" printUrl ="${pageScope.printUrl}"
							saveUrl="${pageScope.saveUrl }" convertUrl="${pageScope.convertUrl }" makerApproverCheck="${pageScope.makerApproverCheck }" tncAppId="${pageScope.tncAppId }"/>

	<c:if test="${pageScope.showSubmitToBank eq true }">
		<div class="btn-group ml-1 submitter-group">
			<div class="">
				<div class="input-group-text">
					<spring:message code="label.state.sent-to" />
				</div>
			</div>
				<c:choose>
					<c:when test="${!fn:contains('DUP', pageScope.status) }">
						<c:set var="disableSelect" value="true"></c:set>
					</c:when>
					<c:otherwise>
						<c:set var="disableSelect" value="false"></c:set>
					</c:otherwise>
				</c:choose>
				<spring:message code='label.selectbank' var="selectfieldLabel" />
				<tfap:selectGroup id="bankIdSelected" selectedId="${pageScope.selectedBank }" selectList="${subscribedBankProducts }" placeholder="${selectfieldLabel }" disabled="${disableSelect }"></tfap:selectGroup>
		</div>
	</c:if>


	<tfap:actionButtonsRight status="${pageScope.status }" msgType="${pageScope.msgType}" tranId="${pageScope.tranId }"
							 submitUrl="${pageScope.submitUrl }" makerApproverCheck="${pageScope.makerApproverCheck}"
							 modelNameUrl="${modelNameUrl}"/>
	
		
</div>

<c:if test="${not empty pageScope.showBankSelection and pageScope.showBankSelection}">
	<tfap:modal button_name="label.bank.button" modal_title="label.bank.select" modal_Id="modal_bankId_select" show_button_close="false" show_button_primary="false">
		<br />
		<div class="">
			<spring:message code="label.state.sent-to" />
			<c:out value="${pageScope.selectedBank}" />	
			
			<spring:message code='label.selectbank' var="selectfieldLabel" />
			<tfap:selectGroup placeholder="${selectfieldLabel }" required="true" id="bankSelection" selectedId="${selectedBank }" selectList="${subscribedBankProducts }" disabled="${bankSelectionEnabled }"/> 
			<br /><br/>
			<div class="modal-footer" style="margin-top: -20px;">
				<button type="button" class="btn btn-outline-primary mr-1"
					id="redirect_to_main" onclick="redirectToMain()"
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
		</div>
	</tfap:modal>
	
	<script>
	function selectdBankVal(e){
		var selectedBankVal = $('#bankSelection').val();
		$('#selectedBank1').val(selectedBankVal);
		var currUrl = window.location.href;
		window.location.href = setQueryParamsForBankSelection(selectedBankVal, currUrl);
	}
	
	function setQueryParamsForBankSelection(bankId, url) {
		var newParam;
		if (url) {
			var i = url.indexOf("?");
			if (i == -1) {
				url += '?';
			}
			newParam = url.substring(i, url.length);
			newParam = newParam.replace('&isDuplicate=true', '&isDuplicate=false'); 
		}
		var ttfId = "${pageScope.tranId}";
		return newParam + '&bankAccnId=' + bankId + '&ttfId=' + ttfId;
	}
	
	function redirectToMain(e){
		window.location.href="${pageContext.request.contextPath}/tfApplication/list/view";
	}
	
	$("#bankSelection").on('change', function () {	
	    $('#select_banks_btn').prop('disabled', $('#bankSelection :selected').val() == "");
	   
	    $("#tfTransaction\\.tfTran\\.tftBnkAccn").val($('#bankSelection :selected').val());
	    $("#tfTransaction\\.tfTran\\.tftBnkName").val($('#bankSelection :selected').text());
	    retrieveBankSpecific = true;
	});
	
	$(document).ready(function() {
		$('#modal_bankId_select').modal({backdrop: 'static', keyboard: false}) 
		/*$('#modal_bankId_select').modal('show');*/
		$('#select_banks_btn').prop('disabled', $('#bankSelection :selected').val() == "");
		$('#reset-action-btn').on('click', function(){
			openResetModal();
		});	
	});
	</script>
</c:if>
