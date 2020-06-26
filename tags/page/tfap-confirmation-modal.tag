<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@attribute name="button_name" type="java.lang.String" required="true"%>
<%@attribute name="modal_title" type="java.lang.String" required="true"%>
<%@attribute name="modal_Id" type="java.lang.String" required="true"%>
<%@attribute name="modal_size" type="java.lang.String" required="false"%>
<%@attribute name="primary_btn_id" type="java.lang.String" required="false"%>
<%@attribute name="message" type="java.lang.String" required="true"%>
<%@attribute name="callback" required="false"%>
<%@attribute name="dismiss_modal" type="java.lang.Boolean" required="false"%>

<c:set var="modal_size"	value="${(empty modal_size) ? 'sm' : modal_size}" />
<c:set var="dismiss_modal"
	value="${(empty dismiss_modal) ? 'modal' : '' }" />
	
<div class="modal fade text-left" id="${modal_Id}" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel17" style="display: none;"
	aria-hidden="true" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog modal-${modal_size}" role="document">
		<div class="modal-content">
			<div class="modal-header">
			<!-- <input type="text" id="urlModelName" value=""> -->
				<h4 class="modal-title" id="myModalLabel17">
					<strong><spring:message code='${modal_title}' /></strong>
				</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
				<h4 class="text-center"><spring:message code='${message}' /></h4>
			</div>
			<div class="modal-footer" style="margin-top: -20px;">

				<button type="button" class="btn btn-outline-primary mr-1"
					data-dismiss="modal">
					<spring:message code='label.modal.button.no' />
				</button>

				<button type="button" id="confirm_modal_yes" class="btn btn-primary"
					data-dismiss="${dismiss_modal}">
					<spring:message code='${button_name}' />
				</button>
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function(){
	$('#${modal_Id} #confirm_modal_yes').on('click', function(e){
		${callback};
	});
});
</script>