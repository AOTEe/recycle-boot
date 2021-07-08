<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>上月份统计</title>

    <%--获得当前工程名--%>
    <%
    String basePath = request.getContextPath();
    pageContext.setAttribute("basePath", basePath);
    %>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${basePath}/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${basePath}/layuiadmin/style/admin.css" media="all">
</head>

<body>


<div class="layui-fluid">
    <div class="layui-card">
        <form class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item" id="area-picker">
                <div class="layui-form-label">地区选择</div>
                <div class="layui-input-inline" style="width: 200px;">
                    <select name="province" class="province-selector"  data-value="福建省" lay-filter="province-1" id="province">
                        <option value="">请选择省</option>
                    </select>
                </div>
                <div class="layui-input-inline" style="width: 200px;">
                    <select name="city" class="city-selector" data-value="福州市"  lay-filter="city-1" id="city">
                        <option value="">请选择市</option>
                    </select>
                </div>
                <div class="layui-input-inline" style="width: 200px; display: none">
                    <select name="county" class="county-selector" lay-filter="county-1">
                        <option value="">请选择区</option>
                    </select>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn " id="search">
                        <i class="layui-icon  layuiadmin-button-btn">查询</i>
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

        <div id="waste" style="width: 600px;height:400px;float: left"></div>

        <div id="region" style="width: 600px;height:400px;float: left"></div>


<script src="${basePath}/layuiadmin/layui/layui.js"></script>
<!-- 引入 ECharts 文件 -->
<script src="${basePath}/layuiadmin/modules/echarts.min.js"></script>
<script>

    //echars
    // 指定图表的配置项和数据
    var wasteChart = echarts.init(document.getElementById('waste'));
    var regionChart = echarts.init(document.getElementById('region'));

    var wasteOption = {
        title: {
            text: '上月份废品成交额',
            left: 'center'
        },
        tooltip: {},
        legend: {
            data:['成交金额']

        },
        xAxis: {
            data: []
        },
        yAxis: {},
        series: [{
            name: '金额:元',
            type: 'bar',
            data: []
        }]
    };
    //地区统计
    var regionOption = {
        title: {
            text: '上月份地区收货重量',
            //subtext: '纯属虚构',
            left: 'center'
        },
        tooltip: {
            trigger: 'item'
        },
        legend: {
            orient: 'vertical',
            left: 'left',
        },
        series: [
            {
                name: '收货量:KG',
                type: 'pie',
                radius: '50%',
                data:[],

                emphasis: {
                    itemStyle: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                },
                label:{            //饼图图形上的文本标签
                    normal:{
                        show:true,
                        formatter:'{d}%'


                    }
                },
            }
        ]
    };


    layui.config({
        base: '${basePath}/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'useradmin', 'table', 'layer','layarea'], function () {
        var $ = layui.$
            , form = layui.form
            , table = layui.table
            , layer = layui.layer
            , layarea=layui.layarea;



        //地区三级联动
        layarea.render({
            elem: '#area-picker',
            change: function (res) {
                //选择结果
                console.log(res);
            }
        });

        charsAjax("福建省福州市");

        $("#search").click(function (){

            var region=$("#province").val()+$("#city").val()
            charsAjax(region);
            console.log(region)
            return false;
        })


        // 使用刚指定的配置项和数据显示图表。
        wasteChart.setOption(wasteOption);

        regionChart.setOption(regionOption);

        function charsAjax(region){
            //ajax获取echars中需要的数据
            $.ajax({ url: "${basePath}/echars/regionData",data:{region:region}, success: function(res){

                     // 异步加载数据
                    regionChart.setOption({

                        series: [
                            {
                                type: 'pie',
                                radius: '50%',
                                data:res
                            }]
                    });
                }});

            //ajax获取echars中需要的数据
            $.ajax({ url: "${basePath}/echars/wasteData",data:{region:region}, success: function(res){
                    // 异步加载数据
                    var arr=res;
                    var categories=new Array();
                    var data=new Array();
                    console.log(res)
                    for (var i=0;i<arr.length;i++){
                        categories.push(arr[i].waste);
                        data.push(arr[i].price)
                    }
                    console.log(categories)
                    console.log(data)

                    wasteChart.setOption({

                        xAxis: {
                            axisLabel: {

                                interval: 0, //横轴信息全部显示
                                rotate: -30, //-15度角倾斜显示

                            },
                            data: categories

                        },
                        series: [{
                            // 根据名字对应到相应的系列
                            data: data
                        }]
                    });
                }});
        }


    });
</script>
</body>
</html>
