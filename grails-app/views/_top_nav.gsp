<%@ page import="org.springframework.http.HttpStatus.*" %>
<!-- Main navbar -->
<div class="navbar navbar-default">
    <g:set var="cmsUtilities" value="${new com.clk.cms.CmsUtilities()}"/>
    <g:set var="manageInfo" value="${new com.clk.cms.mgt.ManageController()}"/>
    <sec:ifLoggedIn><g:set var="top_user_info" value="${com.clk.cms.User.get(sec.loggedInUserInfo(field: 'id'))}"/></sec:ifLoggedIn>
    <div class="navbar-header">
        <!--a class="navbar-brand" href="index.html"><img src="assets/images/logo_light.png" alt=""></a-->
        <ul class="nav navbar-nav visible-xs-block">
            <li><a data-toggle="collapse" data-target="#navbar-mobile"><i class="icon-tree5"></i></a></li>
            <li><a class="sidebar-mobile-main-toggle"><i class="icon-paragraph-justify3"></i></a></li>
        </ul>
    </div>

    <div class="navbar-collapse collapse" id="navbar-mobile">
        <ul class="nav navbar-nav mt-5">
            <li><asset:image src="logo-jhipster.png" height="50"/></li>
        </ul>

        <ul class="nav navbar-nav">
            <li>
                <h3><small><span class="text-cms"></span></small> <strong><span class="text-cms">Complaints Management System</span> </strong></h3>
            </li>
        </ul>

        <ul class="nav navbar-nav navbar-right">
            <!--li><a>Mlipa A/C: 011</a></li-->
            <!--li class="dropdown language-switch">
                <a class="dropdown-toggle text-primary-800" data-toggle="dropdown">
                    <img src="assets/images/flags/gb.png" class="position-left" alt="">
                    English
                    <span class="caret"></span>
                </a>

                <ul class="dropdown-menu bg-top-nav-gray">
                    <li><a class="swahili"><img src="assets/images/flags/de.png" alt=""> <span class="text-primary-800">Kiswahili</span></a></li>
                    <li><a class="english"><img src="assets/images/flags/gb.png" alt=""> <span class="text-primary-800">English</a></li>
                </ul>
            </li-->
            <sec:ifLoggedIn>
                <li class="dropdown">
                    <g:set var="jsonData" value="${new com.clk.cms.mgt.ComplaintController()}"/>
                    <g:set var="inbox" value="${jsonData.inbox(top_user_info)}"/>
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="icon-bubbles9 text-primary"></i>
                        <span class="visible-xs-inline-block position-right">Complaints</span>
                        <g:if test="${inbox.alerts_count > 0}">
                            <span class="badge bg-warning-400">${inbox.alerts_count}</span>
                        </g:if>
                        <i class="caret text-primary"></i>
                    </a>

                    <div class="dropdown-menu dropdown-content width-350 bg-cms">
                        <div class="dropdown-content-heading">
                            <g:link controller="complaint" action="complaints_list" class="text-white">Complaints</g:link>
                            <ul class="icons-list">
                                <li><g:link controller="complaint" action="add_complaint"><i class="icon-compose text-white"></i></g:link></li>
                            </ul>
                        </div>

                        <ul class="media-list dropdown-content-body">
                            <g:each in="${inbox["alerts"]}" var="alert">
                                <g:link controller="complaint" action="complaint_info" params="[complaint_id: alert.complaint.id]">
                                    <li class="media ${alert.is_accessed ? 'alert alert-default no-border' : 'alert alert-info no-border'}">
                                        <div class="media-body ${alert.is_accessed ? '' : 'text-bold'}">
                                            <span class="media-heading">
                                                <span class="text-white">${manageInfo.user_details(alert.escalated_by.id).full_name}</span>
                                                <span class="media-annotation pull-right">${cmsUtilities.timeDifference(alert.escalated_time.toString())}</span>
                                            </span>
                                            <span class="text-muted text-300-truncate">${alert.complaint.description}</span>
                                        </div>
                                    </li>
                                </g:link>
                            </g:each>
                            <g:if test="${inbox.alerts_count < 1}">
                                <li class="media">
                                    <div class="media-body text-center">
                                        <span class="text-white">No new complaints</span>
                                    </div>
                                </li>
                            </g:if>
                        </ul>

                        <div class="dropdown-content-footer bg-cms">
                            <g:link controller="complaint" action="complaints_list" data-popup="tooltip" title="All Complaints"><i class="icon-menu display-block text-white"></i></g:link>
                        </div>
                    </div>
                </li>

                <li class="dropdown dropdown-user">
                    <a class="dropdown-toggle text-cms" data-toggle="dropdown">
                        <img src="assets/images/placeholder.jpg" alt="">
                        <span class="text-primary">${top_user_info.username}</span>
                        <i class="caret text-primary"></i>
                    </a>

                    <ul class="dropdown-menu dropdown-menu-right bg-cms">
                        <li><g:link controller="user" action="my_profile"><i class="icon-user-tie text-white"></i> <span class="text-white">My profile</span></g:link></li>
                        <li class="divider"></li>
                        <li><g:link controller="logout" action="index"><i class="icon-switch2 text-danger"></i> <span class="text-danger">Logout</span></g:link></li>
                    </ul>
                </li>
            </sec:ifLoggedIn>
            <sec:ifNotLoggedIn><li><g:link controller="home" action="homepage"><i class="icon-switch"></i> Login</g:link></li></sec:ifNotLoggedIn>
        </ul>
    </div>
</div>
<!-- /main navbar -->


<!-- Page header -->
<div class="page-header">
    <div class="breadcrumb-line bg-cms">
        <ul class="breadcrumb breadcrumb-arrows">
            <li><g:link url="${request.getHeader('referer')}" class="text-white"><i class="icon-arrow-left52 position-left"></i>Back</g:link><span class="text-semibold"></span></li>
            <li><g:link controller="home" action="homepage"><i class="icon-home2 position-left"></i> Home</g:link></li>
            <li>
                <g:if test="${controllerName}">
                    <g:if test="${controllerName == 'home'}">
                        <g:link controller="home" action="homepage" class="text-white">Dashboard</g:link>
                        </span> <i class="icon-arrow-right22"></i> ${cmsUtilities.toCapitalize(cmsUtilities.replaceChars(actionName.toString(), "_", " "))}
                    </g:if>
                    <g:else>
                        ${cmsUtilities.toCapitalize(controllerName.toString())}
                        </span> <i class="icon-arrow-right22"></i> ${cmsUtilities.toCapitalize(cmsUtilities.replaceChars(actionName.toString(), "_", " "))}
                    </g:else>
                </g:if>
            </li>
        </ul>

        <ul class="breadcrumb-elements">
            <!--li><a href="#"><i class="icon-comment-discussion position-left"></i> Support</a></li-->
            <sec:ifLoggedIn>
                <sec:ifAllGranted roles="ROLE_ADMIN">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="icon-gear position-left"></i>
                            Configuration
                            <span class="caret"></span>
                        </a>

                        <ul class="dropdown-menu dropdown-menu-right bg-cms">
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="icon-users4 position-left"></i>
                            Users Management
                            <span class="caret"></span>
                        </a>

                        <ul class="dropdown-menu dropdown-menu-right bg-cms">
                            <li class="${(controllerName == 'manage' && (actionName == 'departments' || actionName == 'add_department' || actionName == 'update_department') ? 'active' : '')}"><g:link controller="manage" action="departments"><i class="icon-users4"></i><span>Departments</span></g:link></li>
                            <li class="${(controllerName == 'manage' && (actionName == 'user_list' || actionName == 'add_user' || actionName == 'update_user') ? 'active' : '')}"><g:link controller="manage" action="user_list"><i class="icon-users4"></i><span>Users</span></g:link></li>
                            <li class="${(controllerName == 'manage' && (actionName == 'roles' || actionName == 'add_role' || actionName == 'update_role') ? 'active' : '')}"><g:link controller="manage" action="roles"><i class="icon-lock5"></i><span>Roles</span></g:link></li>
                            <li class="${(controllerName == 'manage' && (actionName == 'user_roles' || actionName == 'update_user_role') ? 'active' : '')}"><g:link controller="manage" action="user_roles"><i class="icon-lock5"></i><span>User Roles</span></g:link></li>
                            <li class="divider"></li>
                            <li class="${(controllerName == 'manage' && (actionName == 'add_menager' || actionName == 'update_manager' || actionName == 'managers') ? 'active' : '')}"><g:link controller="manage" action="managers"><i class="icon-user-lock"></i><span>Supervisors</span></g:link></li>
                        </ul>
                    </li>
                </sec:ifAllGranted>
            </sec:ifLoggedIn>
        </ul>
    </div>

    <!--sec:ifLoggedIn-->
        <!--div class="page-header-content">
            <div class="page-title">
            </div>
        </div-->
    <!--/sec:ifLoggedIn-->
</div>