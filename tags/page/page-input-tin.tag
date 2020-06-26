<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@attribute name="fieldName" type="java.lang.String" required="true"%>
<%@attribute name="fieldKey" type="java.lang.String" required="true"%>
<%@attribute name="fieldId" type="java.lang.String" required="true"%>
<%@attribute name="required" type="java.lang.Boolean" required="true"%>
<%@attribute name="tableName" type="java.lang.String" required="false"%>
<%@attribute name="selectBoxId" type="java.lang.String" required="true"%>
<%@attribute name="searchId" type="java.lang.String" required="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="cnsw"%>
<c:set var="tableName" value="${(empty tableName) ? 'dataTableHs' : tableName}" />
<spring:bind path="${fieldName}">
	<div class="form-group">
	  <label for="${fieldName}"><spring:message code="${fieldKey}" /></label>
	  <div class="input-group">
		<form:input id="${fieldId}" class="form-control required" path="${fieldName}" disabled="true" />
		<div class="input-group-append">
		  <div class="input-group-text">
		  				<form:checkbox path="trader.${selectBoxId}" value="on" id="${selectBoxId}" aria-label="Checkbox for following text input" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Others"/>
                   </div>
				<button type="button" id="${searchId}" class="btn btn-primary" data-toggle="modal" data-target="#${tableName}Modal"><i class="fa fa-search"> </i></button>
		</div>
	  </div>
	  <form:errors path="${fieldName}" class="red" /> 
	</div>
	<div class="modal fade" id="${tableName}Modal" role="dialog">
		<div class="modal-dialog  modal-lg">
			<!-- Modal content-->
			<div class="modal-content">
				<cnsw:pagetabletin titleKey="label.trader.tinLists"
					breadCrumbKey="label.trader.tinLists"
					modelName="sewELicense" model="${sewELicense}" tableName="${tableName}"
					isadvanced="${false}">
				</cnsw:pagetabletin>
				<div class="modal-footer">
					<button type="button" class="btn btn-info " data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	
<script type="text/javascript">
$('#${tableName} tbody')
.on('click','tr',function() {
	var row=$("#${tableName}").DataTable().row($(this)).data();
	$('#${tableName}Modal').modal('hide');
	$('#${fieldId}').val(row.accCoyRegn);
	var name = ${tableName};
	
	/*LPCO Importer*/
	if("${tableName}"=="tinImport")
	{
	$('#trader\\.sewImporter\\.dtdrTin').val(row.accCoyRegn);
	$('#trader\\.sewImporter\\.dtdrAccnId').val(row.accID);
	$('#trader\\.sewImporter\\.dtdrName').val(row.accName);
	$('#trader\\.sewImporter\\.dtdrTel').val(row.accTelephone);
	$('#trader\\.sewImporter\\.dtdrFax').val(row.accFax);
	$('#trader\\.sewImporter\\.dtdrEmail').val(row.accEmail);
	$('#trader\\.sewImporter\\.dtdrAddr1').val(row.accAddress1);
	$('#trader\\.sewImporter\\.dtdrAddr2').val(row.accAddress2);
	$('#trader\\.sewImporter\\.dtdrCity').val(row.accCity);
	$('#trader\\.sewImporter\\.dtdrProv').val(row.accProv);
	$('#trader\\.sewImporter\\.dtdrPcode').val(row.accPinCode);	
	$('#trader\\.sewImporter\\.ctyCode').val(row.accCityCode);
	}
	/*LPCO Exporter*/
	if("${tableName}"=="tinExport")
	{
	$('#trader\\.sewExporter\\.dtdrAccnId').val(row.accID);
	$('#trader\\.sewExporter\\.dtdrTin').val(row.accCoyRegn);
	$('#trader\\.sewExporter\\.dtdrName').val(row.accName);
	$('#trader\\.sewExporter\\.dtdrTel').val(row.accTelephone);
	$('#trader\\.sewExporter\\.dtdrFax').val(row.accFax);
	$('#trader\\.sewExporter\\.dtdrEmail').val(row.accEmail);
	$('#trader\\.sewExporter\\.dtdrAddr1').val(row.accAddress1);
	$('#trader\\.sewExporter\\.dtdrAddr2').val(row.accAddress2);
	$('#trader\\.sewExporter\\.dtdrCity').val(row.accCity);
	$('#trader\\.sewExporter\\.dtdrProv').val(row.accProv);
	$('#trader\\.sewExporter\\.dtdrPcode').val(row.accPinCode);	
	$('#trader\\.sewExporter\\.ctyCode').val(row.accCityCode);
	}
	/*Manifest Consignee*/
	if("${tableName}"=="tinConsignee")
	{
		$('#trader\\.sewConsignee\\.mtdrTin').val(row.accCoyRegn);
		$('#trader\\.sewConsignee\\.mtdrAccnId').val(row.accID);
		$('#trader\\.sewConsignee\\.mtdrName').val(row.accName);
		$('#trader\\.sewConsignee\\.mtdrTel').val(row.accTelephone);
		$('#trader\\.sewConsignee\\.mtdrFax').val(row.accFax);
		$('#trader\\.sewConsignee\\.mtdrEmail').val(row.accEmail);
		$('#trader\\.sewConsignee\\.mtdrAddr1').val(row.accAddress1);
		$('#trader\\.sewConsignee\\.mtdrAddr2').val(row.accAddress2);
		$('#trader\\.sewConsignee\\.mtdrCity').val(row.accCity);
		$('#trader\\.sewConsignee\\.mtdrProv').val(row.accProv);
		$('#trader\\.sewConsignee\\.mtdrPcode').val(row.accPinCode);	
		$('#trader\\.sewConsignee\\.ctyCode').val(row.accCityCode);
	}
	/*Manifest Export*/
	else if("${tableName}"=="tinExport")
	{
		$('#trader\\.sewExporter\\.mtdrTin').val(row.accCoyRegn);
		$('#trader\\.sewExporter\\.mtdrAccnId').val(row.accID);
		$('#trader\\.sewExporter\\.mtdrName').val(row.accName);
		$('#trader\\.sewExporter\\.mtdrTel').val(row.accTelephone);
		$('#trader\\.sewExporter\\.mtdrFax').val(row.accFax);
		$('#trader\\.sewExporter\\.mtdrEmail').val(row.accEmail);
		$('#trader\\.sewExporter\\.mtdrAddr1').val(row.accAddress1);
		$('#trader\\.sewExporter\\.mtdrAddr2').val(row.accAddress2);
		$('#trader\\.sewExporter\\.mtdrCity').val(row.accCity);
		$('#trader\\.sewExporter\\.mtdrProv').val(row.accProv);
		$('#trader\\.sewExporter\\.mtdrPcode').val(row.accPinCode);	
		$('#trader\\.sewExporter\\.ctyCode').val(row.accCityCode);
	}
	/*Manifest Notifier*/
	else if("${tableName}"=="tinNotifier")
	{
		$('#trader\\.sewNotifier\\.mtdrTin').val(row.accCoyRegn);
		$('#trader\\.sewNotifier\\.mtdrAccnId').val(row.accID);
		$('#trader\\.sewNotifier\\.mtdrName').val(row.accName);
		$('#trader\\.sewNotifier\\.mtdrTel').val(row.accTelephone);
		$('#trader\\.sewNotifier\\.mtdrFax').val(row.accFax);
		$('#trader\\.sewNotifier\\.mtdrEmail').val(row.accEmail);
		$('#trader\\.sewNotifier\\.mtdrAddr1').val(row.accAddress1);
		$('#trader\\.sewNotifier\\.mtdrAddr2').val(row.accAddress2);
		$('#trader\\.sewNotifier\\.mtdrCity').val(row.accCity);
		$('#trader\\.sewNotifier\\.mtdrProv').val(row.accProv);
		$('#trader\\.sewNotifier\\.mtdrPcode').val(row.accPinCode);	
		$('#trader\\.sewNotifier\\.ctyCode').val(row.accCityCode);
	}
});
</script>
</spring:bind>