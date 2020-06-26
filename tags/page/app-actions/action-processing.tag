<%@tag description="Page Tag" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap" %>

<tfap:tfapconfirmationmodal
        button_name="label.modal.button.yes"
        modal_title="label.modal.title.confirmation"
        modal_Id="modal_confirm_processing"
        primary_btn_id="btn_confirm_processing"
        message="label.modal.message.confirmation.processing"
        callback="processingCallback()"/>

<script type="text/javascript">
    var appId = '';
    var docType = '';
	var dataTable = '';

    function openProcessingModal(_tfapId, _docType, _dataTable) {
        appId = _tfapId;
        docType = _docType;
		dataTable = (_dataTable)? _dataTable:dataTable;
        $('#modal_confirm_processing').modal('show');
    }

   function processingCallback() {

	   $.ajax({
  			url: "${pageContext.request.contextPath}/tfApplication/validate/recordOwnStatus?tfapId="+appId,
  			type:"POST",
  			success: function(result){
  				var isRecordOpen = result;
  				if(isRecordOpen!=null && isRecordOpen == 'true'){
  					swal({
  						//title: '<spring:message code="message.record.tfaprecord.open"/>',
  						title: 'This record is currently being edited by another user. Do you want to proceed to edit it?',
  						icon: "warning",
  						//buttons: ["<spring:message code='message.record.confirm.cancel'/>","<spring:message code='message.record.confirm.ok'/>"],
  						buttons: ["Cancel","Ok"],
  						dangerMode: true,
  					})
  					.then(function(willDelete) {
  					  if (willDelete) {
  						processingCallbackAdd();
  					  }
  					});
  				}else{
  					processingCallbackAdd();	
  				}
  			}
  		});	
    	
    } 


   function processingCallbackAdd() {
   	$.get("/TFAPortal/tfApplication/state-action/app/process?tfapid=" + appId + "&doc_type=" + docType, function (data, status) {
           data = JSON.parse(data);
           // redirectUrl = data.redirect;
           window.location = data.redirect;
       });
   } 

	// $('#modal_confirm_processing').on('hidden.bs.modal', function (e) {
	// 	if(dataTable != ''){
	// 		dataTable.draw();
	// 	}else{
	// 		window.location = redirectUrl;
	// 	}
	// });

</script>