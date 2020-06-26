<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<%@attribute name="fieldName" type="java.lang.String" required="true"%>
<%@attribute name="fieldKey" type="java.lang.String" required="true"%>
<%@attribute name="btnId" type="java.lang.String" required="true"%>
<%@attribute name="maxlength" type="java.lang.Boolean" required="false"%>
<%@attribute name="maxVal" type="java.lang.String" required="false"%>
<%@attribute name="required" type="java.lang.Boolean" required="true"%>
<%@attribute name="fieldId" type="java.lang.Integer" required="true"%>
<%@attribute name="fieldIndex" type="java.lang.Integer" required="false"%>
<%@attribute name="showLabel" type="java.lang.Boolean" required="false"%>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false" %>
<%@attribute name="isdisabled" type="java.lang.Boolean" required="false" %>

<c:set var="fieldIndex"
	value="${(empty fieldIndex) ? 0 : fieldIndex}" />
<c:set var="showLabel"
	value="${(empty showLabel) ? true : showLabel}" />
	
<style type="text/css">
.dataPost{
    border: none;
    background: transparent;
}
</style>
<spring:bind path="${fieldName}">
	<div class="form-group">
		<c:if test="${showLabel}">
			<label for="${fieldName}"><spring:message code="${fieldKey}" /></label>
		</c:if>
		<div class="input-group">
			<form:input id="${fieldName}" 
				path="${fieldName}" 
				cssErrorClass="border-danger form-control tfap-number-input ${not empty required && required ? 'required' : ''}" 
				cssClass="form-control tfap-number-input ${not empty required && required ? 'required' : ''}" 
				disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}"
				placeHolder="${not empty placeHolder ? placeHolder : '' }" 
				maxlength="${not empty maxVal && maxlength ? maxVal : ''}"
				value="${not empty value ? value : '' }"/>

			<div class="input-group-append">
				<button type="button" id="${btnId}${fieldId}" class="btn btn-primary"  data-toggle="tooltip" data-placement="bottom" title="<spring:message code="label.tooltip.history"/>">
					<i class="fa fa-clock-o"> </i>
				</button>
			</div>
			
		</div>
		<form:errors path="${fieldName}" class="red" />
	</div>
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
$(document).ready(function(){	
	
	$('.tfap-number-input').on('keypress', tfapNumberInputOnKeyPress);
	$('.tfap-number-input').on('change', tfapNumberInputOnChange);
})

function tfapNumberInputOnKeyPress(evt){
	console.log('keypress')
	var charCode = (evt.which) ? evt.which : evt.keyCode
	if ((charCode >= 48 && charCode <= 57)) {
		return true;
	}else{
		return false;
	}
}

function tfapNumberInputOnChange(evt){
	console.log('change')
	if(/[^\d]/.test($(this).val())){
		$(this).val('')
	}
}

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
						if(item.tfdaDataPre.length > 100 || item.tfdaDataPost.length > 100){
							$tr = $('<tr>').append( $('<td>').append($('<a>').text(item.tfdaTftIdAmmend).attr({'href': item.readUrl, 'target': '_blank'})),
									$('<td>').text(item.lastUpdatedDateStr), 
									$('<td>').append($('<textarea class="dataPost" disabled= "true" cols="65" rows="10"> ').text(item.tfdaDataPre)),
									$('<td>').append($('<textarea class="dataPost" disabled= "true" cols="65" rows="10"> ').text(item.tfdaDataPost))).appendTo('#${btnId}historytable${fieldId}');
							
						}
						else{
						$tr = $('<tr>').append( $('<td>').append($('<a>').text(item.tfdaTftIdAmmend).attr({'href': item.readUrl, 'target': '_blank'})),
								$('<td>').text(item.lastUpdatedDateStr), $('<td>').html(item.tfdaDataPre),
								$('<td>').html(item.tfdaDataPost)).appendTo('#${btnId}historytable${fieldId}');
						}
					});
				}
				
		  }

	});
	
	$('[id="${btnId}modals_amend${fieldId}"]').modal('show');
});

</script>
</spring:bind>
