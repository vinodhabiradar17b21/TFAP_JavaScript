<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@attribute name="fieldName" type="java.lang.String" required="true"%>
<%@attribute name="fieldId" type="java.lang.String" required="true"%>
<%@attribute name="maxlength" type="java.lang.Boolean" required="false" %>
<%@attribute name="maxVal" type="java.lang.String" required="false" %>
<%@attribute name="value" type="java.lang.String" required="false" %>
<%@attribute name="label" type="java.lang.String" required="false" %>
<%@attribute name="callback" required="false"%>
<%@attribute name="placeHolder" type="java.lang.String" required="false" %>
<%@attribute name="serviceUrl" type="java.lang.String" required="true"%>
<%@attribute name="required" type="java.lang.Boolean" required="true"%>
<%@attribute name="disabled" type="java.lang.Boolean" required="true"%>
<%@attribute name="searchIndex" type="java.lang.String" required="false"%>
<%@attribute name="smartSearchIndex" type="java.lang.String" required="false"%>
<%@attribute name="readonly" type="java.lang.Boolean" required="false"%>

<c:set var="smartSearchIndex"
	value="${(empty smartSearchIndex) ? '3' : smartSearchIndex}" />
<c:set var="searchIndex"
	value="${(empty searchIndex) ? '0' : searchIndex}" />

<spring:bind path="${fieldName}">

	<form:input id="${fieldId}" class="form-control ${required?'required':''}"
		path="${fieldName}" disabled="${disabled}"
		maxlength="${not empty maxVal && maxlength ? maxVal : ''}" data-search-index="${searchIndex}"
		placeHolder="${not empty placeHolder ? placeHolder : '' }" readonly="${not empty readonly ? readonly : 'false' }"/>

<script>
	$(document).ready(function(){
		$( "#${fieldId}" ).autocomplete({
			minLength: ${smartSearchIndex},
			select: function( event, ui ) {
		    	${callback}(ui.item.obj);
		    },
		    source: function(request, response) {
		        $.ajax({
		            url: "${serviceUrl}"+$("#${fieldId}").val(),
		            type: "GET",
		            success: function(data) { 
		            	var results = []
		            	data = JSON.parse(data)
		            	
		            	//if data not load from database edit this path data.aaData
		            	$.each(data.aaData, function(i,obj){
		            		var label = obj.${label}
		            		var value = obj.${value}
		            		results.push({label : label, value : value, obj:obj})
		            	});
		            	response(results);
		            }

		        });
		    }
		
		});
	})  
  </script>
  <%-- https://jsfiddle.net/gotemkfr/ --%>
</spring:bind>