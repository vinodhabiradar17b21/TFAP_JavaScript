<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@attribute name="transactionId" type="java.lang.String" required="true"%>
<%@attribute name="documentType" type="java.lang.String" required="true"%>
<%@attribute name="attachmentType" type="java.lang.String" required="true"%>
<%@attribute name="itemSetId" type="java.lang.String" required="true"%>
<%@attribute name="isOthers" type="java.lang.String" required="false"%>
<%@attribute name="items" type="java.lang.String" required="false"%>
<%@attribute name="attJson" type="java.lang.String" required="false"%>
<%@attribute name="isDisabled" type="java.lang.String" required="false"%>
<%@attribute name="state" required="false"%>
<%@attribute name="callback" required="false"%>

<c:set var="isOthers" value="${documentType eq 'OTH' ? 'true' : false}" />
<c:set
	var="disableBnkSpecificAttTab"
    value="${(empty disableBnkSpecific) ?
    ((empty isDisabled)?((empty isdisabled)?false:isdisabled):isDisabled) : disableBnkSpecific}" />
<div
	class="${itemSetId}"
	data-documentType="${documentType}"
	data-trasactionId="${transactionId}"
	data-attachmentType="${attachmentType}"
	data-id="${itemSetId}"
	data-isdisablebankspecific="${disableBnkSpecificAttTab}"
	data-isOthers="${isOthers}">
	<ul class="attachment-listing" data-count="0"></ul>
	<p class="mb-0">
		<label class="btn btn-primary file-attach ${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled)) ? 'disabled' : '' }" class="btn btn-secondary"  data-toggle="tooltip" data-trigger="hover" data-placement="bottom" title="" data-original-title="Browse from Local">
			<input type="file" class="filesUploadTab"  multiple='multiple' id="${itemSetId}" ${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled)) ? 'disabled' : ''}>
			<span>
				<i class="fa fa-upload "></i>
				<i class="fa fa-spinner fa-spin fa-lg fa-fw hidden"></i>
				Browse from Local
			</span>
		</label>
		<button type="button" onclick="deleteTabItem(this)" data-isDeleteAll="true" class="btn btn-link mr-1 ${itemSetId}-btn" data-toggle="tooltip" data-trigger="hover" data-placement="bottom" title="" data-original-title="Delete All" ${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled)) ? 'disabled' : ''} >Delete All</button>
		<div class="clearfix"></div>
		<div class="error${itemSetId} pull-left"></div>
	</p>
</div>
<script>
	$(document).ready(function(){
		var isDeleteDisabled = "${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled)) ? 'disabled' : '' }";
		var attJsonVar = '${attJson}';
		var attList = attJsonVar.trim().length > 0 ?  JSON.parse('${attJson}') : {"read":[]};
		attList.read = attList.read.filter(function (el) {return el.documentType == '${documentType}'});
		appendTabItemEach("${itemSetId}", ${isOthers}, attList, false, isDeleteDisabled);
	});
</script>