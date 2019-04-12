<!-- Footer -->
<div class="navbar navbar-default navbar-fixed-bottom footer">
    <ul class="nav navbar-nav visible-xs-block">
        <li><a class="text-center collapsed" data-toggle="collapse" data-target="#footer"><i class="icon-circle-up2"></i></a></li>
    </ul>

    <div class="navbar-collapse collapse" id="footer">
        <div class="navbar-text">
            <g:set var="thisYear" value="${new java.util.Date()}"/>
            <span class="text-black">Copyright &copy; <g:formatDate date="${thisYear}" format="yyyy"/></span> <g:link controller="home" action="homepage" class="navbar-link  text-primary-800">Complaints Management System</g:link> <span class="text-black">Powered by</span> <a href="http://www.datavision.co.tz/" class="navbar-link  text-primary-800" target="_blank">UNHCR</a>
        </div>

        <div class="navbar-right">
            <ul class="nav navbar-nav">
                <li class="${actionName == 'about' ? 'active' : ''}"><g:link controller="home" action="about" class="text-primary-800">About</g:link></li>
                <li class="${actionName == 'terms' ? 'active' : ''}"><g:link controller="login" action="terms_of_service" class="text-primary-800">Terms</g:link></li>
                <li class="${actionName == 'contact' ? 'active' : ''}"><g:link controller="home" action="contact" class="text-primary-800">Contact</g:link></li>
            </ul>
        </div>
    </div>
</div>
<!-- /footer -->
<script>
    // Select with search
    $('.select-search').select2();
</script>