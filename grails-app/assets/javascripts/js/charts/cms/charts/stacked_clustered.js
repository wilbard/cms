$(function() {
    $.get('/cms/chart/processed_complaints', function (data) {
        var desired_info = [];
        var desired_label = [];
        var current_label = [];
        var current_info = [];
        for (var i in data["desired"]) {
            desired_info.push(data["desired"][i]);
            desired_label.push([i])
        }
        for (var i in data["current"]) {
            current_info.push(data["current"][i]);
            current_label.push([i])
        }

        var myChart = echarts.init(document.getElementById("stacked_clustered_columns"));
        var stacked_clustered_columns_options = {

            /**title : {
            text: 'Actual vs Planned',
            subtext: 'It can be exported'
        },*/
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data: [
                    'ECharts1 - 2k data', 'ECharts1 - 2w data', 'Pending', '',
                    'ECharts2 - 2k data', 'ECharts2 - 2w data', 'Processed'
                ]
            },
            toolbox: {
                show: true,
                feature: {
                    mark: {show: true},
                    saveAsImage: {
                        show: true,
                        title: 'export'
                    },
                    restore: {
                        show: true,
                        title: 'refresh'
                    },
                    magicType: {show: true, title: 'change', type: ['line', 'bar']}
                }
            },
            calculable: true,
            grid: {y: 70, y2: 30, x: 100, x2: 20},
            xAxis: [
                {
                    type: 'category',
                    data: desired_label
                },
                {
                    type: 'category',
                    axisLine: {show: false},
                    axisTick: {show: false},
                    axisLabel: {show: false},
                    splitArea: {show: false},
                    splitLine: {show: false},
                    data: desired_label
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    axisLabel: {formatter: '{value} Complaints'}
                }
            ],
            series: [
                {
                    name: 'Processed',
                    type: 'bar',
                    itemStyle: {
                        normal: {
                            color: 'rgba(12,184,92,1)',
                            label: {show: true, textStyle: {color: '#ffffff'}}
                        }
                    },
                    data: current_info
                },
                {
                    name: 'Pending',
                    type: 'bar',
                    xAxisIndex: 1,
                    itemStyle: {
                        normal: {
                            color: 'rgba(217,53,79,0.3)',
                            label: {show: true, textStyle: {color: '#ffffff'}}
                        }
                    },
                    data: desired_info
                }
            ]
        };
        myChart.setOption(stacked_clustered_columns_options, true);
        window.onresize = function () {
            setTimeout(function () {
                myChart.resize();
            }, 200);
        }
    }, "json");
});