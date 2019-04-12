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
    <g:set var="manageInfo" value="${new com.clk.cms.mgt.ManageController()}"/>
    <div class="panel panel-flat">
        <div class="panel-heading">
            <h5 class="panel-title">${manageInfo.user_details(managers.user.id).full_name}
                <g:link controller="manage" action="managers" class="btn btn-default btn-sm"><i class="icon-plus-circle2 text-blue"></i>&nbsp;&nbsp;All Supervisors</g:link>
            </h5>
        </div>
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
                <tr class="bg-primary">
                    <th>Supervisor Name</th>
                    <th>Department</th>
                    <th colspan="3" class="text-center">Actions</th>
                </tr>
                </thead>
                <tbody>
                <g:if test="${managers}">
                    <g:each in="${managers}" var="manager_info">
                        <tr>
                            <td>${manageInfo.user_details(manager_info.user.id).full_name}</td>
                            <td>${manager_info.department.department_name}</td>
                            <td class="text-center">
                                <div class="btn-group-sm">
                                    <g:link controller="manage" action="update_manager" params="[manager_id: manager_info.id]"><i class="icon-pencil6 text-warning"></i> Update</g:link>
                                    <g:link controller="manage" action="delete_manager" params="[manager_id: manager_info.id]"><i class="icon-cancel-square2 text-danger"></i> Delete</g:link>
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
                    <li><g:if test="${page_number > 1}"><g:link controller="manage" action="managers" params="[page_number: page_number - 1]">&lsaquo;</g:link></g:if></li>
                    <g:each in="${number_of_pages}" var="page_list">
                        <li class="${page_number == page_list ? 'active' : ''}"><g:link controller="manage" action="managers" params="[page_number: page_list]">${page_list}</g:link></li>
                    </g:each>
                    <li><g:if test="${number_of_pages != null}"><g:if test="${page_number < number_of_pages.size()}"><g:link controller="manage" action="managers" params="[page_number: page_number + 1]">&rsaquo;</g:link></g:if></g:if></li>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
</html>