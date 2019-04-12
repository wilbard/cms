<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Welcome to Grails</title>

    <asset:stylesheet src="main.app.css"/>

    <!-- Theme JS files -->
    <asset:javascript src="js/plugins/tables/datatables/datatables.min.js"/>
    <asset:javascript src="js/plugins/forms/selects/select2.min.js"/>

    <asset:javascript src="js/pages/datatables_basic.js"/>
    <!-- /theme JS files -->

</head>
<body>
<div class="content-wrapper">
    <g:set var="cmsUtilities" value="${new com.clk.cms.CmsUtilities()}"/>
    <g:set var="manageInfo" value="${new com.clk.cms.mgt.ManageController()}"/>
    <g:set var="user_info" value="${com.clk.cms.User.get(sec.loggedInUserInfo(field: 'id'))}"/>
    <div class="panel panel-flat">
        <div class="panel-heading">
            <h5 class="panel-title">Complaints
                <g:link controller="complaint" action="add_complaint" class="btn btn-default btn-sm"><i class="icon-plus-circle2 text-blue"></i>&nbsp;&nbsp;Add Complaint</g:link>
            </h5>
        </div>
        <div class="panel-body">
            <div class="datatable-header">
                <g:if test="${errorMessage}">
                    <div class="col-md-3"></div>
                    <div class="col-md-6 alert alert-danger alert-bordered alert-rounded text-center">
                        <button type="button" class="close" data-dismiss="alert"><span>&times;</span><span class="sr-only">Close</span></button>
                        ${errorMessage}
                    </div>
                    <div class="col-md-3"></div>
                </g:if>
                <g:if test="${successMessage}">
                    <div class="col-md-3"></div>
                    <div class="col-md-6 alert alert-info alert-bordered alert-rounded text-center">
                        <button type="button" class="close" data-dismiss="alert"><span>&times;</span><span class="sr-only">Close</span></button>
                        ${successMessage}
                    </div>
                    <div class="col-md-3"></div>
                </g:if>
            </div>

            <div class="table-responsive">
                <table class="table tables-min-height">
                    <thead>
                    <tr class="bg-cms">
                        <th>Complaint</th>
                        <th>Last Action</th>
                        <th>Sender</th>
                        <th>Delivered Time</th>
                        <th>Last Escalated</th>
                        <th>Status</th>
                        <th colspan="2" class="text-center">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:if test="${complaints}">
                        <g:each in="${complaints}" var="complaint">
                            <g:set var="escalate_info" value="${manageInfo.escalate_details(complaint.id, user_info.id)}"/>
                            <tr class="${escalate_info != null ? (escalate_info.is_accessed ? 'alert alert-default no-border' : 'alert alert-info no-border' ) : ''}">
                                <td>${complaint.title}</td>
                                <td>${complaint.last_action}</td>
                                <td>${manageInfo.user_details(complaint.submitted_by.id).full_name}</td>
                                <td>${cmsUtilities.dateFormat(complaint.created_time.toString())}</td>
                                <td>${cmsUtilities.dateFormat(complaint.updated_time.toString())}</td>
                                <td>${complaint.status}</td>
                                <td class="text-center">
                                    <div class="btn-group-sm">
                                        <g:link controller="complaint" action="complaint_info" params="[complaint_id: complaint.id]"><i class="icon-pencil6 text-warning"></i> View</g:link>
                                        <g:link controller="complaint" action="escalate_complaint" params="[complaint_id: complaint.id]"><i class="icon-pencil6 text-warning"></i> Escalate</g:link>
                                    </div>
                                </td>
                            </tr>
                        </g:each>
                    </g:if>
                    </tbody>
                </table>
            </div>

            <div class="row section-margin">
                <div class="col-md-offset-4 col-md-4 col-md-offset-4">
                    <ul class="pagination pagination-separated pagination-rounded">
                        <li><g:if test="${page_number > 1}"><g:link controller="user" action="user_list" params="[page_number: page_number - 1]">&lsaquo;</g:link></g:if></li>
                        <g:each in="${number_of_pages}" var="page_list">
                            <li class="${page_number == page_list ? 'active' : ''}"><g:link controller="user" action="user_list" params="[page_number: page_list]">${page_list}</g:link></li>
                        </g:each>
                        <li><g:if test="${number_of_pages != null}"><g:if test="${page_number < number_of_pages.size()}"><g:link controller="user" action="user_list" params="[page_number: page_number + 1]">&rsaquo;</g:link></g:if></g:if></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>