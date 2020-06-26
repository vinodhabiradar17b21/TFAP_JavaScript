<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@attribute name="titleKey" type="java.lang.String" required="true"%>
<%@attribute name="modelName" type="java.lang.String" required="true"%>
<%@attribute name="model" type="java.lang.Object" required="true"%>
<%@attribute name="isadvanced" type="java.lang.Boolean" required="false"%>
<%@attribute name="tableName" type="java.lang.String" required="false"%>
<%@attribute name="searchForm" fragment="true"%>
<%@ attribute name="columns" required="false" type="java.lang.Object" %>
<c:set var="tableName" value="${(empty tableName) ? 'dataTableInput' : tableName}" />
<c:set var="columns" value="${(empty columns) ? '${columns}' : columns}" />
	<style>
.switch {
	position: relative;
	display: inline-block;
	width: 40px;
	height: 20px;
}

.switch input {
	opacity: 0;
	width: 0;
	height: 0;
}

.slider {
	position: absolute;
	cursor: pointer;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: #ccc;
	-webkit-transition: .4s;
	transition: .4s;
}

.slider:before {
	position: absolute;
	content: "";
	height: 18px;
	width: 18px;
	left: 4px;
	bottom: 1px;
	background-color: white;
	-webkit-transition: .4s;
	transition: .4s;
}

input:checked+.slider {
	background-color: #2196F3;
}

input:focus+.slider {
	box-shadow: 0 0 1px #2196F3;
}

input:checked+.slider:before {
	-webkit-transform: translateX(16px);
	-ms-transform: translateX(16px);
	transform: translateX(16px);
}

/* Rounded sliders */
.slider.round {
	border-radius: 34px;
}

.slider.round:before {
	border-radius: 50%;
}
</style>
 <div class=""> 
	 <div class="content-body" id="tableInput"> 
		<section id="description" class="card">
			<div class="card-header">
				<div class="row">
				
					<div class="col-9">
						<c:if test="${isadvanced}">
						<h4 class="card-title">
							<spring:message code="${titleKey}" />
							&nbsp;
							<spring:message code="label.list" />
						</h4>
						</c:if>
					</div>
						
					<div class="col-3" align="right">
						<button type="button" id="addRow${tableName}" class="btn btn-info">Add&nbsp;<i class="fa fa-plus" aria-hidden="true"></i>
						</button>
						<button type="button" id="delEntries${tableName}" class="btn btn-info">Delete&nbsp;<i class="fa fa-trash" aria-hidden="true"></i>
						</button>
					</div>
				</div>
				
			</div>
			<hr>
			<!-- <div class="card-content">
				<div class="card-body">
					<div class="card-text"> -->
						<div class="row">
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<%@ include
									file="/WEB-INF/views/common/common_html_datatable_input.jspf"%>
								<script type="text/javascript">
									var aoColumns${tableName} = [
										<c:forEach items="${columns}" var="column" >
											{
										 		"render": function ( data, type, row, meta ) {
										 			var row = meta.row;
													var col="${column}";
												
													if(col=='hsefSize')
														{
														data='<select class="form-control" id="desc'+row+'" name="hsefSize" style="display: none;" disabled>'
														<c:forEach items="${HsCodeDescription}" var="data">
														+'<option value=${data.key}>${data.value}</option>'
														</c:forEach>
														+'</select>'
														+ '<input type="text" onkeypress="return isNumber(event)"  placeholder="NUMERIC VALUES" name="hsefSize" id="num'+row+'" class="form-control input-xs table-filter" style="width: 100%; display:none; font-size:1rem;" disabled>'
														+ '<input type="text" name="hsefSize" id="alphanum'+row+'" class="form-control input-xs table-filter" style="width: 100%; font-size:1rem;" >'
														+ '<input class="form-control" id="dateTest'+row+'" name="hsefSize" placeholder="MM/DD/YYY" type="text" style="display: none; font-size:1rem;" disabled>'
														
														}
												 	else if(col=='Actions')
													{
													data='&nbsp;&nbsp;&nbsp;<i class="fa fa-window-close fa-2x delrow" style="cursor:pointer; color: red; margin-top:7px"></i>'
													}  
													else if(col=='No.')
													{
													data=row+1;
													} 
													else if(col=='Select')
													{
													data='&nbsp;&nbsp;&nbsp;<input type="checkbox" class="selectBox" id="" name="someCheckbox" />'														
													} 
													else if(col.indexOf("Mandatory") >= 0 || col.indexOf("payment.sewOtherStp.dothStpEmergencyApList") >=0 )
													{
													data='&nbsp;&nbsp;&nbsp;<!-- Default switch --><label class="switch" id="'+col+row+'" style="margin-top:-15px; margin-left:10px;"><input class="mandatoryCheck" id="mandatoryCheck'+row+'" class="form-control" type="checkbox" name="'+col+'" ><span class="slider round"></span></label><input class="form-control" id="hiddenValue'+row+'" type="hidden" value="off" name="'+col+'">'														
													
													} 
											 		else if(col=='hseftCode')
														{
														
														data='<select class="form-control selectType" id="dataType'+row+'"  name="'+col+'"/>'
														<c:forEach items="${datatype}" var="data">
														+'<option value=${data.key}>${data.value}</option>'
														</c:forEach>
														+'</select>'
														}
													  
					 								 else  
														{
					 									data='<input type="text" name="'+col+'" id="'+col+'" class="form-control input-xs table-filter" style="width: 100%; font-size:1rem;" >'														
														} 
								                    return data;
								                } 
												
												},
										</c:forEach>
												
									];
							 			
									function isNumber(evt) {
									    evt = (evt) ? evt : window.event;
									    var charCode = (evt.which) ? evt.which : evt.keyCode;
									    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
									        return false;
									    }
									    return true;
									}
									
							 		$('#delEntries${tableName}').on("click", function(){
							 			$('#${tableName} tbody tr td input:checkbox:checked').each( function ()
							 				{
							 				 $("#${tableName}").DataTable().row($(this).parents('tr')).remove().draw(false);					 				
							 				}
							 			);
							 			$("#selectAll${tableName}").prop('checked',false);
							 	});
									 
								  
									
									  $('#addRow${tableName}').on( 'click', function () {
										  $("#${tableName}").DataTable().row.add([]).draw();
									    } );
									 
									  var listRows = [];
									   $('#save').on( 'click', function () {
										   $("#${tableName}").DataTable().rows().every( function ( rowIdx, tableLoop, rowLoop ) {
											  var row = $(this.node());
											  
											  listRows.push({
												  <c:forEach items="${columns}" var="column" varStatus="loop">
												  <c:if test="${column != 'Actions' && column != 'Select' }" >
												  '${column}' :row.find('td:eq(${loop.index}) input').val(),
												  </c:if>
												  </c:forEach>
											  });
											 
											  
											} );
									   }); 
									
								</script>
								<div class="table-responsive">
									<table id="${tableName}"
										class="table table-striped jambo_table bulk_action stripe">
										<thead>
											<tr class="table_header">
												<c:forEach items="${columns}" var="column" varStatus="loop">
												<c:choose>
                                                   <c:when test="${column == 'hseftCode'}">
                                                    <th class="column-title">Data Type</th>
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
									</table>
								</div>
							</div>
						</div>
		</section>
	 </div>
</div>
