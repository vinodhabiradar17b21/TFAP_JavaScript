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
<%@attribute name="primary_btn_id" type="java.lang.String" required="false"%>
<%@attribute name="status_div_id" type="java.lang.String" required="true"%>
<%@attribute name="noBrowseFromNtp" type="java.lang.Boolean" required="false"%>
<%@attribute name="state" required="false"%>
<%@attribute name="callback" required="false"%>
<%@attribute name="isCustomMsg" required="false"%>


<section 
	class="${itemSetId}"
	data-documentType="${documentType}" 
	data-trasactionId="${trasactionId}" 
	data-attachmentType="${attachmentType}" 
	data-id="${itemSetId}"
	data-endPoint="${endPoint}"
	data-callback="${callback}"
	data-isOthers="${isOthers}">

	<div class="col-12 p-0 mb-1">
		<c:choose>
			<c:when test="${isCustomMsg}">
				<label for="basicInput">Upload File (Previous data will be replaced after uploading latest file)</label>
			</c:when>
			<c:otherwise>
			  <label for="basicInput">Upload File</label>
			 </c:otherwise> 
		</c:choose>
		
		<div class="input-group">
			<input type="text" class="form-control uploadedFile" placeholder="" id="filed${itemSetId}">
			<p class="input-group-append m-0">
				<c:if test="${!noBrowseFromNtp}">
					<button
							type="button"
							class="btn btn-secondary disabled"
							data-toggle="tooltip"
							data-placement="bottom" title=""
							data-original-title="Browse from NTP">
						<i class="fa fa-upload"></i>
					</button>
				</c:if>
				<label 
					for="${itemSetId}"
					class="btn btn-primary m-0" 
					data-toggle="tooltip"
					data-placement="bottom" title=""
					data-original-title="Browse from Local">
					<input type="file" class="hidden" id="${itemSetId}" ${multiple}>
					<span>
						<i class="fa fa-upload "></i>
						<i class="fa fa-spinner fa-spin fa-lg fa-fw hidden"></i>
					</span>
				</label>
			</p>
		</div>
		<div id="${status_div_id}"></div>
	</div>
	
	<script>
		$(document).ready(function(){
			
			$('#${primary_btn_id}').prop('disabled', 'disabled');			
			$('#${primary_btn_id}').on('click', function(e){
				var e = $('#${itemSetId}');				
				singleuploadFile(e[0]);
			});
			
			$('#${itemSetId}').on('change', function(e){
				$(' #filed${itemSetId}').val(e.target.files[0].name);
				$('#${primary_btn_id}').prop('disabled', '');
			});
						
		});
	</script>
	
</section>