<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>UNHCR</title>

    <!-- Theme JS files -->
    <asset:javascript src="js/pages/components_navs.js"/>
    <!-- /theme JS files -->

</head>
<body>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3">
            <div class="panel-group accordion-sortable content-group-lg" id="accordion-controls-clients">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h6 class="panel-title">
                            <g:link controller="client" action="client_list">Clients Management</g:link>
                        </h6>

                        <div class="heading-elements">
                            <ul class="icons-list">
                                <li><a data-action="collapse"></a></li>
                                <li><a data-action="close"></a></li>
                            </ul>
                        </div>
                    </div>
                    <div id="accordion-controls-client" class="panel-collapse collapse in">
                        <div class="panel-body">
                            Manage clients' for administration purposes.
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="panel-group accordion-sortable content-group-lg" id="accordion-controls-users">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h6 class="panel-title">
                            <g:link controller="user" action="user_list">Users Management</g:link>
                        </h6>

                        <div class="heading-elements">
                            <ul class="icons-list">
                                <li><a data-action="collapse"></a></li>
                                <li><a data-action="close"></a></li>
                            </ul>
                        </div>
                    </div>
                    <div id="accordion-controls-user" class="panel-collapse collapse in">
                        <div class="panel-body">
                            Manage users' accounts
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="panel-group accordion-sortable content-group-lg" id="accordion-controls-schools">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h6 class="panel-title">
                            <g:link controller="institution" action="course_list">School / College Management</g:link>
                        </h6>

                        <div class="heading-elements">
                            <ul class="icons-list">
                                <li><a data-action="collapse"></a></li>
                                <li><a data-action="close"></a></li>
                            </ul>
                        </div>
                    </div>
                    <div id="accordion-controls-school" class="panel-collapse collapse in">
                        <div class="panel-body">
                            Manage school / college activities
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="panel-group accordion-sortable content-group-lg" id="accordion-controls-students">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h6 class="panel-title">
                            <g:link controller="student" action="student_list">Students Management</g:link>
                        </h6>

                        <div class="heading-elements">
                            <ul class="icons-list">
                                <li><a data-action="collapse"></a></li>
                                <li><a data-action="close"></a></li>
                            </ul>
                        </div>
                    </div>
                    <div id="accordion-controls-student" class="panel-collapse collapse in">
                        <div class="panel-body">
                            Manage Students activities
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="panel-group accordion-sortable content-group-lg" id="accordion-controls-fees">
                <div class="panel panel-info">
                    <g:link controller="fee" action="fee_structure">
                        <div class="panel-heading">
                            <h6 class="panel-title">
                                Fee Management
                            </h6>

                            <div class="heading-elements">
                                <ul class="icons-list">
                                    <li><a data-action="collapse"></a></li>
                                    <li><a data-action="close"></a></li>
                                </ul>
                            </div>
                        </div>
                    </g:link>

                    <g:link controller="fee" action="fee_structure">
                        <div id="accordion-controls-fee" class="panel-collapse collapse in">
                            <div class="panel-body">
                                Manage fee activities
                            </div>
                        </div>
                    </g:link>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="panel-group accordion-sortable content-group-lg" id="accordion-controls-staffs">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h6 class="panel-title">
                            <g:link controller="client" action="staff_list">Staff Management</g:link>
                        </h6>

                        <div class="heading-elements">
                            <ul class="icons-list">
                                <li><a data-action="collapse"></a></li>
                                <li><a data-action="close"></a></li>
                            </ul>
                        </div>
                    </div>
                    <div id="accordion-controls-staff" class="panel-collapse collapse in">
                        <div class="panel-body">
                            Manage staff accounts
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="panel-group accordion-sortable content-group-lg" id="accordion-controls-notifications">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h6 class="panel-title">
                            <g:link controller="notifications" action="sms_notification">Notifications</g:link>
                        </h6>

                        <div class="heading-elements">
                            <ul class="icons-list">
                                <li><a data-action="collapse"></a></li>
                                <li><a data-action="close"></a></li>
                            </ul>
                        </div>
                    </div>
                    <div id="accordion-controls-notification" class="panel-collapse collapse in">
                        <div class="panel-body">
                            Email and sms notifications
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
