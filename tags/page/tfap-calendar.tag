<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@attribute name="fieldName" type="java.lang.String" required="true"%>
<%@attribute name="fieldKey" type="java.lang.String" required="false"%>
<%@attribute name="fieldId" type="java.lang.String" required="true"%>
<%@attribute name="placeHolder" type="java.lang.String" required="false"%>
<%@attribute name="required" type="java.lang.Boolean" required="true"%>
<%@attribute name="futureDateNotReq" type="java.lang.Boolean" required="false"%>
<%@attribute name="pastDateNotReq" type="java.lang.Boolean" required="false"%>
<%@attribute name="pastCurDateNotReq" type="java.lang.Boolean" required="false"%>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false" %>
<%@attribute name="isdisabled" type="java.lang.Boolean" required="false" %>
<%@attribute name="infoContent" type="java.lang.String" required="false" %>

<spring:bind path="${fieldName}">
	<div class="form-group ${status.error ? 'has-error' : ''}">
		<c:if test="${not empty fieldKey}">
			<label for="${fieldName}"><spring:message code="${fieldKey}" /></label>
		</c:if>
		<div class="input-group">
			<c:choose>
			<c:when test="${required}">
			<form:input id="${fieldName}" path="${fieldName}" readonly="true"
				cssErrorClass="border-danger form-control ${required ? 'required-date' : 'data-bg'}"
				cssClass="form-control ${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? '':'required-date'}"
				placeHolder="${not empty placeHolder ? placeHolder : '' }"
				disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}" autocomplete="off"/>
			</c:when>
			<c:otherwise>
			<form:input id="${fieldName}" path="${fieldName}" readonly="true"
				cssErrorClass="border-danger form-control ${required ? 'required-date' : 'data-bg'}"
				cssClass="form-control ${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? '':'data-bg'}"
				placeHolder="${not empty placeHolder ? placeHolder : '' }"
				disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}" autocomplete="off"/>
			</c:otherwise>
			</c:choose>
			<input type="hidden" id="${fieldName}_temp_hidden" value=""/>
			
			<button type="button" onclick="" class="btn bg-transparent clear-input d-none" data-clear-input="${fieldName}" style="margin-left: -40px; z-index: 100;">
				<i class="fa fa-times"></i>
			</button>
		</div>
		<div id="${fieldName}_err" class="red d-none"></div>
		<form:errors path="${fieldName}" class="red" />
	</div>
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
		
		
		$('[data-clear-input="${fieldName}"]').on('click', function(){
			$('input[name="${fieldName}"]').val('')
			$('[data-clear-input="${fieldName}"]').addClass('d-none')
			var element = document.getElementById('${fieldName}');
			var event = new Event('change');
			element.dispatchEvent(event);
			initializeDaterangePicker();
		});
		
		
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
		
		$(function () {
		  $('[data-toggle="popover"]').popover(true);
		});
		
		
});
<c:if test="${fn:length(infoContent)>0}">	
$('[for="${fieldName}"]').append(
	' <i id="${inputId}" class="fa fa-info-circle font-medium-1 mr-1" tabindex="0" class="btn btn-lg btn-danger" role="button" title=\"<spring:message code="info.forinfo" />"	data-toggle="popover" data-trigger="hover"	data-placement="bottom"	data-content="<spring:message code="${infoContent}" />"></i>'
);
</c:if>
</script>
	
</spring:bind>
