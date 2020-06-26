<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@tag description="Page Tag" pageEncoding="UTF-8"%>

<script type="text/javascript">

function onExtensionClick(tfapid, msgType) {
    const jData = {
        tfapId: tfapid,
        moduleName: msgType,
        fromAppView: true
    }
    $.ajax({
        type: 'POST',
        url: '<spring:url value="/ifImpPre/extension/modal/show"/>',
        contentType: 'application/json',
        data: JSON.stringify(jData),
        success: function (data) {
            $('#if_extension_modal_content').html(data);
            $('#if_extension_modal').modal('show');
        },
        error: function (err) {
            console.error('Error onExtensionClickFromList: ' + err);
        }
    });
}

function onExtensionClickFromList(tfapid,moduleName){
    const jData = {
        tfapId: tfapid,
        moduleName: moduleName
    }
    $.ajax({
        type: 'POST',
        url: '<spring:url value="/ifImpPre/extension/modal/show"/>',
        contentType: 'application/json',
        data: JSON.stringify(jData),
        success: function(data) {
            $('#if_extension_modal_content').html(data);
            $('#if_extension_modal').modal('show');
        },
        error: function(err) {
            console.error('Error onExtensionClickFromList: ' + err);
        }
    })
}
</script>



