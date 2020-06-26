<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@attribute name="button_name" type="java.lang.String" required="true"%>
<%@attribute name="button_cancel_name" type="java.lang.String" required="false"%>
<%@attribute name="modal_title_prefix" type="java.lang.String" required="false"%>
<%@attribute name="modal_title" type="java.lang.String" required="true"%>
<%@attribute name="modal_Id" type="java.lang.String" required="true"%>
<%@attribute name="modal_size" type="java.lang.String" required="false"%>
<%@attribute name="primary_btn_id" type="java.lang.String" required="false"%>
<%@attribute name="show_button_cancel" type="java.lang.Boolean" required="false"%>
<%@attribute name="show_button_primary" type="java.lang.Boolean" required="false"%>
<%@attribute name="show_modal_title" type="java.lang.Boolean" required="false"%>
<%@attribute name="css_class" type="java.lang.String" required="false"%>
<%@attribute name="dismiss_modal" type="java.lang.Boolean" required="false"%>
<%@attribute name="show_button_close" type="java.lang.Boolean" required="false"%>



<c:set var="modal_size"
	value="${(empty modal_size) ? 'xs' : modal_size}" />
<c:set var="primary_btn_id"
	value="${(empty primary_btn_id) ? 'tfap-modal-primary-id' : primary_btn_id}" />
<c:set var="show_button_primary"
	value="${(empty show_button_primary) ? true : show_button_primary}" />
<c:set var="dismiss_modal"
	value="${(empty dismiss_modal) ? 'modal' : '' }" />
<c:set var="show_modal_title"
	value="${(empty show_modal_title) ? true : show_modal_title}" />	
<c:set var="show_button_close"
	value="${(empty show_button_close) ? true : ''}" />
	
<div class="modal fade text-left ${css_class}" id="${modal_Id}" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel17" style="display: none;"
	aria-hidden="true">
	<div class="modal-dialog modal-${modal_size}" role="document">
		<div class="modal-content">
			<div class="modal-header">	
				<c:if test="${show_modal_title}">
					<h4 class="modal-title" id="myModalLabel17">
						<strong>
							<c:if test="${not empty modal_title_prefix}">
								<spring:message code='${modal_title_prefix}' />
							</c:if>
							<spring:message code='${modal_title}' />
						</strong>
					</h4>
				</c:if>
				<c:if test="${show_button_close}">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				</c:if>
			</div>
			<div class="modal-body">
				<jsp:doBody />
			</div>
			<div class="modal-footer" style="margin-top: -20px;">
				<c:if test="${show_button_cancel}">
					<button type="button" class="btn btn-outline-primary mr-1"
						data-dismiss="modal">
						<c:choose>
						  <c:when test="${!empty button_cancel_name}">
						    <spring:message code='${button_cancel_name}' />
						  </c:when>
						  <c:otherwise>
							<spring:message code='label.modal.button.close' />
						  </c:otherwise>
						</c:choose>
						
					</button>
				</c:if>
				<c:if test="${show_button_primary}">
					<button type="button" id="${primary_btn_id}" class="btn btn-primary" data-dismiss="${dismiss_modal}">
						<spring:message code='${button_name}' />
					</button>
				</c:if>
			</div>
		</div>
	</div>
</div>