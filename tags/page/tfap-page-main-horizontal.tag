<%@tag description="Page Tag" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@attribute name="titleKey" type="java.lang.String" required="true" %>
<%@attribute name="elementExt" type="java.lang.String" required="false"%>
<%@attribute name="enableNotifMod" type="java.lang.String" required="false"%>
<%@attribute name="enableQueryMod" type="java.lang.String" required="false"%>
<%@attribute name="enableFeedBack" type="java.lang.String" required="false"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<jsp:useBean id="attributes" class="java.util.LinkedHashMap" />
<c:set target="${attributes }" property="data-col" value="2-columns" />
<c:set target="${attributes }" property="data-open" value="click" />
<c:set target="${attributes }" property="data-menu" value="vertical-menu-modern" />

<tfap:tfpageportalhorz bodyClass="horizontal-layout horizontal-menu 2-columns  menu-expanded"  titleKey="${titleKey}" bodyAttributes="${attributes }" elementExt="${elementExt}" enableNotifMod="${enableNotifMod}" enableQueryMod="${enableQueryMod}" enableFeedBack="${enableFeedBack}">
	<div class="app-content content container" style="max-width: 100%">
		<jsp:doBody/>	
	</div>
</tfap:tfpageportalhorz>