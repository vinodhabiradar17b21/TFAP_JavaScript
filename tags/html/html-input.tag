<%@tag description="Input Text Group Tag" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@attribute name="id" required="false" type="java.lang.String" %>
<%@attribute name="name" required="false" type="java.lang.String" %>
<%@attribute name="required" required="false" type="java.lang.Boolean" %>
<%@attribute name="draftable" required="false" type="java.lang.Boolean" %>
<%@attribute name="disabled" required="false" type="java.lang.Boolean" %>
<%@attribute name="readonly" required="false" type="java.lang.Boolean" %>
<%@attribute name="placeholder" required="false" type="java.lang.String" %>
<%@attribute name="value" required="false" type="java.lang.String" %>
<%@attribute name="autoCompleteUrl" required="false" type="java.lang.String" %>
<%@attribute name="autoCompleteKey" required="false" type="java.lang.String" %>
<%@attribute name="autoCompleteId" required="false" type="java.lang.String" %>
<%@attribute name="autoCompleteOn" required="false" type="java.lang.String" %>
<%@attribute name="wildcard" required="false" type="java.lang.String" %>
<%@attribute name="type" required="false" type="java.lang.String" %>
<%@attribute name="uppercase" required="false" type="java.lang.String" %>
<c:set var="isUpperCase" value="${(empty uppercase) ? false : true}"/>
<div>
    <input ${ empty pageScope.id ? null : "id=\"".concat(pageScope.id).concat("\"") } ${ empty pageScope.name ? null : "name=\"".concat(pageScope.name).concat("\"") }
    ${ empty pageScope.type?"type=\"text\"": "type=\"".concat(pageScope.type).concat("\"")}
            class="form-control input-xs ${ pageScope.required or pageScope.draftable ? 'required' : null }"
    value="${pageScope.value}"
    ${ pageScope.required ? 'required' : null } ${ pageScope.disabled ? 'disabled' : null } ${ pageScope.readonly ? 'readonly' : null }
    ${ empty pageScope.placeholder ? null : "placeholder=\"".concat(pageScope.placeholder).concat("\"") }
    ${ empty pageScope.autoCompleteUrl ? null : "data-autocomplete-url=\"".concat(pageScope.autoCompleteUrl).concat("\"") }
    ${ empty pageScope.autoCompleteKey ? null : "data-autocomplete-key=\"".concat(pageScope.autoCompleteKey).concat("\"") }
    ${ empty pageScope.autoCompleteId ? null : "data-autocomplete-id=\"".concat(pageScope.autoCompleteId).concat("\"") }
    ${ empty pageScope.autoCompleteOn ? null : "data-autocomplete-on=\"".concat(pageScope.autoCompleteOn).concat("\"") }
    ${pageScope.wildcard}
    ${ empty uppercase ? null : "style=\"text-transform:uppercase\"" }
    />
</div>

<script type="text/javascript">
<c:if test="${isUpperCase}">
$('[id="${pageScope.id}"]').on("keyup", function(e) {
	$(this).val($(this).val().toUpperCase());
})
</c:if>
</script>