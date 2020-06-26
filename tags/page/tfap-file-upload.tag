<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@attribute name="fieldName" type="java.lang.String" required="true"%>
<%@attribute name="trasactionId" type="java.lang.String" required="true"%>
<%@attribute name="itemSetId" type="java.lang.String" required="true"%>
<%@attribute name="isOthers" type="java.lang.String" required="false"%>
<%@attribute name="items" type="java.lang.String" required="false"%>
<%@attribute name="multiple" type="java.lang.String" required="false"%>
<%@attribute name="isView" type="java.lang.String" required="false"%>
<%@attribute name="endPoint" type="java.lang.String" required="true"%>
<%@attribute name="state" required="false"%>
<%@attribute name="callback" required="false"%>


<div 
	class="${itemSetId}"
	data-documentType="${documentType}" 
	data-trasactionId="${trasactionId}" 
	data-attachmentType="${attachmentType}" 
	data-id="${itemSetId}"
	data-endPoint="${endPoint}"
	data-callback="${callback}"
	data-isOthers="${isOthers}">
	
	<p>
		<button type="button" class="btn btn-secondary mr-1 disabled" data-toggle="tooltip" data-trigger="hover" data-placement="bottom" title="" data-original-title="Browse from NTP">
			<i class="fa fa-upload"></i>
			Browse from NTP
		</button>
		<label class="btn btn-primary file-attach" data-toggle="tooltip" data-trigger="hover" data-placement="bottom" title="" data-original-title="Browse from Local">
			<input type="file" class="filesUpload" id="${itemSetId}" ${multiple}>
			<span>
				<i class="fa fa-upload "></i>
				<i class="fa fa-spinner fa-spin fa-lg fa-fw hidden"></i> 
				Browse from Local
			</span>
		</label>
	</p>
</div>