<%@tag description="Page Tag" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://clib.camelone.com/" prefix="co"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>

<%@attribute name="modelName" type="java.lang.String" required="true"%>
<%@attribute name="columns" required="false" type="java.lang.Object" %>
<%@attribute name="isDisabled" type="java.lang.String" required="false"%>
<%@attribute name="tfapid" type="java.lang.String" required="true"%>

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
                                    <table id="invoiceStatusTable" class="table table-striped jambo_table bulk_action stripe">
                                        <thead>
                                        <tr class="table_header text-center">
                                            <th class="column-title"><spring:message code="label.modal.invoice.download.filename" /></th>
                                            <th class="column-title"><spring:message code="label.modal.invoice.download.uploadedBy" /></th>
                                            <th class="column-title"><spring:message code="label.modal.invoice.download.uplodatedDt" /></th>
                                            <th class="column-title"><spring:message code="label.modal.invoice.download.processingDt" /></th>
                                            <th class="column-title"><spring:message code="label.modal.invoice.download.processedDt" /></th>
                                            <th class="column-title"><spring:message code="label.modal.invoice.download.status" /></th>
                                            <th class="column-title"><spring:message code="label.modal.invoice.download.waitingTime" /></th>
                                            <th class="column-title"><spring:message code="label.modal.invoice.download.action" /></th>
                                        </tr>
                                        </thead>
                                        <tbody></tbody>
                                    </table>
                                </div>

                                <script type="text/javascript">
                                    //Instantiate the table
                                    $("#invoiceStatusTable").dataTable({
                                        autoWidth: false,
                                        serverSide: true,
                                        processing: true,
                                        deferLoading: 0,
                                        aaSorting: [[2, "desc"]],
                                        ajax: {
                                            url: '<spring:url value="/${modelName}/download_invoice_status"/>?transId=${tfapid}',
                                            dataSrc: 'data'
                                        },
                                        columns: [
                                            {data: 'tfuiFileM', class: 'text-center'},
                                            {data: 'tfuiUploadUid', class: 'text-center'},
                                            {data: 'tfuiUploadDtStr', class: 'text-center'},
                                            {data: 'tfuiProcessStartDtStr', class: 'text-center'},
                                            {data: 'tfuiProcessEndDtStr', class: 'text-center'},
                                            {data: 'tfuiProcessStatus', class: 'text-center'},
                                            {data: 'waitingTime', class: 'text-center'},
                                            {
                                                data: function (row, type, set, meta) {
                                                	if(row.tfuiSystemReportM && row.tfuiSystemReportM!=''){
                                                    	return '<a href="/TFAPortal/${modelName}/download_status_report?sysFileM='+row.tfuiSystemReportM+'">'+
                                                    		'<button class="btn btn-primary download" type="button"><i class="fa fa-download"></i></button></a>';
                                                	}else{
                                                		return '';
                                                	}
                                                }, class: 'text-center'
                                            }
                                        ],
                                        paging: false,
                                        language: {
                                            zeroRecords: 'There are no records that match your search criterion',
                                            'processing': 'Processing',
                                            infoFiltered: '',
                                            info: '',
                                            infoEmpty: ''
                                        }
                                    });

                                    $('#modals_status_report_download').on('show.bs.modal', function (e) {
                                       $('#invoiceStatusTable').DataTable().draw();
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
    $('#invoiceStatusTable tbody').on("click", ".download", function () {
        const row = $("#invoiceStatusTable").DataTable().row($(this).parents('tr')).data();

    });

</script>
