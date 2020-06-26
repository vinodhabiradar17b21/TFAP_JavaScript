<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<c:set var="titleKey" value="label.header.manage.account"/>
<c:set var="breadCrumbKey" value="label.header.manage.account"/>

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
							<a href="${pageContext.request.contextPath}/home">
								<spring:message	code="label.home" />
							</a>
						</li>
						<li class="breadcrumb-item">
							<spring:message code="${breadCrumbKey}" />
						</li>
					</ol>
				</div>
			</div>
		</div>

		<div class="content-header-right col-7">				
			<div class="content-header-right text-right">
				<div class="btn-group float-md-right" role="group" aria-label="Button group with nested dropdown">
					<button id="mng_acc_reset_btn" class="btn btn-outline-primary" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Reset">
						<i class="fa fa-repeat"></i>
					</button>
					<button type="button" id="save_manAccn" class="btn btn-primary">
						<i class="fa fa-floppy-o"></i>&nbsp; Save
					</button>	 
				</div>
			</div>
		</div>
	</div>
	
	<div class="content-body">
		<div id="user-profile">
		<section class="card profile-with-cover">
			<div class="card-img-top img-fluid bg-cover height-100" style="background: url('<c:url value="/resources/images/dashboard/bg_user_profile.jpg"/>') 50%;"></div>
			<div class="media profil-cover-details w-100">
			  <div class="media-left pl-2 pt-2">
				<a href="#" class="profile-image">
				  <img src='<c:url value="/resources/images/dashboard/avatar-m-1.png"/>' class="rounded-circle img-border height-100" alt="Card image">
				</a>
			  </div>
			  <div class="media-body pt-3 px-2">
				<div class="row">
				  <div class="col">
					<h3 class="card-title_user">${ManageAccn.tCoreAccnDto.accnName}</h3>
				  </div>

				</div>
			  </div>
			</div>
			<div style="height:48px">&nbsp</div>
		</section>
		</div>
		
		
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

<tfap:action-reset/>


<script>
function submit_form(action) {
	if (action == 'submit') {
	$('#editForm').attr('action','/TFAPortal/tfApplication/manageaccount/save');
	}
	$('#editForm').submit();
}
$(document).ready(function() {
	$("#save_manAccn").click(function() {
		submit_form('submit');
	});
	
	$('#mng_acc_reset_btn').on('click', function(){
		openResetModal();
	});
});
</script>
