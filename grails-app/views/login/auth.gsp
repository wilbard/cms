<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="login" />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login</title>

    <link href="https://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700,900"/>

</head>
<body>

<!-- Page container -->
<div class="page-container pb-20">

    <!-- Page content -->
    <div class="page-content">

        <!-- Main content -->
        <div class="content-wrapper">
        <!-- Advanced login -->
            <g:form controller="login" action="authenticate" method="POST" autocomplete="off">
                <div class="panel panel-body login-form">
                    <div class="text-center">
                        <div class="border-warning-400 text-warning-400"><i class="icon-lock5"></i></div>
                        <asset:image src="logo-jhipster.png" height="50"/>
                        <!--h5 class="content-group-lg">Login to your account <small class="display-block">Enter your credentials</small></h5-->
                    </div>
                    <div class="content-divider text-muted form-group"><span></span></div>
                    <g:if test="${flash.message}">
                        <div class="message text-danger text-center" role="status">${flash.message}</div>
                    </g:if>

                    <div class="form-group has-feedback has-feedback-left">
                        <g:textField name="username" class="form-control" placeholder="Username"/>
                        <div class="form-control-feedback">
                            <i class="icon-user text-muted"></i>
                        </div>
                    </div>

                    <div class="form-group has-feedback has-feedback-left">
                        <g:passwordField name="password" class="form-control" placeholder="Password"/>
                        <div class="form-control-feedback">
                            <i class="icon-lock2 text-muted"></i>
                        </div>
                    </div>

                    <div class="form-group login-options">
                        <div class="row">
                            <div class="col-sm-6">
                                <label class="checkbox-inline">
                                    <input type="checkbox" name="remember-me" id="remember_me" class="styled" checked="checked">
                                    Remember
                                </label>
                            </div>

                            <div class="col-sm-6 text-right">
                                <g:link controller="login" action="login_password_recover">Forgot password?</g:link>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <g:submitButton name="Login" class="btn bg-blue btn-block">Login <i class="icon-circle-right2 position-right"></i></g:submitButton>
                    </div>

                    <!--div class="content-divider text-muted form-group"><span>Don't have an account?</span></div-->
                    <!--g:link controller="login" action="register" class="btn bg-slate btn-block content-group"--><!--Register--><!--/g:link-->
                    <!--span class="help-block text-center no-margin"--><!--By continuing, you're confirming that you've read our --><!--g:link controller="login" action="terms_of_service" target="_blank"--><!--Terms &amp; Conditions--><!--/g:link--><!-- and <a href="#">Cookie Policy</a></span-->
                </div>
            </g:form>
        <!-- /advanced login -->

        </div>
        <!-- /main content -->

    </div>
    <!-- /page content -->

</div>
<!-- /page container -->

</body>
</html>
