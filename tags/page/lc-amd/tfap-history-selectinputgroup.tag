<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<%@attribute name="fieldName" type="java.lang.String" required="true"%>
<%@attribute name="fieldKey" type="java.lang.String" required="true"%>
<%@attribute name="fieldName2" type="java.lang.String" required="true"%>
<%@attribute name="fieldId" type="java.lang.Integer" required="true"%>
<%@attribute name="maxlength" type="java.lang.Boolean" required="false" %>
<%@attribute name="maxVal" type="java.lang.String" required="false" %>
<%@attribute name="placeHolder" type="java.lang.String" required="false" %>
<%@attribute name="selectFieldDescription" type="java.lang.String" required="false" %>
<%@attribute name="required" type="java.lang.String" required="false" %>
<%@attribute name="groupText" type="java.lang.String" required="false" %>
<%@attribute name="items"  type="java.lang.Object" required="false" %>
<%@attribute name="btnId" type="java.lang.String" required="true"%>
<%@attribute name="textInput"  type="java.lang.Object" required="false" %>

<c:set var="fieldIndex" value="${(empty fieldIndex) ? 0 : fieldIndex}" />


<spring:bind path="${fieldName}">

	<div class="form-group ${status.error ? 'has-error' : ''} group-validation">
	
		<c:if test="${not empty fieldKey}">
			<label for="${fieldName}"><spring:message code="${fieldKey}"/></label>
		</c:if>
		
		<div class="input-group" >
				
			<form:input 
				id="${fieldName}" 
				path="${fieldName}" 
				cssErrorClass="border-danger form-control  ${not empty required && required ? 'required' : ''}" 
				cssClass="form-control  ${not empty required && required ? 'required' : ''}" 
				disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}"
				placeHolder="${not empty placeHolder ? placeHolder : '' }" 
				maxlength="${not empty maxVal && maxlength ? maxVal : ''}"/>				
			
			<c:if test="${not empty groupText}">
				<div class="input-group-append">
					<span class="input-group-text">
						<spring:message code="${groupText}"/>
					</span>
				</div>
			</c:if>
			
				<div class="input-group-append mobil-v">
	
				<spring:message 
					code='${fieldKey}' 
					var="fieldDescription" />
					
				<div class="${status.error ? 'has-error' : ''}">

					<form:select 
						id="${fieldName2}" 
						path="${fieldName2}"
						cssErrorClass="border-danger form-control ${required ? 'required' : ''}"
						cssClass="form-control ${required ? 'required' : ''}"
						disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}">
						
						<spring:message code='${selectFieldDescription}' var="selectfieldLabel"/>
						<form:option 
							value="" 
							label="${selectfieldLabel}"/>
						<form:options 
							items="${items}" />
					</form:select>
							
				</div>	
			</div>
			<%-- <div class="input-group-append">
				<button type="button" id="${btnId}" class="btn btn-primary" data-toggle="tooltip" data-placement="bottom" title="<spring:message code="label.tooltip.history"/>">
					<i class="fa fa-clock-o"> </i>
				</button>
				</div> --%>
		</div>
		<div class="group-validation">
			<form:errors path="${fieldName}" class="red" />
			<form:errors path="${fieldName2}" class="red" />
		</div>
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
		
		$(document).ready(function(){	
			if(${empty textInput || !textInput}){

				$('input[name="${fieldName}"]').on('keypress', function(evt){
					var charCode = (evt.which) ? evt.which : evt.keyCode
					if ((charCode >= 48 && charCode <= 57)) {
						return true;
					}else{
						return false;
					}
				})
				
				$('input[name="${fieldName}"]').on('change', function(evt){
					if(/[^\d]/.test($(this).val())){
						$(this).val('')
					}
				})
			}
			
			$("#${btnId}").click(function() {
			
				$('#${btnId}historytable tbody tr').empty();
				
				$.ajax({
					  url: "/TFAPortal/principleaccount/history",
					  type: "get", //send it through get method
					  data: { 
					    fieldId:${fieldId},
					    ttfId:"${tfApplication.tfTransaction.tfTran.tftRelatedTftId}",
					    index : ${fieldIndex}
					  },
					  success: function(data) {
						  //console.log("Data: " + data + "\nStatus: " + status);
							response = $.parseJSON(data);
							//console.log(response.aaData.length);
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