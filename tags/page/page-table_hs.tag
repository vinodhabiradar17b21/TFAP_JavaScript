<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@attribute name="titleKey" type="java.lang.String" required="true"%>
<%@attribute name="breadCrumbKey" type="java.lang.String"
	required="true"%>
<%@attribute name="modelName" type="java.lang.String" required="true"%>
<%@attribute name="tableName" type="java.lang.String" required="true"%>
<%@attribute name="model" type="java.lang.Object" required="true"%>
<%@attribute name="isadvanced" type="java.lang.Boolean" required="false"%>
<%@attribute name="fieldName" type="java.lang.String" required="true" %>
<c:set var="isDatatbleview"
	value="${(empty extraField) ? false : extraField}" />
<%@attribute name="searchForm" fragment="true"%>
<div class="content-wrapper">
	<div class="content-body">
		<section id="description" class="card">
			<div class="card-header">
				<div class="row">
					<div class="col-6">
						<h4 class="card-title">
							<spring:message code="${titleKey}" />
							
							<spring:message code="label.list" />
						</h4>
					</div>

				</div>
			</div>
			<div class="card-content">
				<div class="card-body">
					<div class="card-text">
						<div class="row">

							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<%@ include
									file="/WEB-INF/views/common/common_html_datatable_hsList.jspf"%>
								<script type="text/javascript">
								
							
									/* 		$(document).ready(function(){
												$.ajax({url: "/CNSWPortal/harmonizedSystemCode/hscolumns",
													success: function(result){
											    }});
											}); */
									var urlView = "<spring:url value='/${modelName}/list/json/' />";
									var aoColumnsView = [ {
										"mData" : "hsCode"
									},

									{
										"mData" : "hsDescription"
									},

									{
										"mData" : "uomByHsUom"
									},

									];
									
								</script>
								<div class="table-responsive">
									<table id="${tableName}"
										class="table table-striped jambo_table bulk_action stripe">
										<thead>
											<tr class="table_header">

												<th class="column-title">HS Code</th>

												<th class="column-title">Description</th>

												<th class="column-title">UOM</th>


											</tr>
										</thead>
										<tbody></tbody>
										<tfoot>
											<tr>
												<th><input type="text" id="search_0"
													class="form-control input-xs table-filter"
													style="width: 100%;" placeholder="HS Code"></th>

												<th><input type="text" id="search_0"
													class="form-control input-xs table-filter"
													style="width: 100%;" placeholder="Description"></th>

												<th><input type="text" id="search_0"
													class="form-control input-xs table-filter"
													style="width: 100%;" placeholder="UOM"></th>

											</tr>
										</tfoot>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>

</div>
<script type="text/javascript">

$('#${tableName} tbody')
.on(
		'click',
		'tr',
		function() {
			var row = $(this);
			var hsCode = row[0].childNodes[0].innerText.trim();

			<c:choose>
			<c:when test="${extraField}">
			$
					.ajax({
						url : "../hsCodeValidator?hscode="
								+ hsCode,
						success : function(result) {
							if (!result) {
								swal(
										"",
										"Extra Field Configuration for selected HSCode already exists!",
										"warning");
								$('#${fieldName}').val("");
							} else {
								$('#${tableName}Modal').modal(
										'hide');
								$('#${fieldName}')
										.val(
												row[0].childNodes[0].innerText
														.trim());
								$('#${fieldName}desc')
								.val(
										row[0].childNodes[1].innerText
												.trim());
							}
							
						}
					});
			</c:when>
			<c:otherwise>
			$('#${tableName}Modal').modal('hide');
			document.getElementById('${fieldName}').value = row[0].childNodes[0].innerText.trim();
			document.getElementById('${fieldName}Desc').value = row[0].childNodes[1].innerText.trim();
			$('#sewItemhsCodeDesc').val(row[0].childNodes[1].innerText.trim());		//for hidden field in sewLicenceDocItem.jspf
			
				<c:choose>
					<c:when test="${hsEFListHasVal}">
					$.ajax({
						url : "../sewELicense/hsCodeXtraFieldDisplay?hscode="+hsCode,
						type : "POST",	
						success : function(result) {
							var arr=JSON.parse(result);
							fromTagHsCodeXtraField(arr);
						}
					
					});
					$.ajax({
						url : "../sewELicense/hsCodeInterProdDisplay?hscode="+hsCode,
						type : "POST",	
						success : function(result) {
							fromTagInternalProd(result,hsCode);
						}
					
					});
					</c:when>
				</c:choose>
			</c:otherwise>
			</c:choose>

		});
</script>
