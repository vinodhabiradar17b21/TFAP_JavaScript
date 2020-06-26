<%@tag description="Page Tag" pageEncoding="UTF-8" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<%@attribute name="modelUrl" type="java.lang.String" required="false" %>

<script src="<c:url value="/resources/js/scripts/customNumber/jquery.number.js"/>" type="text/javascript"></script>

<c:set var="tableName" value="${(empty tableName) ? 'dataTableInput' : tableName}"/>
<c:set var="columns" value="${(empty columns) ? '${columns}' : columns}"/>

<div class="content-wrapper">
    <div class="content-header row">
        <div class="content-header-left col-6 mb-2">
            <h3 class="content-header-title mb-0">
                <spring:message code="${breadCrumbKey}"/>
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
        <c:if test="${modelName == 'tfApplication'}">
   		<div class="content-header-right col-6 text-right">
		  	<div class="btn-group float-md-right" role="group" aria-label="Button group with nested dropdown">
				 <a class="btn btn-outline-primary primary" data-toggle="collapse" data-target="#collapseFilters" aria-expanded="false" aria-controls="collapseExample">
	                 <i class="fa fa-filter" data-toggle="tooltip" data-placement="bottom" title="Quick Filters"></i>
	             </a>
	             
	               <a class="btn btn-outline-primary primary btnReset" aria-expanded="false">
	                 <i class="fa fa-repeat" data-toggle="tooltip" data-placement="bottom" title="Reset Filters"></i>
	             </a>
	             
         	</div>
        </div>
        </c:if>


    </div>
    
    <div class="content-body">        

		<c:if test="${modelName == 'tfApplication'}">
			<tfap:tfap-datatable-filter-panel filterProducts="${filterProducts}" tableType="${tableType}" filterStatus="${filterStatus}"/>
		</c:if>
		        
        <script>
		var modelName  = '${modelName}';
	
            $(document).ready(function () {
             	retriveFIlters('search_j0');
            	retriveFIlters('search_0');
            	retriveFIlters('search_j1');
            	retriveFIlters('search_1');
            	retriveFIlters('search_j2');
            	retriveFIlters('search_2');
            	retriveFIlters('search_j4');
            	retriveFIlters('search_4');
            	retriveFIlters('search_j5');
            	retriveFIlters('search_5');
            	retriveFIlters('search_j6');
            	retriveFIlters('search_6');
             	retriveFIlters('search_j7');
            	retriveFIlters('search_7');
             	retriveFIlters('search_j8');
            	retriveFIlters('search_8');
            	retriveFIlters('search_j9');
            	retriveFIlters('search_9');
            	retriveFIlters('search_j10');
            	retriveFIlters('search_10');
            	retriveFIlters('table-filter-status-dropdown');
            	retriveFIlters('table-filter-product-dropdown');
            	
            	var searchTerms= window.sessionStorage.getItem('searchTerms');
            	if(null!=searchTerms && searchTerms!='' && searchTerms.indexOf(',')>=0)
            		{
            		var eles=[];
            		eles=searchTerms.split(',');
            		eles.forEach(function(item) {
            			$("input[value='"+item+"']").prop("checked", true);
            		});
            		$('#collapseFilters').addClass('show');
            		}
            	else if(null!=searchTerms && searchTerms!='')
            		{
            		$('#collapseFilters').addClass('show');
            		$("input[value='"+searchTerms+"']").prop("checked", true);
            		}
            	
            	$('.table-filter-checkbox').on('change', function (e) {
                    $('.table-filter-product-dropdown').val('');

                    var searchTerms = []
                    $.each($('.table-filter-checkbox'), function (i, elem) {
                        if ($(elem).prop('checked')) {
                            searchTerms.push($(this).val())
                        }
                    });
                    window.sessionStorage.setItem('searchTerms', searchTerms);
                    dataTable.column(3).search(searchTerms.join('|'), true, false, true).draw();
                });
            	
            	if(modelName === "tfImpBillSummary") {
	                $('.table-filter-status-dropdown').on('change', function (e) {
	                    var status = $(this).val();
	                    $('.table-filter-status-dropdown').val(status)
	                    dataTable.column(11).search(status).draw();
	                })
            	} else {
            		 $('.table-filter-status-dropdown').on('change', function (e) {
                         var status = $(this).val();
                         $('.table-filter-status-dropdown').val(status)
                          window.sessionStorage.setItem('table-filter-status-dropdown', status);
                         dataTable.column(11).search(status).draw();
                     })
            	}
            	
                $('.table-filter-product-dropdown').on('change', function (e) {
                    $('.table-filter-checkbox').prop('checked', false);
                    var product = $(this).val();
                    window.sessionStorage.setItem('table-filter-product-dropdown', product);
                    dataTable.column(3).search(product).draw();
                })
                
                $('.table-filter-paymentterms-dropdown').on('change', function (e) {
                    var accepted = $(this).val();
                    $('.table-filter-paymentterms-dropdown').val(accepted)
                    dataTable.column(7).search(accepted).draw();
                })
                
                $('.table-filter-accepted-dropdown').on('change', function (e) {
                    var accepted = $(this).val();
                    $('.table-filter-accepted-dropdown').val(accepted)
                    dataTable.column(10).search(accepted).draw();
                })                
                
                if(modelName === "tfImpBillSummary") {
                	 $('#search_8, #search_9, #search_j8, #search_j9').daterangepicker({
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
       			}                
                else {
	               $('#search_9, #search_j9, #search_10, #search_j10').daterangepicker({
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
                }

                $('.clear-input').on('click', function () {
                    $('#' + $(this).attr('data-clear-input')).val('').change()
                    $(this).addClass('d-none')
                });
				
                if(modelName === "tfImpBillSummary") {
	       			 $('#search_8,#search_j8').on('change', function () {
	                     var submitted = $(this).val();
	                    	dataTable.column(8).search(submitted).draw();
	                 });
	                 $('#search_9,#search_j9').on('change', function () {
	                     var updated = $(this).val();
	                     dataTable.column(9).search(updated).draw();
	                 });
        		}
        		else
       			{
        			 $('#search_9,#search_j9').on('change', function () {
        				 var id=this.id;
                         var submitted = $(this).val();
                         window.sessionStorage.setItem(id, submitted);
                        	dataTable.column(9).search(submitted).draw();
                     });
                     $('#search_10,#search_j10').on('change', function () {
                    	 var id=this.id;
                    	 var updated = $(this).val();
                         window.sessionStorage.setItem(id, updated);
                         dataTable.column(10).search(updated).draw();
                     });
       			}               
            });
            
            function retriveFIlters(item)
            {
            	var searchTfapIdTop= window.sessionStorage.getItem(item);
            	if(null!=searchTfapIdTop && searchTfapIdTop!='' && item.indexOf('table-filter') >= 0)
            		{
            		$('.'+item).val(searchTfapIdTop)
            		} 
            	else if(null!=searchTfapIdTop && searchTfapIdTop!='')
            		{
            		$('#'+item).val(searchTfapIdTop)
            		}
            }
        </script>
        
        <section id="description" class="card">
            <div class="card-header">
                <div class="row">
                    <div class="col-6">
                        <h4 class="card-title">
                            <spring:message code="${titleKey}"/>
                            <spring:message code="label.list"/>
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
                                    <tfap:tfapstatuslabelsettle status="NEW"/>
                                    <tfap:tfapstatuslabelsettle status="DRF"/>
                                    <tfap:tfapstatuslabelsettle status="PCH"/>
                                    <tfap:tfapstatuslabelsettle status="PAU"/>
                                    <tfap:tfapstatuslabelsettle status="SUB"/>
                                    <tfap:tfapstatuslabelsettle status="PRO"/>
                                    <tfap:tfapstatuslabelsettle status="APP"/>
                                    <tfap:tfapstatuslabelsettle status="CAN"/>
                                    <tfap:tfapstatuslabelsettle status="REJ"/>
                                    <tfap:tfapstatuslabelsettle status="ACK"/>
                                    <tfap:tfapstatuslabelsettle status="DIS"/>
                                    <tfap:tfapstatuslabelsettle status="RCV"/>
                                    <tfap:tfapstatuslabelsettle status="AMD"/>
                                    <tfap:tfapstatuslabelsettle status="IRJ"/>
                                    <tfap:tfapstatuslabelsettle status="IAP"/>
                                    <tfap:tfapstatuslabelsettle status="PED"/>
                                </div>

                                <%@ include file="/WEB-INF/views/common/common_html_transaction_datatable.jspf" %>

                                <script type="text/javascript">
	                                var url = '${modelUrl}';
	                                var url${tableName} = "";
	                                if(url=="")
										url${tableName} = "<spring:url value='/${modelName}/list/json?tabletype=${tableType}' />"
									else
										url${tableName} = "<spring:url value='/${modelUrl}/list/json?tabletype=${tableType}' />"
											
									var status;

									var map = { 'ECNEG': "Export Letter of Credit Negotiation",
                                        'LCISS': "Letter Of Credit",
                                        'RFSUB': "Receivable Finance",
                                        'SCISS': "Standby Letter of Credit",
                                        'SGISS': "Shipping Guarantee",
                                        'BGISS':"Banker's Guarantee",
                                        'IFIPR': 'Import Pre-Shipment Financing',
                                        'IFIPO': 'Import Post-Shipment Financing',
                                        'IFEPR': 'Export Pre-Shipment Financing',
                                        'IFEPO': 'Export Post-Shipment Financing',
                                        'IFEXT': 'Invoice Financing Extension'};

                                    var productsActionReject = ['LCISS', 'LCAMD', 'LCCAN', 'RFSUB', 'SCISS', 'SCAMD', 'SCCAN', 'SGISS', 'SGAWB', 'SGBOL', 'SGLOI', 'BGISS', 'BGAMD', 'BGCAN'];
                                    var productsActionApprove = ['LCISS', 'LCAMD', 'LCCAN', 'RFSUB', 'SCISS', 'SCAMD', 'SCCAN', 'SGISS', 'SGAWB', 'SGBOL', 'SGLOI', 'BGISS', 'BGAMD', 'BGCAN'];
                                    var productActionSubmitForReview = ['IBCOL', 'IBULC', 'IBCON', 'IBLCN'];
                                    var productActionPendingAuth = ['IBCOL', 'IBULC', 'IBCON', 'IBLCN'];

                                    var stateUserRolesActionApprove = [
                                        {state: 'PRO', userRoles: ['TFAP_BANK_ADMIN', 'TFAP_BANK_USER']}
                                    ];
                                    var stateUserRolesActionRecieved = [
                                        {state: 'SUB', userRoles: ['TFAP_BANK_MAKER']}
                                    ];
                                    var stateUserRolesActionProccessing = [
                                        {state: 'RCV', userRoles: ['TFAP_BANK_APPROVER']}
                                    ];
                                    var stateUserRolesActionReject = [
                                        {state: 'PRO', userRoles: ['TFAP_BANK_ADMIN', 'TFAP_BANK_USER']}
                                    ];
                                    var stateUserRolesActionSubmitForReview = [
                                        {state: 'DRF', userRoles: ['TFAP_BANK_ADMIN']}
                                    ];
                                    var stateUserRolesActionPendingAuth = [
                                        {state: 'PAU', userRoles: ['TFAP_BANK_ADMIN']}
                                    ];
                                    var actionsDropdownButton = '<button type="button" class="btn_action btn-primary dropdown-toggle"'
                                        + 'data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">'
                                        + '<i class="fa fa-ellipsis-h"></i>'
                                        + '</button>'

                                    var actionDropdownMenuPlaceholder = '<div class="dropdown-menu arrow-right mr-5">'
                                        + '@items@'
                                        + '</div>';
                                  /*   var actionItemView = '<button class="dropdown-item view" type="button">'
                                        + '	<i class="ft-eye"></i>&nbsp; View '
                                        + '</button>'; */

                                    var actionItemReject = '<button class="dropdown-item bank-reject" type="button">'
                                        + '	<i class="fa fa-times-circle"></i>&nbsp; Reject '
                                        + '</button>';

                                    // Need to move, to within forEach loop    
                                    var actionItemApprove = '<button class="dropdown-item bank-approve" type="button">'
                                        + '	<i class="fa fa-check-circle"></i>&nbsp; Approve '
                                        + '</button>';

                                    var actionItemProcess = '<button class="dropdown-item process" type="button">'
                                        + '	<i class="fa fa-check-circle"></i>&nbsp; Process '
                                        + '</button>';

                                    var actionItemReceived = '<button class="dropdown-item received" type="button">'
                                        + '	<i class="fa fa-check-circle"></i>&nbsp; Received '
                                        + '</button>';
                                    
                                    var actionItemSubmitForAuth = '<button class="dropdown-item submitauth" type="button">'
                                            + '	<i class="fa fa-check-square-o"></i>&nbsp; Submit for Auth'
                                            + '</button>';
                                            
                                    var actionItemSubmitForReview = '<button class="dropdown-item submitreview" type="button">'
                                        + '	<i class="fa fa-check-square-o"></i>&nbsp; Submit for Review'
                                        + '</button>';
                                    
                                    var actionItemSubmit = '<button class="dropdown-item submit" type="button">'
                                        + '	<i class="fa fa-check-square-o"></i>&nbsp; Submit '
                                        + '</button>';
                                    
                                    var actionItemReqMofification = '<button class="dropdown-item reject" type="button">'
                                        + '	<i class="fa fa-times-circle"></i>&nbsp; Request for Modification ' /* Reject */
                                        + '</button>';

                                    var actionItemDiscard = '<button class="dropdown-item discard" type="button">'
                                        + '	<i class="fa fa-trash"></i>&nbsp; Discard '
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

                                    var rootUrlName;  
                                    var aoColumns${tableName} = [
                                        <c:forEach items="${columns}" var="column" varStatus="loop">
                                        {
                                        	
                                            "mData": "${column}",
                                            "mRender": function (data, type, full, row) {
                                            	switch(full.product.substring(0,2).trim()) {
											  		case 'LC':
											  		    rootUrlName = "tfApplication";
											  		    break;
											  		case 'RF':
											  			rootUrlName = "receivableFinance";
											   			break;
											  		case 'BG':
											  			rootUrlName = 'bankersGuarantee';
											  			break;
											  		case 'SC':
											  			rootUrlName = "sblc";
											  			break;
											  		case 'SG':
											  			rootUrlName = "sg";	
											  			break;
                                                    case 'IF':
                                                        if (full.product.trim().startsWith('IFIPR')) {
                                                            rootUrlName = 'ifImpPre';
                                                        } else if (full.product.trim().startsWith('IFIPO')) {
                                                            rootUrlName = 'ifImpPost';
                                                        } else if (full.product.trim().startsWith('IFEPR')) {
                                                            rootUrlName = 'ifExpPre';
                                                        } else if (full.product.trim().startsWith('IFEPO')) {
                                                            rootUrlName = 'ifExpPost';
                                                        } else if (full.product.trim().startsWith('IFEXT')) {
                                                            rootUrlName = 'ifExt';
                                                        }
                                                        break;
                                        		}
                                           		switch(full.product.substring(0,5).trim()) {											  		
										  		case 'IBCON':
										  		case 'IBCOL':
										  			rootUrlName = "tfImpBillCol";
										  			break;
										  		case 'IBLNC':
										  		case 'IBULC':
										  			rootUrlName = "importBillLc";	
										  			break;
                                        		}
                                           		switch(full.product.substring(0,5).trim()) {											  		
										  		case 'IMPST':
										  		case 'ISDEB':
										  		case 'ISILN':
										  		case 'ISOTH':
										  			rootUrlName = "tfImpBillSettlementSummary";
										  			break;
										  		case 'ECNEG':
										  			rootUrlName = "exptrlcneg";
										  			break;	
				                          		}

                                                var col = "${column}";
                                                if (col.trim().toLowerCase() == "tfapid") {
                                                    data = "<a href='../../"+rootUrlName+"/read/view?doc_type=" + full.product + "&tfapid=" + full.tfapId + "'>" + data + "</a>";
                                                }
                                                else if(col.trim().toLowerCase()=="product")
                                            	{
                                            	var sName=data;
                                            	var product = full.product;
                                            	if(product.substring(0,2)==="LC"){
                                            		data=map['LCISS'];
                                            	}
                                            	if(product.substring(0,2)==="RF"){
                                            		data=map['RFSUB'];
                                            	}
                                            	if(product.substring(0,2)==='BG'){
                                            		data=map['BGISS'];
                                            	}
                                            	if(product.substring(0,2)==='SC'){
                                            		data=map['SCISS'];
                                            	}
                                            	if(product.substring(0,2)==='SG'){
                                            		data=map['SGISS'];
                                            	}
                                            	if(product.substring(0,2)==='EC'){
                                            		data=map['ECNEG'];
                                            	}
                                            	if (product.substring(0,2)==='IF') {
                                            	    data=map[product.substring(0,5)];
                                                }
                                            	data=  "<label data-toggle='tooltip' data-placement='bottom' title='"+data+"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+ sName +"</label>";
                                            	
                                            	}
                                                else if (col.trim().toLowerCase() == "shortdesc") {
                                                	var product = full.product;
                                                	if(product.substring(0,2)==="LC"){
                                                		data=map['LCISS'];
                                                	}
                                                	if(product.substring(0,2)==="RF"){
                                                		data=map['RFSUB'];
                                                	}
                                                	if(product.substring(0,2)==='BG'){
                                                		data=map['BGISS'];
                                                	}
                                                	if(product.substring(0,2)==='SC'){
                                                		data=map['SCISS'];
                                                	}
                                                	if(product.substring(0,2)==='SG'){
                                                		data=map['SGISS'];
                                                	}
                                                	if(product.substring(0,2)==='EC'){
                                                		data=map['ECNEG'];
                                                	}
                                                	if (product.substring(0,2)==='IF') {
                                                	    data=map[product.substring(0,5)];
                                                    }
                                                } else if (col.trim().toLowerCase() == "tibaccepted") {
                                                	if(data == 'YES')
                                                		data = '<i class="fa fa-check font-medium-4" style="background: none; color: green"></i>'
                                                	if(data == 'NO')
                                                		data = '<i class="fa fa-times font-medium-4" style="background: none; color: red"></i>'
                                                } else if (col.trim().toLowerCase() == "status") {
                                                	/*
                                                		To be removed - If-Else condition to be removed once the states are maintained in models for Import Bills Collection Notification/ Import Bills Notification Under LC 
                                                	*/
                                                    if(data == null)
                                                        data = full.tfmsId;
                                                    else {
                                                		data = $('.status' + data.trim().toUpperCase()).clone()
                                                   		data = data[0];
                                                		var wrapper = document.createElement("div");
                                                        wrapper.appendChild(data);
                                                        var str = wrapper.innerHTML;
                                                        data = str 
                                                    }
                                                    

                                                } else if (col.trim().toLowerCase() == 'actions') {

                                                	  var actionItemView = '<button class="dropdown-item view" type="button" rootUrmName="'+rootUrlName+'">'
                                                          + '	<i class="ft-eye"></i>&nbsp; View '
                                                          + '</button>';
                                                	
                                                    var status = full.status;
                                                    var product = full.product;

                                                    var items = actionItemView
                                                    if(modelName === "tfImpBillSummary")
                                                   	{
                                                    	if (status == "DRF") {// draft
	                                                    	if (productActionSubmitForReview.includes(product) && isPermitted(status, stateUserRolesActionSubmitForReview)) {
	                                                            //items += actionItemSubmitForAuth + actionItemDiscard;
	                                                        }
                                                    	} else if (status == "PAU") {// pending auth                                                    		
                                                    		if (productActionPendingAuth.includes(product) && isPermitted(status, stateUserRolesActionPendingAuth)) {
	                                                            //items += actionItemSubmit + actionItemReqMofification;
	                                                        } 
                                                    	}
                                                   	} else {
                                                        if (status == "SUB") {// submitted
                                                            if (productsActionApprove.includes(product) && isPermitted(status, stateUserRolesActionRecieved)) {
                                                                //items += actionItemReceived;
                                                            }
                                                        } else if (status == "RCV") {//recieved
                                                            if (productsActionApprove.includes(product) && isPermitted(status, stateUserRolesActionProccessing)) {
                                                                //items += actionItemProcess;
                                                            }
                                                        } else if (status == "PRO") {//processing
                                                            if (productsActionApprove.includes(product) && isPermitted(status, stateUserRolesActionApprove)) {
                                                                //items += actionItemApprove;
                                                            }
                                                            if (productsActionReject.includes(product) && isPermitted(status, stateUserRolesActionReject)) {
                                                                //items += actionItemReject;
                                                            }
                                                        } else if (status == "APP") {//approved
                                                            if (productsActionReject.includes(product) && isPermitted(status, stateUserRolesActionReject)) {
                                                                //items += actionItemReject;
                                                            }
                                                        } else if (status == "CAN") {// cancelled
                                                            if (productsActionApprove.includes(product) && isPermitted(status, stateUserRolesActionApprove)) {
                                                                //items += actionItemApprove;
                                                            }
                                                        } else if (status == "REJ") {// rejected
                                                            /*
                                                            *
                                                            */
                                                        }
                                                   	}

                                                    data = actionsDropdownButton + actionDropdownMenuPlaceholder.replace('@items@', items);

                                                } else if (col == 'No.') {
                                                    data = row + 1;
                                                } 
                                                 else if(col == 'tibBillAmt'){ // for Import Bills List 
                                                	data =  full.tibBillAmt.split(' ')[0] == 'null' ? '' : full.tibBillAmt.split(' ')[0] +" "+ $.number(full.tibBillAmt.split(' ')[1], 0);
                                                } else if(col == 'tisBillSettleAmt'){ // for Import Settlement List 
                                                	data =  full.tisBillSettleAmt.split(' ')[0] == 'null' ? '' : full.tisBillSettleAmt.split(' ')[0] +" "+ $.number(full.tisBillSettleAmt.split(' ')[1], 0);
                                                }  
                                                else if (col == 'submitted') {
                                               	 var status = full.status;
                                                 var product = full.product;
                                                 if(((product == "LCCAN") || (product == "SCCAN")) && ((status == "PCH")||(status == "PAU")||(status == "DRF"))) {
                                                	 data = '-';
                                                 }
                                                	 
                                            	} else if (col == 'tibBillPmtTerms') {                                               	
	                                                 if(data == "DA") {
	                                                	 data = 'D/A';
	                                                 }
	                                                 if(data == "DP") {
	                                                	 data = 'D/P';
	                                                 }
	                                                 if(data == "SI") {
	                                                	 data = 'Sight';
	                                                 }
	                                                 if(data == "US") {
	                                                	 data = 'Usance';
	                                                 }
                                            	}
                                                return data;
                                            }

                                        },

                                        </c:forEach>
                                    ]

                                </script>
                                <div class="table-responsive">
                                    <table id="${tableName}"
                                           class="table table-striped jambo_table bulk_action stripe">
                                        <thead>
                                        <tr class="table_header">
                                            <c:forEach items="${columns}" var="column">
                                                <c:choose>
                                                    <c:when test="${column == 'Actions'}">
                                                        <th class="column-title">Actions</th>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <th class="column-title"><spring:message
                                                                code="label.${column}"/></th>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </tr>
                                        </thead>
                                        <thead id="topSearch">
                                        <tr>
                                            <%! int j = 0; %>
                                            <c:forEach items="${columns}" var="column">

                                                <c:choose>
                                                    <c:when
                                                        test="${ fn:contains(column, 'Actions') || fn:contains(column, 'No.') || fn:contains(column, 'Select')}">
                                                        <th style="width:20px;"></th>
                                                    </c:when>

<%--                                                     <c:when test="${ fn:contains(column, 'Product') || fn:contains(column, 'product')}">
                                                        <th style="width:20px;">

                                                            <select class="form-control table-filter-product-dropdown">
                                                                <option value="">All</option>
                                                                <c:forEach items="${filterProducts.keySet()}" var="key" varStatus="i">
																	<option value="${key}">${ filterProducts.get(key)}</option>
																</c:forEach>
                                                            </select>
                                                        </th>
                                                        <% i++; %>
                                                    </c:when> --%>
													<c:when test="${ fn:contains(column, 'shortdesc') || fn:contains(column, 'shortDesc')}">
                                                        <th style="width:20px;">

                                                            <select class="form-control table-filter-product-dropdown">
                                                                <option value="">All</option>
                                                                <c:forEach items="${filterProducts.keySet()}" var="key" varStatus="j">
																	<option value="${key}">${ filterProducts.get(key)}</option>
																</c:forEach>
                                                            </select>
                                                        </th>
                                                        <% j++; %>
                                                    </c:when>
                                                     <c:when test="${ fn:contains(column, 'tibBillPmtTerms') }">
                                                        <th style="width:20px;">
                                                            <select class="form-control table-filter-paymentterms-dropdown">
                                                                <option value="">All</option>
																<option value="DA"><spring:message code="label.tfImpBillCol.tibcBillPmtTerms.false"/></option>
																<option value="DP"><spring:message code="label.tfImpBillCol.tibcBillPmtTerms.true"/></option>
																<option value="SI"><spring:message code="label.tfImportBill.docpymtterms.sight.false"/></option>
																<option value="US"><spring:message code="label.tfImportBill.docpymtterms.usance.true"/></option>
                                                            </select>
                                                        </th>
                                                        <% j++; %>
                                                    </c:when>
 													<c:when test="${ fn:contains(column, 'tibAccepted') }">
                                                        <th style="width:20px;">

                                                            <select class="form-control table-filter-accepted-dropdown">
                                                                <option value="">All</option>
																<option value="YES"><spring:message code="label.tfApplication.APP"/></option>
																<option value="NO"><spring:message code="label.tfApplication.REJ"/></option>
                                                            </select>
                                                        </th>
                                                        <% j++; %>
                                                    </c:when>
                                                    <c:when test="${ fn:contains(column, 'Status') || fn:contains(column, 'status')}">
                                                        <th style="width:20px;">
                                                        	<select class="form-control table-filter-status-dropdown">
                                                                <option value="">All</option>
                                                                <c:forEach items="${filterStatus}" var="statusCode" varStatus="j">
								                                	<option value="${statusCode}"><spring:message code="label.application.status.settle.${statusCode}"/></option>
								                                </c:forEach>
                                                            </select>
                                                        </th>
                                                        <% j++; %>
                                                    </c:when>

													
                                                    <c:when test="${ fn:contains(column, 'Submitted') || fn:contains(column, 'submitted') }">
                                                    	<th>
                                                            <div class="input-group">
                                                                <input id="search_j9"
                                                                       class="form-control input-xs table-filter"
                                                                       style="width: 100%; background:white"
                                                                       placeHolder="<spring:message code='label.${column}'/>"
                                                                       autocomplete="off" readonly/>
                                                                <button type="button" onclick=""
                                                                        class="btn bg-transparent clear-input d-none"
                                                                        data-clear-input="search_j9"
                                                                        style="margin-left: -40px; z-index: 100;">
                                                                    <i class="fa fa-times"></i>
                                                                </button>
                                                            </div>
                                                        </th>
                                                        <% j++; %>
                                                    </c:when>

                                                    <c:when test="${ fn:contains(column, 'LastUpdate') || fn:contains(column, 'lastUpdate') }">
                                                    		<th>
	                                                            <div class="input-group">
	                                                                <input id="search_j10"
	                                                                       class="form-control input-xs table-filter"
	                                                                       style="width: 100%; background: white"
	                                                                       placeHolder="<spring:message code='label.${column}'/>"
	                                                                       autocomplete="off" readonly/>
	                                                                <button type="button" onclick=""
	                                                                        class="btn bg-transparent clear-input d-none"
	                                                                        data-clear-input="search_j10"
	                                                                        style="margin-left: -40px; z-index: 100;">
	                                                                    <i class="fa fa-times"></i>
	                                                                </button>
	                                                            </div>
	                                                        </th>
                                                        <% j++; %>
                                                    </c:when>
                                                    
                                                     <c:when test="${ fn:contains(column, 'tibBillNotifyDt') }">
                                                        <th>
                                                            <div class="input-group">
                                                                <input id="search_j8"
                                                                       class="form-control input-xs table-filter"
                                                                       style="width: 100%; background: white"
                                                                       placeHolder="<spring:message code='label.${column}'/>"
                                                                       autocomplete="off" readonly/>
                                                                <button type="button" onclick=""
                                                                        class="btn bg-transparent clear-input d-none"
                                                                        data-clear-input="search_j8"
                                                                        style="margin-left: -40px; z-index: 100;">
                                                                    <i class="fa fa-times"></i>
                                                                </button>
                                                            </div>
                                                        </th>
                                                        <% j++; %>
                                                    </c:when>
 
                                                    <c:when test="${ fn:contains(column, 'tibBillDueDt') }">
                                                        <th>
                                                            <div class="input-group">
                                                                <input id="search_j9"
                                                                       class="form-control input-xs table-filter"
                                                                       style="width: 100%; background: white"
                                                                       placeHolder="<spring:message code='label.${column}'/>"
                                                                       autocomplete="off" readonly/>
                                                                <button type="button" onclick=""
                                                                        class="btn bg-transparent clear-input d-none"
                                                                        data-clear-input="search_j9"
                                                                        style="margin-left: -40px; z-index: 100;">
                                                                    <i class="fa fa-times"></i>
                                                                </button>
                                                            </div>
                                                        </th>
                                                        <% j++; %>
                                                    </c:when>
                                                    
                                                    <c:otherwise>
                                                        <th><input type="text" id="search_j<%=j%>"
                                                                   class="form-control input-xs table-filter"
                                                                   style="width: 100%;"
                                                                   placeholder="<spring:message code='label.${column}'/>">
                                                        </th>
                                                        <% j++; %>
                                                    </c:otherwise>
                                                </c:choose>


                                            </c:forEach>
                                        </tr>
                                        </thead>
                                        <tbody></tbody>
                                        <tfoot>
                                        <tr>
                                            <%! int i = 0; %>
                                            <c:forEach items="${columns}" var="column">

                                                <c:choose>
                                                    <c:when
                                                        test="${ fn:contains(column, 'Actions') || fn:contains(column, 'No.') || fn:contains(column, 'Select')}">
                                                        <th style="width:20px;"></th>
                                                    </c:when>

<%--                                                     <c:when test="${ fn:contains(column, 'Product') || fn:contains(column, 'product')}">
                                                        <th style="width:20px;">

                                                            <select class="form-control table-filter-product-dropdown">
                                                                <option value="">All</option>
                                                                <c:forEach items="${filterProducts.keySet()}" var="key" varStatus="i">
																	<option value="${key}">${ filterProducts.get(key)}</option>
																</c:forEach>
                                                            </select>
                                                        </th>
                                                        <% i++; %>
                                                    </c:when> --%>
													 <c:when test="${ fn:contains(column, 'shortdesc') || fn:contains(column, 'shortDesc')}">
                                                        <th style="width:20px;">

                                                            <select class="form-control table-filter-product-dropdown">
                                                                <option value="">All</option>
                                                                <c:forEach items="${filterProducts.keySet()}" var="key" varStatus="i">
																	<option value="${key}">${ filterProducts.get(key)}</option>
																</c:forEach>
                                                            </select>
                                                        </th>
                                                        <% i++; %>
                                                    </c:when>
                                                    <c:when test="${ fn:contains(column, 'tibBillPmtTerms') }">
                                                        <th style="width:20px;">
                                                            <select class="form-control table-filter-paymentterms-dropdown">
                                                                <option value="">All</option>
																<option value="DA"><spring:message code="label.tfImpBillCol.tibcBillPmtTerms.false"/></option>
																<option value="DP"><spring:message code="label.tfImpBillCol.tibcBillPmtTerms.true"/></option>
																<option value="SI"><spring:message code="label.tfImportBill.docpymtterms.sight.false"/></option>
																<option value="US"><spring:message code="label.tfImportBill.docpymtterms.usance.true"/></option>
                                                            </select>
                                                        </th>
                                                        <% i++; %>
                                                    </c:when>
 													<c:when test="${ fn:contains(column, 'tibAccepted') }">
                                                        <th style="width:20px;">

                                                            <select class="form-control table-filter-accepted-dropdown">
                                                                <option value="">All</option>
																<option value="YES"><spring:message code="label.tfApplication.APP"/></option>
																<option value="NO"><spring:message code="label.tfApplication.REJ"/></option>
                                                            </select>
                                                        </th>
                                                        <% i++; %>
                                                    </c:when>

                                                    <c:when
                                                            test="${ fn:contains(column, 'Status') || fn:contains(column, 'status')}">
                                                        <th style="width:20px;">
                                                        	<select class="form-control table-filter-status-dropdown">
                                                                <option value="">All</option>
                                                                <c:forEach items="${filterStatus}" var="statusCode" varStatus="i">
								                                	<option value="${statusCode}"><spring:message code="label.application.status.settle.${statusCode}"/></option>
								                                </c:forEach>
                                                            </select>
                                                        </th>
                                                        <% i++; %>
                                                    </c:when>

                                                    <c:when test="${ fn:contains(column, 'Submitted') || fn:contains(column, 'submitted')}">
                                                       	<th>
	                                                            <div class="input-group">
	                                                                <input id="search_9"
	                                                                       class="form-control input-xs table-filter"
	                                                                       style="width: 100%; background:white"
	                                                                       placeHolder="<spring:message code='label.${column}'/>"
	                                                                       autocomplete="off" readonly/>
	                                                                <button type="button" onclick=""
	                                                                        class="btn bg-transparent clear-input d-none"
	                                                                        data-clear-input="search_9"
	                                                                        style="margin-left: -40px; z-index: 100;">
	                                                                    <i class="fa fa-times"></i>
	                                                                </button>
	                                                            </div>
	                                                        </th>
                                                        <% i++; %>
                                                    </c:when>

                                                    <c:when test="${ fn:contains(column, 'LastUpdate') || fn:contains(column, 'lastUpdate') }">
                                                    	<th>
                                                            <div class="input-group">
                                                                <input id="search_10"
                                                                       class="form-control input-xs table-filter"
                                                                       style="width: 100%; background: white"
                                                                       placeHolder="<spring:message code='label.${column}'/>"
                                                                       autocomplete="off" readonly/>
                                                                <button type="button" onclick=""
                                                                        class="btn bg-transparent clear-input d-none"
                                                                        data-clear-input="search_10"
                                                                        style="margin-left: -40px; z-index: 100;">
                                                                    <i class="fa fa-times"></i>
                                                                </button>
                                                            </div>
                                                        </th>
                                                        <% i++; %>
                                                    </c:when>
                                                    
                                                    <c:when test="${ fn:contains(column, 'tibBillNotifyDt') }">
                                                        <th>
                                                            <div class="input-group">
                                                                <input id="search_8"
                                                                       class="form-control input-xs table-filter"
                                                                       style="width: 100%; background: white"
                                                                       placeHolder="<spring:message code='label.${column}'/>"
                                                                       autocomplete="off" readonly/>
                                                                <button type="button" onclick=""
                                                                        class="btn bg-transparent clear-input d-none"
                                                                        data-clear-input="search_8"
                                                                        style="margin-left: -40px; z-index: 100;">
                                                                    <i class="fa fa-times"></i>
                                                                </button>
                                                            </div>
                                                        </th>
                                                        <% i++; %>
                                                    </c:when>

                                                    <c:when test="${ fn:contains(column, 'tibBillDueDt') }">
                                                        <th>
                                                            <div class="input-group">
                                                                <input id="search_9"
                                                                       class="form-control input-xs table-filter"
                                                                       style="width: 100%; background: white"
                                                                       placeHolder="<spring:message code='label.${column}'/>"
                                                                       autocomplete="off" readonly/>
                                                                <button type="button" onclick=""
                                                                        class="btn bg-transparent clear-input d-none"
                                                                        data-clear-input="search_9"
                                                                        style="margin-left: -40px; z-index: 100;">
                                                                    <i class="fa fa-times"></i>
                                                                </button>
                                                            </div>
                                                        </th>
                                                        <% i++; %>
                                                    </c:when>
                                                    
                                                    <c:otherwise>
                                                        <th><input type="text" id="search_<%=i%>"
                                                                   class="form-control input-xs table-filter"
                                                                   style="width: 100%;"
                                                                   placeholder="<spring:message code='label.${column}'/>">
                                                        </th>
                                                        <% i++; %>
                                                    </c:otherwise>
                                                </c:choose>


                                            </c:forEach>
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

<c:choose>
	<c:when test="${modelName == 'tfApplication'}">
		<tfap:action-bank-approve/>
		<tfap:action-bank-reject/>
	</c:when>
</c:choose>
<tfap:action-process/>
<tfap:action-received/>
<tfap:action-submit-for-auth/>
<tfap:action-submit/>
<tfap:action-reject/>

<script type="text/javascript">
	$(document).ready(function(){
		var modelName  = '${modelName}';
		if(modelName === "tfApplication") {
			$('#search_3,#search_j3').on('keypress', function(evt){
				var charCode = (evt.which) ? evt.which : evt.keyCode
				if ((charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122)) {
					return true;
				}else{
					return false;
				}
			})
		}
	});
</script>