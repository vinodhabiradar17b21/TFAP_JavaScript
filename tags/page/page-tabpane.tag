<%@attribute name="id" type="java.lang.String" required="true" %>
<%@attribute name="isactive" type="java.lang.Boolean" required="true" %>
<div class="col-12 tab-pane ${isactive ? 'active in' : ''}" id="${id}" role="tabpanel"  aria-labelledby="${id}-tab" aria-expanded="true">
		<jsp:doBody/>
</div>