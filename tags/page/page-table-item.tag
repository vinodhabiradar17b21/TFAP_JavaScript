<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@attribute name="titleKey" type="java.lang.String" required="true"%>
<%@attribute name="breadCrumbKey" type="java.lang.String"
	required="false"%>
<%@attribute name="modelName" type="java.lang.String" required="true"%>
<%@attribute name="model" type="java.lang.Object" required="true"%>
<%@attribute name="modelId" type="java.lang.Object" required="false"%>
<%@attribute name="searchForm" fragment="true"%>
<div class="content-body">
	<section id="description" class="card">
	
	<div class="title-tab font-weight-bold border-bottom-form mb-1">
					 <div class="row">
					 <div class="col-8"><spring:message code="${titleKey}" />
							<spring:message code="label.list" /></div>
					 <div class="col-4">
					 <div class="float-right">
						 <button class="btn-f btn-primary" id="addEntry" style="margin-top: -15px;" type="button"><i class="fa fa-plus"></i>&nbsp; Add New</button>
					 </div>
					 </div>
					 </div>
				 </div>
		<div class="row">
	
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<%@ include file="/WEB-INF/views/common/common_html_datatable_item.jspf"%>
				<script type="text/javascript">
									var editUrl= "<spring:url value='/${modelName}/getEditableFileds/' />";
									var editablecols=[];
									var status;
									//editablecols=${editablecolumns};
									var aoColumns = [
										<c:forEach items="${columns}" var="column" varStatus="loop">
											{"mData" : "${column}",
												 
												 "mRender": function (data, type, full) {
													 var col="${column}";
												    if(col=='Actions')
													{
													data= '<button type="button" class="btn_action btn-primary dropdown-toggle" data-toggle="dropdown"'
														+'   aria-haspopup="true" aria-expanded="false">'
													     +'<i class="fa fa-ellipsis-h"></i>'
							                                +'</button>'
							                              +' <div class="dropdown-menu arrow-right mr-5">'
							                              +'<button class="dropdown-item editrow" type="button"><i class="fa fa-pencil-square-o "></i>&nbsp; Edit </button>'
							                            +'<button class="dropdown-item deactivate" type="button"><i class="fa fa-trash-o"></i>&nbsp; Delete</button>'
							                            +'</div>'
													}
												   
													return data;
													}	 
											
											},
											
										</c:forEach>
									];
								
								</script>
				<div class="table-responsive">
					<table id="dataTable"
						class="table table-striped jambo_table bulk_action stripe">
						<thead>
							<tr class="table_header">
								<c:forEach items="${columns}" var="column" varStatus="loop">
												<c:choose>
                                                   <c:when test="${column == 'hsCode'}">
                                                    <th class="column-title">HS Code</th>
                                                  </c:when>  
                                                  <c:when test="${column == 'No.'}">
                                                    <th class="column-title">No.</th>
                                                  </c:when>    
                                                      <c:when test="${column == 'Select'}">
                                                    <th class="column-title"><input type="checkbox" class="selectBox" id="selectAll${tableName}" name="someCheckbox" /></th>
                                                  </c:when> 
                                               <c:otherwise>
                                                    <th class="column-title"><spring:message
											code="label.${modelName}.${column}" /></th>
                                              </c:otherwise>
                                              </c:choose>
												</c:forEach>
							</tr>
						</thead>
						<tbody></tbody>
						<tfoot>
						 	<tr>
								<c:forEach items="${columns}" var="column">
							<c:choose>
                                   <c:when 
							test="${ !fn:contains(column, 'Actions') && !fn:contains(column, 'No.') && !fn:contains(column, 'Select')}">               
                                      	<th><input type="text" id="search_0"
										class="form-control input-xs table-filter"
										style="width: 100%;"
										placeholder="<spring:message code='label.${modelName}.${column}'/>"></th>
                                              </c:when>
							         <c:otherwise>
                                                	<th></th>
                                              </c:otherwise>
							
							           </c:choose>
                      
								
								</c:forEach>
							</tr> 
						</tfoot>
					</table>
				</div>
			</div>
		</div>

</section>
</div>


