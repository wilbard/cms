$(function() {
    $.get('/cms/chart/annual_chart', function (unordered) {
        var data = {};
        Object.keys(unordered).sort().forEach(function(key) {
            data[key] = unordered[key];
        });

        var month = [];
        var amount = [];

        for (var i in data) {
            amount.push(data[i]);
            month.push([i])
        }

        var myChart = echarts.init(document.getElementById("semi_annual_lines"));
        var semi_annual_lines_options = {

            /**title : {
            text: 'Actual vs Planned',
            subtext: 'It can be exported'
        },*/
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data: [
                    'ECharts1 - 2k data', 'ECharts1 - 2w data', 'Annual Report', ''
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
                    data: month
                },
                {
                    type: 'category',
                    axisLine: {show: false},
                    axisTick: {show: false},
                    axisLabel: {show: false},
                    splitArea: {show: false},
                    splitLine: {show: false},
                    data: month
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    axisLabel: {formatter: '{value} complaints'}
                }
            ],
            series: [
                {
                    name: 'Semi-Annual Report',
                    type: 'line',
                    xAxisIndex: 1,
                    itemStyle: {
                        normal: {
                            color: 'rgba(91,192,222)',
                            label: {show: true, textStyle: {color: '#ffffff'}}
                        }
                    },
                    data: amount
                }
            ]
        };
        myChart.setOption(semi_annual_lines_options, true);
        window.onresize = function () {
            setTimeout(function () {
                myChart.resize();
            }, 200);
        }
    }, "json");
});