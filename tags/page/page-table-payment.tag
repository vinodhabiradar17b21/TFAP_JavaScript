<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@attribute name="titleKey" type="java.lang.String" required="true"%>
<%@attribute name="breadCrumbKey" type="java.lang.String"
	required="false"%>
<%@attribute name="modelName" type="java.lang.String" required="true"%>
<%@attribute name="model" type="java.lang.Object" required="true"%>
<%@attribute name="modelId" type="java.lang.Object" required="false"%>
<%@attribute name="isadvanced" type="java.lang.Boolean" required="false"%>
<%@attribute name="isDatatbleview" type="java.lang.Boolean"
	required="false"%>
	<%@ attribute name="columns" required="false" type="java.lang.Object" %>
	<%@attribute name="tableName" type="java.lang.String" required="false"%>
<%@attribute name="searchForm" fragment="true"%>
<%@attribute name="jsondto" type="java.lang.Object" required="true"%>
<c:set var="tableName" value="${(empty tableName) ? 'dataTableInput' : tableName}" />
<c:set var="columns" value="${(empty columns) ? '${columns}' : columns}" />
<c:set var="isDatatbleview"
	value="${(empty isDatatbleview) ? true : isDatatbleview}" />
<c:set var="isPopUp" value="${(empty isPopUp) ? false : isPopUp}" />

<style>
.switch {
	position: relative;
	display: inline-block;
	width: 40px;
	height: 20px;
}

.switch input {
	opacity: 0;
	width: 0;
	height: 0;
}

.slider {
	position: absolute;
	cursor: pointer;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: #ccc;
	-webkit-transition: .4s;
	transition: .4s;
}

.slider:before {
	position: absolute;
	content: "";
	height: 18px;
	width: 18px;
	left: 4px;
	bottom: 1px;
	background-color: white;
	-webkit-transition: .4s;
	transition: .4s;
}

input:checked+.slider {
	background-color: #2196F3;
}

input:focus+.slider {
	box-shadow: 0 0 1px #2196F3;
}

input:checked+.slider:before {
	-webkit-transform: translateX(16px);
	-ms-transform: translateX(16px);
	transform: translateX(16px);
}

/* Rounded sliders */
.slider.round {
	border-radius: 34px;
}

.slider.round:before {
	border-radius: 50%;
}
</style>
<c:if test="${isDatatbleview}">
	<div class="content-wrapper">

		<div class="content-header row">
			<div class="content-header-left col-6 mb-2">
				<h3 class="content-header-title mb-0">
					<spring:message code="${breadCrumbKey}" />
				</h3>
				<div class="row breadcrumbs-top">
					<div class="breadcrumb-wrapper col-12">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a
								href="${pageContext.request.contextPath}/home"><spring:message
										code="label.home" /></a></li>
							<li class="breadcrumb-item active"><spring:message
									code="${breadCrumbKey}" /></li>
						</ol>
					</div>
				</div>
			</div>
			<div class="content-header-right col-6">
				<%-- <%@include file="/META-INF/views/common/common_html_buttons.jspf"%> --%>
			</div>
		</div>
</c:if>
<div class="content-body">
	<section id="description" class="card">
		<c:if test="${isDatatbleview}">
			<div class="card-header">
				<div class="row">
					<div class="col-6">
						<h4 class="card-title">
							<spring:message code="${titleKey}" />
							<spring:message code="label.list" />
						</h4>
					</div>
					<%-- <div class="col-3" align="right">
						<button type="button" id="addRow${tableName}" class="btn btn-info">Add&nbsp;<i class="fa fa-plus" aria-hidden="true"></i>
						</button>
					</div> --%>
					<c:if test="${isadvanced}">
						<div class="col-6">
							<ul class="nav navbar-right panel_toolbox pull-right">
								<!-- <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li> -->
								<li><a role="button" data-toggle="collapse"
									href="#advancedSearch" aria-expanded="false"
									aria-controls="collapseExample" class="collapsed"> <i
										class="fa fa-info-circle" style="display: inline-flex;">&nbsp;
											<div class="text_btn">
												<spring:message code="label.advancedSearch" />
											</div>
									</i>
								</a></li>
							</ul>
							<div class="clear"></div>
						</div>
					</c:if>
				</div>
			</div>
		</c:if>
		<c:if test="${isDatatbleview}">
			<div class="card-content">
				<div class="card-body">
					<div class="card-text">
		</c:if>
		<div class="row">
			<c:if test="${isDatatbleview}">
				<%-- <%@include file="/META-INF/views/common/common_html_message.jspf"%> --%>
			</c:if>
			<c:if test="${isadvanced}">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="collapse" id="advancedSearch" aria-expanded="false"
						style="height: 0px;">
						<div class="well">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="title-sub">
										<h5>
											<spring:message code="label.searchCriteria" />
										</h5>
									</div>
								</div>
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<jsp:invoke fragment="searchForm" />
								</div>
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="col-action-btn">
										<div class="btn-group input-xs" role="group" aria-label="...">
											<button type="button" class="btn btn-action btn-primary"
												data-toggle="tooltip" data-placement="top" title=""
												onclick="document.editForm.action.value='search'; submitForm( $('#editForm'), '/${modelName}/datatablejson');"
												data-original-title="Search messages using criteria(s)...">
												<div class="fa fa-search"></div>
												&nbsp;
												<spring:message code="label.search" />
											</button>
											<button type="button" class="btn btn-action"
												data-toggle="tooltip" data-placement="top" title=""
												onclick="clearDataTableFilter(); document.editForm.action.value='clear'; submitForm( $('#editForm'), '/${modelName}/datatablejson');"
												data-original-title="Clear criteria(s)...">
												<div class="fa fa-undo"></div>
												&nbsp;
												<spring:message code="label.clear" />
											</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<%@ include file="../../views/common/common_html_datatable_payment.jspf"%>
				<script type="text/javascript">
								 var url${tableName} = "<spring:url value='/${modelName}/list/json/' />";
								 <c:if test="${not isDatatbleview}">
								      url${tableName} = "<spring:url value='/sewELicense/datatableview?radio=123' />";
									</c:if> 
									var status;
									var aoColumns${tableName} = [
										<c:forEach items="${columns}" var="column" varStatus="loop">
											{"mData" : "${column}",
												"mRender": function (data, type, full, row) {
													 var col="${column}";
													 if(col.trim().toLowerCase().indexOf("status") >= 0)
														{
													if(data.trim()=="A")
														{
														status=full.${column};
														data='&nbsp;&nbsp;<div class="badge badge-success">Active</div>'
														}
													else if(data.trim()=="I")
														{
														status=full.${column};
														data='&nbsp;&nbsp;<div class="badge badge-danger">InActive</div>'
														}
														}
												   if(col=='Actions' && status.trim()=="I")
														{
														data= '&nbsp;&nbsp;<button type="button" class="btn_action btn-primary dropdown-toggle" data-toggle="dropdown"'
															+'   aria-haspopup="true" aria-expanded="false">'
														+'<i class="fa fa-ellipsis-h"></i>'
								                                +'</button>'
															
								                              +' <div class="dropdown-menu arrow-right mr-5">'
								                        /*     +'<button class="dropdown-item editrow" type="button"><i class="fa fa-pencil-square-o "></i>&nbsp; Edit </button>' */
								                           /*  +'<button class="dropdown-item" type="button"><i class="fa fa-copy"></i>&nbsp; Duplicate</button>' */
								                            +'<button class="dropdown-item activate" type="button"><i class="fa fa-link"></i>&nbsp; Activate</button>'
								                           /*  +'<button class="dropdown-item view" type="button"><i class="fa fa-eye"></i>&nbsp; View</button>' */
								                            +'</div>'
														}
													else if(col=='Actions' && status.trim()=="A")
													{
													data= '&nbsp;&nbsp;<button type="button" class="btn_action btn-primary dropdown-toggle" data-toggle="dropdown"'
														+'   aria-haspopup="true" aria-expanded="false">'
													+'<i class="fa fa-ellipsis-h"></i>'
							                                +'</button>'
														
							                              +' <div class="dropdown-menu arrow-right mr-5">'
							                              +'<button class="dropdown-item view" type="button"><i class="fa fa-eye"></i>&nbsp; View</button>'
							                              +'<button class="dropdown-item editrow" type="button"><i class="fa fa-pencil-square-o "></i>&nbsp; Edit </button>'
							                             +'<button class="dropdown-item duplicate" type="button"><i class="fa fa-copy"></i>&nbsp; Duplicate</button>'
							                            +'<button class="dropdown-item deactivate" type="button"><i class="fa fa-unlink"></i>&nbsp; Deactivate</button>'
							                            +'</div>'
													}
													else if(col=='Actions' && status=='')
														{
														data= '&nbsp;&nbsp;<button type="button" class="btn_action btn-primary dropdown-toggle" data-toggle="dropdown"'
															+'   aria-haspopup="true" aria-expanded="false">'
														+'<i class="fa fa-ellipsis-h"></i>'
								                                +'</button>'
															
								                              +' <div class="dropdown-menu arrow-right mr-5">'
								                            +'<button class="dropdown-item view" type="button"><i class="fa fa-eye"></i>&nbsp; View</button>'
								                            +'</div>'
														
														}
													else if(col=='No.')
													{
													data=row+1;
													} 
													return data;
													}	 
											
											},
											
										</c:forEach>
									];
								
									
								</script>
				<div class="table-responsive">
					<table id="${tableName}"
						class="table table-striped jambo_table bulk_action stripe">
						<thead>
							<tr class="table_header">
								<c:forEach items="${columns}" var="column">
								<c:choose>
                                   <c:when test="${column == 'hseftCode'}">
                                      <th class="column-title">Data Type</th>
                                   </c:when>    
                                <c:otherwise>
                                      <th class="column-title"><spring:message
											code="label.${modelName}.${column}" /></th>
                                </c:otherwise>
                               </c:choose>
								</c:forEach>
							</tr>
						</thead>
						<tbody></tbody>
						<tfoot>
							<tr>
								<c:forEach items="${columns}" var="column">
								
								<c:choose>
                                   <c:when test="${column == 'hseftCode'}">
                                      	<th><input type="text" id="search_0"
										class="form-control input-xs table-filter"
										style="width: 100%;"
										placeholder="Data Type"></th>
                                   </c:when>    
                                    <c:when 
							test="${ fn:contains(column, 'Actions') || fn:contains(column, 'No.') || fn:contains(column, 'Select')}"> 
							<th th style="width:20px;"></th>   
							</c:when>
							
							<c:when 
							test="${ fn:contains(column, 'Status')}"> 
							<th style="width:20px;"><input type="text" id="search_0"
										class="form-control input-xs table-filter"
										style="width: 100%;"
										placeholder="<spring:message code='label.${modelName}.${column}'/>"></th>   
							</c:when>
                                <c:otherwise>
                                      	<th><input type="text" id="search_0"
										class="form-control input-xs table-filter"
										style="width: 100%;"
										placeholder="<spring:message code='label.${modelName}.${column}'/>"></th>
                                </c:otherwise>
                               </c:choose>
								
								
								</c:forEach>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</div>
		<c:if test="${isDatatbleview}">
</div>
</div>
</div>
</c:if>
</section>
</div>
<c:if test="${isDatatbleview}">
	<div class="content-header row">
		<div class="content-header-right col-12 mb-2">
			<%-- <%@include file="/META-INF/views/common/common_html_buttons.jspf"%> --%>
		</div>
	</div>

	</div>
</c:if>
<form:form id="editForm"
	action="${pageContext.request.contextPath}/${modelName}/update"
	method="post" modelAttribute="${modelName}"
	enctype='multipart/form-data'>
	<!-- Modal -->
	<div class="modal fade" id="editableModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header" style="background-color: #00B5B8;">
					<h4 class="modal-title" style="color: white;">Editable Fields</h4>
				</div>
				<div class="modal-body">

					<c:forEach items="${editablecolumns}" var="column">
						<c:if test="${column == 'hseftCode'}">
							<div class="row" id="${column}row">
								<div class="col-6">
									<label for="${column}">Data Type</label>



								</div>
								<div class="col-6">


									<select class="form-control selectType" id="dataType"
										name="hseftCode">
										<c:forEach items="${datatype}" var="data">
											<option value=${data.key}>${data.value}</option>
										</c:forEach>
									</select>



								</div>
							</div>

						</c:if>
						<c:if test="${column == 'hsefSize'}">
							<div class="row" id="${column}row">
								<div class="col-6">
									<label for="${column}"><spring:message
											code='label.${modelName}.${column}' /></label>



								</div>
								<div class="col-6">


									<select class="form-control" id="desc" name="hsefSize"
										style="display: none;" disabled>
										<c:forEach items="${HsCodeDescription}" var="data">
											<option value=${data.key}>${data.value}</option>
										</c:forEach>
									</select> <input type="text" onkeypress="return isNumber(event)"
										placeholder="NUMERIC VALUES" name="hsefSize" id="num"
										class="form-control input-xs table-filter"
										style="width: 100%; display: none;" disabled> <input
										type="text" name="hsefSize" id="alphanum"
										class="form-control input-xs table-filter"
										style="width: 100%;"> <input class="form-control"
										id="dateTest" name="hsefSize" placeholder="MM/DD/YYY"
										type="text" style="display: none;" disabled>



								</div>
							</div>
						</c:if>

						<c:if test="${fn:contains(column, 'Mandatory')}">
							<div class="row" id="${column}row">
								<div class="col-6">
									<label for="${column}"><spring:message
											code='label.${modelName}.${column}' /></label>



								</div>
								<div class="col-6">

									<!-- Default switch -->
									<label class="switch" id="mandatSwitch"
										style="margin-top: -15px;"><input
										class="mandatoryCheck" id="mandatoryCheck"
										class="form-control" type="checkbox" name="${column}"><span
										class="slider round"></span></label><input class="form-control"
										id="hiddenValue" type="hidden" value="off" name="${column}">



								</div>
							</div>

						</c:if>

						<c:if
							test="${ !fn:contains(column, 'hsefSize') && !fn:contains(column, 'hseftCode') && !fn:contains(column, 'Mandatory')}">
							<div class="row" id="${column}row">
								<div class="col-6">
									<label for="${column}"><spring:message
											code='label.${modelName}.${column}' /></label>



								</div>
								<div class="col-6">

									<input type="text" class="form-control input-xs table-filter"
										style="width: 100%;" name="${column}" id="${column}"
										placeholder="<spring:message code='label.${modelName}.${column}'/>">



								</div>
							</div>
						</c:if>




						<br>
					</c:forEach>

				</div>

				<div class="modal-footer">
					<button type="submit" class="btn btn-primary" id="saveButton">Save</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

		</div>
	</div>
</form:form>
