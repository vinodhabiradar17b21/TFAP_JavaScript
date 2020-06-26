<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@attribute name="fieldName" type="java.lang.String" required="true"%>
<%@attribute name="fieldKey" type="java.lang.String" required="true"%>
<%@attribute name="btnId" type="java.lang.String" required="true"%>
<%@attribute name="maxlength" type="java.lang.Boolean" required="false"%>
<%@attribute name="maxVal" type="java.lang.String" required="false"%>
<%@attribute name="options" type="java.lang.Object" required="true"%>
<%@attribute name="required" type="java.lang.Boolean" required="true"%>
<%@attribute name="fieldId" type="java.lang.Integer" required="true"%>

<c:set var="fieldIndex" value="${(empty fieldIndex) ? 0 : fieldIndex}" />

<spring:bind path="${fieldName}">
	
		<label for="${fieldName}"><spring:message code="${fieldKey}" /></label>
		<div class="space_input">
			<tfap:tfapselect options="${options}"
				fieldName="${fieldName}"
				fieldKey="${fieldKey}"
				required="${required}" isDisabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}"/>

			<%-- <div class="input-group-append">
				<button type="button" id="${btnId}" class="btn btn-primary" data-toggle="tooltip" data-placement="bottom" title="<spring:message code="label.tooltip.history"/>">
					<i class="fa fa-clock-o"> </i>
				</button>
			</div> --%>
		</div>
	
	<tfap:modal button_name="label.modal.button.close"
	modal_title_prefix="${fieldKey}"
	modal_title="label.modal.title.amendment" modal_Id="${btnId}modals_amend"
	primary_btn_id="modal_dis_primary" modal_size="lg">
	<div class="content-wrapper">
		<div class="table-responsive">
			<table class="table table-striped jambo_table bulk_action stripe" id="${btnId}historytable">
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
</script>
</spring:bind>




