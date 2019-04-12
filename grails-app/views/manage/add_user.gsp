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
    <div class="page-header-content">
        <div class="page-title">
        </div>
    </div>
    <div class="panel panel-body panel-cms login-form col-md-offset-1 col-md-10">
        <div class="panel-heading">
            <h6 class="panel-title">Register Staff</h6>
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
        <g:form controller="manage" action="add_user" class="steps-validation" method="POST">
            <div class="panel panel-body login-form">
                <div class="content-divider text-muted form-group"><span>User Details</span></div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group has-feedback has-feedback-left">
                            <label>Full Name: <span class="text-danger">*</span></label>
                            <g:if test="${user_return != null}">
                                <g:textField name="full_name" class="form-control required" value="${user_return.full_name != null ? user_return.full_name : ''}" placeholder="Full Name"/>
                            </g:if>
                            <g:else>
                                <g:textField name="full_name" class="form-control required" placeholder="Full Name"/>
                            </g:else>
                            <div class="form-control-feedback">
                                <i class="icon-user-check text-muted"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group has-feedback has-feedback-left">
                            <label>Username: <span class="text-danger">*</span></label>
                            <g:if test="${user_return != null}">
                                <g:textField name="username" class="form-control required" value="${user_return.username != null ? user_return.username : ''}" placeholder="Username"/>
                            </g:if>
                            <g:else>
                                <g:textField name="username" class="form-control required" placeholder="Username"/>
                            </g:else>
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
                            <g:if test="${user_return != null}">
                                <g:select name="department_id" value="${user_return.department_id != null ? user_return.department_id : ''}" from="${departments}" optionKey="id" optionValue="department_name" noSelection="['': 'Choose Department']" class="select-search required"/>
                            </g:if>
                            <g:else>
                                <g:select name="department_id" from="${departments}" optionKey="id" optionValue="department_name" noSelection="['': 'Choose Department']" class="select-search required"/>
                            </g:else>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group has-feedback has-feedback-left">
                            <label>Password: <span class="text-danger">*</span></label>
                            <g:passwordField name="password" class="form-control required" placeholder="Create password"/>
                            <div class="form-control-feedback">
                                <i class="icon-user-lock text-muted"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>User Type: <span class="text-danger">*</span></label>
                            <g:if test="${user_return != null}">
                                <g:select name="user_type_id" value="${user_return.user_type_id != null ? user_return.user_type_id : ''}" from="${user_types}" class="select-search required" noSelection="['': 'Choose User Type']"
                                          optionValue="user_type" optionKey="id"/>
                            </g:if>
                            <g:else>
                                <g:select name="user_type_id" from="${user_types}" class="select-search required" noSelection="['': 'Choose User Type']"
                                      optionValue="user_type" optionKey="id"/>
                            </g:else>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group has-feedback has-feedback-left">
                            <label>Confirm Password: <span class="text-danger">*</span></label>
                            <g:passwordField name="confirm" class="form-control required" placeholder="Confirm password"/>
                            <div class="form-control-feedback">
                                <i class="icon-user-lock text-muted"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="content-divider text-muted form-group"><span>User Contacts</span></div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group has-feedback has-feedback-left">
                            <label>Permanent Address: <span class="text-danger"></span></label>
                            <g:if test="${user_return != null}">
                                <g:textField name="address" value="${user_return.address != null ? user_return.address : ''}" class="form-control required" placeholder="Permanent Address"/>
                            </g:if>
                            <g:else>
                                <g:textField name="address" class="form-control required" placeholder="Permanent Address"/>
                            </g:else>
                            <div class="form-control-feedback">
                                <i class="icon-mention text-muted"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group has-feedback has-feedback-left">
                            <label>Current Address: <span class="text-danger"></span></label>
                            <g:if test="${user_return != null}">
                                <g:textField name="current_address" value="${user_return.current_address != null ? user_return.current_address : ''}" class="form-control required" placeholder="Current Address"/>
                            </g:if>
                            <g:else>
                                <g:textField name="current_address" class="form-control required" placeholder="Current Address"/>
                            </g:else>
                            <div class="form-control-feedback">
                                <i class="icon-phone2 text-muted"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group has-feedback has-feedback-left">
                            <label>Emai Address: <span class="text-danger"></span></label>
                            <g:if test="${user_return != null}">
                                <g:textField name="email" value="${user_return.email != null ? user_return.email : ''}" class="form-control required" placeholder="Office email"/>
                            </g:if>
                            <g:else>
                                <g:textField name="email" class="form-control required" placeholder="Office email"/>
                            </g:else>
                            <div class="form-control-feedback">
                                <i class="icon-mention text-muted"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group has-feedback has-feedback-left">
                            <label>Phone Number: <span class="text-danger"></span></label>
                            <g:if test="${user_return != null}">
                                <g:textField name="phone_number" value="${user_return.phone_number != null ? user_return.phone_number : ''}" class="form-control required" placeholder="Phone Number"/>
                            </g:if>
                            <g:else>
                                <g:textField name="phone_number" class="form-control required" placeholder="Phone Number"/>
                            </g:else>
                            <div class="form-control-feedback">
                                <i class="icon-phone2 text-muted"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <g:actionSubmit name="add_user" action="add_user" class="btn btn-cms btn-sm center-block" value="Add">Add <i class="icon-circle-right2 position-right"></i></g:actionSubmit>
            </div>
        </g:form>
    </div>
</div>
</body>
</html>