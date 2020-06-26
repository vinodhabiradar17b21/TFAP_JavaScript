<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>


<style>
.swal-title {
    font-weight: 400; !important;
    font-size: 15px;
}

.swal-icon:first-child {
    margin-top: 5px;
}

.swal-icon--warning__body {
    width: 2px;
    height: 21px;
    top: 10px;
    border-radius: 2px;
    margin-left: -2px;
}

.swal-icon {
    width: 80px;
    height: 54px;
    border-width: 2px;
}

.swal-icon--warning__dot {
    width: 5px;
    height: 5px;
    margin-left: -2px;
}

.swal-footer {
    padding: 0px 0px;
}

</style>

<div class="modal" id="auto-saving-modal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
      <div class="text-center" style="margin-top:150px">
      	<img width="50px" height="50px" src="data:image/gif;base64,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"/>
      	<h3 class="mt-1" style="color:#ccc">Saving...</h3>
      </div>
  </div>
</div>

<tfap:modal button_name="label.bank.button"
			modal_title="label.bank.maker.approver.check" modal_Id="modal_maker_approver_id"
			show_button_close="false" show_button_primary="false">
			<br />
			<div class="modal-content">
				<div class="modal-body">
					<h4 style="text-align: center;"><spring:message code="modal.checker.maker.restrict.message"/></h4>
				</div>
				<div class="modal-footer" style="margin-top: -20px;">
					<button type="button" class="btn btn-outline-primary mr-1"
						id="redirect_to_app_pro" onclick="redirectToApplicationProcess()"
						href="${pageContext.request.contextPath}/tfApplication/list/view"
						data-dismiss="modal">
						<spring:message code='label.modal.button.close' />
					</button>
				</div>
			</div>
</tfap:modal>


<script type="text/javascript">
$(document).ready(function(){
	
	$('#application_form a[data-toggle="tab"]').on('hidden.bs.tab', function(e) {

		//console.log( isChangedForm + " ----  " + '${tfApplication.stateForStatusBar}' ) ;
		if( isChangedForm ||  ( 'NEW' == '${tfApplication.stateForStatusBar}' ) ) {
			isChangedForm = false;
			//console.log( 'Auto save ' ) ;
			autoSave($(e.target).attr('id'));	
		}
	});
	
	var isChangedForm = false;

	var displayPageTime = new Date();

	$(document).on('change', 'form,input,select,textarea', function() {

		//console.log( 'Changed form ' + $(this).attr("id") ) ;
		
		if ( ( new Date() ) - displayPageTime < 1000 ) {
			// delay 1 second after displayed page.
			return; 
		}
		isChangedForm = true;
	});
    
	
});

/* // Temporary Disabled
$(window).bind('beforeunload', function(e){
	var tabId = $('#application_form a[data-toggle="tab"].active').attr('id');
	autoSave(tabId);
}); */

function redirectToApplicationProcess(e){
	window.location.href="${pageContext.request.contextPath}/tfApplication/list/view";
}

function autoSave(tabId){
	
	var url = rootUrl + '/draft/savetab?tab='+tabId+'&doc_type=${tfApplication.tfTransaction.tfTran.msgType}'; // the script where you handle the form input.

	var makerComAppCheck = '${makerComApproverCheck}';
	if(makerComAppCheck === 'RESTRICT'){
		$('#modal_maker_approver_verification_id').modal('show');
	}else{ 

		 var tfapId = "${tfApplication.tfTransaction.tfTran.ttfId}";
		 var appRefType = "${tfApplication.tfTransaction.tfTran.msgType}";
		 //if(tfapId!=null && appRefType!=null && (appRefType == 'SCISS' || appRefType == 'LCISS' || appRefType == 'ECNEG' || appRefType == 'BGISS')){

 		if(tfapId!=null && appRefType!=null){
			 $.ajax({
					url: rootUrl+"/validate/recordOwnStatus?tfapId="+tfapId,
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
								  callTabFormSubmit(url);
							  }
							});
						}else{
							callTabFormSubmit(url);
						}
					}
				});
							

		 }else{

			//Auto save ajax call start
				callTabFormSubmit(url);
			//Auto save ajax call end

		}		
	   		
	}
		
}

function callTabFormSubmit(url){

	$.ajax({
		type: "POST",
	        url: url,
	        data: $("#editForm").serialize(),
	        beforeSend: function(){
	        	$('#auto-saving-modal').modal('show');
	        },
   	    success: function(data){
   	    	data = JSON.parse(data);
   	    	if(data.processed)
			{
			 swal('<spring:message code="error.general.stateChange.message.refresh"/>', "","warning").then(function() {
                 //window.location.reload(true);
             });
		}
   	    else{
   	    	$('#auto-saving-modal').modal('hide');
   	    	$('#isRecordLock').hide();
   	    	//data = JSON.parse(data);
	        if(data.redirect){
	        	redirectUrl = data.redirect;
	        	window.location = redirectUrl;
	        }
	        if (data.tfTranOptLock) {
	        	$('#tfTranOptLock').val(data.tfTranOptLock);
			}
   	    }
   	    }
   	});
}

</script>

