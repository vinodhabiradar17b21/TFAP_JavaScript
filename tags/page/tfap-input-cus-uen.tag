<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<%@attribute name="fieldKey" type="java.lang.String" required="true"%>
<%@attribute name="fieldName" type="java.lang.String" required="true"%>
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
			<spring:message code="label.product.link.placeholder" var="productLinkPlaceholder"/>
			<tfap:tfapautocompleteinput fieldId="${fieldId}"
				serviceUrl="${serviceUrl}" fieldName="${fieldName}"
				maxVal="${maxVal}" maxlength="${maxlength}" required="true"
				disabled="${isDisabled}" placeHolder="${productLinkPlaceholder}" readonly="true"
				label="${label}" value="${value}" callback="${callback}" smartSearchIndex="${smartSearchIndex}"/>
			<div class="input-group-append">
				<button type="button" id="${searchId}search" class="btn btn-primary"
					data-toggle="modal" data-target="#${tableName}Modal"
					data-placement="bottom" title=""
					data-original-title="Search Company UEN"
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
				<tfap:pagetableuen titleKey="label.product.customer.uenPopUpHeader"
					breadCrumbKey="label.product.customer.uenPopUpHeader"
					modelName="tfApplication" model="${tfApplication}"
					tableName="${tableName}" isadvanced="${false}" rootUrlName="${rootUrlName}">
				</tfap:pagetableuen>
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
			var s= $('#${fieldId}').val();
			$('#${tableName}Modal').modal('hide');
				$('#${fieldId}').val(row.accCoyRegn).change();
				$('#accName').val(row.accName);

		});
		
		$('#${tableName}Modal').on('shown.bs.modal',function() {
			$.each($('#${tableName}').find('[id*="search_"]'), function(index, value) { 
				$(this).val('');
			});
			
			clear${tableName}DataTableFilter();
				
		});
		
		$('#${addTable}Modal').on(	'hide.bs.modal',function() {
			if(window.clicked${addTable}Btn == '${searchId}' && window.addNewBenfSuccess){
				var row = {
						accCoyRegn:$('#accCoyRegn').val(),
						accName:$('#accName').val()						
				};
				${callback}(row);
				clicked${addTable}Btn =='';
			}
		});
				
			
		$('#${searchId}search').click(function() {
			$('#${tableName}').DataTable().draw();
		});
	});
	</script>
</spring:bind>