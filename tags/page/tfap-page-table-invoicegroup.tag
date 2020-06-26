<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<%@attribute name="titleKey" type="java.lang.String" required="true"%>
<%@attribute name="breadCrumbKey" type="java.lang.String" required="false"%>
<%@attribute name="modelName" type="java.lang.String" required="true"%>
<%@attribute name="modelId" type="java.lang.Object" required="false"%>
<%@attribute name="columns" required="false" type="java.lang.Object" %>
<%@attribute name="isDisabled" type="java.lang.String" required="false"%>
<%@attribute name="financeTransId" type="java.lang.String" required="true"%>
<%@attribute name="isRF" type="java.lang.Boolean" required="false"%>

<c:set var="columns" value="${(empty columns) ? '${columns}' : columns}" />
<c:set var="isDisabled" value="${(empty isDisabled || isDisabled=='') ? '' : 'disabled'}" />

<div class="content-wrapper p-0">
    <div class="content-body">
        <section id="description" class="card">
            <div class="card-header p-0">
                <div class="row">
                    <div class="col-6"></div>
                </div>
            </div>
            <div class="card-content p-0">
                <div class="card-body p-0">
                    <div class="card-text">
                        <div class="row">

                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="table-responsive">
                                    <table id="invoiceGroupingTable" class="table table-striped jambo_table bulk_action stripe">
                                        <thead>
                                        <tr class="table_header text-center">
<%--                                            <th class="column-title"><spring:message code="label.rfGrp.bnkBillToId" /></th>--%>
                                            <c:choose>
                                                <c:when test="${isRF}">
                                                    <th class="column-title"><spring:message
                                                            code="label.rfGrp.bnkBillToName"/></th>
                                                </c:when>
                                                <c:otherwise>
                                                    <th class="column-title"><spring:message code="label.ifGrp.bnkBillToName"/></th>
                                                </c:otherwise>
                                            </c:choose>

                                            <th class="column-title"><spring:message  code="label.rfGrp.relatedParty" /></th>

<%--                                            <th class="column-title"><spring:message code="label.rfGrp.invBillToAdd" /></th>--%>

                                            <th class="column-title"><spring:message code="label.rfGrp.ccy" /></th>

                                            <th class="column-title"><spring:message code="label.rfGrp.totCcyAmt" /></th>
                                            
                                            
											 <c:choose>
                                                <c:when test="${isRF}">
                                                    <th class="column-title"><spring:message code="label.rfGrp.aggrt" /></th>
                                                </c:when>
                                                <c:otherwise>
                                                    <th class="column-title"><spring:message code="label.rfGrp.finpct"/></th>
                                                </c:otherwise>
                                            </c:choose>
                                            <th class="column-title"><spring:message code="label.rfGrp.finamt"/></th>
                                            <th class="column-title"><spring:message code="label.rfGrp.finccy"/></th>

                                            <th class="column-title"><spring:message code="label.rfGrp.action" /></th>
                                        </tr>
                                        </thead>
                                        <tbody></tbody>
                                    </table>
                                </div>

                                <script type="text/javascript">
                                    //Instantiate the table
                                    $("#invoiceGroupingTable").dataTable({
                                        autoWidth: false,
                                        serverSide: true,
                                        processing: true,
                                        deferLoading: 0,
                                        ajax: {
                                            url: '<spring:url value="/${modelName}/group/list/json"/>?transId=${financeTransId}',
                                            dataSrc: 'data'
                                        },
                                        columns: [
                                            {data: 'billToName', class: 'text-center'},
                                            {data: 'relatedParty', class: 'text-center'},
                                            {data: 'currency', class: 'text-center'},
                                            {data: 'totalAmount', class: 'text-center'},
                                            <c:choose>
                                            <c:when test="${isRF}">
                                            {data: 'aggregatedCrdb', class: 'text-center'},
                                            </c:when>
                                            <c:otherwise>
                                            {data: 'finPct', class: 'text-center'},
                                            </c:otherwise>
                                        	</c:choose>
                                        	{data: 'finAmt', class: 'text-center'},
                                        	{data: 'finCcy', class: 'text-center'},
                                            {
                                                data: function (row, type, set, meta) {
                                                    return '<button class="btn btn-primary rf-inv-grp-view" type="button"><i class="ft-eye"></i></button>';
                                                }, class: 'text-center'
                                            }
                                        ],
                                        paging: false,
                                        searching: false,
                                        language: {
                                            zeroRecords: 'There are no records that match your search criterion',
                                            'processing': 'Processing',
                                            infoFiltered: '',
                                            info: '',
                                            infoEmpty: ''
                                        } 
                                    });

                                    $('#rf_grouping-tab').on('shown.bs.tab', function (e) {
                                       $('#invoiceGroupingTable').DataTable().draw();
                                    });
                                </script>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
<script type="text/javascript">
    $('#invoiceGroupingTable tbody').on("click", ".rf-inv-grp-view", function () {
        const row = $("#invoiceGroupingTable").DataTable().row($(this).parents('tr')).data();
        viewGroupingByDoc(row.billToName, row.currency, '${financeTransId}');
    });

    function viewGroupingByDoc(billToName, currency, ttfId) {
        openRFInvoiceGroupModal(ttfId, billToName, currency);
    }
</script>

<c:choose>
    <c:when test="${isRF}">
        <%@ include file="/WEB-INF/views/receivableFinance/rf-rec-finance-grouping-modal.jspf" %>
    </c:when>
    <c:otherwise>
        <%@ include file="/WEB-INF/views/if/if-finance-grouping-modal.jspf" %>
    </c:otherwise>
</c:choose>