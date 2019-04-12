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
    <div class="panel panel-flat">
        <div class="panel-heading">
            <h5 class="panel-title">Department of ${departments.department_name}
                <g:link controller="manage" action="departments" class="btn btn-default btn-sm"><i class="icon-book3 text-blue"></i>&nbsp;&nbsp;All Departments</g:link>
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
                    <th>Department</th>
                    <th colspan="3" class="text-center">Actions</th>
                </tr>
                </thead>
                <tbody>
                <g:if test="${departments}">
                    <g:each in="${departments}" var="department">
                        <tr>
                            <td>${department.department_name}</td>
                            <td class="text-center">
                                <div class="btn-group-sm">
                                    <g:link controller="manage" action="update_department" params="[department_id: department.id]"><i class="icon-pencil6 text-warning"></i> Update</g:link>
                                    <g:link controller="manage" action="delete_department" params="[department_id: department.id]"><i class="icon-cancel-square2 text-danger"></i> Delete</g:link>
                                </div>
                            </td>
                        </tr>
                    </g:each>
                </g:if>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>