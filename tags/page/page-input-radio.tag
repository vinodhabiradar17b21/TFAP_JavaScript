<%--<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>--%>
<%--<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>--%>
<%--<%@attribute name="fieldName" type="java.lang.String" required="true" %>--%>
<%--<%@attribute name="fieldKey" type="java.lang.String" required="true" %>--%>
<%--<%@attribute name="required" type="java.lang.Boolean" required="true" %>--%>
<%--<%@attribute name="isDisabled" type="java.lang.Boolean" required="false" %>--%>




<%--<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>--%>
<%--<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>--%>
<%--<%@attribute name="fieldName" type="java.lang.String" required="true"%>--%>
<%--<%@attribute name="upVal" type="java.lang.String" required="true"%>--%>
<%--<%@attribute name="lowVal" type="java.lang.String" required="true"%>--%>
<%--<%@attribute name="fieldKey" type="java.lang.String" required="true"%>--%>
<%--<%@attribute name="fieldId" type="java.lang.String" required="true"%>--%>
<%--<%@attribute name="required" type="java.lang.Boolean" required="true"%>--%>
<%--<%@attribute name="tableName" type="java.lang.String" required="false"%>--%>
<%--<%@attribute name="selectBoxId" type="java.lang.String" required="true"%>--%>
<%--<%@attribute name="searchId" type="java.lang.String" required="false"%>--%>
<%--<%@attribute name="maxlength" type="java.lang.Boolean" required="false"%>--%>
<%--<%@attribute name="maxVal" type="java.lang.String" required="false"%>--%>
<%--<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>--%>
<%--<%@ taglib uri="http://clib.camelone.com/" prefix="co"%>--%>
<%--<%@ taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>--%>


<%--<spring:bind path="${fieldName}">--%>

    <%--<div class="form-group ${status.error ? 'has-error' : ''}">--%>
        <%--<c:if test="${not empty fieldKey}">--%>
            <%--<label for="${fieldName}"><spring:message code="${fieldKey}" /></label>--%>
        <%--</c:if>--%>
        <%--<div class="input-group">--%>

            <%--<div class="input-group-append">--%>
                <%--<input type="radio" name="charge" value="charge1" id="chargeval1"> <spring:message code="label.lcIssuance.charge.val" /><br><br>--%>
                <%--<span class="input-group-text">+</span>--%>
                <%--<input--%>
                        <%--type="text" class="form-control" id="${upVal}"--%>
                        <%--cssErrorClass="border-danger form-control ${not empty required && required ? 'required' : ''}"--%>
                        <%--cssClass="form-control ${not empty required && required ? 'required' : ''}"--%>
                        <%--aria-describedby="${fieldId}"--%>
                        <%--maxlength="${not empty maxVal && maxlength ? maxVal : ''}" value="${upVal}"/>--%>
                <%--<span class="input-group-text">/</span>--%>
                <%--<span class="input-group-text">-</span>--%>
                <%--<input type="text"--%>
                       <%--class="form-control" id="${lowVal}"--%>
                       <%--cssErrorClass="border-danger form-control ${not empty required && required ? 'required' : ''}"--%>
                       <%--cssClass="form-control ${not empty required && required ? 'required' : ''}"--%>
                       <%--aria-describedby="${fieldId}"--%>
                       <%--maxlength="${not empty maxVal && maxlength ? maxVal : ''}" value="${lowVal}">--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</spring:bind>--%>





<%--<spring:bind path="${fieldName}">--%>
    <%--<div class="form-group ${status.error ? 'has-error' : ''}">--%>
        <%--<form:checkbox value='0' id="${fieldName}" path="${fieldName}" disabled="${isdisabled?'true':'false'}"/>--%>
        <%--<label for="${fieldName}" class="ml-1"><spring:message code="${fieldKey}"/></label>--%>
            <%--&lt;%&ndash; <form:errors path="${fieldName}" class="text-danger" />  &ndash;%&gt;--%>
    <%--</div>--%>
<%--</spring:bind>--%>


<%--<input type="radio" name="charge" value="charge1" id="chargeval1"> <spring:message code="label.lcIssuance.charge.val" /><br><br>--%>


<%--<spring:bind path="${fieldName}">--%>
    <%--<label for="${fieldName}"><spring:message code="${fieldKey}"/></label>--%>
    <%--<div class="input-group">--%>
        <%--<form:input id="${fieldName}" type = "text" path="${fieldName}" cssErrorClass="border-danger form-control ${not empty required && required ? 'required' : ''}"--%>
                    <%--cssClass="form-control ${not empty required && required ? 'required' : ''}" disabled="${not empty isDisabled && isDisabled? 'true':'false'}"--%>
                    <%--placeHolder="${not empty placeHolder ? placeHolder : '' }"/>--%>
        <%--<div class="input-group-append">--%>
            <%--<button type="button" class="btn btn-primary" data-toggle="modal" data-target="${dataTarget}"><i class="fa fa-search" data-toggle="tooltip"  data-placement="bottom" title="Search HS Code"></i></button>--%>
        <%--</div>--%>
    <%--</div>--%>
    <%--<form:errors path="${fieldName}" class="red" />--%>
<%--</spring:bind>--%>