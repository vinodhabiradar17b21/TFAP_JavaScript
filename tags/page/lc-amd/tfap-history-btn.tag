<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@attribute name="btnId" type="java.lang.String" required="true"%>
<%@attribute name="fieldText" type="java.lang.String" required="false"%>
<%@attribute name="fieldId" type="java.lang.Integer" required="true"%>
<%@attribute name="fieldIndex" type="java.lang.Integer" required="false"%>

<c:set var="fieldIndex" value="${(empty fieldIndex) ? 0 : fieldIndex}" />
<c:set var="fieldText" value="${(empty fieldText) ? '' : fieldText}" />
	
<button type="button" id="${btnId}${fieldId}" class="btn btn-primary" data-toggle="tooltip" data-placement="bottom" title="<spring:message code="label.tooltip.history"/>">
	<i class="fa fa-clock-o"> </i>
</button>

<tfap:modal button_name="label.modal.button.close"
	modal_title_prefix="${fieldText}"
	modal_title="label.modal.title.amendment"
	modal_Id="${btnId}modals_amend${fieldId}" primary_btn_id="modal_dis_primary"
	modal_size="lg">
	<div class="content-wrapper">
		<div class="table-responsive">
			<table class="table table-striped jambo_table bulk_action stripe"
				id="${btnId}historytable${fieldId}">
				<thead>
					<tr class="table_header">
						<th class="column-title" style="width: 14%"><spring:message
								code="label.modal.table.history.tfid" /></th>
						<th class="column-title" style="width: 18%"><spring:message
								code="label.modal.table.history.date" /></th>
						<th class="column-title" style="width: 34%"><spring:message
								code="label.modal.table.history.before" /></th>
						<th class="column-title" style="width: 34%"><spring:message
								code="label.modal.table.history.after" /></th>
					</tr>

				</thead>
				<tbody></tbody>

			</table>
		</div>
	</div>
</tfap:modal>

<script type="text/javascript">

$('[id="${btnId}${fieldId}"]').on('click',function() {
	$('#${btnId}historytable${fieldId} tbody tr').empty();
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
					$tr = $('<tr>').append('<td colspan="4" class="text-center"><spring:message code="label.no.amendment.log"/></td>').appendTo('#${btnId}historytable${fieldId}');
				}else {				
					$.each(response.aaData, function(i, item) {
						$tr = $('<tr>').append( $('<td>').append($('<a>').text(item.tfdaTftIdAmmend).attr({'href': item.readUrl, 'target': '_blank'})),
								$('<td>').text(item.lastUpdatedDateStr), $('<td>').html(item.tfdaDataPre),
								$('<td>').html(item.tfdaDataPost)).appendTo('#${btnId}historytable${fieldId}');
					});
				}
				
		  }

	});
	
	$('[id="${btnId}modals_amend${fieldId}"]').modal('show');
});

</script>