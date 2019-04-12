<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <title>Add Manager</title>

    <asset:javascript src="js/plugins/forms/validation/validate.min.js"/>
    <asset:javascript src="js/plugins/forms/selects/bootstrap_multiselect.js"/>
    <asset:javascript src="js/plugins/forms/inputs/touchspin.min.js"/>
    <asset:javascript src="js/plugins/forms/styling/switch.min.js"/>
    <asset:javascript src="js/plugins/forms/styling/switchery.min.js"/>
    <asset:javascript src="js/plugins/forms/styling/uniform.min.js"/>

    <asset:javascript src="js/core/libraries/jquery_ui/interactions.min.js"/>
    <asset:javascript src="js/plugins/forms/selects/select2.min.js"/>

    <asset:javascript src="js/pages/form_inputs.js"/>
    <asset:javascript src="js/pages/colors_success.js"/>
    <asset:javascript src="js/pages/colors_danger.js"/>
    <asset:javascript src="js/pages/form_validation.js"/>

</head>
<body>
<div class="content-wrapper">
    <div class="panel panel-body panel-cms login-form col-md-offset-1 col-md-10">
        <div class="panel-heading">
            <h6 class="panel-title">Updating Department of ${department_info.department_name}</h6>
        </div>
        <div class="row">
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
        <g:form controller="manage" action="update_department" class="steps-validation" method="POST">
            <div class="panel panel-body login-form">
                <div class="content-divider text-muted form-group"><span>Department Details</span></div>
                <div class="row">
                    <div class="col-md-offset-3 col-md-6">
                        <div class="form-group has-feedback has-feedback-left">
                            <label>Department Name: <span class="text-danger">*</span></label>
                            <g:hiddenField name="department_id" value="${department_info.id}"/>
                            <g:textField name="department_name" class="form-control required" value="${department_info.department_name != null ? department_info.department_name : ''}"/>
                            <div class="form-control-feedback">
                                <i class="icon-user-check text-muted"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <g:actionSubmit name="update_department" action="update_department" class="btn btn-cms btn-sm center-block" value="Save">Save <i class="icon-circle-right2 position-right"></i></g:actionSubmit>
            </div>
        </g:form>
    </div>
</div>
</body>
</html>