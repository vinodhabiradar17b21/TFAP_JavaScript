<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@attribute name="fieldName" type="java.lang.String" required="true"%>
<%@attribute name="fieldId" type="java.lang.String" required="true"%>
<%@attribute name="fieldKey" type="java.lang.String" required="true"%>
<%@attribute name="fieldFalse" type="java.lang.String" required="true"%>
<%@attribute name="fieldTrue" type="java.lang.String" required="true"%>
<%@attribute name="callback" required="false"%>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false"%>
<%@attribute name="isdisabled" type="java.lang.Boolean" required="false"%>

<c:set var="inputId" value="${fn:replace(fieldName, '.', '\\\\\\\\.')}" />
<spring:bind path="${fieldName}">
	<style>
.btn-l {
	border: 1px solid #CCC;
	-webkit-border-top-left-radius: 5px !important;
	-webkit-border-bottom-left-radius: 5px !important;
	-moz-border-radius-topleft: 5px !important;
	-moz-border-radius-bottomleft: 5px !important;
	border-top-left-radius: 5px !important;
	border-bottom-left-radius: 5px !important;
}
.btn-r {
	border: 1px solid #CCC;
	-webkit-border-top-right-radius: 5px !important;
	-webkit-border-bottom-right-radius: 5px !important;
	-moz-border-radius-topright: 5px !important;
	-moz-border-radius-bottomright: 5px !important;
	border-top-right-radius: 5px !important;
	border-bottom-right-radius: 5px !important;
}
.isDisabled {
	color: currentColor;
	cursor: not-allowed;
	opacity: 0.5;
	text-decoration: none;
	pointer-events: none;
}
</style>
	<div class="form-group swipe-btn-group ${status.error ? 'has-error' : ''}">
		<div class="row col-12 m-0 p-0 ds-b">
		
			<c:if test="${not empty fieldKey}">				
				<label for="${fieldName}" class="inline-label"><spring:message code="${fieldKey}" /></label>				
			</c:if>
			
			<c:choose>
				<c:when
					test="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))}">
					<div is="0" class="btn-group" tabindex="0">
						<form:hidden path="${fieldName}" />
						<a is="0" class="btn active btn-l ${fieldId}false isDisabled"
							data-isCheck="false" id="lbutton">
							<spring:message code="${fieldFalse}" />
						</a>
						<a is="1" class="btn active btn-r ${fieldId}true isDisabled"
							data-isCheck="true" id="rbutton">
							<spring:message code="${fieldTrue}" />
						</a>
					</div>
				</c:when>
				<c:otherwise>
					<div is="0" class="btn-group" tabindex="0">
						<form:hidden path="${fieldName}" />
						<a is="0" class="btn active btn-l ${fieldId}false"
							data-isCheck="false">
							<spring:message code="${fieldFalse}" />
						</a>
						<a is="1" class="btn active btn-r ${fieldId}true" data-isCheck="true">
							<spring:message code="${fieldTrue}" />
						</a>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<script>
		$(document).ready(function() {

			$('.${fieldId}true').on('click', function(e) {
				e.target.classList.add('btn-success');
				$('.${fieldId}false').removeClass('btn-danger');
				$('#${inputId}').val(true).change();
				${callback}(true);
			});

			$('.${fieldId}false').on('click', function(e) {
				e.target.classList.add('btn-danger');
				$('.${fieldId}true').removeClass('btn-success');
				$('#${inputId}').val(false).change();
				${callback}(false);
			});

			if ($('#${inputId}').val() == "true") {
				$('.${fieldId}true').addClass('btn-success');
			} else {
				$('.${fieldId}false').addClass('btn-danger');
			}
		});
	</script>
</spring:bind>