$(function () {
    $.get('/cms/chart/departmental_complaints', function (data) {
        var department = [];
        var complaints = [];

        for (var i in data) {
            var data_value = {"value":data[i], "name":[i]};
            complaints.push(data_value);
            department.push([i])
        }

        // Initialize charts
        // ------------------------------

        var basic_pie = echarts.init(document.getElementById('basic_pie'));


        // Charts setup
        // ------------------------------

        //
        // Basic pie options
        //

        var basic_pie_options = {

            // Add title
            /**title: {
                text: 'Browser popularity',
                subtext: 'Open source information',
                x: 'center'
            },*/

            // Add tooltip
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b}: {c} ({d}%)"
            },

            // Add legend
            legend: {
                orient: 'vertical',
                x: 'left',
                data: department
            },

            // Display toolbox
            toolbox: {
                show: true,
                orient: 'vertical',
                feature: {
                    mark: {
                        show: true,
                        title: {
                            mark: 'Markline switch',
                            markUndo: 'Undo markline',
                            markClear: 'Clear markline'
                        }
                    },
                    dataView: {
                        show: true,
                        readOnly: false,
                        title: 'View data',
                        lang: ['View chart data', 'Close', 'Update']
                    },
                    magicType: {
                        show: true,
                        title: {
                            pie: 'Switch to pies',
                            funnel: 'Switch to funnel',
                        },
                        type: ['pie', 'funnel'],
                        option: {
                            funnel: {
                                x: '25%',
                                y: '20%',
                                width: '50%',
                                height: '70%',
                                funnelAlign: 'left',
                                max: 1548
                            }
                        }
                    },
                    restore: {
                        show: true,
                        title: 'Restore'
                    },
                    saveAsImage: {
                        show: true,
                        title: 'Same as image',
                        lang: ['Save']
                    }
                }
            },

            // Enable drag recalculate
            calculable: true,

            // Add series
            series: [{
                name: 'Departments',
                type: 'pie',
                radius: '70%',
                center: ['50%', '57.5%'],
                data: complaints
            }]
        };


        // Apply options
        // ------------------------------

        basic_pie.setOption(basic_pie_options);


        // Resize charts
        // ------------------------------

        window.onresize = function () {
            setTimeout(function () {
                basic_pie.resize();
            }, 200);
        }
    }, "json");
});
