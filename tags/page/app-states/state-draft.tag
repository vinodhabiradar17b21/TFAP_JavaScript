<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@attribute name="isDisabled" type="java.lang.Boolean" required="false"%>

<div class="content-header-right text-right">
	<div class="btn-group" role="group"
		aria-label="Button group with nested dropdown">


		<tfap:state-print/>
					<tfap:state-termscond/>

		<tfap:tfap-user-role-permission userRoles="${userRoles}"
			TFAP_COM_MAKER="true">
			<a href="javascript:void(0)" class="btn btn-outline-primary"
				data-toggle="tooltip" data-placement="bottom" title="Discard"
				data-original-title="Discard" id="discard-action-btn"> <i
				class="fa fa-trash"></i>
			</a>
		</tfap:tfap-user-role-permission>
		<!--Commenting Reset Button- Saurabh -->
		<!-- 			<a href="#" class="btn btn-outline-primary" id="reset-action-btn" data-toggle="tooltip"
			data-placement="bottom" title="Reset" data-original-title="Reset"><i class="fa fa-repeat"></i></a> -->

		<!-- 		removed TFA_BANK_ADMIN and TFAP_COM_ADMIN -->
		<c:choose>
			<c:when
				test="${tfApplication.tfTransaction.tfTran.msgType eq 'IBULC' || tfApplication.tfTransaction.tfTran.msgType eq 'IBCOL' || tfApplication.tfTransaction.tfTran.msgType eq 'IBCON' || tfApplication.tfTransaction.tfTran.msgType eq 'IBLCN'}">
				<tfap:tfap-user-role-permission userRoles="${userRoles}"
					TFAP_BANK_MAKER="true">
					<a href="javascript:void(0)" class="btn btn-outline-primary"
						data-toggle="tooltip" data-placement="bottom" title="Discard"
						data-original-title="Discard" id="discard-action-btn"> <i
						class="fa fa-trash"></i>
					</a>
				</tfap:tfap-user-role-permission>
				<tfap:tfap-user-role-permission userRoles="${userRoles}"
					TFAP_BANK_MAKER="true">
					<a href="javascript:void(0)" id="save-action-btn"
						class="btn btn-outline-primary" data-toggle="tooltip"
						data-placement="bottom" title="Save" data-original-title="Save"
						onclick="submit_form('save');"><i class="fa fa-floppy-o"></i></a>
				</tfap:tfap-user-role-permission>
			</c:when>
			<c:otherwise>
				<tfap:tfap-user-role-permission userRoles="${userRoles}"
					TFAP_COM_MAKER="true">
					<a href="javascript:void(0)" id="save-action-btn"
						class="btn btn-outline-primary" data-toggle="tooltip"
						data-placement="bottom" title="Save" data-original-title="Save"
						onclick="submit_form('save');"><i class="fa fa-floppy-o"></i></a>
				</tfap:tfap-user-role-permission>
			</c:otherwise>
		</c:choose>
		
			

	</div>
	<tfap:state-submit-bank />
</div>

<tfap:action-discard />
<tfap:action-reset />

<tfap:auto-save />

<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$("#discard-action-btn")
								.click(
										function() {
											openDiscardModal(appId,
													'${tfApplication.tfTransaction.tfTran.msgType}');
										});

						$('#reset-action-btn').on('click', function() {
							openResetModal();
						});

						$('#print_btn')
								.on(
										"click",
										function(e) {
											window
													.open(
															rootUrl
																	+ "/print?transactionId=${tfApplication.tfTransaction.tfTran.ttfId}&docType=${tfApplication.tfTransaction.tfTran.msgType}",
															'_blank');

										});
					});
</script>