<%@tag description="Page Tag" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://clib.camelone.com/" prefix="co" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap" %>

<%@attribute name="titleKey" type="java.lang.String" required="true" %>
<%@attribute name="breadCrumbKey" type="java.lang.String" required="false" %>
<%@attribute name="modelName" type="java.lang.String" required="true" %>
<%@attribute name="modelId" type="java.lang.Object" required="false" %>
<%@ attribute name="columns" required="false" type="java.lang.Object" %>
<%@attribute name="tableName" type="java.lang.String" required="false" %>
<%@attribute name="filterProducts" type="java.util.Map" required="true" %>
<%@attribute name="filterStatus" type="java.util.List" required="true" %>
<%@attribute name="tableType" type="java.lang.String" required="true" %>
<%@attribute name="searchForm" fragment="true" %>

<c:set var="tableName" value="${(empty tableName) ? 'dataTableInput' : tableName}"/>
<c:set var="columns" value="${(empty columns) ? '${columns}' : columns}"/>

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
                                code="label.home"/></a></li>
                        <li class="breadcrumb-item active"><spring:message
                                code="${breadCrumbKey}"/></li>
                    </ol>
                </div>
            </div>
		</div>
   		<div class="content-header-right col-6 text-right">

			<tfap:tfap-user-role-permission userRoles="${userRoles}"
				TFAP_BANK_PRD_MAKER="true">
				<div class="btn-group float-md-right" role="group"
					aria-label="Button group with nested dropdown">
					<button type="button" id="addNewProdId" class="btn btn-primary"
						title="Submit">
						<i class="fa fa-check-square-o"></i>&nbsp; Add New Product
					</button>
				</div>
			</tfap:tfap-user-role-permission>
		  	<div class="btn-group float-md-right" role="group" aria-label="Button group with nested dropdown">
				 <a class="btn btn-outline-primary primary" data-toggle="collapse" data-target="#collapseFilters" aria-expanded="false" aria-controls="collapseExample">
	                 <i class="fa fa-filter" data-toggle="tooltip" data-placement="bottom" title="Quick Filters"></i>
	             </a>
         	</div>
        </div>
	</div>
	<div class="content-body">
		<tfap:tfap-datatable-filter-panel filterProducts="${filterProducts}" tableType="${tableType}" filterStatus="${filterStatus}"/>
	   
		<section id="description" class="card">
			<div class="card-header">
				<div class="row">
					<div class="col-6">
						<h4 class="card-title">
							<spring:message code="${titleKey}" />
							<spring:message code="label.list" />
						</h4>
					</div>
	
	
				</div>
			</div>
			<div class="card-content">
				<div class="card-body">
					<div class="card-text">
						<div class="row">
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<div class="d-none">
										<!-- needs to changed --> 
										<tfap:tfapstatuslabel status="D"/>
	                                    <tfap:tfapstatuslabel status="P"/>
	                                    <tfap:tfapstatuslabel status="A"/>
	                                    <tfap:tfapstatuslabel status="M"/>
	                                    <tfap:tfapstatuslabel status="I"/>
	                                    <tfap:tfapstatuslabel status="N"/>
	                                </div>
								
									
								
								<%@ include file="/WEB-INF/views/common/tfap_common_html_datatable.jspf" %>
								
								<script type="text/javascript">
								
								var actionsDropdownButton = '<button type="button" class="btn_action btn-primary dropdown-toggle"'
	                                 + 'data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">'
	                                 + '<i class="fa fa-ellipsis-h"></i>'
	                                 + '</button>'
	                                
	                              var actionsDropdownButtonDisable = '<button type="button" class="btn_action btn-primary dropdown-toggle"'
	                                   + 'data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" disabled>'
	                                     + '<i class="fa fa-ellipsis-h"></i>'
	                                     + '</button>'
	
	                             var actionDropdownMenuPlaceholder = '<div class="dropdown-menu arrow-right mr-5">'
	                                 + '@items@'
	                                 + '</div>';
	                                 
	                             var actionItemModify = '<button class="dropdown-item Modify" type="button">'
	                                 + '<i class="fa fa-times-circle"></i>&nbsp; Modify '
	                                 + '</button>';
	                                 
	                            var actionItemDelete = '<button class="dropdown-item Delete" type="button">'
	                                 + '<i class="fa fa-check-circle"></i>&nbsp; Delete'
	                                 + '</button>';
	                                 
	                            var actionItemview = '<button class="dropdown-item view" type="button">'
	                                  + '<i class="fa ft-eye"></i>&nbsp; view'
	                                  + '</button>';
								
								
                                var map = { 'ECNEG': "Export Letter of Credit Negotiation",
									'LCISS': "Letter Of Credit",
									'RFSUB': "Receivable Finance",
									'SCISS':"Standby Letter of Credit",
									'BGISS':"Banker's Guarantee",
									'SGISS':"Shipping Guarantee",
									'IFIPR': 'Import Pre-Shipment Financing',
									'IFIPO': 'Import Post-Shipment Financing',
									'IFEPR': 'Export Pre-Shipment Financing',
									'IFEPO': 'Export Post-Shipment Financing'};
							var urlView${tableName} = "<spring:url value='/tfApplication/product-management/datatable/prd-offering/view' />";
							var aoColumnsView${tableName} = [
								
										{
											"mData" : "tfboId",
											"mRender" : function(data, type, full, row){
	                                            	var tfboId = full.tfboId;
                                            		data = "<a href='/TFAPortal/tfApplication/product-management/prod-det/view?tfboId=" + tfboId + "'>" + tfboId + "</a>";
	                                            	return data;
											}
										},
										{
											"mData" : "tfboPrdId",
											"mRender" : function(data, type, full, row){
                                            	var product = full.tfboPrdId;
                                            	if(product.substring(0,2)==="LC"){
                                            		data = map['LCISS'] ;
                                            	}
                                            	if(product.substring(0,2)==="RF"){
                                            		data =  map['RFSUB'] ;
                                            	}
                                            	if(product.substring(0,2)==='BG'){
                                            		data =  map['BGISS'] ;
                                            	}
                                            	if(product.substring(0,2)==='SB'){
                                            		data = map['SCISS'] ;
                                            	}
                                            	if(product.substring(0,2)==='SG'){
                                            		data = map['SGISS'] ;
                                            	}
                                            	if(product.substring(0,2)==='EC'){
                                            		data = map['ECNEG'];
                                            	}
                                            	if(product.substring(0,2)==='IF') {
                                            		data = map[product.substring(0,5)];
												}
                                            	return data;
											}
											
										} ,
										{
											"mData" : "tfboMaker"
										},
										{
											"mData" : "tfboApprover"
										},
										{
											"mData" : "tfboDtLupd"
										},
										{
											"mData" : "tfboStatus",
											"mRender" : function (data, type, full, row) {
													 	data = $('.status' + full.tfboStatus).clone()
		                                            	data = data[0];
													 	console.log("data :- "+ data)
		                                             	var wrapper = document.createElement("div");
		                                             	wrapper.appendChild(data);
		                                             	var str = wrapper.innerHTML;
		                                             	data = str
		                                             	return data;
											}
											
										},
										{
											"mData" : "tfboStatus",
											"mRender" : function(data, type, full, row){
												var items = '';
												items += actionItemview;
												data = actionsDropdownButton + actionDropdownMenuPlaceholder.replace('@items@', items);
												return data;
											}
												
										}
										];
								</script>
								
								<div class="table-responsive">
									<table id="${tableName}"
										class="table table-striped jambo_table bulk_action stripe">
										<thead>
											<tr class="table_header">
												<th class="column-title"><spring:message
														code="label.table.product.offering.tfboId" /></th>
												<th class="column-title"><spring:message
														code="label.table.product.offering.tfboProdId" /></th>
												<th class="column-title"><spring:message
														code="label.table.product.offering.tfboMaker" /></th>
												<th class="column-title"><spring:message
														code="label.table.product.offering.tfboAPprover" /></th>
												<th class="column-title"><spring:message
														code="label.table.product.offering.tfboDtLupd" /></th>
												<th class="column-title"><spring:message
															code="label.table.product.offering.tfboStatus" /></th>
												<th class="column-title"><spring:message
														code="label.table.product.offering.action" /></th>
												<th></th>
											</tr>
										</thead>
										<thead id="topSearch">
											<tr>
												<th><input type="text" id="search_j0"
													class="form-control input-xs table-filter"
													placeholder="<spring:message
														code="label.table.product.offering.tfboId" />"
													style="width: 100%"></th>
												<th><input hidden type="text" id="search_j1"
													class="form-control input-xs table-filter"
													placeholder="<spring:message
														code="label.table.approval.TfapId" />"
													style="width: 100%"> <select
													class="form-control table-filter-product-dropdown"
													style="width: 100%">
														<option value="">All</option>
														<c:forEach items="${filterProducts.keySet()}" var="key"
															varStatus="i">
															<option value="${key}">${ filterProducts.get(key)}</option>
														</c:forEach>
												</select></th>
												<th><input type="text" id="search_j2"
													class="form-control input-xs table-filter"
													placeholder="<spring:message
														code="label.table.product.offering.tfboMaker" />"
													style="width: 100%"></th>
												<th><input type="text" id="search_j3"
													class="form-control input-xs table-filter"
													placeholder="<spring:message
														code="label.table.product.offering.tfboAPprover" />"
													style="width: 100%"></th>
												<th>
													<div class="input-group">
														<input id="search_j4"
															class="form-control input-xs table-filter"
															style="width: 100%; background: white"
															placeHolder="<spring:message code='label.table.product.offering.tfboDtLupd'/>"
															autocomplete="off" readonly />
														<button type="button" onclick=""
															class="btn bg-transparent clear-input d-none"
															data-clear-input="search_j4"
															style="margin-left: -40px; z-index: 100;">
															<i class="fa fa-times"></i>
														</button>
													</div>
												</th>
												<th><select
													class="form-control table-filter-status-dropdown"
													style="width: 100%">
														<option value="">Select Status</option>
														<option value="All">All</option>
														<c:forEach items="${filterStatus}" var="statusCode"
															varStatus="i">
															<option value="${statusCode}"><spring:message
																	code="label.application.status.${statusCode}" /></option>
														</c:forEach>
												</select></th>
											</tr>
										</thead>
										<tbody></tbody>
										<tfoot>
											<tr>
												<th><input type="text" id="search_0"
													class="form-control input-xs table-filter"
													placeholder="<spring:message
														code="label.table.product.offering.tfboId" />"style="width:100%">
												</th>
 												 <th>
												 	
												 	<input hidden type="text" id="search_1"
													class="form-control input-xs table-filter"
													placeholder="<spring:message
														code="label.table.approval.TfapId" />"style="width:100%">
												 	<select class="form-control table-filter-product-dropdown" style="width:100%">
														<option value="">All</option>
														<c:forEach items="${filterProducts.keySet()}" var="key" varStatus="i">
															<option value="${key}">${ filterProducts.get(key)}</option>
														</c:forEach>
	                                                </select>
												</th>
												<th><input type="text" id="search_2"
													class="form-control input-xs table-filter"
													placeholder="<spring:message
														code="label.table.product.offering.tfboMaker" />"style="width:100%">
												</th>
												<th><input type="text" id="search_3"
													class="form-control input-xs table-filter"
													placeholder="<spring:message
														code="label.table.product.offering.tfboAPprover" />"style="width:100%">
												</th>
												<th>
                                                    <div class="input-group">
                                                        <input id="search_4"
                                                                       class="form-control input-xs table-filter"
                                                                       style="width: 100%; background:white"
                                                                       placeHolder="<spring:message code='label.table.product.offering.tfboDtLupd'/>"
                                                                       autocomplete="off" readonly/>
                                                         <button type="button" onclick=""
                                                                        class="btn bg-transparent clear-input d-none"
                                                                        data-clear-input="search_4"
                                                                        style="margin-left: -40px; z-index: 100;">
                                                                    <i class="fa fa-times"></i>
                                                         </button>
                                                     </div>
                                                  </th>
												<th>
													<select class="form-control table-filter-status-dropdown" style="width:100%">
														<option value="">Select Status</option>
														<option value="All">All</option>
														<c:forEach items="${filterStatus}" var="statusCode" varStatus="i">
															<option value="${statusCode}"><spring:message code="label.application.status.${statusCode}"/></option>
														</c:forEach>
													</select>
												</th>
											</tr>
										</tfoot>
									</table>
								</div>
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
	modal_Id="modal_confirm_bank_approve"
	primary_btn_id="btn_confirm_bank_approve"
	message="label.modal.message.confirmation.approve"
	callback="bank_approveCallback()"/>
	
<tfap:tfapconfirmationmodal
	button_name="label.modal.button.yes"
	modal_title="label.modal.title.confirmation" 
	modal_Id="modal_confirm_bank_reject"
	primary_btn_id="btn_confirm_bank_reject"
	message="label.modal.message.confirmation.reject"
	callback="bank_rejectCallback()"/>
	
<tfap:tfapconfirmationmodal
	button_name="label.modal.button.yes"
	modal_title="label.modal.title.confirmation" 
	modal_Id="modal_confirm_bank_unsubscribe"
	primary_btn_id="btn_confirm_bank_unsubscribe"
	message="label.modal.message.confirmation.unsubscribe"
	callback="bank_unsubscribeCallback()"/>
	
<tfap:modal button_name="label.modal.button.continue"
	modal_title="label.modal.title.success" modal_Id="modal_no_new_prod"
	show_button_primary="false">
	<h4 style="text-align: center;">All bank products already offered</h4>
</tfap:modal>
	
<script>
 $(document).ready(function(){
 	$('#search_0,#search_j0').on('keypress', function(evt){
		var charCode = (evt.which) ? evt.which : evt.keyCode;
		if ((charCode >= 48 && charCode <= 57)) {
			return true;
		}else{
           return false;
		}
	});
	
 	$('#search_0,#search_j0').on('paste', function(evt){
			return false;
	});
	
	$("#${tableName}").DataTable().draw();
	var dataTable = $("#${tableName}").DataTable();
	
	$(' #search_4').daterangepicker({
	    maxDate: new Date,
	    //minDate: new Date,
	    format: 'YYYY-MM-DD',
	    singleDatePicker: true,
	    calender_style: "picker_2",
	    showDropdowns: true,
	}, function (start, end, label) {
	    var id = this.element[0].id
	    $('[data-clear-input="' + id + '"]').removeClass('d-none')
	    this.element.change();
	});


	$(' #search_j4').daterangepicker({
	    maxDate: new Date,
	    //minDate: new Date,
	    format: 'YYYY-MM-DD',
	    singleDatePicker: true,
	    calender_style: "picker_2",
	    showDropdowns: true,
	}, function (start, end, label) {
	    var id = this.element[0].id
	    $('[data-clear-input="' + id + '"]').removeClass('d-none')
	    this.element.change();
	});


	$('.clear-input').on('click', function () {
	    $('#' + $(this).attr('data-clear-input')).val('').change();
	    $(this).addClass('d-none')
	});
	
    $('#search_4,#search_j4').on('change', function () {
        var updated = $(this).val();
        dataTable.column(4).search(updated).draw();
    });

    $('.table-filter-status-dropdown').on('change', function (e) {
        var status = $(this).val();
        $('.table-filter-status-dropdown').val(status)
        dataTable.column(5).search(status).draw();
    });
     
	$('.table-filter-product-dropdown').on('change', function (e) {
        var product = $(this).val();
        $('.table-filter-product-dropdown').val(product)        
        dataTable.column(1).search(product).draw();
    });
	
});

$('#${tableName} tbody').on("click", ".view", function () {
    var row = $("#${tableName}").DataTable().row($(this).parents('tr')).data();
    window.location.href = "/TFAPortal/tfApplication/product-management/prod-det/view?tfboId=" + row.tfboId;
});

$("#addNewProdId").on('click', function() {
	var prodDescMap= "${prodDescMap}";
	if(prodDescMap == null || prodDescMap === '{}'){
		$('#modal_no_new_prod').modal('show');
	}else {
		window.location = "/TFAPortal/tfApplication/product-management/prd-det/new";
	}
});

</script>