<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<%@attribute name="auditTfapId" type="java.lang.String" required="false" %>


<div class="col-12">

	<table class="table table-striped table-bordered table-hover" id="auditTable" style="width:100%">
		<thead>
			<tr class="table_header">
				<th>ID</th>
				<th><spring:message code="label.event" /></th>
				<th><spring:message code="label.timeStamp" /></th>
				<%-- <th><spring:message code="label.remarks" /></th> --%>
				<th width="200px;"><spring:message code="label.userID" /></th>
				<th width="200px;"><spring:message code="label.userName" /></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${auditLogs}" var="audit">
  					<tr>
   					<td>${audit.audtReckey}</td>
   					<td>${audit.audtEvent}</td>
					<td>${audit.audtTimestamp}</td>
					<td>${audit.audtUid}</td>
					<td>${audit.audtUname}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
</div>

        	
 <script type="text/javascript">
 
        $(function() {

        	<c:if test="${ empty auditTfapId && not empty tfApplication.tfTransaction.tfTran.ttfId}">
        		<c:set var="auditTfapId" value="${tfApplication.tfTransaction.tfTran.ttfId}"/>
        	</c:if>

        	<c:if test="${ not empty auditTfapId}">
        	
	            $('#auditTable').DataTable({
	            	"order": [[ 2, "desc" ], [ 1, "desc" ]],
	                pageLength: 10,
	                "ajax": '${pageContext.request.contextPath}/tfApplication/auditLog/json/${auditTfapId}',
	                "columns": [
	                    { "data": "audtReckey" },
	                    { "data": "audtEvent" },
	                    { "data": "audtTimestamp" },
	                    { "data": "audtUid" },
	                    { "data": "audtUname" }
	                ]
	            });
	            
	        	$('#application_form #audits-tab').on('show.bs.tab', function(e) {
	
	            	console.log("refresh audit: ${auditTfapId}" );
	            	$('#auditTable').DataTable().ajax.reload();
	        	});
	        	
		     </c:if>
        })
        
</script>
    
 <%@ include file="/WEB-INF/views/common/common_html_audit_script.jspf"%>   