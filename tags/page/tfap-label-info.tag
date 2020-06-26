<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@attribute name="fieldName" type="java.lang.String" required="true" %>
<%@attribute name="infoContent" type="java.lang.String" required="true" %>

<script>

	$(document).ready(function(){
		$(function () {
		  $('[data-toggle="popover"]').popover(true);
		});		
	});
	
	$('[for="${fieldName}"]').append(
		' <i id="${inputId}" class="fa fa-info-circle font-medium-1 mr-1" tabindex="0" class="btn btn-lg btn-danger" role="button" title=\"<spring:message code="info.forinfo" />"	data-toggle="popover" data-trigger="hover"	data-placement="bottom"	data-content="<spring:message code="${infoContent}" />"></i>'
	);
	
</script>