<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@attribute name="filterProducts" type="java.util.Map" required="true" %>
<%@attribute name="filterStatus" type="java.util.List" required="true" %>
<%@attribute name="tableType" type="java.lang.String" required="true" %>

<div class="collapse" id="collapseFilters">
	<section id="filter-panel" class="card">
	    <div class="card-header">
	        <h4 class="card-title">Quick Filters</h4>
	    </div>
	    <div class="card-content">
		    <div class="card-body">
			    <div class="card-text">
					<form id="quick-filters">
						<div class="row">
							<div class="col-10">
								<c:forEach items="${filterProducts.keySet()}"
									var="key" varStatus="i">
									<label> <input type="checkbox" value="${key}"
										class="table-filter-checkbox"> <span>${ filterProducts.get(key)}</span>
									</label>
								</c:forEach>
							</div>
							<div class="col-2">
								<div class="btn-group submitter-group ml-1">
									<div class="input-group-prepend">
										<div class="input-group-text">Status</div>
									</div>
									<select class="form-control table-filter-status-dropdown">
										<option value="">All</option>
										<c:forEach items="${filterStatus}" var="statusCode" varStatus="i">
											<option value="${statusCode}"><spring:message
													code="label.application.status.${statusCode}" /></option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
</div>