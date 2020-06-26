<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@attribute name="fieldName" type="java.lang.String" required="true" %>
<%@attribute name="fieldKey" type="java.lang.String" required="true" %>
<%@attribute name="fileType" type="java.lang.String" required="false" %>
<%@attribute name="ErrorMsg" type="java.lang.String" required="false" %>
<%@attribute name="uploadedFileName" type="java.lang.String" required="false" %>
<%@attribute name="callback" required="false"%>
<%@attribute name="callbackValidateFileSize" required="false"%>
<%@attribute name="required" type="java.lang.Boolean" required="true" %>
<%@attribute name="maxFileSizeToDisplay" type="java.lang.String" required="false"%>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false"%>

<spring:bind path="${fieldName}">
	<div class="form-group ${status.error ? 'has-error' : ''}">
		<span class="custom-file"> <input id="${fieldName}"
			name="${fieldName}" type="file"
			class="custom-file-input ${required ? 'required' : ''}"
			accept="${not empty fileType ? fileType : '*/*'}"
			${((disabled)|| isDisabled)? 'disabled' :  ''} /> <label
			id="${fieldName}_label"
			class="custom-file-label ${required?'required':''}"
			data-hidden-text="<spring:message code="${fieldKey}"/>"> <c:choose>
					<c:when test="${not empty uploadedFileName}">
						${uploadedFileName}
					</c:when>
					<c:otherwise>
						<spring:message code="${fieldKey}" />
					</c:otherwise>
				</c:choose>
		</label>
		</span> <span id="${fieldKey}_upload_filesErrors" class="red d-none">Invalid
			File Format</span><br> <span id="${fieldKey}_upload_filesSizeErrors"
			class="red d-none">Maximum allowed file size is
			${maxFileSizeToDisplay}</span>
		<form:errors path="${fieldName}" class="red" />
	</div>

	<script>
		$(document).ready(function(){			
			$('[id="${fieldName}"]').on('change', function(e){
				$('[id="${fieldKey}_upload_filesSizeErrors"]').addClass('d-none');
			
				${callback}("${fieldKey}_upload_filesErrors","${fieldName}");
				
				var filePath = $(this).val();
				
				if(filePath != ''){
					var fileSize = document.getElementById('${fieldName}').files.item(0).size;
					${callbackValidateFileSize}("${fieldKey}_upload_filesSizeErrors", "${fieldName}", fileSize);

					var fileName = document.getElementById('${fieldName}').files.item(0).name;
					$('[id="${fieldName}_label"]').text(fileName);
					
					
				}else{
					var txt = $('[id="${fieldName}_label"]').attr('data-hidden-text');
					$('[id="${fieldName}_label"]').text(txt);
				}
				
			});
			
		});
	</script>
</spring:bind>