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
	                                    <%-- <tfap:tfapstatuslabel status="A"/>
	                                    <tfap:tfapstatuslabel status="P"/>
	                                    <tfap:tfapstatuslabel status="R"/> --%>
	                                    <tfap:tfapstatuslabel status="NEW"/>
	                                    <tfap:tfapstatuslabel status="DRF"/>
	                                    <tfap:tfapstatuslabel status="PAU"/>
	                                    <tfap:tfapstatuslabel status="SUB"/>
	                                    <tfap:tfapstatuslabel status="PRO"/>
	                                    <tfap:tfapstatuslabel status="APP"/>
	                                    <tfap:tfapstatuslabel status="REJ"/>
	                                    <tfap:tfapstatuslabel status="ACK"/>
	                                    <tfap:tfapstatuslabel status="DIS"/>
	                                    <tfap:tfapstatuslabel status="RCV"/>
	                                    <tfap:tfapstatuslabel status="PED"/>
										<tfap:tfapstatuslabel status="IAC"/>
	                                </div>
								
									
								
<%-- 								<%@ include file="/WEB-INF/views/common/tfap_common_html_datatable.jspf" %> --%>
								
								<script type="text/javascript">
								var stateUserRolesActionDiscard = [ //used for discard
                                	{state: 'DRF', userRoles: ['TFAP_BANK_ONBOARDING_MAKER']}
                                ];
								var stateUserRolesActionUnsubscribe = [ //used for unsubscribe
                                	//{state: 'APP', userRoles: ['TFAP_BANK_ONBOARDING_MAKER']}
                                	{state: 'APP', userRoles: ['TFAP_BANK_ONBOARDING_APPROVER']}
                                ];
                                var stateUserRolesActionReject = [ //used for ReqForMod
                                	{state: 'PAU', userRoles: ['TFAP_BANK_ONBOARDING_APPROVER']},
                                ];
								
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
	                                 
	                             var actionItemReject = '<button class="dropdown-item reject" type="button">'
	                                 + '<i class="fa fa-times-circle"></i>&nbsp; Reject '
	                                 + '</button>';
	                                 
	                            var actionItemApprove = '<button class="dropdown-item approve" type="button">'
	                                 + '<i class="fa fa-check-circle"></i>&nbsp; Approve'
	                                 + '</button>';
	                                 
	                            var actionItemUnsubscribe = '<button class="dropdown-item unsubscribe" type="button">'
	                                  + '<i class="fa fa-bell-slash"></i>&nbsp; Unsubscribe'
	                                  + '</button>';
	                                  
	                            var actionItemDownloadTCApp = '<button class="dropdown-item downloadtcprod" type="button">'
			                          + '<i class="fa fa-download"></i>&nbsp; Download T&C (Application)'
			                          + '</button>';
			                          
			                    var actionItemDownloadTCSub = '<button class="dropdown-item downloadtcsub" type="button">'
				                      + '<i class="fa fa-download"></i>&nbsp; Download T&C (Subscription)'
				                      + '</button>';				          
					                  
			                  	var actionItemView = '<button class="dropdown-item view" type="button">'
		                                + '	<i class="ft-eye"></i>&nbsp; View '
		                                + '</button>';
	                                       
                                var actionItemDiscard = '<button class="dropdown-item discard" type="button" id="discard">'
				  						+'	<i class="fa fa-trash"></i>&nbsp; Discard'
			   							+'</button>';
	   							
	   							var actionItemReqMofification = '<button class="dropdown-item reject" type="button">'
                                       + '	<i class="fa fa-times-circle"></i>&nbsp; Request for Modification ' 
                                       + '</button>';
			              
				                  var loggedUsersRoles = [];
                                  <c:forEach var="role" items="${userRoles}">
                                  loggedUsersRoles.push('${role}');
                                  </c:forEach>    
					                  
				                  function isPermitted(state, stateUserRolesAction) {
	                                       var stateObjArr = stateUserRolesAction.filter(function (obj) {
	                                           return (obj.state == state);
	                                       });
	
	                                       return stateObjArr.length >0 && (stateObjArr[0].userRoles.filter(function (userRole) {
	                                           return loggedUsersRoles.includes(userRole);
	                                       })).length > 0;
	                                   }
								
								
									var urlView${tableName} = "<spring:url value='/tfApplication/product-management/prd-approval-list-table/view?tabletype=${tableType}' />";
									var aoColumnsView${tableName} = [
										{
											"mData" : "tfpslTfapId",
											"mRender" : function (data, type, full, row) {
											data = "<a href='../viewLinkOrSub?tfapId=" + full.tfpslTfapId + "'>" + full.tfpslTfapId + "</a>";
											return data;
											}
										} ,
										{
											"mData" : "tfpNameByProduct"
										},
										{
											"mData" : "tfpslReqType"
										},
										{
											"mData" : "companyUENByTCoreAccn"
										},
										{
											"mData" : "companyNameByTCoreAccn"
										},
										{
											"mData" : "tfpslLupdDt",
											"mRender" : function (data, type, full, row) {
												if(data != null){
													data = moment(data).format("YYYY-MM-DD HH:mm:ss");
												}
												
												return data;
											}
										},
										{
											"mData" : "tfpslStatus",
											/* "bSortable": false, */
											   "mRender" : function (data, type, full, row) {
												 data = $('.status' + full.tfpslStatus).clone()
	                                             data = data[0];
	                                             var wrapper = document.createElement("div");
	                                             wrapper.appendChild(data);
	                                             var str = wrapper.innerHTML;
	                                            
	                                             data = str
	                                             return data;
											}   
										},
										{
											"mData" : "tfpslStatus",
											"bSortable": false,
											"mRender" : function (data, type, full, row) {
												var items = '';
												items += actionItemView;
												items += actionItemDownloadTCApp;
												items += actionItemDownloadTCSub;
																														
												var status = full.tfpslStatus;
												var reqType = full.tfpslReqType;
												if (status == "DRF"){
													if(isPermitted(status, stateUserRolesActionDiscard)){
														items += actionItemDiscard;
													}
												}
												else if(status == "APP"){ //A
													if(isPermitted(status, stateUserRolesActionUnsubscribe)){
												 		items += actionItemUnsubscribe;
													}
												}
											
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
														code="label.table.approval.TfapId" /></th>
												<th class="column-title"><spring:message
														code="label.table.approval.Product" /></th>
												<th class="column-title"><spring:message
														code="label.table.approval.request.type" /></th>
												<th class="column-title"><spring:message
														code="label.table.approval.CustomerUEN" /></th>
												<th class="column-title"><spring:message
															code="label.table.approval.CompanyName" /></th>
												<th class="column-title"><spring:message
														code="label.table.approval.DtLupd" /></th>
												<th class="column-title"><spring:message
														code="label.table.approval.Status" /></th>
												<th class="column-title"><spring:message
														code="label.table.approval.Action" /></th>
											</tr>
										</thead>
										<tbody></tbody>
										<tfoot>
											<tr>
												 <th><input type="text" id="search_0" class="form-control input-xs table-filter inputFilter" placeholder="<spring:message code="label.table.approval.TfapId" />"style="width:100%"></th>
												 <th>
												 	<select class="form-control table-filter-product-dropdown" style="width:100%" id="search_1">
														<option value="">All</option>
														<c:forEach items="${filterProducts.keySet()}" var="key" varStatus="i">
															<option value="${key}">${ filterProducts.get(key)}</option>
														</c:forEach>
	                                                </select>
												</th>
												<th><input type="text" id="search_2" class="form-control input-xs table-filter inputFilter" placeholder="<spring:message code="label.table.approval.request.type" />"style="width:100%"></th>
												<th><input type="text" id="search_3" class="form-control input-xs table-filter inputFilter" placeholder="<spring:message code="label.table.approval.CustomerUEN" />"style="width:100%"></th>
												<th><input type="text" id="search_4" class="form-control input-xs table-filter inputFilter" placeholder="<spring:message code="label.table.approval.CompanyName" />"style="width:100%"></th>
												<th>
												<div class="input-group">
												<input type="text" id="search_5" class="form-control input-xs table-filter dateFilter" placeholder="<spring:message code="label.table.approval.DtLupd" />"style="width:100%; background: white" readonly>
													<button type="button" onclick=""
	                                                        class="btn bg-transparent clear-input d-none"
	                                                        data-clear-input="search_5"
	                                                        style="margin-left: -40px; z-index: 100;">
	                                                    <i class="fa fa-times"></i>
	                                                </button>
	                                                </div>
												</th>
												<th>
													<select class="form-control table-filter-status-dropdown" style="width:100%" id="search_6">
														<option value="">All</option>
														<c:forEach items="${filterStatus}" var="statusCode" varStatus="i">
															<option value="${statusCode}"><spring:message code="label.application.status.${statusCode}"/></option>
														</c:forEach>
													</select>
												</th>
												<th></th>
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

<tfap:action-prd-discard/>
<tfap:action-prd-reject/>
<%-- <tfap:action-reject/>
<tfap:action-submit/>
<tfap:action-submit-for-auth/> --%>

<div class="modal fade text-left" id="modal_view_remarks_add" tabindex="-1"
	role="dialog" style="display: none;" aria-hidden="true">
	<div class="modal-dialog modal-lg" style="max-width: 400px" role="document">
		<div id="modal_view_remarks_add_body"></div>
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
	
<script>
var det_tfpslAccnid = '';
var det_tfpslAccnidBnk = '';
var det_tfpslPrdId = '';
var det_tfpslTfapId= '';

$(document).ready(function(){

	var dataTable${tableName};
	//Instantiate the table
	dataTable${tableName} = $("#${tableName}").dataTable({
		"aLengthMenu": [[3,5, 10, 15, 25, 50], [3,5, 10, 15, 25, 50]],
		"aoColumns": aoColumnsView${tableName},
		"bFilter" : true,
		"bAutoWidth" : false,
		"deferLoading" : 0,
		"iDisplayLength": 10,
		"oLanguage": {
			"sZeroRecords": "There are no records that match your search criterion",
			"sLengthMenu": "Rows per page&nbsp;_MENU_",
			"sProcessing" : "Processing...",
			"sInfoFiltered": ""
		},
		"sDom": '<"col-12">rt<"col-12"<"pagination-show"li>p><"clear">',
		"bProcessing": true, 
		"bServerSide": true,
		
		"fnServerData": function ( sSource, aoData, fnCallback, oSettings ) {
		
			oSettings.jqXHR = $.ajax({
				"dataType": 'json',
				"type": "GET",
				"url": sSource,
				"data": aoData,
				"cache":    false,
				"success": fnCallback,
				"timeout": 15000,
				"error": handleAjaxError
			});
		},							
		"sAjaxSource": urlView${tableName},
		"aaSorting": [[ 0, "asc" ]],
		"bStateSave": false
	});
	


	function handleAjaxError( xhr, textStatus, error ) {
		/* if ( textStatus === 'timeout' ) {
			alert( 'The server took too long to send the data.' );
		}
		else { */
			alert("The website encountered an issue. We apologise for the inconvenience.\nPlease contact the CamelONE Trade Finance Support.\nError: "	+ error + "\n" + textStatus);
		//}
	}

	 function printableChar(keyCode){
		 printable = false;
		 if (keyCode == 13 || //return 
				 keyCode == 32 || // spacebar
				 keyCode == 16 || // shift
				 keyCode == 8 || // backspace
				 (keyCode >= 48 && keyCode <= 57) || // numbers
				 (keyCode >= 95 && keyCode <=111) || // numpad
				 (keyCode >= 65 && keyCode <= 90) || // letters
				 (keyCode >=186 && keyCode <=192) || // ;=,./`
				 (keyCode >=219 && keyCode <=222)    // [\]'
				 ){
			 printable = true;
		 }
		 return printable;
	 }


	function clear${tableName}DataTableFilter() {
		var odataTable${tableName}Settings = dataTable${tableName}.fnSettings();
		for (iCol = 0; iCol < odataTable${tableName}Settings.aoPreSearchCols.length; iCol++) {
			odataTable${tableName}Settings.aoPreSearchCols[iCol].sSearch = '';
		}
		dataTable${tableName}.fnDraw();
	}				
	
	Number.prototype.pad = function(size) {
		var s = String(this);
		while (s.length < (size || 2)) {s = "0" + s;}
		return s;
	}
	
	$("#${tableName}").DataTable().draw();
	
	 var dataTable = $("#${tableName}").DataTable();

	 $('.table-filter-status-dropdown').on('change', function (e) {
         var status = $(this).val();
         $('.table-filter-status-dropdown').val(status)
         dataTable.column(6).search(status).draw();
     });
	 $('.table-filter-checkbox').on('change', function (e) {
         $('.table-filter-product-dropdown').val('');

         var searchTerms = []
         $.each($('.table-filter-checkbox'), function (i, elem) {
             if ($(elem).prop('checked')) {
                 searchTerms.push($(this).val())
             }
         });
         dataTable.column(1).search(searchTerms.join('|'),true,false,true).draw();
     });
		
	$('.table-filter-product-dropdown').on('change', function (e) {
         $('.table-filter-checkbox').prop('checked', false);
         var product = $(this).val();
         dataTable.column(1).search(product).draw();
     });
	 
	 $('#${tableName}').on('click', '.downloadtcsub', function(){
			var row=$("#${tableName}").DataTable().row($(this).parents('tr')).data();
			et_tfpslAccnid = row.tfpslAccnid;
			det_tfpslAccnidBnk = row.tfpslAccnidBnk;
			det_tfpslPrdId = row.tfpslPrdId;
			det_tfpslTfapId = row.tfpslTfapId;
			window.location.assign("${pageContext.request.contextPath}/tfApplication/product-management/prd-sub/viewtncext?flag=sub&det_tfpslAccnidBnk="+det_tfpslAccnidBnk+"&det_tfpslPrdId="+det_tfpslPrdId);	
		});
	 
	 $('#${tableName}').on('click', '.downloadtcprod', function(){
			var row=$("#${tableName}").DataTable().row($(this).parents('tr')).data();
			et_tfpslAccnid = row.tfpslAccnid;
			det_tfpslAccnidBnk = row.tfpslAccnidBnk;
			det_tfpslPrdId = row.tfpslPrdId;
			det_tfpslTfapId = row.tfpslTfapId;
			window.location.assign("${pageContext.request.contextPath}/tfApplication/product-management/prd-sub/viewtncext?flag=prd&det_tfpslAccnidBnk="+det_tfpslAccnidBnk+"&det_tfpslPrdId="+det_tfpslPrdId);	
		});
	 
	 $('#${tableName} tbody').on("click", ".viewremarks", function () {
      	var row = $("#${tableName}").DataTable().row($(this).parents('tr')).data();
      	tfpslRemarks = row.tfpslRemarks;
		$.get("/TFAPortal/tfApplication/product-management/prd-sub/viewremarks?tfpslRemarks="+encodeURIComponent(tfpslRemarks), function(data, status) {
				$('#modal_view_remarks_add_body').html(data);
				$('#modal_view_remarks_add').modal('show');
			});
		}); 
	 
	 $('#${tableName} tbody').on("click", ".view", function () {
      	var row = $("#${tableName}").DataTable().row($(this).parents('tr')).data();
		 window.location.href = "../viewLinkOrSub?tfapId=" + row.tfpslTfapId;;
		}); 
	 
	 $('#${tableName} tbody').on("click", ".discard", function () {
		 var row = $("#${tableName}").DataTable().row($(this).parents('tr')).data();
		 openPrdDiscardModal(row.tfpslTfapId);
		}); 

	 $('#${tableName} tbody').on('click', '.unsubscribe', function(){
			var row=$("#${tableName}").DataTable().row($(this).parents('tr')).data();
			det_tfpslAccnid = row.tfpslAccnid;
			det_tfpslAccnidBnk = row.tfpslAccnidBnk;
			det_tfpslPrdId = row.tfpslPrdId;
			det_tfpslTfapId = row.tfpslTfapId;
			$('#modal_confirm_bank_unsubscribe').modal('show');	
	});
	 
	 
	 $('.inputFilter').on('keyup', function(event){
		 var value = $(this).val();
		 var id = event.target.id;
		 var index = id.substring(id.indexOf("_")+1, id.length);
		 setTimeout(function(){
        	 var oSettings = $("#${tableName}").dataTable().fnSettings();
        	 if(value == ''){
        		 value = "";
        		 oSettings.aoPreSearchCols[index].sSearch = '';
             }
        	 $("#${tableName}").dataTable().fnFilter(value, $("#${tableName}").dataTable().oApi._fnVisibleToColumnIndex(oSettings,index));
     }, 500 );
	 });
	 
	 $('.dateFilter').on('keydown', function(event) {
			var key = event.keyCode || event.charCode;				
			   
			if( key == 8 || key == 46 ){
				//$('.dateFilter').val('');
			}
		  });
	  
	  var dateFormat='YYYY-MM-DD';
	  if (dateFormat.toLowerCase().indexOf("hh:mm") >= 0){
		  dateFormat=dateFormat.replace("hh:mm", "00:00");
	  }
	  $('.dateFilter').daterangepicker({
		  
		   //minDate: new Date,
          format: 'YYYY-MM-DD',
          singleDatePicker: true,
          calender_style: "picker_2",
          showDropdowns: true,
		}, function(start, end, label,element) {
			   var id = this.element[0].id
               $('[data-clear-input="' + id + '"]').removeClass('d-none')
               this.element.change();
			var date=start;
     	 var value = start.format(dateFormat);
     	 var id = this.element[0].id;
     	 var index = id.substring(id.indexOf("_")+1, id.length);
					 setTimeout(function(){
				        	 var oSettings = $("#${tableName}").dataTable().fnSettings();
				        	 if(date == ''){
				        		 date = "";
				        		 oSettings.aoPreSearchCols[index].sSearch = '';
				             }
				        	 $("#${tableName}").dataTable().fnFilter(value, $("#${tableName}").dataTable().oApi._fnVisibleToColumnIndex(oSettings,index));
			         }, 500 );
		});
		$('.dateFilter').on('apply.daterangepicker', function(e, picker) {
			picker.element.val(picker.startDate.format("YYYY-MM-DD"));
		});
});
$('.clear-input').on('click', function () {
    $('#' + $(this).attr('data-clear-input')).val('').change();
    $(this).addClass('d-none');
    $("#${tableName}").DataTable().column(5).search("").draw();
});
function bank_approveCallback(){
 $.get("/TFAPortal/tfApplication/product-management/prd-approval-list-table/approve?tfpslAccnid="+det_tfpslAccnid+"&tfpslAccnidBnk="+ det_tfpslAccnidBnk+"&tfpslPrdId="+det_tfpslPrdId+"&tfpslTfapId="+det_tfpslTfapId, function(data, status) {
		$("#${tableName}").DataTable().draw();
	});
} 

function bank_rejectCallback(){
	$.get("/TFAPortal/tfApplication/product-management/prd-approval-list-table/reject?tfpslAccnid="+det_tfpslAccnid+"&tfpslAccnidBnk="+ det_tfpslAccnidBnk+"&tfpslPrdId="+det_tfpslPrdId+"&tfpslTfapId="+det_tfpslTfapId, function(data, status) {
		$("#${tableName}").DataTable().draw();
	});
}

function bank_unsubscribeCallback(){
	$.get("/TFAPortal/tfApplication/product-management/prd-approval-list-table/unsubscribe?tfpslAccnid="+det_tfpslAccnid+"&tfpslAccnidBnk="+ det_tfpslAccnidBnk+"&tfpslPrdId="+det_tfpslPrdId+"&tfpslTfapId="+det_tfpslTfapId, function(data, status) {
		swal('<spring:message code="sweetalert.product.unsubscription.message.success"/>', '', 'success').then(function() {
			$("#${tableName}").DataTable().draw();
		});
	});
}

/* function viewRemarks(){
	$('#modal_view_remarks').modal('show');
	$.get("/TFAPortal/tfApplication/product-management/prd-sub/viewtnc?flag=sub&id="+id, function(data, status) {
		//$("#${tableName}").DataTable().draw();
	});
} */

</script>