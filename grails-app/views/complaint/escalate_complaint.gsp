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
            <h6 class="panel-title">Escalate Complaint</h6>
            <sec:ifLoggedIn><g:set var="userId" value="${sec.loggedInUserInfo(field: 'id')}"/></sec:ifLoggedIn>
            <g:set var="manageInfo" value="${new com.clk.cms.mgt.ManageController()}"/>
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
        <g:form controller="complaint" action="escalate_complaint" class="steps-validation" method="POST">
            <div class="panel panel-body login-form">
                <div class="content-divider text-muted form-group"><span>Escalation Details</span></div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group has-feedback has-feedback-left">
                            <label>Complaint: <span class="text-danger">*</span></label>
                            <g:hiddenField name="escalated_by_id" value="${userId}"/>
                            <g:if test="${complaint_id != null}">
                                <g:select name="complaint_id" from="${complaints}" optionKey="id" optionValue="title" class="select-search required" value="${complaint_id != null ? complaint_id : ''}" noSelection="['': 'Choose complaint']"/>
                            </g:if>
                            <g:else>
                                <g:select name="complaint_id" from="${complaints}" optionKey="id" optionValue="title" class="select-search required" noSelection="['': 'Choose complaint']"/>
                            </g:else>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group has-feedback has-feedback-left">
                            <label>Escalate To: <span class="text-danger">*</span></label>
                            <g:select name="escalated_to" from="${escalatees}" optionValue="${{it.full_name + " - " + it.department.department_name}}" optionKey="${{it.user.id}}" noSelection="['': 'Choose where to escalate']" class="form-control required"/>
                        </div>
                    </div>
                </div>
                <g:actionSubmit name="escalate_complaint" action="escalate_complaint" class="btn btn-cms btn-sm center-block" value="Escalate">Escalate <i class="icon-circle-right2 position-right"></i></g:actionSubmit>
            </div>
        </g:form>
    </div>
</div>
</body>
</html>