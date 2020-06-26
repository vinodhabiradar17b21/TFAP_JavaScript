<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<%@attribute name="fieldName" type="java.lang.String" required="true"%>
<%@attribute name="fieldKey" type="java.lang.String" required="true"%>
<%@attribute name="fieldId" type="java.lang.String" required="true"%>
<%@attribute name="required" type="java.lang.Boolean" required="true"%>
<%@attribute name="tableName" type="java.lang.String" required="false"%>
<%@attribute name="searchId" type="java.lang.String" required="true"%>
<%@attribute name="maxlength" type="java.lang.Boolean" required="false"%>
<%@attribute name="maxVal" type="java.lang.String" required="false"%>
<%@attribute name="serviceUrl" type="java.lang.String" required="false"%>
<%@attribute name="rootUrlName" type="java.lang.String" required="false"%>
<%@attribute name="label" type="java.lang.String" required="false"%>
<%@attribute name="value" type="java.lang.String" required="false"%>
<%@attribute name="callback" required="false"%>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false"%>
<%@attribute name="isdisabled" type="java.lang.Boolean" required="false"%>
<%@attribute name="smartSearchIndex" type="java.lang.String" required="false"%>

<c:set var="addTable" value="addDataAccn"/>
<c:set var="tableName"
	value="${(empty tableName) ? 'dataTableHs' : tableName}" />
<c:set var="label"
	value="${(empty label) ? ' ' : label}" />
<c:set var="value"
	value="${(empty value) ? ' ' : value}" />
<spring:bind path="${fieldName}">
	<div class="form-group">
		<label for="${fieldName}"><spring:message code="${fieldKey}" /></label>
		<div class="input-group">
			
			<tfap:tfapautocompleteinput fieldId="${fieldId}"
				serviceUrl="${serviceUrl}" fieldName="${fieldName}"
				maxVal="${maxVal}" maxlength="${maxlength}" required="true"
				disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}" label="${label}" value="${value}" callback="${callback}" smartSearchIndex="${smartSearchIndex}"/>
			<div class="input-group-append">
				
				<button type="button" id="${searchId}plus" class="btn btn-primary"
					data-toggle="modal" data-target="#${addTable}Modal"  data-placement="bottom"
					${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'disabled':''}>
					<i class="fa fa-plus"></i>
				</button>
				
			<!-- 	end pop up window -->
				
				
				<button type="button" id="${searchId}search" class="btn btn-primary"
					data-toggle="modal" data-target="#${tableName}Modal"
					data-placement="bottom" title=""
					data-original-title="Search Beneficiary Name"
					${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'disabled':''}>
					<i class="fa fa-search"> </i>
				</button>
				
			</div>
		</div>
		<form:errors path="${fieldName}" class="red" />
	</div>
	<div class="modal fade" id="${tableName}Modal" role="dialog">
		<div class="modal-dialog  modal-lg">
			<!-- Modal content-->
			<div class="modal-content">
				<tfap:pagetablebenf titleKey="label.beneficiary.benNamePopUpHeader"
					breadCrumbKey="label.beneficiary.benNamePopUpHeader"
					modelName="tfApplication" model="${tfApplication}"
					tableName="${tableName}" isadvanced="${false}" rootUrlName="${rootUrlName}">
				</tfap:pagetablebenf>
				<div class="modal-footer">
					<button type="button" class="btn btn-info " data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	$(document).ready( function() {
		$('#${tableName} tbody').on('click', 'tr', function() {
			var row = $("#${tableName}").DataTable().row($(this)).data();
			${callback}(row);
			$('#${tableName}Modal').modal('hide');
			$('#${fieldId}').val(row.tfacpName).change();

		});
		
		$(document).ready( function() {
			$('#${tableName}Modal').on('shown.bs.modal',function() {
				$.each($('#${tableName}').find('[id*="search_"]'), function(index, value) { 
					$(this).val('');
				});
				
				clear${tableName}DataTableFilter();
					
			});
			
			$('#${addTable}Modal').on(	'hide.bs.modal',function() {
				if(window.clicked${addTable}Btn == '${searchId}' && window.addNewBenfSuccess){
					var row = {
							tfacpName:$('#tfacpName').val(),
							tfacpTel: $('#tfacpTel').val(),
							tfacpEmail:$('#tfacpEmail').val(),
							tMstCountry:$('#tMstCountry').val(),
							tfacpAddr1:$('#tfacpAddr1').val(),
							tfacpAddr2:$('#tfacpAddr2').val(),
							tfacpAddr3:$('#tfacpAddr3').val(),
							tfacpPriConName:$('#tfacpPriConName').val()
					};
					${callback}(row);
					clicked${addTable}Btn =='';
				}
			});
			
		});
		
		
		$('#${searchId}plus').click(function(){
			window.clicked${addTable}Btn='${searchId}';				
			$.get("/TFAPortal/principleaccount/beneficiary/create", function(data, status) {
				$("#addNewModal").html(data);
			});
			
		});
		
		
		$('#${searchId}search').click(function() {
			//$('#${tableName}').DataTable().draw();
		});
	});
	</script>
</spring:bind>