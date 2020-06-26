<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<%@attribute name="fieldName" type="java.lang.String" required="true"%>
<%@attribute name="fieldKey" type="java.lang.String" required="true"%>
<%@attribute name="fields" type="java.lang.String" required="true"%>
<%@attribute name="fieldId" type="java.lang.Integer" required="true"%>
<%@attribute name="required" type="java.lang.Boolean" required="true"%>
<%@attribute name="searchId" type="java.lang.String" required="false"%>
<%@attribute name="maxlength" type="java.lang.Boolean" required="false"%>
<%@attribute name="maxVal" type="java.lang.String" required="false"%>
<%@attribute name="placeHolder" type="java.lang.String" required="false"%>
<%@attribute name="callback" required="false"%>
<%@attribute name="searchIndex" type="java.lang.String" required="false"%>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false"%>
<%@attribute name="isdisabled" type="java.lang.Boolean" required="false"%>
<%@attribute name="label" type="java.lang.String" required="false"%>
<%@attribute name="value" type="java.lang.String" required="false"%>
<%@attribute name="serviceUrl" type="java.lang.String" required="false"%>
<%@attribute name="btnId" type="java.lang.String" required="true"%>
<%@attribute name="fieldIndex" type="java.lang.Integer" required="false"%>

<c:set var="fieldIndex"
	value="${(empty fieldIndex) ? 0 : fieldIndex}" />
<c:set var="searchIndex"
	value="${(empty searchIndex) ? '0' : searchIndex}" />
<c:set var="label"
	value="${(empty label) ? ' ' : label}" />
<c:set var="value"
	value="${(empty value) ? ' ' : value}" />
	
<c:set var="tableName"	value="dataTableBnkBic" />
<spring:bind path="${fieldName}">
	<div class="form-group">
		<label for="${fieldName}"><spring:message code="${fieldKey}" /></label>
		<div class="input-group">
			<tfap:tfapautocompleteinput fieldId="${fields}"
				searchIndex="${searchIndex}"
				serviceUrl="${serviceUrl}" fieldName="${fieldName}"
				maxVal="${maxVal}" maxlength="${maxlength}" required="${required}"
				placeHolder="${not empty placeHolder ? placeHolder : '' }"
				disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}" label="${label}" value="${value}" callback="${callback}"/>
			<div class="input-group-append">
				<button type="button" id="${searchId}" class="btn btn-primary"
					data-toggle="modal" data-target="#${tableName}Modal"
					${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'disabled':''}>
					<i class="fa fa-search"> </i>
				</button>
			</div>
<!--  			<div class="input-group-append">
				<button type="button" id="${btnId}" class="btn btn-primary" data-toggle="tooltip" data-placement="bottom" title="<spring:message code="label.tooltip.history"/>">
					<i class="fa fa-clock-o"> </i>
				</button>
			</div>
-->		</div>
		<form:errors path="${fieldName}" class="red" />
	</div>
	<tfap:modal button_name="label.modal.button.close"
		modal_title_prefix="${fieldKey}"
		modal_title="label.modal.title.amendment" modal_Id="${btnId}modals_amend"
		primary_btn_id="modal_dis_primary" modal_size="lg">
		<div class="content-wrapper">
			<div class="table-responsive">
				<table class="table table-striped jambo_table bulk_action stripe"
					id="${btnId}historytable">
					<thead>
						<tr class="table_header">
							<th class="column-title"><spring:message
									code="label.modal.table.history.tfid" /></th>
							<th class="column-title"><spring:message
									code="label.modal.table.history.date" /></th>
							<th class="column-title"><spring:message
									code="label.modal.table.history.before" /></th>
							<th class="column-title"><spring:message
									code="label.modal.table.history.after" /></th>
						</tr>

					</thead>
					<tbody></tbody>

				</table>
			</div>
		</div>
	</tfap:modal>

	<script type="text/javascript">
		
	
		$(document).ready(function() {
			$('#${tableName} tbody').on('click', 'tr', function() {
				if(window.clicked${tableName}Btn == '${searchId}'){
					var row = $("#${tableName}").DataTable().row($(this)).data();
					${callback}(row);
					window.clicked${tableName}Btn = '';
					$('#${tableName}Modal').modal('hide');
				}
			});
			
			$('#${tableName}Modal').on('shown.bs.modal', function() {
				if(window.clicked${tableName}Btn == '${searchId}'){
					$.each($('#${tableName}').find('[id*="search_"]'), function(index, value) { 
						$(this).val('');
					});
					clear${tableName}DataTableFilter();				
				}
			});
			
			$('#${searchId}').click(function() {
				window.clicked${tableName}Btn = '${searchId}';
			});
						
			
			$("#${btnId}").click(function() {
				$('#${btnId}historytable tbody tr').empty();
				$.ajax({
					  url: "/TFAPortal/principleaccount/history",
					  type: "get",
					  data: { 
					    fieldId:${fieldId},
					    ttfId:"${tfApplication.tfTransaction.tfTran.tftRelatedTftId}",
					    index : ${fieldIndex}
					  },
					  success: function(data) {
							response = $.parseJSON(data);
							var $tr;
							
							if(response.aaData.length == 0 ){
								$tr = $('<tr>').append('<td colspan="4" class="text-center"><spring:message code="label.no.amendment.log"/></td>').appendTo('#${btnId}historytable');
							}else {				
								$.each(response.aaData, function(i, item) {
									$tr = $('<tr>').append( $('<td>').append($('<a>').text(item.tfdaTftIdAmmend).attr({'href': item.readUrl, 'target': '_blank'})),
											$('<td>').text(item.lastUpdatedDateStr), $('<td>').text(item.tfdaDataPre),
											$('<td>').text(item.tfdaDataPost)).appendTo('#${btnId}historytable');
								});
							}
							
					  }

				});

				$('#${btnId}modals_amend').modal('show');
			});
		});
		
	</script>
</spring:bind>