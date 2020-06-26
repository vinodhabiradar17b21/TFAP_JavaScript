<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@attribute name="fieldName" type="java.lang.String" required="true"%>
<%@attribute name="fieldKey" type="java.lang.String" required="true"%>
<%@attribute name="placeHolder" type="java.lang.String" required="false"%>
<%@attribute name="required" type="java.lang.Boolean" required="true"%>
<%@attribute name="futureDateNotReq" type="java.lang.Boolean" required="false"%>
<%@attribute name="pastDateNotReq" type="java.lang.Boolean" required="false"%>
<%@attribute name="pastCurDateNotReq" type="java.lang.Boolean" required="false"%>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false" %>
<%@attribute name="isdisabled" type="java.lang.Boolean" required="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@attribute name="btnId" type="java.lang.String" required="true"%>
<%@attribute name="fieldId" type="java.lang.Integer" required="true"%>
<%@attribute name="showLabel" type="java.lang.Boolean" required="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="fieldIndex"
	value="${(empty fieldIndex) ? 0 : fieldIndex}" />
<c:set var="showLabel"
	value="${(empty showLabel) ? true : showLabel}" />
	
<spring:bind path="${fieldName}">
	<div class="form-group ${status.error ? 'has-error' : ''}">
		<c:if test="${showLabel}">
			<label for="${fieldName}"><spring:message code="${fieldKey}" /></label>
		</c:if>
		<div class="input-group">
			<c:choose>
			<c:when test="${required}">
			<form:input id="${fieldName}" path="${fieldName}"
				cssErrorClass="border-danger form-control ${required ? 'required-date' : 'data-bg'}"
				cssClass="form-control ${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? '':'required-date'}"
				placeHolder="${not empty placeHolder ? placeHolder : '' }"
				disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}" autocomplete="off"/>
			</c:when>
			<c:otherwise>
			<form:input id="${fieldName}" path="${fieldName}"
				cssErrorClass="border-danger form-control ${required ? 'required-date' : 'data-bg'}"
				cssClass="form-control ${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? '':'data-bg'}"
				placeHolder="${not empty placeHolder ? placeHolder : '' }"
				disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}" autocomplete="off"/>
			</c:otherwise>
			</c:choose>
			
			<button type="button" onclick="" class="btn bg-transparent clear-input d-none" data-clear-input="${fieldName}" style="margin-left: -40px; z-index: 100;">
				<i class="fa fa-times"></i>
			</button>
			<%-- <div class="input-group-append">
				<button type="button" id="${btnId}${fieldId}"
					class="btn btn-primary" data-toggle="tooltip"
					data-placement="bottom"
					title="<spring:message code="label.tooltip.history"/>">
					<i class="fa fa-clock-o"> </i>
				</button>
			</div> --%>
		</div>
		<div id="${fieldName}_err" class="red d-none"></div>
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
<style>
.picker_2{
	z-index: 1052	
}
</style>
<script type="text/javascript">
$(document).ready(function() {
		
	var today = new Date();
	var tomorrow = new Date();
	tomorrow.setDate(today.getDate()+1);
	
	initializeDaterangePicker();
	
		function initializeDaterangePicker(){
			if($('input[name="${fieldName}"]').prop('disabled')){
				return;
			}
			$('input[name="${fieldName}"]').daterangepicker({
				<c:if test="${futureDateNotReq}">			
				maxDate: new Date,		
				</c:if>
				<c:if test="${pastDateNotReq}">	
				minDate: new Date,
				</c:if>
				<c:if test="${pastCurDateNotReq}">	
				minDate: tomorrow,
			    </c:if>
				format: 'YYYY-MM-DD',
				singleDatePicker : true,
				calender_style : "picker_2",
				showDropdowns: true,
			}, function(start, end, label) {
				$('[data-clear-input="${fieldName}"]').removeClass('d-none')
				this.element.change();
			});
		}	
		
		$('input[name="${fieldName}"]').tfapDateValidator({
			format : 1,
			errElem: $('[id="${fieldName}_err"]'),
			<c:if test="${futureDateNotReq}">			
				maxDate: new Date,			
			</c:if>
			<c:if test="${pastDateNotReq}">	
				minDate: new Date,
			</c:if>
			<c:if test="${pastCurDateNotReq}">	
			minDate: tomorrow,
		    </c:if>
			onError: function(){
				initializeDaterangePicker();
			}
		});
			
		
		
		$('[data-clear-input="${fieldName}"]').on('click', function(){
			$('input[name="${fieldName}"]').val('')
			$('[data-clear-input="${fieldName}"]').addClass('d-none')
			var element = document.getElementById('${fieldName}');
			var event = new Event('change');
			element.dispatchEvent(event);
			initializeDaterangePicker();
		});
			
		$('[id="${btnId}${fieldId}"]').on('click', function(e) {
			$('#${btnId}historytable${fieldId} tbody').empty();
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
								$tr = $('<tr>').append( 
										$('<td>').append($('<a>').text(item.tfdaTftIdAmmend).attr({'href': item.readUrl, 'target': '_blank'})),
										$('<td>').text(item.lastUpdatedDateStr), 
										$('<td>').html(item.tfdaDataPre),
										$('<td>').html(item.tfdaDataPost)
								).appendTo('#${btnId}historytable${fieldId}');
							});
						}
						
				  }

			});
			
			$('[id="${btnId}modals_amend${fieldId}"]').modal('show');
		});
});
	</script>
</spring:bind>
