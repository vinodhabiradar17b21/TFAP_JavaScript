<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<%@attribute name="titleKey" type="java.lang.String" required="true"%>
<%@attribute name="modelName" type="java.lang.String" required="false"%>
<%@attribute name="breadCrumbKey" type="java.lang.String" required="false"%>
<%@attribute name="modelid" type="java.lang.String" required="false"%>
<%@attribute name="modelid1" type="java.lang.String" required="false"%>
<%@attribute name="tabs" fragment="true"%>
<%@attribute name="tablinks" fragment="true"%>
<%@attribute name="isAdvancedProfile" required="false"%>
<%@attribute name="isAdvanBtnEnable" required="false"%>
<%@attribute name="advanProfileName" required="false"%>
<%@attribute name="advanProfilePic" required="false"%>
<%@attribute name="isIdNotReqDisplayInBreadCrum" type="java.lang.Boolean" required="false"%>

<!-- 
 https://jira.vcargocloud.com/browse/TFAPRW-1088
 Generic message should be shown without jumping to any specific tabs
 can not change clib code;
 -->
<c:if test="${not empty msgdanger and ('DRF' == tfApplication.stateForStatusBar or 'NEW' == tfApplication.stateForStatusBar)}">
	<spring:message code="error.general.message" var="msgdanger" scope="request"/>
</c:if>

<c:if test="${not empty stateChange}">
	<spring:message code="error.general.stateChange.message" var="msgdanger" scope="request"/>
</c:if>


<div class="content-wrapper">
	<div class="content-header row">
		<div class="content-header-left col-5 mb-2">
			<h3 class="content-header-title mb-0">
			  
			  <c:if test="${not empty isRecordLock && isRecordLock}"> 
			  <span id=isRecordLock>
			   	 <a href="javascript:void(0)"
			     data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Record is being edited by another user now">
			   <!-- <i class="fa fa-lock"></i> -->
			   <i class="btn_editable_icon"></i>
			   </a>&nbsp;
			   </span>
			  </c:if>
			
				<c:choose>
					<c:when test="${not empty breadCrumbKey}">
						TFAP ID: ${tfApplication.tfTransaction.tfTran.ttfId} &nbsp;
						<!-- This condition is added because Import Settlement has different label name processed instead of processing -->
						<c:choose>
						<c:when test="${modelName == 'tfImpSettlement'}"><tfap:tfapstatuslabelsettle
							status="${tfApplication.stateForStatusBar}" /></c:when>
						<c:otherwise><tfap:tfapstatuslabel
							status="${tfApplication.stateForStatusBar}" /></c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<spring:message code="${titleKey}" />
					</c:otherwise>
				</c:choose>
			</h3>
			<c:if test="${not empty breadCrumbKey}">
				<div class="row breadcrumbs-top">
					<div class="breadcrumb-wrapper col-12">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a
								href="${pageContext.request.contextPath}/home"><spring:message
										code="label.home" /></a></li>
							<li class="breadcrumb-item"><a
								href="${pageContext.request.contextPath}/${modelName}/list/view"><spring:message
										code="${breadCrumbKey}" /></a></li>
							<c:if test="${not isIdNotReqDisplayInBreadCrum}">
							<li class="breadcrumb-item active">TFAP ID:
								${tfApplication.tfTransaction.tfTran.ttfId} &nbsp</li>
							</c:if>
						</ol>
					</div>
				</div>
			</c:if>
		</div>
	<%-- 		<div class="content-header col-2"
			style="text-align: center; margin-bottom: 15px; margin-top: -10px;">
			
			<a href="/TFAPortal/tfApplication/product-management/prd-sub/viewtnc?flag=prd&id=${tfApplication.tfTransactionBankParam.tfBnkOfferTnc.tfbotId}" id="save-action-btn"
			target="_blank" class="btn btn-outline-primary" data-toggle="tooltip"
			data-placement="bottom" title="Terms & Conditions" data-original-title="Terms & Conditions"> T&C
			
			</a>	
			
		</div> --%>
		<c:if test="${not empty breadCrumbKey}">

			<div class="content-header-right col-7">
				<c:choose>
					<c:when test="${tfApplication.tfTransaction.tfTran.state eq 'NEW' || bankPopupRequire }">
						<tfap:state-new />
					</c:when>
					<c:when test="${tfApplication.tfTransaction.tfTran.state eq 'DRF'}">
						<tfap:state-drf />
					</c:when>
					<c:when test="${tfApplication.tfTransaction.tfTran.state eq 'PCH'}">
						<tfap:state-penrev />
					</c:when>
					<c:when test="${tfApplication.tfTransaction.tfTran.state eq 'PAU'}">
						<tfap:state-penauth />
					</c:when>
					<c:when test="${tfApplication.tfTransaction.tfTran.state eq 'SUB'}">
						<tfap:state-submitted />
					</c:when>
					<c:when test="${tfApplication.tfTransaction.tfTran.state eq 'RCV'}">
						<tfap:state-received />
					</c:when>
					<c:when test="${tfApplication.tfTransaction.tfTran.state eq 'PRO'}">
						<tfap:state-processing/>
					</c:when>
					<c:when test="${tfApplication.tfTransaction.tfTran.state eq 'IAP'}">
						<tfap:state-initiate-Approval/>
					</c:when>
					<c:when test="${tfApplication.tfTransaction.tfTran.state eq 'IRJ'}">
						<tfap:state-initiate-rejection/>
					</c:when>
					<c:when test="${tfApplication.tfTransaction.tfTran.state eq 'APP'}">
						<tfap:state-approved/>
					</c:when>
					<c:when test="${tfApplication.tfTransaction.tfTran.state eq 'REJ'}">
						<tfap:state-rejected/>
					</c:when>
					<c:when test="${tfApplication.tfTransaction.tfTran.state eq 'AMD'}">
						<tfap:state-amended/>
					</c:when>
					<c:when test="${tfApplication.tfTransaction.tfTran.state eq 'CAN'}">
						<tfap:state-canceled/>
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>
			</div>
		</c:if>
	</div>
	<c:if test="${isAdvancedProfile}">
		<div class="content-body">
			
		</div>
	</c:if>
	<div class="content-body">
		<section id="description" class="card">
			<div class="card-content">
				<div class="card-body">
					<div class="card-text">
						<div class="row">
							<div class="col-12">
								<jsp:doBody />
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
</div>
<tfap:tfapconfirmationmodal
button_name="label.modal.button.yes"
modal_title="label.modal.title.confirmation"
modal_Id="modal_confirm_discard"
primary_btn_id="btn_confirm_discard"
message="label.modal.message.confirmation.discard"
callback="discardCallback()"/>
<script type="text/javascript">
	function openDiscardModal(_tfapId, _docType){
		appId = _tfapId;
		docType = _docType
		$('#modal_confirm_discard').modal('show');
	}

	function discardCallback(){
		$.get("/TFAPortal/tfApplication/state-action/app/discard?tfapid=" + appId+"&doc_type="+docType, function(data, status) {
			data = JSON.parse(data);
			redirectUrl = data.redirect;
			window.location = redirectUrl;
		});
	}
</script>
