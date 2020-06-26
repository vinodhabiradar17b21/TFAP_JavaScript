<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@attribute name="titleKey" type="java.lang.String" required="true"%>
<%@attribute name="breadCrumbKey" type="java.lang.String"
	required="false"%>
<%@attribute name="modelName" type="java.lang.String" required="true"%>
<%@attribute name="isModelNameDiff" type="java.lang.String" required="false"%>

<%@attribute name="model" type="java.lang.Object" required="true"%>
<%@attribute name="modelId" type="java.lang.Object" required="false"%>
<%@attribute name="isadvanced" type="java.lang.Boolean" required="false"%>
<%@attribute name="isDatatbleview" type="java.lang.Boolean"
	required="false"%>
	<%@ attribute name="columns" required="false" type="java.lang.Object" %>
	<%@attribute name="tableName" type="java.lang.String" required="false"%>
<%@attribute name="searchForm" fragment="true"%>
<%@attribute name="isAllBtnDisable" type="java.lang.Boolean"
	required="false"%>
<%@attribute name="isAddStsEn" type="java.lang.Boolean"
	required="false"%>	
<%@attribute name="isCustoms" type="java.lang.Boolean"
	required="false"%>
<%@attribute name="isAgencyAdmin" type="java.lang.Boolean"
	required="false"%>
<%@attribute name="isCNSWDashboard" type="java.lang.Boolean"
	required="false"%> 
	<%@attribute name="isNoPagination" type="java.lang.Boolean"
	required="false"%>
<%@attribute name="isManageDistributor" type="java.lang.Boolean"
	required="false"%> 
<c:set var="tableName" value="${(empty tableName) ? 'dataTableInput' : tableName}" />
<c:set var="columns" value="${(empty columns) ? '${columns}' : columns}" />
<c:set var="isDatatbleview"
	value="${(empty isDatatbleview) ? true : isDatatbleview}" />
<c:set var="isPopUp" value="${(empty isPopUp) ? false : isPopUp}" />

<style>
table.dataTable tbody tr:hover {
   background-color:#C0D9E5 !important;
/*     cursor:pointer; */
}
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
				<%@include file="/WEB-INF/views/common/common_html_buttons.jspf"%>
			</div>
		</div>
</c:if>
<div class="content-body">
	<section id="description" class="card">
	<c:choose>
	    <c:when test="${isDatatbleview}">
	    <div class="card-header">
					<div class="row">
						<div class="col-12 section_title">
							<h4 class="card-title">
								<img
									src="<c:url value="/resources/app-assets/images/icon_page/TMA_icon.png"/>"
									alt="" class="title-page">
								<spring:message code="${titleKey}" />
								<c:if test="${not isManageDistributor}">
								<spring:message code="label.list" />
								</c:if>

								<c:if test="${isadvanced}">
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
								</c:if>
							</h4>

						</div>
					</div>
				</div>
	    
	    </c:when>
	      <c:otherwise>
	      <c:if test="${isEdit}">
                  <div class="row">
                   <div class="col-10">
                   </div>
                       <div class="col-2" align="right">
                        <button type="button" id="addRow${tableName}" class="btn btn-outline-primary"><i class="fa fa-plus" aria-hidden="true"></i>
						</button>
                        </div>
                   </div>
                   </c:if>
          </c:otherwise>
	</c:choose>
	
		<c:if test="${isDatatbleview}">
			<div class="card-content">
				<div class="card-body">
					<div class="card-text">
		</c:if>
		<div class="row">
			<c:if test="${isDatatbleview}">
				<%@include file="/WEB-INF/views/common/common_html_message.jspf"%>
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
				<%@ include file="/WEB-INF/views/common/common_html_datatable.jspf"%>
				<script type="text/javascript">
								 var url${tableName} = "<spring:url value='/${modelName}/list/json/' />";
								 <c:if test="${not isDatatbleview}">
								      url${tableName} = "<spring:url value='/${modelName}/datatableview?radio=${modelId}' />";
									</c:if> 
									<c:if test="${isCNSWDashboard}">
								      url${tableName} = "<spring:url value='/CNSWdashboard/datatableView?radio=${modelId}' />";
									</c:if>
									 <c:if test="${isManageDistributor}">
								      url${tableName} = "<spring:url value='/${modelName}/distributorlist/json?radio=${manageDistributorType}' />";
									</c:if>
									var status;
									var userRoles;
									var usrUid;
									var logginUsrId = "${loggedUsr.getUserId()}"
									var loginUsrRole = "${loggedUsr.getRoleList()}"
									var aoColumns${tableName} = [
										<c:forEach items="${columns}" var="column" varStatus="loop">
											{
												"mData" : "${column}",
												"mRender": function (data, type, full, row) {
													 
													var col="${column}";
													if(col.trim().toLowerCase().indexOf("pstcode") >= 0) {
														 status = 'PayTxn';
														
														if(data.trim()=="PENDING") {
															//status=full.${column};
															data='<div class="badge badge-primary" style="margin-top:8px"><spring:message code='label.pagetable.pending'/></div>';
															
														} else if(data.trim()=="PAID") {
															//status=full.${column};
															data='<div class="badge badge-success" style="margin-top:8px"><spring:message code='label.pagetable.paid'/></div>';
															
														} else if(data.trim()=="FAILED") {
															//status=full.${column};
															data='<div class="badge badge-danger" style="margin-top:8px"><spring:message code='label.pagetable.failed'/></div>';
															
														}
													}

													if(col.trim().toLowerCase().indexOf("userrole") >= 0) {
														userRoles = data;
													}	
													if(col.trim().toLowerCase().indexOf("ntpAccnStatus") >= 0) {
														ntpaccnStatus = data;
													}	
													if(col.trim().toLowerCase().indexOf("usruid") >= 0) {
														usrUid = data;
														if(logginUsrId == usrUid){
													     <c:set var="loggedInUsr" value= "true" />
														}
														else{
														 <c:set var="loggedInUsr" value= "false" />
														}	
													}	
													 
													if(col.trim().toLowerCase().indexOf("status") >= 0) {
														if(data.trim()=="A") {
															status=full.${column};
															data='<div class="badge badge-success" style="margin-top:8px"><spring:message code='label.pagetable.active'/></div>';
															
														} else if(data.trim()=="I") {
															status=full.${column};
															data='<div class="badge badge-danger" style="margin-top:8px"><spring:message code='label.pagetable.inactive'/></div>';
														
														} else if(data.trim()=="S") {
															status=full.${column};
															data='<div class="badge badge-danger" style="margin-top:8px"><spring:message code='label.pagetable.suspended'/></div>';
														
														}
													
													}

													if(col.trim().toLowerCase().indexOf("ntpAccnStatus") >= 0) {
														if(data.trim()=="A") {
															data='<div class="badge badge-success" style="margin-top:8px"><spring:message code='label.pagetable.active'/></div>';
															
														} else if(data.trim()=="I") {
															data='<div class="badge badge-danger" style="margin-top:8px"><spring:message code='label.pagetable.inactive'/></div>';
														
														}  
													
													}
													
													 
													 /* For Approval Status */
													 if(col.trim().toLowerCase().indexOf("approvests") >= 0) {
														 if(data.trim()=="R") {
															status=full.${column};
															data='<div class="badge badge-success" style="margin-top:8px"><spring:message code='label.pagetable.accountapproved'/></div>';
															
														 } else if(data.trim()=="A") {
															status=full.${column};
															data='<div class="badge badge-warning" style="margin-top:8px"><spring:message code='label.pagetable.pendingtoapprove'/></div>';
														 
														 } else if(data.trim()=="S") {
															status=full.${column};
															data='<div class="badge badge-danger" style="margin-top:8px"><spring:message code='label.pagetable.rejorsuspended'/></div>';
															
														 } else if(data.trim()=="O") {
															status=full.${column};
															data='<div class="badge badge-success" style="margin-top:8px"><spring:message code='label.pagetable.onboarded'/></div>';
														 }
													}
														
														if(col=='NTPActions' && status=="I") {
									                            
															data= '<button type="button" class="btn_action btn-action-drop" style="background-color:transparent"  data-toggle="dropdown"' 
																+'   aria-haspopup="true" aria-expanded="false">'
															+'<i class="fa fa-ellipsis-v"></i>'
									                                +'</button>'
									                              +' <div class="dropdown-menu arrow-right mr-5">'
									                            +'<button class="dropdown-item ntpActivate" type="button"><i class="fa fa-link"></i>&nbsp; Activate</button>'
									                            +'</div>';
									                            
														}
														 else if(col=='NTPActions' && status=="A") {
								                            
															data= '<button type="button" class="btn_action btn-action-drop" style="background-color:transparent"  data-toggle="dropdown"' 
																+'   aria-haspopup="true" aria-expanded="false">'
															+'<i class="fa fa-ellipsis-v"></i>'
									                                +'</button>'
									                              +' <div class="dropdown-menu arrow-right mr-5">'
									                            +'<button class="dropdown-item ntpDeactivate" type="button"><i class="fa fa-link"></i>&nbsp; Deactivate</button>'
									                            +'</div>';
									                            
														}  
													 
														else if(col=='Actions' && status.trim()=="I") {
								                            
														data= '<button type="button" class="btn_action btn-action-drop" style="background-color:transparent"  data-toggle="dropdown"' 
															+'   aria-haspopup="true" aria-expanded="false">'
														+'<i class="fa fa-ellipsis-v"></i>'
								                                +'</button>'
															
								                              +' <div class="dropdown-menu arrow-right mr-5">'
								                        /*     +'<button class="dropdown-item editrow" type="button"><i class="fa fa-pencil-square-o "></i>&nbsp; Edit </button>' */
								                           /*  +'<button class="dropdown-item" type="button"><i class="fa fa-copy"></i>&nbsp; Duplicate</button>' */
								                            +'<button class="dropdown-item activate" type="button"><i class="fa fa-link"></i>&nbsp; Activate</button>'
								                           /*  +'<button class="dropdown-item view" type="button"><i class="fa fa-eye"></i>&nbsp; View</button>' */
								                            +'</div>';
								                            
													} else if(col=='Actions' && status.trim()=="A") {

														 if(userRoles != null && userRoles.includes("_SUP_ADMIN")){
														 	if (loginUsrRole.includes("_ADMIN") && !loginUsrRole.includes("_SUP_ADMIN")) {
														 		 data= '<button type="button" class="btn_action btn-action-drop" style="background-color:transparent"  data-toggle="dropdown"'
																		+'   aria-haspopup="true" aria-expanded="false">'
																	+'<i class="fa fa-ellipsis-v"></i>'
											                                +'</button>'
											                              +' <div class="dropdown-menu arrow-right mr-5">'
											                              <c:if test="${not isViewNotRequired}">
											                              +'<button class="dropdown-item view" type="button"><i class="fa fa-eye"></i>&nbsp; View</button>'
											                              </c:if>
											                              <c:if test="${isResendEmailEnable!=null && isResendEmailEnable}">
											                              +'<button class="dropdown-item resendMailUser" type="button"><i class="fa fa-link"></i>&nbsp; Resend Mail</button>'
											                              </c:if>
											                            
											                            +'</div>';
															} else {
																 data= '<button type="button" class="btn_action btn-action-drop" style="background-color:transparent"  data-toggle="dropdown"'
																		+'   aria-haspopup="true" aria-expanded="false">'
																	+'<i class="fa fa-ellipsis-v"></i>'
											                                +'</button>'
											                              +' <div class="dropdown-menu arrow-right mr-5">'
											                              <c:if test="${not isViewNotRequired}">
											                              +'<button class="dropdown-item view" type="button"><i class="fa fa-eye"></i>&nbsp; View</button>'
											                              </c:if>
											                              <c:if test="${not isEditNotRequired}">
											                              +'<button class="dropdown-item editrow" type="button"><i class="fa fa-pencil-square-o "></i>&nbsp; Edit </button>'
											                              </c:if>
											                              <c:if test="${isResendEmailEnable!=null && isResendEmailEnable}">
											                              +'<button class="dropdown-item resendMailUser" type="button"><i class="fa fa-link"></i>&nbsp; Resend Mail</button>'
											                              </c:if>
											                            
											                            +'</div>';
															}

														 }else
															if(logginUsrId == usrUid){
																 data= '<button type="button" class="btn_action btn-action-drop" style="background-color:transparent"  data-toggle="dropdown"'
																		+'   aria-haspopup="true" aria-expanded="false">'
																	+'<i class="fa fa-ellipsis-v"></i>'
											                                +'</button>'
																		
											                              +' <div class="dropdown-menu arrow-right mr-5">'
											                              <c:if test="${not isViewNotRequired}">
											                              +'<button class="dropdown-item view" type="button"><i class="fa fa-eye"></i>&nbsp; View</button>'
											                              </c:if>
											                              <c:if test="${not isEditNotRequired}">
											                              +'<button class="dropdown-item editrow" type="button"><i class="fa fa-pencil-square-o "></i>&nbsp; Edit </button>'
											                              </c:if>
											                              <c:if test="${not isCustoms}">
											                              	+'<button class="dropdown-item duplicate" type="button"><i class="fa fa-copy"></i>&nbsp; Duplicate</button>'
											                              </c:if>
											                          
											                            +'</div>';	
																}
															else
															 {
															 data= '<button type="button" class="btn_action btn-action-drop" style="background-color:transparent"  data-toggle="dropdown"'
																	+'   aria-haspopup="true" aria-expanded="false">'
																+'<i class="fa fa-ellipsis-v"></i>'
										                                +'</button>'
																	
										                              +' <div class="dropdown-menu arrow-right mr-5">'
										                              <c:if test="${not isViewNotRequired}">
										                              +'<button class="dropdown-item view" type="button"><i class="fa fa-eye"></i>&nbsp; View</button>'
										                              </c:if>
										                              <c:if test="${not isEditNotRequired}">
										                              +'<button class="dropdown-item editrow" type="button"><i class="fa fa-pencil-square-o "></i>&nbsp; Edit </button>'
										                              </c:if>
										                              <c:if test="${not isCustoms}">
										                              	+'<button class="dropdown-item duplicate" type="button"><i class="fa fa-copy"></i>&nbsp; Duplicate</button>'
										                              </c:if>
										                              <c:if test="${loggedInUsr eq 'false'}">
										                              	+'<button class="dropdown-item deactivate" type="button"><i class="fa fa-unlink"></i>&nbsp; Deactivate</button>'
										                              </c:if>
									                              	 <c:if test="${isResendEmailEnable!=null && isResendEmailEnable}">
										                               +'<button class="dropdown-item resendMailUser" type="button"><i class="fa fa-envelope"></i>&nbsp; Reset Password</button>'
										                              </c:if> 
										                              
										                          
										                            +'</div>';	 
														 }
														
								                            
													} else if(col=='Actions' && status.trim()=="S") {
														data= '<button type="button" class="btn_action btn-action-drop" style="background-color:transparent"  data-toggle="dropdown"'
															+'   aria-haspopup="true" aria-expanded="false">'
														+'<i class="fa fa-ellipsis-v"></i>'
								                                +'</button>'
															
								                              +' <div class="dropdown-menu arrow-right mr-5">'
								                        /*     +'<button class="dropdown-item editrow" type="button"><i class="fa fa-pencil-square-o "></i>&nbsp; Edit </button>' */
								                           /*  +'<button class="dropdown-item" type="button"><i class="fa fa-copy"></i>&nbsp; Duplicate</button>' */
								                            +'<button class="dropdown-item suspendActivate" type="button"><i class="fa fa-link"></i>&nbsp; Activate</button>'
								                           /*  +'<button class="dropdown-item view" type="button"><i class="fa fa-eye"></i>&nbsp; View</button>' */
								                            +'</div>';
								                            
													} else if(col=='Actions' && status=='') {
														data= '<button type="button" class="btn_action btn-action-drop" style="background-color:transparent" data-toggle="dropdown"'
															+'   aria-haspopup="true" aria-expanded="false">'
														+'<i class="fa fa-ellipsis-v"></i>'
								                                +'</button>'
															
								                              +' <div class="dropdown-menu arrow-right mr-5">'
								                            +'<button class="dropdown-item view" type="button"><i class="fa fa-eye"></i>&nbsp; View</button>'
								                            +'</div>';
														
													} else if(col=='Actions' && status=='PayTxn') {
														data= '<button type="button" class="btn_action btn-action-drop" style="background-color:transparent" data-toggle="dropdown"'
															+'   aria-haspopup="true" aria-expanded="false">'
														+'<i class="fa fa-ellipsis-v"></i>'
								                                +'</button>'
															
								                              +' <div class="dropdown-menu arrow-right mr-5">'
								                            +'<button class="dropdown-item view" type="button"><i class="fa fa-eye"></i>&nbsp; View Referance</button>'
								                            +'</div>';
														
													} else if(col=='ViewDeactAction' && status=='A') {
													   /* Code for showing only View & Deactivate Actions */
													   data= '<button type="button" class="btn_action btn-action-drop" style="background-color:transparent"  data-toggle="dropdown"'
															+'   aria-haspopup="true" aria-expanded="false">'
														+'<i class="fa fa-ellipsis-v"></i>' 
														+'</button>'
								                        +' <div class="dropdown-menu arrow-right mr-5">'
								                        +'<button class="dropdown-item view" type="button"><i class="fa fa-eye"></i>&nbsp; View</button>'
								                        +'<button class="dropdown-item deactivate" type="button"><i class="fa fa-unlink"></i>&nbsp; Deactivate</button>'
								                         +'</div>';
								                         
												   } else if(col=='ViewDeactAction' && status=='I') {
													   data= '<button type="button" class="btn_action btn-action-drop" style="background-color:transparent"  data-toggle="dropdown"'
															+'   aria-haspopup="true" aria-expanded="false">'
														+'<i class="fa fa-ellipsis-v"></i>'
								                                +'</button>'
															
								                              +' <div class="dropdown-menu arrow-right mr-5">'
								                            +'<button class="dropdown-item activate" type="button"><i class="fa fa-link"></i>&nbsp; Activate</button>'
								                            +'</div>';
								                            
												   } else if(col=='Approve' && status.trim()=="A") {
														/*    Code for showing only View & Deactivate Actions */
														data= '<button type="button" class="btn_action btn-action-drop" style="background-color:transparent"  data-toggle="dropdown"'
															+'   aria-haspopup="true" aria-expanded="false">'
														+'<i class="fa fa-ellipsis-v"></i>'
								                                +'</button>'
															
								                              +' <div class="dropdown-menu arrow-right mr-5">'
								                            +'<button class="dropdown-item approve" type="button"><i class="fa fa-thumbs-o-up"></i>&nbsp; Approve</button>'
								                            +'<button class="dropdown-item view" type="button"><i class="fa fa-eye"></i>&nbsp; View</button>'
								                            +'<button class="dropdown-item reject" type="button"><i class="fa fa-thumbs-o-down"></i>&nbsp; Reject</button>'
								                            +'</div>';
								                            
													} else if(col=='Approve' && status.trim()=="S") {
														data= '<button type="button" class="btn_action btn-action-drop" style="background-color:transparent"  data-toggle="dropdown"'
															+'   aria-haspopup="true" aria-expanded="false">'
														+'<i class="fa fa-ellipsis-v"></i>'
								                              +'</button>'
								                              +' <div class="dropdown-menu arrow-right mr-5">'
								                            +'<button class="dropdown-item activate" type="button"><i class="fa fa-link"></i>&nbsp; Activate</button>'
								                            +'<button class="dropdown-item view" type="button"><i class="fa fa-eye"></i>&nbsp; View</button>'
								                            +'</div>';
								                            
													} else if(col=='Approve' && status.trim()=="R") {
														data= '<button type="button" class="btn_action btn-action-drop" style="background-color:transparent" data-toggle="dropdown"'
															+'   aria-haspopup="true" aria-expanded="false">'
														+'<i class="fa fa-ellipsis-v"></i>'
								                              +'</button>'
								                              +' <div class="dropdown-menu arrow-right mr-5">'
								                              +'<button class="dropdown-item resendMailR" type="button"><i class="fa fa-link"></i>&nbsp; Resend Mail</button>'
								                              +'<button class="dropdown-item view" type="button"><i class="fa fa-eye"></i>&nbsp; View</button>'
								                            +'</div>';
								                            
													} else if(col=='Approve' && status.trim()=="O") {
														data= '<button type="button" class="btn_action btn-action-drop" style="background-color:transparent" data-toggle="dropdown"'
															+'   aria-haspopup="true" aria-expanded="false">'
														+'<i class="fa fa-ellipsis-v"></i>'
								                              +'</button>'
								                              +' <div class="dropdown-menu arrow-right mr-5">'
								                              +'<button class="dropdown-item resendMailO" type="button"><i class="fa fa-link"></i>&nbsp; Resend Mail</button>'
								                              +'<button class="dropdown-item view" type="button"><i class="fa fa-eye"></i>&nbsp; View</button>'
								                            +'</div>';
								                            
													} else if(col=='No.') {
														data=row+1;
													}
													
													//'Dt') || fn:endsWith(column, 'Date'
													if(col.toLowerCase().endsWith('dt') || col.toLowerCase().endsWith('date')) {
														if(data !== null){
															data = moment(data).format("YYYY-MM-DD HH:mm:ss");
														}
														
													}
												   
												   	
													return data;
												}	 
											},
											
										</c:forEach>
									];
								
								 	$(document).ready(function() {
										$('#tableInput').hide();
									}); 
									$('#addRow${tableName}').on("click", function(){
										 $("#viewTable").parents('div.dataTables_wrapper').first().toggle();
										 $('#tableInput').toggle();
										 $("i", this).toggleClass("fa fa-plus fa fa-minus");
										 
							 			});
								</script>
				<div class="table-responsive">
					<table id="${tableName}"
						class="table table-striped jambo_table bulk_action stripe">
						<thead>
							<tr class="table_header">
								<c:forEach items="${columns}" var="column">
								<c:choose>
                                   <c:when test="${column == 'hseftCode'}">
                                      <th class="column-title"><spring:message code='label.pagetable.datatype'/></th>
                                   </c:when>    
                                    <c:when test="${column == 'Actions'}">
                                      <th class="column-title"><spring:message code='label.pagetable.actions'/></th>
                                   </c:when> 
                                <c:otherwise>
                                      <th class="column-title"><spring:message
											code="label.${modelName}.${column}" /></th>
                                </c:otherwise>
                               </c:choose>
								</c:forEach>
							</tr>
						</thead>
						<thead id="topSearch">
							<tr>
								<c:forEach items="${columns}" var="column" varStatus="loop">
								
								<c:choose>
                                   <c:when test="${column == 'hseftCode'}">
                                      	<th><input type="text" id="search_0" data-index=${loop.index}
										class="form-control input-xs table-filter"
										style="width: 100%;"
										placeholder="Data Type"></th>
                                   </c:when>    
                                    <c:when 
										test="${ fn:contains(column, 'Actions') || fn:contains(column, 'No.') || fn:contains(column, 'Select')}"> 
										<th th style="width:20px;"></th>   
									</c:when>
									<c:when 
										test="${ fn:contains(column, 'ViewDeactAction') || fn:contains(column, 'No.') || fn:contains(column, 'Select')}"> 
										<th th style="width:20px;"></th>   
									</c:when>
									 <c:when test="${(column == 'dwstRegime') || (column == 'regDescription')}">
										<th style="width: 100px;">
										<select id="regime" data-index=${loop.index} class="form-control input-xs table-filter regime">
											<option value=""><spring:message code='label.BOTH'/></option>
											<option value="IMPORT"><spring:message code='label.IMPORT'/></option>
											<option value="EXPORT"><spring:message code='label.EXPORT'/></option>
											
										</select></th>
									</c:when>
									
									<c:when test="${ fn:endsWith(column, 'Dt') || fn:endsWith(column, 'Date')}">
												<th style="width: 10%;"><input type="text" 
													 class="form-control input-xs table-filter dateFilter"
													style="width: 100%; background: white" id="search_${loop.index }"
													placeholder="<spring:message code='label.${modelName}.${column}'/>" readonly>
												<button type="button" onclick=""
                                                        class="btn bg-transparent clear-input d-none"
                                                        data-clear-input="search_${loop.index }"
                                                        style="margin-left: -40px; z-index: 100;">
                                                    <i class="fa fa-times"></i>
                                                </button>
												</th>
									</c:when>
							
									<c:when test="${ fn:contains(fn:toLowerCase(column), fn:toLowerCase('status')) }"> 
										<th style="width: 100px;">
										<select id="states" data-index=${loop.index} class="form-control input-xs table-filter">
											<option value=""><spring:message code='label.All'/></option>
											<option value="A"><spring:message code='label.Active'/></option>
											<option value="I"><spring:message code='label.InActive'/></option>
											<c:if test="${isAddStsEn}">
												<option value="S"><spring:message code='label.suspend'/></option>
											</c:if>
										</select></th>
									</c:when>
									
									<c:when test="${ fn:contains(fn:toLowerCase(column), fn:toLowerCase('canuPublic')) }"> 
										<th style="width: 100px;">
										<select id="states" data-index=${loop.index} class="form-control input-xs table-filter">
											<option value=""><spring:message code='label.All'/></option>
											<option value="Y"><spring:message code='label.public'/></option>
											<option value="N"><spring:message code='label.nonpublic'/></option>
										</select></th>
									</c:when>
									
									<c:when test="${ fn:contains(fn:toLowerCase(column), fn:toLowerCase('approvests')) }"> 
										<th style="width: 100px;">
										<select id="states" data-index=${loop.index} class="form-control input-xs table-filter">
											<option value=""><spring:message code='label.All'/></option>
											<option value="R"><spring:message code='label.account.approved'/></option>
											<option value="A"><spring:message code='label.account.pendingToApprove'/></option>
											<option value="S"><spring:message code='label.account.rejected'/></option>
											<c:if test="${isAddStsEn}">
											<option value="O"><spring:message code='label.account.onboarded'/></option>
											</c:if>
										</select></th>
									</c:when>
					<c:when test="${isNoPagination }"></c:when>
									
                                <c:otherwise>
                                      	<th><input type="text" id="search_${loop.index }" data-index=${loop.index}
										class="form-control input-xs table-filter"
										style="width: 100%;"
										placeholder="<spring:message code='label.${modelName}.${column}'/>"></th>
                                </c:otherwise>
                               </c:choose>
								
								
								</c:forEach>
							</tr>
						</thead>
						<tbody></tbody>
						<tfoot>
							<tr>
								<c:forEach items="${columns}" var="column" varStatus="loop">
									<c:choose>
	                                   <c:when test="${column == 'hseftCode'}">
	                                      	<th><input type="text" id="search_0" data-index=${loop.index}
											class="form-control input-xs table-filter"
											style="width: 100%;"
											placeholder="Data Type"></th>
	                                   </c:when>    
	                                    <c:when 
											test="${ fn:contains(column, 'Actions') || fn:contains(column, 'No.') || fn:contains(column, 'Select')}"> 
											<th th style="width:20px;"></th>   
										</c:when>
										<c:when 
											test="${ fn:contains(column, 'ViewDeactAction') || fn:contains(column, 'No.') || fn:contains(column, 'Select')}"> 
											<th th style="width:20px;"></th>   
										</c:when>
										 <c:when test="${(column == 'dwstRegime') || (column == 'regDescription')}">
											<th style="width: 100px;">
											<select id="regime" data-index=${loop.index} class="form-control input-xs table-filter regime">
												<option value=""><spring:message code='label.BOTH'/></option>
												<option value="IMPORT"><spring:message code='label.IMPORT'/></option>
												<option value="EXPORT"><spring:message code='label.EXPORT'/></option>
												
											</select></th>
										</c:when>
										
										<c:when test="${ fn:endsWith(column, 'Dt') || fn:endsWith(column, 'Date')}">
											<th style="width: 10%;"><input type="text"
												 class="form-control input-xs table-filter dateFilter"
												style="width: 100%; background: white"  id="search_${loop.index }"
												placeholder="<spring:message code='label.${modelName}.${column}'/>" readonly>
												<button type="button" onclick=""
                                                        class="btn bg-transparent clear-input d-none"
                                                        data-clear-input="search_${loop.index }"
                                                        style="margin-left: -40px; z-index: 100;">
                                                    <i class="fa fa-times"></i>
                                                </button>
											</th>
										</c:when>
								
										<c:when test="${ fn:contains(fn:toLowerCase(column), fn:toLowerCase('status')) }"> 
											<th style="width: 100px;">
											<select id="states" data-index=${loop.index} class="form-control input-xs table-filter">
												<option value=""><spring:message code='label.All'/></option>
												<option value="A"><spring:message code='label.Active'/></option>
												<option value="I"><spring:message code='label.InActive'/></option>
												<c:if test="${isAddStsEn}">
													<option value="S"><spring:message code='label.suspend'/></option>
												</c:if>
											</select></th>
										</c:when>
										
										<c:when test="${ fn:contains(fn:toLowerCase(column), fn:toLowerCase('canuPublic')) }"> 
											<th style="width: 100px;">
											<select id="states" data-index=${loop.index} class="form-control input-xs table-filter">
												<option value=""><spring:message code='label.All'/></option>
												<option value="Y"><spring:message code='label.public'/></option>
												<option value="N"><spring:message code='label.nonpublic'/></option>
											</select></th>
										</c:when>
										
										<c:when test="${ fn:contains(fn:toLowerCase(column), fn:toLowerCase('approvests')) }"> 
											<th style="width: 100px;">
											<select id="states" data-index=${loop.index} class="form-control input-xs table-filter">
												<option value=""><spring:message code='label.All'/></option>
												<option value="R"><spring:message code='label.account.approved'/></option>
												<option value="A"><spring:message code='label.account.pendingToApprove'/></option>
												<option value="S"><spring:message code='label.account.rejected'/></option>
												<c:if test="${isAddStsEn}">
												<option value="O"><spring:message code='label.account.onboarded'/></option>
												</c:if>
											</select></th>
										</c:when>
										<c:when test="${isNoPagination }"></c:when>
										
		                                <c:otherwise>
		                                      	<th><input type="text" id="search_0" data-index=${loop.index}
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
			<%@include file="/WEB-INF/views/common/common_html_buttons.jspf"%>
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
									<label for="${column}"><spring:message code='label.pagetable.datatype'/></label>

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
					<button type="submit" class="btn btn-primary" id="saveButton"><spring:message code='label.pagetable.save'/></button>
					<button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code='label.pagetable.close'/></button>
				</div>
			</div>

		</div>
	</div>
</form:form>
