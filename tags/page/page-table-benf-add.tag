<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@attribute name="titleKey" type="java.lang.String" required="true"%>
<%@attribute name="breadCrumbKey" type="java.lang.String"
	required="true"%>
<%@attribute name="modelName" type="java.lang.String" required="true"%>
<%@attribute name="model" type="java.lang.Object" required="true"%>
<%@attribute name="isadvanced" type="java.lang.Boolean" required="false"%>
<%@attribute name="tableName" type="java.lang.String" required="true"%>
<%@attribute name="searchForm" fragment="true"%>
<div class="content-wrapper">
	<div class="content-body">
		<section id="description" class="card mb-0">
			<div class="card-header">
				<div class="row">
					<div class="col-6">
						<h4 class="card-title">
							<spring:message code="${titleKey}" />
						</h4>
					</div>

				</div>
			</div>
			<div class="card-content">
				<div class="card-body">
					<div class="card-text">
						<div class="row">
							<co:pagecolumn colSpan="6">
								<div class="form-group ">
									<label for="add_tfacpName"> <spring:message
											code="label.beneficiary.Add.tfacpName" /></label> <input
										id="add_tfacpName" name="add_tfacpName"
										class="form-control required" type="text" maxlength="256">

								</div>
								<div class="form-group ">
									<label for="add_tfacpTel"> <spring:message
											code="label.beneficiary.Add.tfacpTel" /></label> <input
										id="add_tfacpTel" name="add_tfacpTel" class="form-control"
										type="text" maxlength="25">

								</div>
								<div class="form-group ">
									<label for="add_tfacpPriConName"> <spring:message
											code="label.beneficiary.Add.tfacpPriConName" /></label> <input
										id="add_tfacpPriConName" name="add_tfacpPriConName"
										class="form-control" type="text" maxlength="25">

								</div>
								<div class="form-group ">
									<label for="add_tfacpEmail"> <spring:message
											code="label.beneficiary.Add.tfacpEmail" /></label> <input
										id="add_tfacpEmail" name="add_tfacpEmail" class="form-control"
										type="text" maxlength="128">

								</div>





							</co:pagecolumn>

							<co:pagecolumn colSpan="6">
								<div class="form-group ">
									<label for="add_tfacpAddr1"> <spring:message
											code="label.beneficiary.Add.tfacpAddr1" /></label> <input
										id="add_tfacpAddr1" name="add_tfacpAddr1" class="form-control"
										type="text" maxlength="64">

								</div>
								<div class="form-group ">
									<label for="add_tfacpAddr2"> <spring:message
											code="label.beneficiary.Add.tfacpAddr2" /></label> <input
										id="add_tfacpAddr2" name="add_tfacpAddr2" class="form-control"
										type="text" maxlength="64">

								</div>

								<div class="form-group ">
									<label for="add_tfacpAddr3"> <spring:message
											code="label.beneficiary.Add.tfacpAddr3" /></label> <input
										id="add_tfacpAddr3" name="add_tfacpAddr3" class="form-control"
										type="text" maxlength="64">

								</div>



							</co:pagecolumn>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer text-right">

				<co:pagecolumn colSpan="12">

					<button type="button" class="btn btn-outline-primary"
						data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						id="addCounterpartSubmit" data-dismiss="modal">&nbsp;&nbsp;&nbsp;&nbsp;Save&nbsp;&nbsp;&nbsp;&nbsp;</button>

				</co:pagecolumn>
			</div>
		</section>
	</div>

</div>

<script type="text/javascript">
	$("#addCounterpartSubmit").click(
			function() {
				tfacpName = $("#add_tfacpName").val();
				tfacpAddr1 = $("#add_tfacpAddr1").val();
				tfacpAddr2 = $("#add_tfacpAddr2").val();
				tfacpAddr3 = $("#add_tfacpAddr3").val();
				//tMstCountry = $("#tfAccCp\\.tMstCountry").val();
				tfacpTel = $("#add_tfacpTel").val();
				tfacpEmail = $("#add_tfacpEmail").val();
				tfacpPriConName = $("#add_tfacpPriConName").val();
				$.post(rootUrl + "/account_counterparty/save", {
					tfacpName : tfacpName,
					tfacpAddr1 : tfacpAddr1,
					tfacpAddr2 : tfacpAddr2,
					tfacpAddr3 : tfacpAddr3,
					tMstCountry : tMstCountry,
					tfacpTel : tfacpTel,
					tfacpEmail : tfacpEmail,
					tfacpPriConName : tfacpPriConName
				}, function(data) {
					$('#benfId').val(tfacpName);
					$('#tfTransaction\\.tfTran\\.tftCounterpartyCoyAddr1').val(
							tfacpAddr1);
					$('#tfTransaction\\.tfTran\\.tftCounterpartyCoyAddr2').val(
							tfacpAddr2);
					$('#tfTransaction\\.tfTran\\.tftCounterpartyCoyAddr3').val(
							tfacpAddr3);
					/* $('#tfTransaction\\.tfTran\\.tftCounterpartyCoyCtyCode')
							.val(tMstCountry); */
					$('#tfTransaction\\.tfTran\\.tftCounterpartyConTel').val(
							tfacpTel);
					$('#tfTransaction\\.tfTran\\.tftCounterpartyConName').val(
							tfacpPriConName);
					$('#tfTransaction\\.tfTran\\.tftCouterpartyConEmail').val(
							tfacpEmail);
					console.log(data);
				});
			});
</script>
