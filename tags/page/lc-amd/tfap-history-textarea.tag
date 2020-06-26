<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@attribute name="fieldName" type="java.lang.String" required="true"%>
<%@attribute name="fieldKey" type="java.lang.String" required="true"%>
<%@attribute name="btnId" type="java.lang.String" required="true"%>
<%@attribute name="fieldId" type="java.lang.Integer" required="true"%>
<%@attribute name="maxlength" type="java.lang.Boolean" required="false"%>
<%@attribute name="maxVal" type="java.lang.String" required="false"%>
<%@attribute name="required" type="java.lang.Boolean" required="true"%>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false" %>
<%@attribute name="isdisabled" type="java.lang.Boolean" required="false" %>
<%@attribute name="requireDetails" type="java.lang.Boolean" required="false" %>
<%@attribute name="maxLines" type="java.lang.Integer" required="false" %>
<%@attribute name="maxLengthOfLine" type="java.lang.Integer" required="false" %>

<c:set var="fieldIndex" value="${(empty fieldIndex) ? 0 : fieldIndex}" />

<style type="text/css">
.dataPost{
    border: none;
    background: transparent;
}
</style>
<spring:bind path="${fieldName}">
	<div class="form-group">
		<label for="${fieldName}"><spring:message code="${fieldKey}" /></label>
		<div class="input-group history-btn-textarea">
			<form:textarea id="${fieldName}" path="${fieldName}" rows="3"
				cssErrorClass="border-danger form-control ${required ? 'required' : ''}"
				cssClass="form-control ${required ? 'required' : ''}"
				disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}"
				maxlength="${not empty maxVal && maxlength ? maxVal : ''}" />
			<button type="button" id="${btnId}" class="btn btn-primary" data-toggle="tooltip" data-placement="bottom" title="<spring:message code="label.tooltip.history"/>">
				<i class="fa fa-clock-o"> </i>
			</button>
		</div>
		<c:if test= "${requireDetails}">
		<p class="mb-0 text-right">
			<span id="${fieldName}_char">0</span> characters remaining | <span id="${fieldName}_line">0</span> lines remaining
		</p>
		</c:if>
		<form:errors path="${fieldName}" class="red" />
	</div>
	<tfap:modal button_name="label.modal.button.close"
	modal_title_prefix="${fieldKey}"
	modal_title="label.modal.title.amendment" modal_Id="${btnId}modals_amend"
	primary_btn_id="modal_dis_primary" modal_size="xl">
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
								$('<td>').text(item.lastUpdatedDateStr),
								$('<td>').append($('<textarea class="dataPost" disabled= "true" cols="65" rows="10"> ').text(item.tfdaDataPre)),
								$('<td>').append($('<textarea class="dataPost" disabled= "true" cols="65" rows="10"> ').text(item.tfdaDataPost))).appendTo('#${btnId}historytable');
					});
				}
				
		  }

	});
	
	$('#${btnId}modals_amend').modal('show');
});
</script>
<c:if test= "${requireDetails}">
	<script>
		$(document).ready(function() {
			$('[id="${fieldName}"]').tfapTextareaManipulator({
				maxLines : ${maxLines},
				maxLengthOfLine : ${maxLengthOfLine},
				charCountElem : $('[id="${fieldName}_char"]'),
				lineCountElem : $('[id="${fieldName}_line"]')
			});
		});
	</script>
</c:if>
</spring:bind>
