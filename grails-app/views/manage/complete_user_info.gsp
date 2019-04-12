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
            <h6 class="panel-title">Complete Staff registration</h6>
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
        <g:form controller="manage" action="complete_user_info" class="steps-validation" method="POST">
            <div class="panel panel-body login-form">
                <div class="content-divider text-muted form-group"><span>User Details</span></div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group has-feedback has-feedback-left">
                            <label>Full Name: <span class="text-danger">*</span></label>
                            <g:textField name="full_name" class="form-control required" value="${user_return.full_name != null ? user_return.full_name : ''}" placeholder="Full Name"/>
                            <div class="form-control-feedback">
                                <i class="icon-user-check text-muted"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group has-feedback has-feedback-left">
                            <label>Username: <span class="text-danger">*</span></label>
                            <g:textField name="username" class="form-control required" value="${username}" disabled="disabled"/>
                            <div class="form-control-feedback">
                                <i class="icon-user-check text-muted"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Department: <span class="text-danger">*</span></label>
                            <g:select name="department_id" from="${departments}" value="${user_return.department_id != null ? user_return.department_id : ''}" optionKey="id" optionValue="department_name" noSelection="['': 'Choose Department']" class="select-search required"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>User Type: <span class="text-danger">*</span></label>
                            <g:select name="user_type_id" from="${user_types}" value="${user_return.user_type_id != null ? user_return.user_type_id : ''}" class="select-search required" noSelection="['': 'Choose User Type']"
                                      optionValue="user_type" optionKey="id"/>
                        </div>
                    </div>
                </div>
                <g:actionSubmit name="complete_user_info" action="complete_user_info" class="btn btn-cms btn-sm center-block" value="Finish">Finish <i class="icon-circle-right2 position-right"></i></g:actionSubmit>
            </div>
        </g:form>
    </div>
</div>
</body>
</html>