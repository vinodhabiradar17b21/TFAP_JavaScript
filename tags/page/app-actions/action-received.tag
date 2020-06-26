<%@tag description="Page Tag" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript">
    var appId = '';
    var docType = '';
	var dataTable = '';

    function receivedCallback(_tfapId, _docType, _dataTable) {
        appId = _tfapId;
        docType = _docType;
        console.log('hello');
        dataTable = (_dataTable)? _dataTable:dataTable;
        receivedValid(appId, docType, dataTable);
    }

	
    function receivedValid(appId, docType, dataTable){

   	 $.ajax({
   			url: "${pageContext.request.contextPath}/tfApplication/validate/recordOwnStatus?tfapId="+appId,
   			type:"POST",
   			success: function(result){
   				var isRecordOpen = result;
   				if(isRecordOpen!=null && isRecordOpen == 'true'){
   					swal({
   						title: '<spring:message code="message.record.tfaprecord.open"/>',
   						icon: "warning",
   						buttons: ["<spring:message code='message.record.confirm.cancel'/>","<spring:message code='message.record.confirm.ok'/>"],
   						dangerMode: true,
   					})
   					.then(function(willDelete) {
   					  if (willDelete) {
   						receivedCallbackAdditional(appId, docType, dataTable);
   					  }
   					});
   				}else{
   					receivedCallbackAdditional(appId, docType, dataTable);	
   				}
   			}
   		});	

   	}

	function receivedCallbackAdditional(appId, docType, dataTable){
		
		$.get("/TFAPortal/tfApplication/state-action/app/received?tfapid=" + appId + "&doc_type=" + docType, function (data, status) {
            data = JSON.parse(data);
            redirectUrl = data.redirect;
            if(dataTable != ''){
    			dataTable.draw();
    		}else{
    			window.location = redirectUrl;
    		}
        });
		
	}
    
    

</script>