<%@tag description="Button Group Tag" pageEncoding="UTF-8"%>

<%@attribute name="id" required="false" type="java.lang.String" %>
<%@attribute name="name" required="false" type="java.lang.String" %>
<%@attribute name="disabled" required="false" type="java.lang.Boolean" %>
<%@attribute name="type" required="false" type="java.lang.String" %>
<%@attribute name="altClass" required="false" type="java.lang.String" %>

<div>
	<button ${ empty pageScope.id ? null : "id=\"".concat(pageScope.id).concat("\"") } ${ empty pageScope.name ? null : "name=\"".concat(pageScope.name).concat("\"") }
	${ empty pageScope.type?"type=\"submit\"": "type=\"".concat(pageScope.type).concat("\"")}
			class="${ not empty pageScope.altClass ? pageScope.altClass : 'btn btn-primary btn-block'}" ${ pageScope.disabled ? 'disabled' : null }
	 ><jsp:doBody/>
	 </button>
</div>