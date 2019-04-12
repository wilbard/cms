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

    <asset:javascript src="js/charts/cms/charts/stacked_clustered.js"/>
    <asset:javascript src="js/charts/cms/charts/semi_annual.js"/>
    <!-- /theme JS files -->

</head>
<body>
<div class="content-wrapper">
    <div class="page-header-content">
        <div class="page-title">
        </div>
    </div>
    <g:link controller="chart" action="complaints_attainment">
        <div class="col-md-6">
            <div class="panel panel-flat">
                <div class="panel-heading">
                    <h5 class="panel-title">Complaints attainment chart</h5>
                </div>

                <div class="panel-body">
                    <div class="chart-container">
                        <div class="chart has-fixed-height" id="stacked_clustered_columns"></div>
                    </div>
                </div>
            </div>
        </div>
    </g:link>
    <g:link controller="chart" action="semi_annual_complaints">
        <div class="col-md-6">
            <div class="panel panel-flat">
                <div class="panel-heading">
                    <h5 class="panel-title">Semi annual complaints chart</h5>
                </div>

                <div class="panel-body">
                    <div class="chart-container">
                        <div class="chart has-fixed-height" id="semi_annual_lines"></div>
                    </div>
                </div>
            </div>
        </div>
    </g:link>
</div>
</body>
</html>
