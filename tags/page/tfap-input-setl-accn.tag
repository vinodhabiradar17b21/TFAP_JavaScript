<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<%@attribute name="fieldName" type="java.lang.String" required="true"%>
<%@attribute name="fieldKey" type="java.lang.String" required="true"%>
<%@attribute name="fieldId" type="java.lang.String" required="true"%>
<%@attribute name="required" type="java.lang.Boolean" required="true"%>
<%@attribute name="searchId" type="java.lang.String" required="false"%>
<%@attribute name="maxlength" type="java.lang.Boolean" required="false"%>
<%@attribute name="maxVal" type="java.lang.String" required="false"%>
<%@attribute name="serviceUrl" type="java.lang.String" required="false"%>
<%@attribute name="rootUrlName" type="java.lang.String" required="false"%>
<%@attribute name="placeHolder" type="java.lang.String" required="false"%>
<%@attribute name="callback" required="false"%>

<%@attribute name="label" type="java.lang.String" required="false"%>
<%@attribute name="value" type="java.lang.String" required="false"%>
<%@attribute name="disabledfield" type="java.lang.Boolean" required="false"%>
<%@attribute name="smartSearchIndex" type="java.lang.String" required="false"%>
<%@attribute name="overrideDisableMode" type="java.lang.Boolean" required="false"%>

<c:set var="label"
	value="${(empty label) ? ' ' : label}" />
<c:set var="value"
	value="${(empty value) ? ' ' : value}" />
<c:set var="disabledfield"
	value="${(empty disabledfield) ? ' ' : disabledfield}" />
	
<c:set var="tableName"	value="dataTableCoyAccn" />
<c:set var="addTable" value="addDataAccn"/>
<spring:bind path="${fieldName}">
	<div class="form-group">
		<label for="${fieldName}"><spring:message code="${fieldKey}" /></label>
		
		<c:choose>
		<c:when test="${not empty disabledfield && disabledfield}">
		<div class="input-group">
			<tfap:tfapautocompleteinput fieldId="${fieldId}"
				serviceUrl="${serviceUrl}" fieldName="${fieldName}"
				maxVal="${maxVal}" maxlength="${maxlength}" required="${required}"
				disabled="true" label="${label}" value="${value}" callback="${callback}" smartSearchIndex="${smartSearchIndex}"/>
			
			<div class="input-group-append">
				<button type="button" id="${searchId}plus" class="btn btn-primary"
					data-toggle="modal" data-target="#${addTable}Modal"  data-placement="bottom" 
					disabled>
					<i class="fa fa-plus"></i>
				</button>
				<button type="button" id="${searchId}" class="btn btn-primary"
					data-toggle="modal" data-target="#${tableName}Modal"
					disabled>
					<i class="fa fa-search"> </i>
				</button>
			</div>
		</div>
		</c:when>
		
		<c:otherwise>
		<div class="input-group">
			<tfap:tfapautocompleteinput fieldId="${fieldId}"
				serviceUrl="${serviceUrl}" fieldName="${fieldName}"
				maxVal="${maxVal}" maxlength="${maxlength}" required="${required}"
				disabled="${(overrideDisableMode) ? 'false' : ((not empty isDisabled && isDisabled) || (not empty isdisabled && isdisabled)) ? 'true' : 'false'}" label="${label}" value="${value}" callback="${callback}" smartSearchIndex="${smartSearchIndex}"/>
			
			<div class="input-group-append">
				
				<button type="button" id="${searchId}plus" class="btn btn-primary"
					data-toggle="modal" data-target="#${addTable}Modal"  data-placement="bottom" data-backdrop="static"
					${(overrideDisableMode) ? '' : ((not empty isDisabled && isDisabled) || (not empty isdisabled && isdisabled)) ? 'disabled' : ''}>
					<i class="fa fa-plus"></i>
				</button>
				
				<button type="button" id="${searchId}" class="btn btn-primary"
					data-toggle="modal" data-target="#${tableName}Modal" data-backdrop="static"
					${(overrideDisableMode) ? '' : ((not empty isDisabled && isDisabled) || (not empty isdisabled && isdisabled)) ? 'disabled' : ''}>
					<i class="fa fa-search"> </i>
				</button>
			</div>
		</div>
		</c:otherwise>
		</c:choose>
		
		<form:errors path="${fieldName}" class="red" />
	</div>

	<script type="text/javascript">

		$(document).ready( function() {
			$('#${tableName} tbody').on('click', 'tr', function() {
				if(window.clicked${tableName}Btn == '${searchId}'){
					var row = $("#${tableName}").DataTable().row($(this)).data();
					${callback}(row);
					window.clicked${tableName}Btn = '';
					$('#${tableName}Modal').modal('hide');
					$('#${fieldId}').val(row.tfabBnkAccn).change();
				}
			});
			
			$('#${tableName}Modal').on(	'shown.bs.modal',function() {
				if(window.clicked${tableName}Btn == '${searchId}'){
					$.each($('#${tableName}').find('[id*="search_"]'), function(index, value) { 
						$(this).val('');
					});
					clear${tableName}DataTableFilter();
				}
			});
			
			$('#${addTable}Modal').on(	'hide.bs.modal',function() {
				if(window.clicked${addTable}Btn == '${searchId}' && window.addNewBnkAccnSuccess){
					var row = {
							tfabBnkAccn: $('#tfabBnkAccn').val(),
							tfabCcy:$('#tfabCcy').val()
					};
					${callback}(row);
					clicked${addTable}Btn =='';
				}
			});
			$('#${searchId}').click(function() {
				window.clicked${tableName}Btn = '${searchId}';
			});

			$('#${searchId}plus').click(function(){
				window.clicked${addTable}Btn='${searchId}';				
				$.get("/TFAPortal/principleaccount/principleAccn/create", function(data, status) {
					$("#addNewModal").html(data);
				});
				
			});
			
		});

	</script>
</spring:bind>