<%@tag description="Page Tag" pageEncoding="UTF-8"%>

<script>	

	$('#print_btn').on("click", function(e){
			 window.open(rootUrl + "/print?transactionId=${tfApplication.tfTransaction.tfTran.ttfId}&docType=${tfApplication.tfTransaction.tfTran.msgType}", '_blank');
	});
</script>



