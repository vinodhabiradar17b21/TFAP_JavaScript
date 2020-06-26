<%@tag description="TFAP Page statesbar Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://clib.camelone.com/" prefix="co"%>

<%@attribute name="currentStatus" required="false" type="java.lang.Object"%>
<%@attribute name="statusList" required="false" type="java.lang.Object"%>
<%@attribute name="modelName" type="java.lang.String" required="false"%>
<%@attribute name="applicationNameLabel"  type="java.lang.String" required="false" %>
<div class="row status-bar">
	<h4><spring:message code="${applicationNameLabel}"></spring:message></h4>
	<a  data-toggle="tooltip" data-placement="top" title="Disable/Enable Status" class="progressBarShow" >
		<i class="fa fa-list-ul"></i>
	</a>
</div>

<div id="tfapstatusBar">
	<co:pagestatusbar
		currentStatus="${currentStatus}"
		modelName="${modelName}" statusList="${statusList}">
	</co:pagestatusbar>
</div>
<script>
	$('.progressBarShow').on('click', function(){
		$('#tfapstatusBar').slideToggle("500");
	});
</script>