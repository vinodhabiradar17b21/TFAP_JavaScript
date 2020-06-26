<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="content-header-right text-right">	
	<div class="btn-group" role="group"
		aria-label="Button group with nested dropdown">
		
		<tfap:state-print/>
		<tfap:state-termscond/>
		<c:choose>
			<c:when test="${tfApplication.tfTransaction.tfTran.msgType eq 'IBULC' || tfApplication.tfTransaction.tfTran.msgType eq 'IBCOL' || tfApplication.tfTransaction.tfTran.msgType eq 'IBCON' || tfApplication.tfTransaction.tfTran.msgType eq 'IBLCN'}">
				<tfap:tfap-user-role-permission userRoles="${userRoles}" TFAP_BANK_APPROVER="true">
					<a class="btn btn-outline-primary" id="reject-action-btn"
						data-toggle="tooltip" data-placement="bottom" title="Request For Modification"
						data-original-title="Reject">
						<i class="fa fa-times-circle"></i>
					</a>
				</tfap:tfap-user-role-permission>
			</c:when>
			<c:otherwise>
				<tfap:tfap-user-role-permission userRoles="${userRoles}" TFAP_COM_APPROVER="true" >
					<a class="btn btn-outline-primary" id="reject-action-btn"
						data-toggle="tooltip" data-placement="bottom" title="Request For Modification"
						data-original-title="Reject">
						<i class="fa fa-times-circle"></i> <!-- Reject -->
					</a>
				</tfap:tfap-user-role-permission>
			</c:otherwise>
		</c:choose>
		&nbsp;
	</div>
	<tfap:state-submitted-bank isSubmissionForAuth="true"/>
</div>
	
<tfap:action-reject/>
<tfap:action-submit/>
<tfap:action-print/>	
	
<script type="text/javascript">
	
/* 	$("#submitauth").on('click', function() {
		 if (retrieveBankSpecific) {
	            $.get(rootUrl + "/view/bankSpecific?bnkAccn=" + $('#selectedBank :selected').val() + "&doc_type=${tfApplication.tfTransaction.tfTran.msgType}" + "&tfap_id=${tfApplication.tfTransaction.tfTran.ttfId}", function (data, status) {

	                data = data.replace("editForm", "bankSpcEditForm");
	                $("#bankspecific").html(data);
	                //to remove form tag to submit
	                $("#bankspecific").html($("#bank_polpulate"));
	            });
	        }
	});
	 */
	$("#reject-action-btn").on('click', function() {
		openRejectModal(appId, '${tfApplication.tfTransaction.tfTran.msgType}')
	});
	
	$(document).ready(function () {
        $("#submitauth").click(function () {
    		openSubmitModal(appId, '${tfApplication.tfTransaction.tfTran.msgType}')
        });
    });
</script>
