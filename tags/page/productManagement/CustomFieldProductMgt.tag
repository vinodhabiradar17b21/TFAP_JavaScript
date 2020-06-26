<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@attribute name="fieldName1" type="java.lang.String" required="false"%>
<%@attribute name="fieldName2" type="java.lang.String" required="false"%>
<%@attribute name="fieldName3" type="java.lang.String" required="false"%>
<%@attribute name="fieldName4" type="java.lang.String" required="false"%>
<%@attribute name="fieldName6" type="java.lang.String" required="false"%>
<%@attribute name="maxlength3" type="java.lang.Boolean" required="false" %>
<%@attribute name="maxVal3" type="java.lang.String" required="false" %>
<%@attribute name="maxlength4" type="java.lang.Boolean" required="false" %>
<%@attribute name="maxVal4" type="java.lang.String" required="false" %>
<%@attribute name="maxlength6" type="java.lang.Boolean" required="false" %>
<%@attribute name="maxVal6" type="java.lang.String" required="false" %>
<%@attribute name="placeHolder3" type="java.lang.String" required="false" %>
<%@attribute name="placeHolder4" type="java.lang.String" required="false" %>
<%@attribute name="placeHolder6" type="java.lang.String" required="false" %>
<%@attribute name="fieldKey3" type="java.lang.String" required="false"%>
<%@attribute name="fieldKey4" type="java.lang.String" required="false"%>
<%@attribute name="fieldKey6" type="java.lang.String" required="false"%>
<%@attribute name="required" type="java.lang.String" required="false" %>
<%@attribute name="flgitems"  type="java.lang.Object" required="false" %>
<%@attribute name="typeitems"  type="java.lang.Object" required="false" %>

<spring:bind path="${fieldName1}">

<div class="form-group mb-0 ${status.error ? 'has-error' : ''}">
		<div class="input-group">
			<form:select id="${fieldName1}" path="${fieldName1}"
				cssErrorClass="border-danger form-control field1 ${required ? 'required' : ''}"
				cssClass="form-control field1 ${required ? 'required' : ''}">
				<form:options items="${flgitems}" />
			</form:select>
			<form:hidden path="${fieldName1}" cssClass="field1-hidden"/>
			
			<form:select id="${fieldName2}" path="${fieldName2}"
				cssErrorClass="border-danger form-control field2 ${required ? 'required' : ''}"
				cssClass="form-control field2 ${required ? 'required' : ''}">
				<form:options items="${typeitems}" />
			</form:select> 
			<form:hidden path="${fieldName2}" cssClass="field2-hidden"/>
			
			<form:input id="${fieldName3}" path="${fieldName3}"
				cssErrorClass="border-danger form-control field3 tfap-number-input or2 ${not empty required && required ? 'required' : ''}"
				cssClass="form-control field3 tfap-number-input ${not empty required && required ? 'required' : ''}"
				placeHolder="${not empty placeHolder3 ? placeHolder3 : '' }"
				maxlength="${not empty maxVal3 && maxlength3 ? maxVal3 : ''}"/>

			<form:input id="${fieldName4}" path="${fieldName4}"
				cssErrorClass="border-danger form-control field4 or2 ${not empty required && required ? 'required' : ''}"
				cssClass="form-control field4 ${not empty required && required ? 'required' : ''}"
				placeHolder="${not empty placeHolder4 ? placeHolder4 : '' }"
				maxlength="${not empty maxVal4 && maxlength4 ? maxVal4 : ''}" />
				
			<form:input id="${fieldName6}" path="${fieldName6}"
				cssErrorClass="border-danger form-control field6 or2 ${not empty required && required ? 'required' : ''}"
				cssClass="form-control field6 ${not empty required && required ? 'required' : ''}"
				placeHolder="${not empty placeHolder6 ? placeHolder6 : '' }"
				maxlength="${not empty maxVal6 && maxlength6 ? maxVal6 : ''}"
				data-toggle="tooltip" data-html="true"
				data-placement="bottom" title="Each option is to be separated by a comma (i.e. ','). Eg: Option1,Option2,Option3. Maximum 10 options may be entered." />
 
 			<button class="btn delete-custom-field" type="button" data-toggle="tooltip" data-trigger="hover" data-placement="bottom" title="" data-original-title="Delete"><i class="fa fa-trash-o"></i></button>
		</div>

	</div>
	<div class="clearfix"></div>
	<div class="group-validation">
		<form:errors path="${fieldName1}" class="red" />
		<form:errors path="${fieldName2}" class="red" />
		<form:errors path="${fieldName3}" class="red" />
		<form:errors path="${fieldName4}" class="red" />
		<form:errors path="${fieldName6}" class="red" />
	</div> 
</spring:bind>
<script type="text/javascript">
$(document).ready(function(){
	$('[id="${fieldName2}"]').on('change', function(){
		if($(this).val() == 'S' || $(this).val() == 'N' ){
			$('[id="${fieldName3}"]').removeAttr('disabled');
			$('[id="${fieldName6}"]').val('');
			$('[id="${fieldName6}"]').attr('disabled', 'disabled');
		}else if($(this).val() == 'R' || $(this).val() == 'M' ){
			$('[id="${fieldName3}"]').val('');
			$('[id="${fieldName3}"]').attr('disabled', 'disabled');
			$('[id="${fieldName6}"]').removeAttr('disabled');
		}else{
			$('[id="${fieldName3}"]').val('');
			$('[id="${fieldName3}"]').attr('disabled', 'disabled');
			$('[id="${fieldName6}"]').val('');
			$('[id="${fieldName6}"]').attr('disabled', 'disabled');
		}
	});
	

	$('[id="${fieldName2}"]').trigger('change');
});

</script>