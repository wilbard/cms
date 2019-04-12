<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Adalipa</title>

    <!-- Theme JS files -->
    <asset:javascript src="js/plugins/tables/datatables/datatables.min.js"/>
    <asset:javascript src="js/plugins/ui/dragula.min.js"/>
    <asset:javascript src="js/plugins/forms/selects/select2.min.js"/>
    <asset:javascript src="js/plugins/forms/styling/uniform.min.js"/>
    <!--asset:javascript src="js/plugins/forms/styling/uniform.min.js"/-->

    <asset:javascript src="js/pages/datatables_basic.js"/>
    <asset:javascript src="js/pages/components_popups.js"/>
    <asset:javascript src="js/pages/form_inputs.js"/>
    <!--asset:javascript src="js/pages/extension_dnd.js"/-->
    <!-- /theme JS files -->

</head>
<body>
<div class="content-wrapper">
    <g:set var="cmsUtilities" value="${new com.clk.cms.CmsUtilities()}"/>
    <g:set var="manageInfo" value="${new com.clk.cms.mgt.ManageController()}"/>
    <div class="panel panel-flat col-md-offset-1 col-md-10 mt-20">
        <div class="panel-heading">
            <h5 class="panel-title">${complaintData.title}</h5>
            <h6 class="panel-info">Complaint escalated from ${manageInfo.user_details(complaintData.submitted_by.id).full_name}</h6>
        </div>

        <div class="panel-body">
            <span>${complaintData.description}</span>
        </div>

        <div class="panel-footer">
            <span class="media-annotation pull-right">${cmsUtilities.timeDifference(complaintData.created_time.toString())}</span>
        </div>

    </div>
</div>
</body>
</html>