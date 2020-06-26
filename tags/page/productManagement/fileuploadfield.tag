<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<%@attribute name="endPoint" type="java.lang.String" required="true"%>
<%@attribute name="tfbotId" type="java.lang.String" required="true"%>
<%@attribute name="fieldName" type="java.lang.String" required="true"%>
<%@attribute name="callback" required="false"%>

<div data-tfbotId="${tfbotId}"
	data-endPoint="${endPoint}"
	data-callback="${callback}"
	data-docType="${docType}">
	
	<span class="custom-file"> <input type="file"
		class="fieldUploadFile" id="tnc-upload"> <label
		class="custom-file-label" for="tnc-upload"><spring:message code="label.fileupload.placeholder" /></label>
	</span>
</div>