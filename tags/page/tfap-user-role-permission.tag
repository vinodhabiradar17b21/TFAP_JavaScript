<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@attribute name="userRoles" type="java.util.List" required="true"%>

<!-- Company User Roles -->
<%@attribute name="TFAP_COM_MAKER" type="java.lang.Boolean" required="false"%>
<%@attribute name="TFAP_VERIFIER" type="java.lang.Boolean" required="false"%>
<%@attribute name="TFAP_COM_APPROVER" type="java.lang.Boolean" required="false"%>
<%@attribute name="TFAP_COM_ADMIN" type="java.lang.Boolean" required="false"%>
<%@attribute name="TFAP_ADMIN" type="java.lang.Boolean" required="false"%>

<!-- Bank User Roles -->
<%@attribute name="TFAP_BANK_USER" type="java.lang.Boolean" required="false"%>
<%@attribute name="TFAP_BANK_ADMIN" type="java.lang.Boolean" required="false"%>
<%@attribute name="TFAP_BANK_MAKER" type="java.lang.Boolean" required="false"%>
<%@attribute name="TFAP_BANK_APPROVER" type="java.lang.Boolean" required="false" %>
<%@attribute name="TFAP_BANK_ONBOARDING_MAKER" type="java.lang.Boolean" required="false"%>
<%@attribute name="TFAP_BANK_ONBOARDING_APPROVER" type="java.lang.Boolean" required="false" %>
<%@attribute name="TFAP_BANK_PRD_MAKER" type="java.lang.Boolean" required="false"%>
<%@attribute name="TFAP_BANK_PRD_APPROVER" type="java.lang.Boolean" required="false" %>

<c:set var="TFAP_COM_MAKER" value="${(empty TFAP_COM_MAKER) ? false : TFAP_COM_MAKER}"/>
<c:set var="TFAP_VERIFIER" value="${(empty TFAP_VERIFIER) ? false : TFAP_VERIFIER}"/>
<c:set var="TFAP_COM_APPROVER" value="${(empty TFAP_COM_APPROVER) ? false : TFAP_COM_APPROVER}"/>
<c:set var="TFAP_COM_ADMIN" value="${(empty TFAP_COM_ADMIN) ? false : TFAP_COM_ADMIN}"/>
<c:set var="TFAP_ADMIN" value="${(empty TFAP_ADMIN) ? false : TFAP_ADMIN}"/>

<c:set var="TFAP_BANK_USER" value="${(empty TFAP_BANK_USER) ? false : TFAP_BANK_USER}"/>
<c:set var="TFAP_BANK_ADMIN" value="${(empty TFAP_BANK_ADMIN) ? false : TFAP_BANK_ADMIN}"/>
<c:set var="TFAP_BANK_MAKER" value="${(empty TFAP_BANK_MAKER) ? false : TFAP_BANK_MAKER}"/>
<c:set var="TFAP_BANK_APPROVER" value="${(empty TFAP_BANK_APPROVER) ? false : TFAP_BANK_APPROVER }"/>
<c:set var="TFAP_BANK_ONBOARDING_MAKER" value="${(empty TFAP_BANK_ONBOARDING_MAKER) ? false : TFAP_BANK_ONBOARDING_MAKER}"/>
<c:set var="TFAP_BANK_ONBOARDING_APPROVER" value="${(empty TFAP_BANK_ONBOARDING_APPROVER) ? false : TFAP_BANK_ONBOARDING_APPROVER }"/>
<c:set var="TFAP_BANK_PRD_MAKER" value="${(empty TFAP_BANK_PRD_MAKER) ? false : TFAP_BANK_PRD_MAKER}"/>
<c:set var="TFAP_BANK_PRD_APPROVER" value="${(empty TFAP_BANK_PRD_APPROVER) ? false : TFAP_BANK_PRD_APPROVER }"/>

<c:set var="SHOW" value="false"/>


<c:choose>
	<c:when test="${TFAP_COM_MAKER && userRoles.contains('TFAP_COM_MAKER')}">
		<c:set var="SHOW" value="true"/>
	</c:when>
	<c:when test="${TFAP_VERIFIER && userRoles.contains('TFAP_COM_VERIFIER')}">
		<c:set var="SHOW" value="true"/>
	</c:when>
	<c:when test="${TFAP_COM_APPROVER && userRoles.contains('TFAP_COM_APPROVER')}">
		<c:set var="SHOW" value="true"/>
	</c:when>
	<c:when test="${TFAP_COM_APPROVER && userRoles.contains('TFAP_COM_APPROVER')}">
		<c:set var="SHOW" value="true"/>
	</c:when>
	<c:when test="${TFAP_COM_ADMIN && userRoles.contains('TFAP_COM_ADMIN')}">
		<c:set var="SHOW" value="true"/>
	</c:when>
	
	<c:when test="${TFAP_BANK_USER && userRoles.contains('TFAP_BANK_USER')}">
		<c:set var="SHOW" value="true"/>
	</c:when>
	<c:when test="${TFAP_BANK_ADMIN && userRoles.contains('TFAP_BANK_ADMIN')}">
		<c:set var="SHOW" value="true"/>
	</c:when>
	<c:when test="${TFAP_BANK_MAKER && userRoles.contains('TFAP_BANK_MAKER')}">
		<c:set var="SHOW" value="true"/>
	</c:when>
	<c:when test="${TFAP_BANK_APPROVER && userRoles.contains('TFAP_BANK_APPROVER')}">
		<c:set var="SHOW" value="true"/>
	</c:when>
	<c:when test="${TFAP_BANK_ONBOARDING_MAKER && userRoles.contains('TFAP_BANK_ONBOARDING_MAKER')}">
		<c:set var="SHOW" value="true"/>
	</c:when>
	<c:when test="${TFAP_BANK_ONBOARDING_APPROVER && userRoles.contains('TFAP_BANK_ONBOARDING_APPROVER')}">
		<c:set var="SHOW" value="true"/>
	</c:when>
	<c:when test="${TFAP_BANK_PRD_MAKER && userRoles.contains('TFAP_BANK_PRD_MAKER')}">
		<c:set var="SHOW" value="true"/>
	</c:when>
	<c:when test="${TFAP_BANK_PRD_APPROVER && userRoles.contains('TFAP_BANK_PRD_APPROVER')}">
		<c:set var="SHOW" value="true"/>
	</c:when>
</c:choose>



<c:if test="${SHOW}">
	<jsp:doBody/>
</c:if>