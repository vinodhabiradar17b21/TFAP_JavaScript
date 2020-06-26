<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@attribute name="sub_fieldName" type="java.lang.String" required="true"%>
<%@attribute name="sub_fieldKey" type="java.lang.String" required="true"%>
<%@attribute name="sub_required" type="java.lang.Boolean" required="true"%>
<%@attribute name="sub_modelName" type="java.lang.String" required="true"%>
<%@attribute name="sub_model" type="java.lang.Object" required="true"%>
<%@attribute name="list" type="java.lang.Object" required="true"%>
<%@attribute name="index" type="java.lang.String" required="true"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

	<div class="col-12 mb-1">
		<div class="row">
			<div class="col-12">
				<!-- Begin Table -->
				<table class="table">
					<tbody>
						<tr class="table_odd">
							<td><input type="text" class="form-control" id=" basicInput"
								value="Level 1" disabled></td>
							<td><select multiple="multiple" id='lstBox1${index}'
								class="form-control">
							</select></td>
							<td>
								<button type="button" id="btnRight${index}" onclick="called();"
									class="btn btn-primary mb-1 w-100">
									<i class="fa fa-chevron-right"></i>
								</button>
								<button type="button" id="btnAllRight${index}"
									class="btn btn-primary mb-1 w-100">
									<i class="fa fa-chevron-right"></i><i
										class="fa fa-chevron-right"></i>
								</button>
								<button type="button" id="btnLeft${index}"
									class="btn btn-primary mb-1 w-100">
									<i class="fa fa-chevron-left"></i>
								</button>
								<button type="button" id="btnAllLeft${index}"
									class="btn btn-primary mb-1 w-100">
									<i class="fa fa-chevron-left"></i><i class="fa fa-chevron-left"></i>
								</button>

							</td>
							<td><select multiple="multiple" id='lstBox2${index}' 
								class="form-control">
							</select></td>
							<td>
								<!-- Dropdown Action -->
								<button type="button"
									class="btn_action btn-primary dropdown-toggle"
									data-toggle="dropdown" aria-haspopup="true"
									aria-expanded="false">
									<i class="fa fa-ellipsis-h"></i>
								</button>
								<div class="dropdown-menu arrow-right mr-5">
									<button class="dropdown-item" type="button">
										<i class="fa fa-pencil-square-o"></i>&nbsp; Edit
									</button>
									<button class="dropdown-item" type="button">
										<i class="fa fa-trash"></i>&nbsp;&nbsp; Delete
									</button>
								</div> <!-- End Dropdown Action -->

							</td>
						</tr>
					</tbody>
				</table>
				<!-- End Table -->
			</div>
		</div>
		
		<input type="hidden" id="userMapCont" value="${list.userMap}"></input>					
	</div>

<script>

$( document ).ready(function() {
	var idx = '${index}';
	var fromBox = '#lstBox1'+idx;
	var toBox = '#lstBox2'+idx;
	
	
	
	var arr=[];
    <c:forEach var="model" items="${list.userMap}">
	{
	var uid = ${model.userID};
	var uname = '${model.userName}';
	var toPush = {id: uid, name: uname};
	arr.push(toPush);
	}
    </c:forEach>
    var i;
	
    for (i = 0; i < arr.length; i++) {
        $(fromBox).append(new Option(arr[i].name,arr[i].id));
    }
    
    var arr=[];
    <c:forEach var="model" items="${list.assignedUserMap}">
	{
	var uid = ${model.userID};
	var uname = '${model.userName}';
	var toPush = {id: uid, name: uname};
	arr.push(toPush);
	}
    </c:forEach>
    var i;
	
    for (i = 0; i < arr.length; i++) {
        $(toBox).append(new Option(arr[i].name,arr[i].id));
    }
});

function called() {
	var idx = '${index}';
	var fromBox = '#lstBox1'+idx;
	var toBox = '#lstBox2'+idx;
	
	console.log(idx+" called");
}

</script>