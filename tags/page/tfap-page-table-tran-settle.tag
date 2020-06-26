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
<%@attribute name="columns" required="false" type="java.lang.Object" %>
<%@attribute name="tableName" type="java.lang.String" required="false" %>
<%@attribute name="filterProducts" type="java.util.Map" required="true" %>
<%@attribute name="filterStatus" type="java.util.List" required="true" %>
<%@attribute name="tableType" type="java.lang.String" required="true" %>
<%@attribute name="searchForm" fragment="true" %>
<%@attribute name="modelUrl" type="java.lang.String" required="false" %>

<script src="<c:url value="/resources/js/scripts/customNumber/jquery.number.js"/>" type="text/javascript"></script>

<c:set var="tableName" value="${(empty tableName) ? 'dataTableInput' : tableName}"/>
<c:set var="columns" value="${(empty columns) ? '${columns}' : columns}"/>
<c:set var="rfTable" value="rfTable" />
<c:set var="rfID" value="rfTable" />


<tfap:modal button_name="label.bank.button"
			modal_title="label.bank.maker.approver.check" modal_Id="modal_maker_approver_application_process_id"
			show_button_close="false" show_button_primary="false">
			<br />
			<div class="modal-content">
				<div class="modal-body">
					<h4 style="text-align: center;">
You are not allowed to modify this transaction as you have previously used another role to process this transaction.</h4>
				</div>
				<div class="modal-footer" style="margin-top: -20px;">
					<button type="button" class="btn btn-outline-primary mr-1"
						id="redirect_to_main_app_process" onclick="redirectToMainReject()"
						href="${pageContext.request.contextPath}/tfApplication/list/view"
						data-dismiss="modal">
						<spring:message code='label.modal.button.close' />
					</button>
				</div>
			</div>
</tfap:modal>



<div class="content-wrapper">
    <div class="content-header row">
        <div class="content-header-left col-6 mb-2">
            <h3 class="content-header-title mb-0">
                <spring:message code="${breadCrumbKey}"/>
            </h3>
            <div class="row breadcrumbs-top">
                <div class="breadcrumb-wrapper col-12">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                        	<a href="${pageContext.request.contextPath}/home">
                                <spring:message code="label.home"/>
                            </a>
                        </li>
                        <li class="breadcrumb-item active">
                        	<spring:message code="${breadCrumbKey}"/>
                        </li>
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
        
<%--         <c:if test="${modelName == 'tfImpSettlement' && enableAddNew=='true'}">
   		<div class="content-header-right col-6 text-right">
		  	<div class="btn-group float-md-right" role="group" aria-label="Button group with nested dropdown">
				 <a class="btn btn-primary" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Add New Import Settlement" 
				 href="../../tfImpBillSettlementSummary/settleByCompany" ><i class="fa fa-plus"></i>&nbsp; Add New</a>
         	</div>
        </div>
        </c:if> --%>
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
				
                $('.table-filter-status-dropdown').on('change', function (e) {
                    var status = $(this).val();
                    $('.table-filter-status-dropdown').val(status);
                    window.sessionStorage.setItem('table-filter-status-dropdown', status);
                    dataTable.column(9).search(status).draw();
                })
                
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
                
                $('.table-filter-discrep-dropdown').on('change', function (e) {
                    var accepted = $(this).val();
                    $('.table-filter-discrep-dropdown').val(accepted)
                    dataTable.column(8).search(accepted).draw();
                })
                
				$('.table-filter-accepted-dropdown').on('change', function (e) {
                    var accepted = $(this).val();
                    $('.table-filter-accepted-dropdown').val(accepted)
                    dataTable.column(11).search(accepted).draw();
                })
                
                $('.table-filter-initsettle-dropdown').on('change', function (e) {
                    var initsettle = $(this).val();
                    $('.table-filter-initsettle-dropdown').val(initsettle)
                    dataTable.column(12).search(initsettle).draw();
                })
                
             if(modelName === "tfImpBillSummary") {
               	 $('#search_9, #search_10, #search_j9, #search_j10').daterangepicker({
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
              } else {
	               $('#search_7, #search_8, #search_j7, #search_j8').daterangepicker({
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
                    $('#' + $(this).attr('data-clear-input')).val('').change();
                    $(this).addClass('d-none')
                });

                if(modelName === "tfImpBillSummary") {
       			 $('#search_9,#search_j9').on('change', function () {
                        var submitted = $(this).val();
                       	dataTable.column(9).search(submitted).draw();
                    });
                    $('#search_10,#search_j10').on('change', function () {
                        var updated = $(this).val();
                        dataTable.column(10).search(updated).draw();
                    });
	       		} else {
	    			 $('#search_7,#search_j7').on('change', function () {
	    				 var id=this.id;
	    				 var submitted = $(this).val();
	                     window.sessionStorage.setItem(id, submitted);
	                    	dataTable.column(7).search(submitted).draw();
	                 });
	                 $('#search_8,#search_j8').on('change', function () {
	                	 var id=this.id;
	                     var updated = $(this).val();
	                     window.sessionStorage.setItem(id, updated);
	                     dataTable.column(8).search(updated).draw();
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
            
            
            function redirectToMainReject(e){
            	window.location.href="${pageContext.request.contextPath}/tfApplication/list/view";
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
                                </div>

                                <%@ include file="/WEB-INF/views/common/common_html_transaction_datatable.jspf" %>

                                <script type="text/javascript">
	                                var url = '${modelUrl}';
	                                var url${tableName} = "";
	                                if(url=="")
										url${tableName} = "<spring:url value='/${modelName}/list/json?tabletype=${tableType}' />";
									else
										url${tableName} = "<spring:url value='/${modelUrl}/list/json?tabletype=${tableType}' />";
											
									var status;
                                    
                                    var map = { 'ECNEG': "Export Letter of Credit Negotiation",
                                        'LCISS': "Letter Of Credit",
                                        'RFSUB': "Receivable Finance",
                                        'SCISS':"Standby Letter of Credit",
                                        'BGISS':"Banker's Guarantee",
                                        'SGISS':"Shipping Guarantee",
                                        'IMPST': "Import Settlement",
                                        'ISDEB': "Import Settlement",
                                        'ISILN': "Import Settlement",
                                        'ISOTH': "Import Settlement",
                                        'IFIPR': 'Import Pre-Shipment Financing',
                                        'IFIPO': 'Import Post-Shipment Financing',
                                        'IFEPR': 'Export Pre-Shipment Financing',
                                        'IFEPO': 'Export Post-Shipment Financing',
                                        'IFEXT': 'Invoice Financing Extension'};
                                    var productsActionDiscard = ['LCISS', 'LCAMD', 'RFSUB', 'LCCAN', 'SCISS', 'SCAMD', 'SCCAN', 'BGISS', 'BGAMD', 'BGCAN', 'SGISS', 'SGAWB', 'SGBOL', 'SGLOI', 'ECNEG'];
                                    var productsActionReject = ['LCISS', 'LCAMD', 'RFSUB', 'LCCAN','SCISS', 'SCAMD', 'SCCAN', 'BGISS', 'BGAMD', 'BGCAN', 'SGISS', 'SGAWB', 'SGBOL', 'SGLOI', 'IMPST','ISDEB','ISILN','ISOTH', 'ECNEG'];
                                    var productsActionSubmitForAuth = ['LCISS', 'LCAMD', 'RFSUB', 'LCCAN', 'SCISS', 'SCAMD', 'SCCAN', 'BGISS', 'BGAMD', 'BGCAN', 'SGISS', 'SGAWB', 'SGBOL', 'SGLOI', 'IMPST','ISDEB','ISILN','ISOTH','ECNEG'];
                                    var productsActionSubmit = ['LCISS', 'LCAMD', 'RFSUB', 'LCCAN', 'SCISS', 'SCAMD', 'SCCAN', 'BGISS', 'BGAMD', 'BGCAN', 'SGISS', 'SGAWB', 'SGBOL', 'SGLOI', 'IMPST','ISDEB','ISILN','ISOTH', 'ECNEG', 'IBULC', 'IBCOL', 'IBLCN', 'IBCON'];
                                    var productsActionCancel = ['LCISS', 'SCISS', 'BGISS', 'LCAMD', 'SCAMD', 'BGAMD'];
                                    var productsActionAmend = ['LCISS', 'SCISS', 'BGISS','LCAMD', 'SCAMD', 'BGAMD'];
                                    var productsActionDuplicate = ['LCISS', 'LCAMD', 'SCISS', 'SCAMD', 'BGISS', 'BGAMD', 'ECNEG'];
                                    var productsActionConvert = ['IFIPR', 'IFEPR'];
                                    const productsActionExtension = ['IFIPR', 'IFEPR', 'IFIPO', 'IFEPO'];
                                    var productsActionViewGrouping = ['RFSUB'];
                                    
                                    
                                    var stateUserRolesActionDiscard = [
                                    	{state: 'DRF', userRoles: ['TFAP_COM_MAKER']}
                                    ];
                                    var stateUserRolesActionReject = [
                                    	{state: 'PCH', userRoles: ['TFAP_COM_APPROVER']},
                                    	{state: 'PAU', userRoles: ['TFAP_COM_APPROVER']}   
                                    ];
                                    var stateUserRolesActionSubmitForAuth = [
                                    	{state: 'PCH', userRoles: ['TFAP_COM_MAKER']}
                                    ];
                                    var stateUserRolesActionSubmit = [
                                    	{state: 'PAU', userRoles: ['TFAP_COM_APPROVER']}
                                    ];
                                    var stateUserRolesActionCancel = [
                                    	{state: 'APP', userRoles: ['TFAP_COM_MAKER']}
                                    ];
                                    var stateUserRolesActionAmend = [
                                    	{state: 'APP', userRoles: ['TFAP_COM_MAKER']} 
                                    ];
                                    var stateUserRolesActionConvert = [
                                    	{state: 'APP', userRoles: ['TFAP_COM_MAKER']} 
                                    ];
                                    const stateUserRolesActionExtend = [
                                        {state: 'APP', userRoles: ['TFAP_COM_MAKER']}
                                    ];
                                    var stateUserRolesActionDuplicate = [
                                    	{state: 'APP', userRoles: ['TFAP_COM_MAKER']},
                                    	{state: 'AMD', userRoles: ['TFAP_COM_MAKER']},
                                    	{state: 'REJ', userRoles: ['TFAP_COM_MAKER']}
                                    ];
                                    var stateUserRolesActionViewGrouping = [
                                    	{state: 'APP', userRoles: ['TFAP_COM_MAKER', 'TFAP_COM_ADMIN', 'TFAP_ADMIN']}
                                    ];
                                    var stateUserRolesActionImpBillsMaker = [
                                    	{state: 'SUB', userRoles: ['TFAP_COM_MAKER']}
                                    ];
                                    var stateUserRolesActionImpBillsApprover = [
                                    	{state: 'SUB', userRoles: ['TFAP_COM_APPROVER']}
                                    ];
                                    var actionsDropdownButton = '<button type="button" class="btn_action btn-primary dropdown-toggle"'
                                        + 'data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">'
                                        + '<i class="fa fa-ellipsis-h"></i>'
                                        + '</button>'

                                    var actionDropdownMenuPlaceholder = '<div class="dropdown-menu arrow-right mr-5">'
                                        + '@items@'
                                        + '</div>';
                                     /* var actionItemView = '<button class="dropdown-item view" type="button">'
                                        + '	<i class="ft-eye"></i>&nbsp; View '
                                        + '</button>';  */

                                    var actionItemDiscard = '<button class="dropdown-item discard" type="button">'
                                        + '	<i class="fa fa-trash"></i>&nbsp; Discard '
                                        + '</button>';

                                    var actionItemReqMofification = '<button class="dropdown-item reject" type="button">'
                                        + '	<i class="fa fa-times-circle"></i>&nbsp; Request for Modification ' /* Reject */
                                        + '</button>';

                                    var actionItemSubmitForAuth = '<button class="dropdown-item submitauth" type="button">'
                                        + '	<i class="fa fa-check-square-o"></i>&nbsp; Submit for Auth'
                                        + '</button>';

                                    var actionItemSubmit = '<button class="dropdown-item submit" type="button">'
                                        + '	<i class="fa fa-check-square-o"></i>&nbsp; Submit '
                                        + '</button>';

                                    /* var actionItemCancel = '<button class="dropdown-item cancel" type="button">'
                                        + '	<i class="fa fa-times-circle"></i>&nbsp; Cancel '
                                        + '</button>'; */

                                    /* var actionItemAmend = '<button class="dropdown-item amend" type="button">'
                                        + '	<i class="fa fa-pencil-square-o"></i>&nbsp; Amend '
                                        + '</button>'; */

                                    /* var actionItemDuplicate = '<button class="dropdown-item duplicate" type="button" on>'
                                        + '	<i class="fa fa-copy"></i>&nbsp; Duplicate '
                                        + '</button>'; */
                                    
                                   	var actionViewGrouping = '<button class="dropdown-item viewgrouping" type="button">'
                                        + '	<i class="fa fa-sitemap"></i>&nbsp; View Grouping '
                                        + '</button>';
                                     
                                   	var actionViewDiscrep = '<button class="dropdown-item viewdiscrep" type="button">'
                                        + '	<i class="ft-eye"></i>&nbsp; View Discrep '
                                        + '</button>';
                                               
                                    var actionItemSettleByDebit = '<button class="dropdown-item settlebydebit" type="button">'
                                        + '	<i class="fa fa-file-o"></i>&nbsp; Settle By Debit Account'
                                        + '</button>';
                                        
                                    var actionItemSettleByImpLoan = '<button class="dropdown-item settlebyimploan" type="button">'
                                        + '	<i class="fa fa-file-text"></i>&nbsp; Settle By Import Loan '
                                        + '</button>';
                                        
                                    var actionItemSettleByOthers = '<button class="dropdown-item settlebyothers" type="button">'
                                        + '	<i class="fa fa-file-text-o"></i>&nbsp; Settle By Others '
                                        + '</button>';
                                                                            
                                    var actionItemAccept = '<button class="dropdown-item accept" type="button">'
                                        + '	<i class="fa fa-check-circle"></i>&nbsp; Accept '
                                        + '</button>';
                                            
                                    var actionItemReject = '<button class="dropdown-item reject" type="button">'
                                        + '	<i class="fa fa-times-circle"></i>&nbsp; Reject ' /* Reject */
                                        + '</button>';
					
                                    var actionItemCompBillAccept = '<button class="dropdown-item compbillaccept" type="button">'
                                        + '	<i class="fa fa-check-circle"></i>&nbsp; Accept ' /*Company Accept the Bill Collection/ Bill Under LC */
                                        + '</button>';
                                            
                                    var actionItemCompBillReject = '<button class="dropdown-item compbillreject" type="button">'
                                        + '	<i class="fa fa-times-circle"></i>&nbsp; Reject ' /*Company Reject the Bill Collection/ Bill Under LC */
                                        + '</button>';
									
                                    var loggedUsersRoles = [];
                                    <c:forEach var="role" items="${userRoles}">
                                    	loggedUsersRoles.push('${role}');
                                    </c:forEach>

                                    function isPermitted(state, stateUserRolesAction) {
                                    	var stateObjArr = stateUserRolesAction.filter(function (obj) {
                                	        return (obj.state == state);
                                  	    });

                                        return stateObjArr.length > 0 &&(stateObjArr[0].userRoles.filter(function (userRole) {
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
                                                        }
                                                        else if (full.product.trim().startsWith('IFIPO')) {
                                                            rootUrlName = 'ifImpPost';
                                                        }
                                                        else if (full.product.trim().startsWith('IFEPR')) {
                                                            rootUrlName = 'ifExpPre';
                                                        }
                                                        else if (full.product.trim().startsWith('IFEPO')) {
                                                            rootUrlName = 'ifExpPost';
                                                        }
                                                        else if (full.product.trim().startsWith('IFEXT')) {
                                                            rootUrlName = 'ifExt';
                                                        }
                                                        break;
  											  	}
                                            	switch(full.product.substring(0,5).trim()) {											  		
										  		case 'IBCOL':
										  		case 'IBCON':
										  			rootUrlName = "tfImpBillCol";
										  			break;
										  		case 'IBLCN':
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
                                                    data = "<a href='../../" + rootUrlName + "/read/view?doc_type=" + full.product + "&tfapid=" + full.tfapId + "'>" + data + "</a>";
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
                                                	
                                                }  else if (col.trim().toLowerCase() == "tibaccepted") {
                                                	if(data == 'YES')
                                                		data = '<i class="fa fa-check font-medium-4" style="background: none; color: green"></i>'
                                                	if(data == 'NO')
                                                		data = '<i class="fa fa-times font-medium-4" style="background: none; color: red"></i>'
                                                }  else if (col.trim().toLowerCase() == "status") {
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
                                                         
                                                      var actionItemAmend = '<button class="dropdown-item amend" type="button" rootUrmName="'+rootUrlName+'">'
                                                          + '	<i class="fa fa-pencil-square-o"></i>&nbsp; Amend '
                                                          + '</button>';    
                                                	
                                                      var actionItemCancel = '<button class="dropdown-item cancel" type="button" rootUrmName="'+rootUrlName+'">'
                                                              + '	<i class="fa fa-times-circle"></i>&nbsp; Cancel '
                                                              + '</button>';
                                                       
                                                      var actionItemDuplicate = '<button class="dropdown-item duplicate" type="button" rootUrmName="'+rootUrlName+'">'
                                                              + '	<i class="fa fa-copy"></i>&nbsp; <spring:message code="label.modal.button.duplicate"/> '
                                                              + '</button>';        
                                                              
                                                      var actionItemConvert = '<button class="dropdown-item convert" type="button" rootUrmName="'+rootUrlName+'">'
                                                          + '	<i class="fa fa-retweet"></i>&nbsp; <spring:message code="label.invoicefinancing.action.convert"/> '
                                                          + '</button>';

                                                      const actionItemExtend = '<button class="dropdown-item extension" type="button" rootUrmName="'+rootUrlName+'">'
                                                          + '	<i class="fa fa-clock-o"></i>&nbsp; <spring:message code="label.invoicefinancing.action.extension"/> '
                                                          + '</button>';
                                                              
                                                    var status = full.status;
                                                    var product = full.product;
                                                    var items = actionItemView;
                                                    if(modelName === "tfImpBillSummary" && (full.product == "IBLCN" || full.product == "IBULC"))
                                                   	{	
                                                    	// For Company Maker
                                                    	if(productsActionSubmit.includes(product) && isPermitted(status, stateUserRolesActionImpBillsMaker))
                                                       	{
	                                                        if(full.tibBillPmtTerms == 'SI' && full.tibBillDiscrep == 'YES' && !(full.tibBillSgRefNo == null || full.tibBillSgRefNo == ''))
	                                                        	items += actionItemSettleByDebit + actionItemSettleByImpLoan + actionItemSettleByOthers;
	                                                        else if(full.tibBillPmtTerms == 'SI' && full.tibBillDiscrep == 'NO')	
	                                                        	items += actionItemSettleByDebit + actionItemSettleByImpLoan + actionItemSettleByOthers;
	                                                        else if(full.tibBillPmtTerms == 'US' && full.tibAccepted == 'YES')
	                                                        	items += actionItemSettleByDebit + actionItemSettleByImpLoan + actionItemSettleByOthers;
                                                       	}
                                                    	
                                                    	// Accept/Reject for Company approver
                                                    	if(productsActionSubmit.includes(product) && isPermitted(status, stateUserRolesActionImpBillsApprover))
                                                       	{
                                                    		if(full.tibBillPmtTerms == 'SI' && full.tibBillDiscrep == 'YES' && (full.tibBillSgRefNo == null || full.tibBillSgRefNo == '') && (full.tibAccepted == null || full.tibAccepted == ''))
                                                    			items += actionItemCompBillAccept + actionItemCompBillReject;	
                                                    		else if(full.tibBillPmtTerms == 'US' ){
                                                    			items += actionItemCompBillAccept;
                                                    			if(full.tibBillDiscrep == 'YES' && full.tibBillSgRefNo == null || full.tibBillSgRefNo == '')
                                                    				items += actionItemCompBillReject;
                                                    		}
                                                    		
                                                    		if(full.tibBillDiscrep == 'YES')
                                                    			items += actionViewDiscrep;
                                                       	}
                                                    	
                                                   	} else if(modelName === "tfImpBillSummary" && (full.product == "IBCOL" || full.product == "IBCON"))
                                                   	{   
                                                   			// For Company Maker
                                                       		if(productsActionSubmit.includes(product) && isPermitted(status, stateUserRolesActionImpBillsMaker))
                                                           	{
    	                                                        	if(full.tibBillPmtTerms == 'DP' && !(full.tibBillSgRefNo == null || full.tibBillSgRefNo == ''))
    	                                                        		items += actionItemSettleByDebit + actionItemSettleByImpLoan + actionItemSettleByOthers;
    	                                                        	else if(full.tibBillPmtTerms == 'DA' && full.tibAccepted == 'YES')
    	                                                        		items += actionItemSettleByDebit + actionItemSettleByImpLoan + actionItemSettleByOthers;
                                                           	}
                                                        	// Accept/Reject for Company approver
                                                        	if(productsActionSubmit.includes(product) && isPermitted(status, stateUserRolesActionImpBillsApprover))
                                                           	{
                                                        		if(full.tibBillPmtTerms == 'DP' && (full.tibBillSgRefNo == null || full.tibBillSgRefNo == '') && (full.tibAccepted == null || full.tibAccepted == ''))
    	                                                        	items += actionItemCompBillAccept + actionItemCompBillReject;
                                                        		else if(full.tibBillPmtTerms == 'DA' && (full.tibAccepted == null || full.tibAccepted == '')){
                                                        			if(full.tibBillSgRefNo == null || full.tibBillSgRefNo == '')
                                                        				items += actionItemCompBillAccept + actionItemCompBillReject;	
                                                        			else
                                                        				items += actionItemCompBillAccept;	
                                                        		}		
                                                           	}
                                                   		 
                                                   	} else {
                                                        if (status == "DRF") {//draft
                                                            if (productsActionDiscard.includes(product) && isPermitted(status, stateUserRolesActionDiscard)) {
                                                                items += actionItemDiscard;
                                                            }
                                                        	if(product == 'IMPST' || product == 'ISILN'||product == 'ISOTH'||product == 'ISDEB') {
                                                                items += actionItemDiscard + actionItemSubmitForAuth;
                                                        	}
                                                        } else if (status == "PCH") {//pending review
                                                            if (productsActionSubmitForAuth.includes(product) && isPermitted(status, stateUserRolesActionSubmitForAuth)) {
                                                                //items += actionItemSubmitForAuth;
                                                            }
                                                            if (productsActionReject.includes(product) && isPermitted(status, stateUserRolesActionReject)) {
                                                                items += actionItemReqMofification;
                                                            }
                                                        } else if (status == "PAU") {//pending auth
                                                            // TFAPP1-1131: Should show only view
                                                            // if (productsActionSubmit.includes(product) && isPermitted(status, stateUserRolesActionSubmit)) {
                                                            //     items += actionItemSubmit;
                                                            // }
                                                            // if (productsActionReject.includes(product) && isPermitted(status, stateUserRolesActionReject)) {
                                                            //     items += actionItemReqMofification;
                                                            // }
                                                        } else if (status == "APP") {
                                                            /* if (productsActionCancel.includes(product) && isPermitted(status, stateUserRolesActionCancel)) {
                                                                items += actionItemAmend;
                                                            } */
                                                            if (productsActionDuplicate.includes(product) && isPermitted(status, stateUserRolesActionDuplicate)) {
                                                                items += actionItemDuplicate;
                                                            }
                                                            if (productsActionViewGrouping.includes(product) && isPermitted(status, stateUserRolesActionViewGrouping)) {
                                                                items += actionViewGrouping;
                                                            }
                                                            // if (productsActionCancel.includes(product) && isPermitted(status, stateUserRolesActionCancel)) {
                                                            //     items += actionItemCancel;
                                                            // }
                                                            if (productsActionAmend.includes(product) && isPermitted(status, stateUserRolesActionAmend)) {
                                                                items += actionItemAmend;
                                                            }
                                                            
                                                            if (productsActionConvert.includes(product) && isPermitted(status, stateUserRolesActionConvert)) {
                                                                items += actionItemConvert;
                                                            }
                                                            if (productsActionExtension.includes(product) && isPermitted(status, stateUserRolesActionExtend) && !full.converted) {
                                                                items += actionItemExtend;
                                                            }

                                                        } else if (status == "AMD" || status == "REJ") {
                                                        	 if (productsActionDuplicate.includes(product) && isPermitted(status, stateUserRolesActionDuplicate)) {
                                                                 items += actionItemDuplicate;
                                                             }
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
                                                     if((product == "LCCAN") && ((status == "PCH")||(status == "PAU")||(status == "DRF"))) {
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
                                                    
													<c:when test="${ fn:contains(column, 'tibBankBic') }">
														<th><input type="text" id="search_j<%=j%>"
                                                                   class="form-control input-xs table-filter"
                                                                   style="width: 100%;" disabled="disabled"
                                                                   placeholder="<spring:message code='label.${column}'/>">
                                                        </th>
                                                        <% j++; %>                                                    
                                                    </c:when>

<%--                                                     <c:when test="${ fn:contains(column, 'Product') || fn:contains(column, 'product')}">
                                                        <th style="width:20px;">
															<script>console.log(${ fn:contains(column, 'Product') || fn:contains(column, 'product')})</script>
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
                                                    <c:when test="${ fn:contains(column, 'tibBillDiscrep') }">
                                                        <th style="width:20px;">
                                                            <select class="form-control table-filter-discrep-dropdown">
                                                                <option value="">All</option>
																<option value="YES"><spring:message code="label.importbill.flag.yes"/></option>
																<option value="NO"><spring:message code="label.importbill.flag.no"/></option>
																<option value="NA"><spring:message code="label.tfApplication.NA"/></option>
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
                                                    
													<c:when test="${ fn:contains(column, 'tibInitSettlement') }">
                                                        <th style="width:20px;">

                                                            <select class="form-control table-filter-initsettle-dropdown">
                                                                <option value="">All</option>
																<option value="YES"><spring:message code="label.importbill.flag.yes"/></option>
																<option value="NO"><spring:message code="label.importbill.flag.no"/></option>
                                                            </select>
                                                        </th>
                                                        <% j++; %>
                                                    </c:when>
                                                    
                                                    <c:when
                                                            test="${ fn:contains(column, 'Status') || fn:contains(column, 'status')}">
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

                                                    <c:when test="${ fn:contains(column, 'Submitted') || fn:contains(column, 'submitted')}">
                                                        <th>
                                                            <div class="input-group">
                                                                <input id="search_j7"
                                                                       class="form-control input-xs table-filter"
                                                                       style="width: 100%; background:white"
                                                                       placeHolder="<spring:message code='label.${column}'/>"
                                                                       autocomplete="off" readonly/>
                                                                <button type="button" onclick=""
                                                                        class="btn bg-transparent clear-input d-none"
                                                                        data-clear-input="search_j7"
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
                                                   
                                                    <c:when test="${ fn:contains(column, 'tibBillNotifyDt') }">
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

                                                    <c:when test="${ fn:contains(column, 'tibBillDueDt') }">
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
													<c:when test="${ fn:contains(column, 'tibBankBic') }">
														<th><input type="text" id="search_j<%=j%>"
                                                                   class="form-control input-xs table-filter"
                                                                   style="width: 100%;" disabled="disabled"
                                                                   placeholder="<spring:message code='label.${column}'/>">
                                                        </th>
                                                        <% j++; %>                                                    
                                                    </c:when>
<%--                                                     <c:when test="${ fn:contains(column, 'Product') || fn:contains(column, 'product')}">
                                                        <th style="width:20px;">
															<script>console.log(${ fn:contains(column, 'Product') || fn:contains(column, 'product')})</script>
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
													<c:when test="${ fn:contains(column, 'tibBillDiscrep') }">
                                                        <th style="width:20px;">
                                                            <select class="form-control table-filter-discrep-dropdown">
                                                                <option value="">All</option>
																<option value="YES"><spring:message code="label.importbill.flag.yes"/></option>
																<option value="NO"><spring:message code="label.importbill.flag.no"/></option>
																<option value="NA"><spring:message code="label.tfApplication.NA"/></option>
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
                                                    
													<c:when test="${ fn:contains(column, 'tibInitSettlement') }">
                                                        <th style="width:20px;">

                                                            <select class="form-control table-filter-initsettle-dropdown">
                                                                <option value="">All</option>
																<option value="YES"><spring:message code="label.importbill.flag.yes"/></option>
																<option value="NO"><spring:message code="label.importbill.flag.no"/></option>
                                                            </select>
                                                        </th>
                                                        <% i++; %>
                                                    </c:when>
                                                    
                                                    <c:when test="${ fn:contains(column, 'Status') || fn:contains(column, 'status')}">
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
	                                                                <input id="search_7"
	                                                                       class="form-control input-xs table-filter"
	                                                                       style="width: 100%; background:white"
	                                                                       placeHolder="<spring:message code='label.${column}'/>"
	                                                                       autocomplete="off" readonly/>
	                                                                <button type="button" onclick=""
	                                                                        class="btn bg-transparent clear-input d-none"
	                                                                        data-clear-input="search_7"
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
                                                    
                                                    <c:when test="${ fn:contains(column, 'tibBillNotifyDt') }">
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

                                                    <c:when test="${ fn:contains(column, 'tibBillDueDt') }">
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
		<tfap:action-discard/>
		<tfap:action-reject/>
		<tfap:action-submit/>
		<tfap:action-submit-for-auth/>
		<tfap:action-cancel/>
		<tfap:action-duplicate/>
		<tfap:action-amend/>
		<tfap:action-convert/>
        <tfap:action-extension/>
	</c:when>
	<c:when test="${modelName == 'tfImpBillSummary'}">
		<tfap:action-compbill-reject/>
	</c:when>
</c:choose>

<div class="modal fade text-left" id="modal_popup_group" tabindex="-1"
	role="dialog" aria-labelledby="popupGroupmyModalLabel17" style="display: none;"
	aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="popupGroupmyModalLabel17">
					<spring:message code="label.modal.title.invoices" />
				</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>

			<div class="modal-body" id="popupGroupModal">
					<div class="content-wrapper p-0">
			<div class="content-body">
				<section id="description" class="card">
				    <div class="card-header p-0">
							<div class="row">
								<div class="col-6">
									
								</div>
								
							
							</div>
						</div>
					<div class="card-content p-0">
							<div class="card-body p-0">
								<div class="card-text">
									<div class="row">

										<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
											<%@ include
												file="/WEB-INF/views/common/tfap_rf_html_datatable.jspf"%>
									
										<script type="text/javascript">
										//function test(id){
											var transId = "${tfApplication.tfTransaction.tfTran.ttfId}";
											
											
											var urlView${rfTable} = "<spring:url value='/tfApplication/receivable-finance/rfgroup/list/json'/>";
										
											
											var aoColumnsView${rfTable} = [ 
												
												
												{
													"mData" : "tfdsgGroupId",
													"sClass": "text-center",
												},
												{
													"mData" : "tfdsgCpBnkId",
													"sClass": "text-center",
													"mRender": function (data, type, full, row) {
														if(data == parseInt(data)) {
															data = parseInt(data);
														}
														return data;
													}
												},
												{
													"mData" : "tfdsgCpName",
													"sClass": "text-center",
													"mRender": function (data, type, full, row) {
														if(data == parseInt(data)) {
															data = parseInt(data);
														}
														return data;
													}
												},
												{
													"mData" :"tfdsgCpRelatedFlg",
													"bSortable": false,
													"sClass": "text-center",
													"mRender": function (data, type, full, row) {
														var isCheck = data == "Y" ? 'checked' : '';
														data = '<input type="checkbox" '+ isCheck +' disabled/>';
														return data;
													}
												},
												{
													"mData" : "ttdsgCpAddr",
													"sClass": "text-center",
													"mRender": function (data, type, full, row) {
														if(data == parseInt(data)) {
															data = parseInt(data);
														}
														return data;
													}
												},
												{
													"mData" : "tfdsgCcy",
													"sClass": "text-center"
												},
												{
													"mData" : "tfdsgTotAmt",
													"sClass": "text-center"
												},
												{
													"mData" : "tfdsgFinAmt",
													"sClass": "text-center",
													"mRender": function (data, type, full, row) {
														data = ('+'+data).replace('+-','-').replace('+0','0');
														return data;
													}
												}
												
											];
											
											/* if(id)
												$("#rfTable").DataTable().draw(); */
											
										/*  }
										test(); */
										
										</script>
									<div class="table-responsive">
										<table id="${rfTable}"
											class="table table-striped jambo_table bulk_action stripe">
											<thead>
												<tr class="table_header text-center">
													
													
													<th class="column-title"><spring:message
															code="label.rfGrp.grpId" /></th>
													
													
													<th class="column-title"><spring:message
															code="label.rfGrp.bnkBillToId" /></th>

													<th class="column-title"><spring:message
															code="label.rfGrp.bnkBillToName" /></th>
													
													<th class="column-title"><input type="checkbox" disabled><spring:message
															code="label.rfGrp.relatedParty" /></th>
															
													<th class="column-title"><spring:message
															code="label.rfGrp.invBillToAdd" /></th>
															
													<th class="column-title"><spring:message
															code="label.rfGrp.ccy" /></th>
															
													<th class="column-title"><spring:message
															code="label.rfGrp.totCcyAmt" /></th>
															
													 <th class="column-title"><spring:message
															code="label.rfGrp.aggrt" /></th>  
															
													
												</tr>
											</thead>
											<tbody></tbody>
													
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
					
				</div>
		
			<div class="modal-footer" style="margin-top: -20px;">
					<button type="button" class="btn btn-outline-primary mr-1"
						data-dismiss="modal">
						<spring:message code="label.modal.button.close" />
					</button>
					
			</div>
		</div>
</div>	
</div>

<script>

function popUpGroup(tfapId){

	urlView${rfTable} = rootUrl+'/receivable-finance/rfgroup/list/json?transId='+tfapId;
	$('#modal_popup_group').modal('show');

}



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