<%@tag description="Page Tag" pageEncoding="UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<%@attribute name="bankId" type="java.lang.String" required="true"%>


<div class="btn-group ml-1 submitter-group">
	<div class="">
		<div class="input-group-text">
			<spring:message code="label.state.sent-to" />
		</div>
	</div>
		<spring:message code='label.selectbank' var="selectfieldLabel" />
		<tfap:selectGroup id="bankIdSelected" selectedId="${pageScope.bankId }" selectList="${subscribedBankProducts }" placeholder="${selectfieldLabel }" disabled="${isDisabled }"></tfap:selectGroup>
</div>