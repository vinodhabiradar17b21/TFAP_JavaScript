<%@tag description="Select Group Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@attribute name="id" required="false" type="java.lang.String"%>
<%@attribute name="name" required="false" type="java.lang.String"%>
<%@attribute name="required" required="false" type="java.lang.Boolean"%>
<%@attribute name="disabled" required="false" type="java.lang.Boolean"%>
<%@attribute name="readonly" required="false" type="java.lang.Boolean"%>
<%@attribute name="placeholder" required="false" type="java.lang.String"%>
<%@attribute name="value" required="false" type="java.lang.Boolean"%>


	<input ${ empty pageScope.id ? null : "id=\"".concat(pageScope.id).concat("\"") } ${ empty pageScope.name ? null : "name=\"".concat(pageScope.name).concat("\"") } class="chk-remember"  type="checkbox"
	${ pageScope.required ? 'required' : null } ${ pageScope.disabled ? 'disabled' : null } ${ pageScope.readonly ? 'readonly' : null } ${ not empty pageScope.value and pageScope.value eq true ? 'checked' : null } />
