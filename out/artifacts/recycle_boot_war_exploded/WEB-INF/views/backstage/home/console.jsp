<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta charset="utf-8">
  <title>车辆管理</title>

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

  <style>
    body,
    html,
    #container {
      overflow: hidden;
      width: 100%;
      height: 100%;
      margin: 0;
      font-family: "微软雅黑";
    }
  </style>
  <style type="text/css">
    .noBorder{
      border: none;
    }
  </style>
</head>
<body>



<div class="layui-fluid">
  <div class="layui-card">
    <form class="layui-form layui-card-header layuiadmin-card-header-auto" id="area">
      <div class="layui-form-item" id="area-picker">
        <div class="layui-form-label">地区选择</div>
        <div class="layui-input-inline" style="width: 200px;">
          <select name="province" class="province-selector" data-value="福建省"  lay-filter="province-1"  id="province">
            <option value="">请选择省</option>
          </select>
        </div>
        <div class="layui-input-inline" style="width: 200px;">
          <select name="city" class="city-selector"  data-value="福州市" lay-filter="city-1"  id="city">
            <option value="">请选择市</option>
          </select>
        </div>
        <div class="layui-input-inline" style="width: 200px;">
          <select name="county" class="county-selector"   lay-filter="county-1"  id="county" >
            <option value="">请选择区/县</option>
          </select>
        </div>
        <div class="layui-inline">
          <button class="layui-btn layuiadmin-btn-useradmin" lay-submit lay-filter="LAY-car-search">
            <i class="layui-icon layui-icon-search layuiadmin-button-btn">查询订单</i>
          </button>
        </div>
      </div>
    </form>
  </div>
</div>

<%--百度地图--%>
<div id="container"></div>
<div id="carrierWindow" style="display: none;margin: 10px">
  <%--表格--%>
  <div>
    <%-- 通过Lay-filer来监听每一行--%>
    <table id="car-page" lay-filter="assign_carriers"></table>

  </div>
</div>

<!--lay-event名字自己取-->
<!--每一行后面的指派按钮-->
<div id="barDemo" style="display: none">
  <a class="layui-btn layui-btn-xs" lay-event="assign">指派</a>
</div>
</body>
</html>


<script src="${basePath}/layuiadmin/layui/layui.js"></script>
<script src="//api.map.baidu.com/api?type=webgl&v=1.0&ak=jFsuLu2G5kNPhpWllelTUgzcGNG1E3Pt"></script>
<script>



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


    $(".layui-btn-sub").click(function (){
      var id=$(".orderId").text;
      console.log(id);
      layer.alert("点击了")
    })

    //地区三级联动
    layarea.render({
      elem: '#area-picker',
      change: function (res) {
        //选择结果
        console.log(res);
      },
    });

    //地图选择初始值
/*    $("#area")[0].reset();
    $("#province").val("请选择省")
    $("#city").val("请选择市")
    $("#county").val("请选择区/县")
    console.log("请选择省")*/

    var address;
    var orderId;
    //废品回收员表渲染
    var tableIns = table.render({
      elem: '#car-page'  //绑定表格元素，使用ID选择器
      , url: '${basePath}/assignCarriers'  //异步请求地址
      , cols: [[//表头  field:与实体类的属性名一致
          {field: 'carrierId', width: 120, title: '回收员ID', sort: true}
        , {field: 'realName', width: 100, title: '回收员姓名'}
        , {field: 'mobile', width: 150, title: '电话号码'}
        , {field: 'assigned', width: 100, title: '本月接单数',
          templet:function (obj){if (obj.assigned==null) return'0'
        else return obj.assigned}}
        , {field: 'finished', width: 100, title: '本月完成数',
          templet:function (obj){if (obj.finished==null) return'0'
          else return obj.finished}}
        , {fixed: 'right', title: '操作', toolbar: '#barDemo', width: 80}
      ]]
      , page: true//查找所有的数据
    });


    function openCarrierWindow(){
      mainIndex = layer.open({
        type: 1,//弹出层类型
        title: "指派废品回收员",
        area: ['700px', '600px'],
        content: $("#carrierWindow"),//引用的窗口代码 divID
      })
    }


    var mainIndex;
    //地图初始化
    var map = new BMapGL.Map('container'); // 创建Map实例
    var point = new BMapGL.Point(119.3,26.08); // 创建点坐标

    var myGeo = new BMapGL.Geocoder();//创建地址解析器实例

    map.centerAndZoom(point, 12);
    map.enableScrollWheelZoom(); // 启用滚轮放大缩小
    var marker;

    //地图相关变量
    var arr ;
    var points;
    var markers;
    var count;//markers数组长度
    var infoWindows;
    var content;
    var currentMarker;
    var currentInfoWindow;
    //收货员列表index


    //监听  每一行的点击操作tool
    table.on('tool(assign_carriers)', function (obj) {

      console.log(obj.data)
      var event = obj.event;
      var id = obj.data.carrierId;
      if (event === 'assign') {
        layer.confirm("确定将订单指派给废品回收员【"+obj.data.realName+"】吗？", function (index) {

          $.ajax({
            url: '${basePath}/assign',
            type: 'post',
            data: {orderId:orderId,carrierId: id},
            dataType: "json",
            success: function () {

            }
          })

          layer.close(index);
          layer.alert("派单成功！",{icon:1})
          //关闭收货员列表窗口
          layer.close(mainIndex);
          //关闭点窗口信息
          currentInfoWindow.close();
          //移除地图上的点坐标
          map.removeOverlay(currentMarker);

          //完成数表刷新
          tableIns.reload();



        });
      }
    })

    var  region;
    var  orderId;
    //监听搜索按钮提交的事件
    form.on("submit(LAY-car-search)", function (data) {

      region=data.field.province+data.field.city+data.field.county;
      console.log(currentInfoWindow+"???????????")
      //关闭点窗口信息
      if (currentInfoWindow!=null){
        console.log(currentInfoWindow)
        currentInfoWindow.close();
      }

      //清除点坐标
      if (count!=null){
        for (let i = 0; i < Number(count); i++) {
          map.removeOverlay(markers[i]);
        }
      }


      //地图聚焦到搜索框中的地区
      myGeo.getPoint(region, function(point) {
        if (point) {
          map.centerAndZoom(point, 12);
        }
      })

      region=data.field.province+data.field.city+data.field.county;

      tableIns.reload({
        where: {region:region},
        page: {
          curr: 1
        }
      });
      $.ajax({
        url: "${basePath}/ordersByAddress?region="+region,
        type: "post",
        dataType: "json",
        success: function (result) {

          //将list转换为数组
           arr = eval(result);
           points=new Array();
           markers=new Array();
           infoWindows=new Array();
           content=new Array();

          console.log(result);
          console.log(data);
          console.log(region);

          if (result!=null) {
            count=arr.length;
            for (let i = 0; i < arr.length; i++) {
              points[i] = new BMapGL.Point(arr[i].lng, arr[i].lat);
              markers[i] = new BMapGL.Marker(points[i]);
              map.addOverlay(markers[i]);
              // 创建信息窗口
              var opts = {
                width: 380,
                height: 210,
                title: "订单信息"
              };
              content[i]=
                       '<ul  style="margin:0 0 5px 0;padding:0.2em 0">'
                      +'<li style="line-height: 26px;font-size: 15px;">'
                      +'<span class="orderId" style="width: 100px;display: inline-block;">订单号:</span>' + arr[i].orderId + '</li>'
                      +'<li style="line-height: 26px;font-size: 15px;">'
                      +'<span style="width: 100px;display: inline-block;">卖家:</span>' + arr[i].sellerName + '</li>'
                      +'<li style="line-height: 26px;font-size: 15px;">'
                      +'<span style="width: 100px;display: inline-block;">手机:</span>' + arr[i].sellerMobile + '</li>'
                      +'<li style="line-height: 26px;font-size: 15px;">'
                      +'<span style="width: 100px;display: inline-block;">地址:</span>' + arr[i].address + '</li>'
                      +'<br>'
                      +'<div style="text-align: right"> <input type="button" class="markerBtn" id="markerBtn" value="选择收货员" > '
                      +' </div>'


              infoWindows[i] = new BMapGL.InfoWindow(content[i], opts);
              // 点标记添加点击事件
              markers[i].addEventListener('click', function () {
                map.openInfoWindow(infoWindows[i], points[i]); // 开启信息窗口
                currentInfoWindow=infoWindows[i];
                $(".markerBtn").unbind('click').click(function (){
                  orderId=arr[i].orderId;
                  currentMarker=markers[i];
                  openCarrierWindow();
                })
              });
            }
            } else {
              layer.msg("该区域内无订单!");
            }
        }
      });
      //禁止页面刷新
      return false;
    });




  });
</script>