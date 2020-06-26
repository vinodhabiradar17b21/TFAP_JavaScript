<%@tag description="Header part where breadcrumbs and action buttons are placed" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<%@attribute name="titleKey" type="java.lang.String" required="true"%>
<%@attribute name="msgAppId" type="java.lang.String" required="true"%>
<%@attribute name="msgType" type="java.lang.String" required="true"%>
<%@attribute name="modelAppStatus" type="java.lang.String" required="true"%>
<%@attribute name="modelAppStatusBar" type="java.lang.String" required="true"%>
<%@attribute name="modelNameUrl" type="java.lang.String" required="false" description="Root URL used. This is usually the same as the model name."%>
<%@attribute name="breadCrumbKey" type="java.lang.String" required="false"%>
<%@attribute name="selectedBankId" type="java.lang.String" required="false"%>
<%@attribute name="isAdvancedProfile" type="java.lang.Boolean" required="false"%>
<%@attribute name="isDisplayModelAppId" type="java.lang.Boolean" required="false"%>
<%@attribute name="isBankPopupRequired" type="java.lang.Boolean" required="false"%>
<%@attribute name="makerApproverCheck" type="java.lang.String" required="false" description="For restrictions between maker/approver"%>
<%@attribute name="tncAppId" type="java.lang.String" required="false" description="For the terms and conditions application"%>
<%@attribute name="isConverted" type="java.lang.Boolean" required="false"%>
<%@attribute name="msgAppParentId" type="java.lang.String" required="false"%>

<c:set var="ctx" value="${pageContext.request.contextPath }"/>
<c:set var="currentState" value="${(not empty modelAppStatus) ? modelAppStatus : 'UKN'}"/>
<div class="content-wrapper">
	<div class="content-header row">
		<div class="content-header-left col-5 mb-2">
			<h3 class="content-header-title mb-0">
				
				<%--  <c:if test="${not empty isRecordLock && isRecordLock}"> 
				   <span id="isRecordLock">
			   		 <a href="javascript:void(0)" class="btn btn-danger"
			  		  data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Record is Locked">
			          <i class="fa fa-lock"></i></a>&nbsp;
			        </span>
			  	 </c:if> --%>
			  	 
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
					<c:when test="${not empty pageScope.breadCrumbKey}">
						TFAP ID: ${pageScope.msgAppId} &nbsp;
						<tfap:tfapstatuslabel status="${pageScope.modelAppStatusBar}" />
						<tfap:tfap-user-role-permission userRoles="${userRoles}"
							TFAP_COM_MAKER="true" TFAP_COM_APPROVER="true">
							<c:if test="${pageScope.isConverted}">
								<c:choose>
									<c:when test="${pageScope.msgType == 'IFIPO'}">
										<a
				
											href="${ctx}/ifImpPre/read/view?tfapid=${pageScope.msgAppParentId}">${pageScope.msgAppParentId}
											&nbsp;</a>
									</c:when>
									<c:when test="${pageScope.msgType == 'IFEPO'}">
										<a
											href="${ctx}/ifExpPre/read/view?tfapid=${pageScope.msgAppParentId}">${pageScope.msgAppParentId}
											&nbsp;</a>
									</c:when>
									<c:when test="${pageScope.msgType == 'IFEXT'}">
										<a
											href="${ctx}/ifExt/read/view?tfapid=${pageScope.msgAppParentId}">${pageScope.msgAppParentId}
											&nbsp;</a>
									</c:when>
								</c:choose>

							</c:if>
						</tfap:tfap-user-role-permission>
					</c:when>
					<c:otherwise>
						<spring:message code="${pageScope.titleKey}" />
					</c:otherwise>
				</c:choose>
			</h3>
			<c:if test="${not empty pageScope.breadCrumbKey}">
				<div class="row breadcrumbs-top">
					<div class="breadcrumb-wrapper col-12">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a
								href="${ctx}/home"><spring:message
										code="label.home" /></a></li>
							<li class="breadcrumb-item"><a
								href="${ctx}/tfApplication/list/view"><spring:message
										code="${pageScope.breadCrumbKey}" /></a></li>
							<c:if test="${not pageScope.isDisplayModelAppId}">
								<li class="breadcrumb-item active">TFAP ID: ${pageScope.msgAppId} &nbsp;</li>
							</c:if>
						</ol>
					</div>
				</div>
			</c:if>
		</div>
		<c:if test="${not empty pageScope.breadCrumbKey}">
			<c:set var="urlForSave" value="${ctx }/${modelNameUrl }/draft/save?doc_type=${pageScope.msgType }&tfapid=${pageScope.msgAppId}"/>
<%--			<c:set var="urlForSubmit" value="${ctx }/${modelNameUrl }/draft/submit?doc_type=${pageScope.msgType }&tfapid=${pageScope.msgAppId}"/>--%>
            <c:set var="urlForSubmit" value="${ctx}/${modelNameUrl}/state/change/${currentState}?tfapId=${msgAppId}&doc_type=${msgType}"/>
			<c:set var="urlForDuplicate" value="${ctx }/${modelNameUrl }/duplicate"/>
			<c:set var="urlForPrint" value="${ctx }/${modelNameUrl }/print?transactionId=${pageScope.msgAppId}&docType=${pageScope.msgType}"/>
			<c:set var="urlForView" value="${ctx }/${modelNameUrl }/read/view?tfapid=${pageScope.msgAppId}&doc_type=${pageScope.msgType}"/>
			<c:set var="urlForConvert" value="${ctx }/${modelNameUrl }/convert/"/>
			<!-- check if the account is company or bank then toggle the showSubmitToBank -->
			<c:set var="showSubmitToBank" value="false"/>
			<tfap:tfap-user-role-permission userRoles="${userRoles}" TFAP_COM_MAKER="true" TFAP_COM_APPROVER="true">
					<c:set var="showSubmitToBank" value="true"/>
			</tfap:tfap-user-role-permission>
			
			<div class="content-header-right col-7">
				<tfap:actions status="${pageScope.modelAppStatus }" modelNameUrl="${modelNameUrl}"
							showBankSelection="${pageScope.isBankPopupRequired }" showSubmitToBank="${showSubmitToBank }" msgType="${pageScope.msgType }" tranId="${pageScope.msgAppId}"
							selectedBank="${pageScope.selectedBankId }" isBankSelectionEnabled="${not empty pageScope.selectedBankId ? false : true}" 
							saveUrl="${urlForSave }" submitUrl="${urlForSubmit }" duplicateUrl="${urlForDuplicate }" printUrl ="${urlForPrint}" convertUrl="${urlForConvert }" 
							makerApproverCheck="${pageScope.makerApproverCheck }" tncAppId="${pageScope.tncAppId }"/>
			</div>
		</c:if>
	</div>
	<c:if test="${pageScope.isAdvancedProfile}">
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
