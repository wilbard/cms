<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="layout" content="main"/>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>cms</title>

    <!-- Theme JS files -->
    <asset:javascript src="js/charts/cms/echarts/echarts.min.js"/>

    <asset:javascript src="js/charts/cms/charts/semi_annual.js"/>
    <!-- /theme JS files -->

</head>
<body>
<div class="content-wrapper">
    <div class="col-md-12">
        <div class="panel panel-flat">
            <div class="panel-heading">
                <h5 class="panel-title">Semi annual complaints chart</h5>
                <div class="heading-elements">
                    <ul class="icons-list">
                        <li><a data-action="collapse"></a></li>
                        <li><a data-action="reload"></a></li>
                        <li><a data-action="close"></a></li>
                    </ul>
                </div>
            </div>

            <div class="panel-body">
                <div class="chart-container">
                    <div class="chart has-fixed-height" id="semi_annual_lines"></div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
