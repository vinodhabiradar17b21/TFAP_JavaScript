<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@attribute name="fieldName" type="java.lang.String" required="true" %>
<%@attribute name="fieldKey" type="java.lang.String" required="true" %>
<%@attribute name="required" type="java.lang.Boolean" required="true" %>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false" %>
<%@attribute name="isdisabled" type="java.lang.Boolean" required="false" %>
<%@attribute name="maxlength" type="java.lang.Boolean" required="false" %>
<%@attribute name="maxVal" type="java.lang.String" required="false" %>
<%@attribute name="requireDetails" type="java.lang.Boolean" required="false" %>
<%@attribute name="maxLines" type="java.lang.Integer" required="false" %>
<%@attribute name="maxLengthOfLine" type="java.lang.Integer" required="false" %>
<%@attribute name="inRow" type="java.lang.String" required="false"%>
<c:set var="noRowsField" value="${(not empty inRow) ? inRow : '3'}"/>
<c:set var="spanId" value="${fn:replace(fieldName, '.','') }" />


<spring:bind path="${fieldName}">
	<div class="form-group ${status.error ? 'has-error' : ''}">
	<c:if test="${not empty fieldKey}">
		<label for="${fieldName}"><spring:message code="${fieldKey}"/></label></c:if>
		<form:textarea id="${fieldName}" path="${fieldName}" rows="${noRowsField}"
			cssErrorClass="border-danger form-control ${required ? 'required' : ''}"
			cssClass="form-control ${required ? 'required' : ''}"
			disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}"
			maxlength="${not empty maxVal && maxlength ? maxVal : ''}" />
		<c:if test= "${requireDetails}">
			<p class="mb-0 text-right">
				<span id="${spanId}">${not empty maxVal && maxlength ? maxVal : ''}</span> characters remaining.
			</p>
		</c:if>
		<form:errors path="${fieldName}" class="red" /> 
	</div>
</spring:bind>

<c:if test= "${requireDetails}">

<script type="text/javascript">
$(document).ready(function() {
	
	if($('[id="${fieldName}"]').val() != ''){
		var cont = $('[id="${fieldName}"]').val();
		//var remaining = ${maxVal} - cont.length;
		var lines = cont.split(/\r|\r\n|\n/);
		var line_count = lines.length;
		var char_count = cont.length;
		var overall_count = char_count+(line_count-1);
		var balance_count = ${maxVal} - overall_count;
		var limit_count = overall_count+balance_count;
		if (line_count>1) {
			$('[id="${fieldName}"]').attr('maxlength',${maxVal}-line_count+1);
		}
		if (balance_count<0){
			txt = $(this).text().substring(0,overall_count+balance_count);
			$('[id="${fieldName}"]').val(r);
		}
		$("span#${spanId}").html(balance_count);
		
	}
	
	$('[id="${fieldName}"]').on("keyup keypress keydown",(function(event){
		if(this.value.length > ${maxVal}){
			return false;
		}
		
		var r = this.value;
		var lines = r.split(/\r|\r\n|\n/).length;
	    var text_length = r.length;
	    var text_remaining = ${maxVal} - text_length;
	    if (lines > 1) {
	      text_remaining = text_remaining - lines + 1;
	      text_length = text_length + lines - 1;
	    }
	    if (text_length > ${maxVal}) {
			if (event.keyCode == 13) {
		   		$('[id="${fieldName}"]').val(r.substring(0, r.length - 1));
		        text_length = $('[id="${fieldName}"]').val().length + lines - 1 - 1;
          		text_remaining = 1;
          		lines = lines - 1;
		    } else {
		    	$('[id="${fieldName}"]').val(r.substring(0, ${maxVal} - lines + 1));
		        text_length = r.length + lines - 1;
          		text_remaining = 0;
		    }
	    }
		$("span#${spanId}").html(text_remaining);	    
	}));
	
});
</script>

</c:if>