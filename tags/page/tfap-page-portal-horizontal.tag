<%@tag description="Portal Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@attribute name="titleKey" type="java.lang.String" required="true"%>
<%@attribute name="bodyClass" type="java.lang.String"%>
<%@attribute name="bodyAttributes" type="java.util.HashMap"%>
<%@attribute name="defaultHead" type="java.lang.Boolean"
	description="set to false if you want to omit coPortal default head fragment"%>
<%@attribute name="head" fragment="true"%>
<%@attribute name="defaultScript" type="java.lang.Boolean"
	description="set to false if you want to omit coPortal default script fragment"%>
<%@attribute name="script" fragment="true"%>
<%@attribute name="loadNav" type="java.lang.Boolean"
	description="set to false if you dont want to load main and side menu and page footer menu"%>
<%@attribute name="elementExt" type="java.lang.String" required="false"%>
<%@attribute name="enableNotifMod" type="java.lang.String" required="false"%>
<%@attribute name="enableQueryMod" type="java.lang.String" required="false"%>
<%@attribute name="enableFeedBack" type="java.lang.String" required="false"%>

<!-- Co Portal Tag -->
<!DOCTYPE html>
<html>
<head>
<title><spring:message code="${titleKey}" /></title>
<c:if test="${empty pageScope.defaultHead || pageScope.defaultHead }">
	<%@ include file="/WEB-INF/views/common/common_html_head_horizontal_tf.jspf"%>
</c:if>
<jsp:invoke fragment="head" />
</head>

<body ${ not empty pageScope.bodyClass ? 'class="'.concat(pageScope.bodyClass).concat('"') : '' } data-open="hover" data-menu="horizontal-menu" data-col="2-columns">
<style>
#pageloader
{
  background: rgba( 255, 255, 255, 0.8 );
  display: none;
  height: 100%;
  position: fixed;
  width: 100%;
  z-index: 9999;
}

#pageloader img
{
  left: 50%;
  margin-left: -32px;
  margin-top: -40px;
  position: absolute;
  top: 50%;
}
</style>

<div id="pageloader">
	<img src="<c:url value="/resources/images/loader-large.gif"/>" alt="processing..." />
</div>
<%@ include file="/WEB-INF/views/common/common_sessiontimeout.jspf"%>
<%@ include file="/WEB-INF/views/common/common_html_header_horizontal_tf.jspf"%>
<%@ include file="/WEB-INF/views/common/common_html_horizontal_menu_tf.jspf"%>

<jsp:doBody />
<c:if test="${empty pageScope.loadNav || pageScope.loadNav }">
	<%@ include file="/WEB-INF/views/common/common_html_footer_horizontal_tf.jspf"%>
</c:if>
<c:if
	test="${ empty pageScope.defaultScript || pageScope.defaultScript}">
	<%@ include file="/WEB-INF/views/common/common_html_script_tf.jspf"%>
</c:if>

</body>

<jsp:invoke fragment="script" />
</html>