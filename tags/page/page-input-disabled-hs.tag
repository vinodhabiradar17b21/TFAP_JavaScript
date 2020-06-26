<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@attribute name="fieldName" type="java.lang.String" required="true"%>
<%@attribute name="fieldKey" type="java.lang.String" required="true"%>
<%@attribute name="required" type="java.lang.Boolean" required="true"%>
<%@attribute name="tableName" type="java.lang.String" required="false"%>
<%@attribute name="isDescReq" type="java.lang.String" required="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="cnsw"%>
<c:set var="tableName" value="${(empty tableName) ? 'dataTableHs' : tableName}" />
<spring:bind path="${fieldName}">
	<div class="input-group">
		<co:pageinput fieldName="${fieldName}" fieldKey="${fieldKey}"
			required="true" isDisabled="false" />
			
		<div class="input-group-append">
			<button type="button" class="btn btn-primary" data-toggle="modal" style="height:38px; margin-top:25px"
				data-target="#${tableName}Modal">
				<i class="fa fa-search" data-toggle="tooltip"
					data-placement="bottom" title="Search HS Code"></i>
			</button>
		</div>
		<c:if test="${isDescReq}">
		
			
			</c:if>
	</div>
	<div class="modal fade" id="${tableName}Modal" role="dialog">
		<div class="modal-dialog  modal-lg">

			<!-- Modal content-->
			<div class="modal-content">
				<cnsw:pagetablehs fieldName="${fieldName}" titleKey="${fieldKey}"
					breadCrumbKey="label.harmonizedSystemCodes"
					modelName="harmonizedSystemCode" model="${harmonizedSystemCode}" tableName="${tableName}"
					isadvanced="${false}">
				</cnsw:pagetablehs>


				<div class="modal-footer">
					<button type="button" class="btn btn-info " data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>


</spring:bind>