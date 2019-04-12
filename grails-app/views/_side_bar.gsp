<%@ page import="com.clk.cms.User" %>
<!-- Main sidebar -->
<div class="sidebar sidebar-main">
    <div class="sidebar-content">
        <sec:ifLoggedIn>
            <g:set var="side_UID" value="${sec.loggedInUserInfo(field: 'id')}"/>
            <g:set var="side_user" value="${com.clk.cms.User.get(side_UID)}"/>
            <g:set var="manageInfo" value="${new com.clk.cms.mgt.ManageController()}"/>
        </sec:ifLoggedIn>

        <!-- User menu -->
        <div class="sidebar-user">
            <div class="category-content">
                <div class="media">
                    <a href="#" class="media-left"><img src="assets/images/placeholder.jpg" class="img-circle img-sm" alt=""></a>
                    <div class="media-body">
                        <span class="media-heading text-semibold">${manageInfo.getUserDetails(side_user.id).full_name}</span>
                        <div class="text-size-mini text-muted">
                            <i class="icon-pin text-size-small"></i> &nbsp;${manageInfo.getUserDetails(side_user.id).address}
                        </div>
                    </div>

                    <div class="media-right media-middle">
                        <ul class="icons-list">
                            <li>
                                <a href="#"><i class="icon-cog3"></i></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- /user menu -->


        <!-- Main navigation -->
        <div class="sidebar-category sidebar-category-visible">
            <div class="category-content no-padding">
                <ul class="navigation navigation-main navigation-accordion">

                    <!-- Main -->
                    <!--li class="navigation-header"><span>Main</span> <i class="icon-menu" title="Main pages"></i></li-->
                    <li><g:link controller="home" action="homepage"><i class="icon-home4"></i> <span>Dashboard</span></g:link></li>
                    <sec:ifLoggedIn>
                        <li>
                            <a href="#"><i class="icon-collaboration"></i> <span>Complaints</span></a>
                            <ul>
                                <li class="${(controllerName == 'complaint' && actionName == 'complaints' ? 'active' : '')}"><g:link controller="complaint" action="complaints"><i class="icon-file-spreadsheet2"></i><span>Sent Complaints</span></g:link></li>
                                <li class="${(controllerName == 'complaint' && actionName == 'complaints_list' ? 'active' : '')}"><g:link controller="complaint" action="complaints_list"><i class="icon-file-spreadsheet2"></i><span>Received Complaints</span></g:link></li>
                                <li class="divider"></li>
                                <li class="${(controllerName == 'complaint' && actionName == 'escalate_complaint' ? 'active' : '')}"><g:link controller="complaint" action="escalate_complaint"><i class="icon-file-spreadsheet2"></i><span>Escalations</span></g:link></li>
                            </ul>
                        </li>
                        <li>
                            <a href="#"><i class="icon-file-stats"></i> <span>Reports & Charts</span></a>
                            <ul>
                                <li class="${(controllerName == 'chart' && actionName == 'our_charts' ? 'active' : '')}"><g:link controller="chart" action="our_charts"><i class="icon-statistics"></i><span>Charts</span></g:link></li>
                                <li class="${(controllerName == 'reports' && actionName == 'cms_reports' ? 'active' : '')}"><g:link controller="reports" action="cms_reports"><i class="icon-file-spreadsheet2"></i> <span>Reports</span></g:link></li>
                            </ul>
                        </li>
                    </sec:ifLoggedIn>
                    <!-- /page kits -->
                </ul>
            </div>
        </div>
        <!-- /main navigation -->
    </div>
</div>
<!-- /main sidebar -->