<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Add Student</title>

    <asset:stylesheet src="main.app.css"/>

    <!-- Theme JS files -->
    <asset:javascript src="js/plugins/forms/validation/validate.min.js"/>
    <asset:javascript src="js/plugins/forms/selects/bootstrap_multiselect.js"/>
    <asset:javascript src="js/plugins/forms/selects/select2.min.js"/>
    <asset:javascript src="js/plugins/forms/styling/uniform.min.js"/>

    <asset:javascript src="js/pages/form_validation.js"/>
    <asset:javascript src="js/pages/datatables_basic.js"/>
    <asset:javascript src="js/pages/components_popups.js"/>
    <asset:javascript src="js/pages/form_inputs.js"/>
    <!-- /theme JS files -->

</head>
<body>
<div class="content-wrapper">
    <div class="page-header-content">
        <div class="page-title">
        </div>
    </div>
    <div class="panel panel-flat">
        <div class="panel-heading">
            <h6 class="content-group text-semibold">
                <g:set var="cmsUtilities" value="${new com.clk.cms.CmsUtilities()}"/>
                Reports that can be exported
                <small class="display-block">All reports on this module are in the form of excel (xlsx or xls) and pdf documents</small>
            </h6>
        </div>
        <div class="panel-body">
            <g:if test="${errorMessage}">
                <div class="row">
                    <div class="col-md-3"></div>
                    <div class="col-md-6 alert alert-danger alert-bordered alert-rounded text-center">
                        <button type="button" class="close" data-dismiss="alert"><span>&times;</span><span class="sr-only">Close</span></button>
                        ${errorMessage}
                    </div>
                    <div class="col-md-3"></div>
                </div>
            </g:if>
            <g:if test="${successMessage}">
                <div class="row">
                    <div class="col-md-3"></div>
                    <div class="col-md-6 alert alert-info alert-bordered alert-rounded text-center">
                        <button type="button" class="close" data-dismiss="alert"><span>&times;</span><span class="sr-only">Close</span></button>
                        ${successMessage}
                    </div>
                    <div class="col-md-3"></div>
                </div>
            </g:if>
            <div class="col-md-12">
                <div class="panel panel-cms">
                    <div class="panel-heading">
                        <h6 class="panel-title">Complaints Report</h6>
                    </div>

                    <div class="panel-body">
                        <g:form controller="reports" class="form-validate-jquery" action="cms_reports" method="POST" target="_blank">
                            <div class="row">
                                <div class="content-divider form-group"><span>Duration:</span></div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>File format: <span class="text-danger">*</span></label>
                                        <g:hiddenField name="reportName" value="complaintsReport" />
                                        <g:select name="fileType" from="['Excel', 'PDF']" noSelection="['PDF': 'Choose format']" class="select-search"/>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>From date: <span class="text-danger">*</span></label>
                                        <input class="form-control" type="date" name="from_date">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>To date: <span class="text-danger">*</span></label>
                                        <input class="form-control" type="date" name="to_date">
                                    </div>
                                </div>
                            </div>

                            <div class="text-right">
                                <g:actionSubmit name="cms_reports" action="cms_reports" class="btn btn-cms center-block" value="Export">Export <i class="icon-arrow-right14 position-right"></i></g:actionSubmit>
                            </div>
                        </g:form>
                    </div>
                </div>
            </div>
            <!-- /Payments reports -->
        </div>
    </div>
</div>
<script>
    // Select with search
    $('.select-search').select2();
</script>
</body>
</html>
