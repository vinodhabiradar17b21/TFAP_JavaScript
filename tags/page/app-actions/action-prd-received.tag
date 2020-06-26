<%@tag description="Page Tag" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap" %>

<script type="text/javascript">
    var appId = '';

    function receivedCallback(_tfapId) {
        appId = _tfapId;
        
		$.get("/TFAPortal/tfApplication/state-action-prd/prd/received?tfapid=" + appId, function (data, status) {
            data = JSON.parse(data);
            redirectUrl = data.redirect;
/*             if(dataTable != ''){
    			dataTable.draw();
    		}else{ */
    			window.location = redirectUrl;
    		/* } */
        });
    }

</script>