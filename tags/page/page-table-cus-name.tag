<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@attribute name="titleKey" type="java.lang.String" required="true"%>
<%@attribute name="breadCrumbKey" type="java.lang.String"
	required="true"%>
<%@attribute name="modelName" type="java.lang.String" required="true"%>
<%@attribute name="model" type="java.lang.Object" required="true"%>
<%@attribute name="isadvanced" type="java.lang.Boolean" required="false"%>
<%@attribute name="tableName" type="java.lang.String" required="false"%>
<%@attribute name="searchForm" fragment="true"%>
<%@attribute name="rootUrlName" type="java.lang.String" required="false"%>

<div class="content-wrapper">
	<div class="content-body">
		<section id="description" class="card">
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

							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<%@ include
									file="/WEB-INF/views/common/tfap_common_html_datatable.jspf"%>
							<script type="text/javascript">
									var urlView${tableName} = "<spring:url value='/${rootUrlName}/cp/list/json' />";
									var aoColumnsView${tableName} = [ 
									{
										"mData" : "tfacpUen"
									},
									{
										"mData" : "tfacpName"
									}
									];
								</script>  
								<div class="table-responsive">
									<table id="${tableName}"
										class="table table-striped jambo_table bulk_action stripe">
										<thead>
											<tr class="table_header">

												<th class="column-title"><spring:message
														code="label.customer.cusuenColHeader" /></th>
												<th class="column-title"><spring:message
														code="label.customer.cusnameColHeader" /></th>


											</tr>
										</thead>
										<tbody></tbody>
										<tfoot>
											<tr>

												<th><input type="text" id="search_0"
													class="form-control input-xs table-filter"
													style="width: 100%;"
													placeholder="<spring:message code="label.customer.cusuenColHeader" />"></th>
												<th><input type="text" id="search_0"
													class="form-control input-xs table-filter"
													style="width: 100%;"
													placeholder="<spring:message code="label.customer.cusnameColHeader" />"></th>

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
