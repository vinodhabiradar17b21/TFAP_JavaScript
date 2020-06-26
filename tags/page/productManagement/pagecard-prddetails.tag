<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<c:set var="titleKey" value="label.header.product.manage.product.details"/>
<c:set var="breadCrumbKey" value="label.header.product.manage.product.breadCrumb.details"/>

<div class="content-wrapper">
	<div class="content-header row">
		<div class="content-header-left col-5 mb-2">
			<h3 class="content-header-title mb-0">
				<spring:message code="${titleKey}" />
			</h3>
			<div class="row breadcrumbs-top">
				<div class="breadcrumb-wrapper col-12">
					<ol class="breadcrumb">
						<li class="breadcrumb-item">
							<a href="${pageContext.request.contextPath}/tfApplication/list/view">
								<spring:message	code="label.home" />
							</a>
						</li>
						<li class="breadcrumb-item">
							<a href="${pageContext.request.contextPath}/tfApplication/product-management/prd-offering/list/">
								<spring:message	code="label.header.product.manage.product.breadCrumb.offerings" />
							</a>
						</li> 
						<li class="breadcrumb-item">
							<spring:message code="${breadCrumbKey}" />
						</li>
					</ol>
				</div>
			</div>
		</div>
		<c:if test="${not empty breadCrumbKey}">

			<div class="content-header-right col-7">
				<c:choose>
					<c:when test="${currentState eq 'NEW'}">
						<tfap:state-prd-offering-new />
					</c:when>
					<c:when test="${currentState eq 'DRF'}">
						<tfap:state-prod-off-draft/>
					</c:when>
					<c:when test="${currentState eq 'PAU'}">
						<tfap:state-pend-auth/>
					</c:when>
					<c:when test="${currentState eq 'APP'}">
						<tfap:state-prd-off-approved/>
					</c:when>
				<%-- <c:when test="${currentState eq 'AMD'}">
						<tfap:state-amended/>
					</c:when>
					<c:when test="${currentState eq 'CAN'}">
						<tfap:state-canceled/>
					</c:when> --%>
					<c:otherwise>
					</c:otherwise>
				</c:choose>
			</div>
		</c:if>

<!-- 		<div class="content-header-right col-7">				
			<div class="content-header-right text-right">
				<a href="#" id="save_prd_det" class="btn btn-primary" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Save"><i class="fa fa-floppy-o"></i>&nbsp; Save</a>
			</div>
		</div> -->
		<br>
<%-- 		<div class="col-12">
			<tfap:tfap-pagestatusbar
				currentStatus="${currentState}"
				modelName="tfApplication" statusList="${stateList}">
			</tfap:tfap-pagestatusbar>
		</div> --%>
		
	</div>
	
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

<tfap:tfapconfirmationmodal button_name="label.modal.button.yes"
		modal_title="label.modal.title.confirmation"
		modal_Id="modal_confirm_bank_offer_details"
		primary_btn_id="btn_confirm_bank_offer_details"
		message="label.modal.message.confirmation.save"
		callback="bank_offerCallback_details()" />
<script>
/* function submit_form(action) {
	if (action == 'submit') {
		$('#ProductOfferingId').attr('action','/TFAPortal/tfApplication/product-management/prd-det/save');
	}
	$('#ProductOfferingId').submit();
} */
$(document).ready(function() {
	$("#save_prd_det").click(function() {
		if($('.invalid-file').length > 0){
			
		}else{
			$('#modal_confirm_bank_offer_details').modal('show');
		}
		
		
	});
	
});

function bank_offerCallback_details(){
	submit_form('submit');
}
</script>