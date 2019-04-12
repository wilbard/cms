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
            <h5 class="panel-title">List of registered users
                <g:link controller="manage" action="user_list" class="btn btn-default btn-sm"><i class="icon-users4 text-blue"></i>&nbsp;&nbsp;All Users</g:link>
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
                    <th>Name</th>
                    <th>Email Address</th>
                    <th>Phone Number</th>
                    <th>Current Address</th>
                    <th>User Type</th>
                    <th>Status</th>
                    <th colspan="3" class="text-center">Actions</th>
                </tr>
                </thead>
                <tbody>
                <g:if test="${user_list}">
                    <g:each in="${user_list}" var="user_info">
                        <tr>
                            <td>${user_info.full_name}</td>
                            <td>${user_info.email != null ? user_info.email : 'Incomplete registration'}</td>
                            <td>${user_info.phone_number != null ? user_info.phone_number : 'Incomplete registration'}</td>
                            <td>${user_info.current_address != null ? user_info.current_address : 'Incomplete registration'}</td>
                            <td>${user_info.user_type.user_type}</td>
                            <td><span class="label ${user_info.user.enabled ? 'label-success' : 'label-danger'}">${user_info.user.enabled ? 'Activated' : 'Deactivated'}</span></td>
                            <td class="text-center">
                                <div class="btn-group-sm">
                                    <g:link controller="manage" action="user_activation" params="[user_id: user_info.user.id, action_type: user_info.user.enabled ? 'suspend' : 'activate']">
                                        <i class="icon-${user_info.user.enabled ? 'cross2' : 'check'} text-${user_info.user.enabled ? 'warning' : 'success'}"></i>${user_info.user.enabled ? 'Suspend' : 'Activate'}</g:link>
                                    <g:link controller="manage" action="update_user" params="[user_id: user_info.id]"><i class="icon-pencil6 text-warning"></i> Update</g:link>
                                    <g:link controller="manage" action="user_delete" params="[user_id: user_info.id]"><i class="icon-cancel-square2 text-danger"></i> Delete</g:link>
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