<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<c:set var="titleKey" value="label.header.product.manage.product.offerings"/>
<c:set var="breadCrumbKey" value="label.header.product.manage.product.breadCrumb.offerings"/>

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
			<div class="btn-group float-md-right" role="group" aria-label="Button group with nested dropdown">
				<button type="button" id="confirm1" class="btn btn-primary" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Confirm" tabindex="0">
					<i class="fa fa-check-square-o"></i>
					<spring:message code="label.product.manage.product.offerings.Confirm"/>
				</button>
			</div>
		</div>
		
	</div>
	
	<div class="content-body">
		<section id="description" class="card">
			<div class="card-header">
				<h4 class="card-title">
					<spring:message code="label.product.manage.product.offerings.cardHeader"/>
				</h4>
			</div>
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