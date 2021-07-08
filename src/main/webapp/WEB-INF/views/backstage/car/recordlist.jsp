<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>出勤记录</title>

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
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">车牌号</label>
                    <div class="layui-input-block">
                        <input type="text" id="carNum" name="carNum" placeholder="请输入" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">收货员姓名</label>
                    <div class="layui-input-block">
                        <input type="text" id="realName" name="realName" placeholder="请输入" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">打卡时间</label>
                    <div class="layui-input-block">
                        <input type="text" id="recordTime" name="recordTime" class="layui-input">
                    </div>
                </div>

                <div class="layui-inline">
                    <button class="layui-btn layuiadmin-btn-useradmin" lay-submit lay-filter="LAY-car-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </form>


        <%--表格--%>
        <div>
            <%-- 通过Lay-filer来监听每一行--%>
            <table id="car-page" lay-filter="LAY-car-page"></table>

        </div>
    </div>
</div>
<%--查看大图div--%>
<div id="bigPicture" style="display: none;margin: 10px">
    <div style="width:250px;height:250px;border:3px solid #0099CC;border-radius: 5px;padding: 3px;">
        <img style="max-width: 200px;max-height:200px;" id="picture">
    </div>
</div>


<script src="${basePath}/layuiadmin/layui/layui.js"></script>
<script>

    layui.config({
        base: '${basePath}/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'useradmin', 'table', 'layer','laydate'], function () {
        var $ = layui.$
            , form = layui.form
            , table = layui.table
            , layer = layui.layer
            , laydate=layui.laydate;


        //日期渲染
        laydate.render({
            elem:"#recordTime"
        })
        //表格条目

        var tableIns = table.render({
            elem: '#car-page'  //绑定表格元素，使用ID选择器
            , url: '${basePath}/getRecordList'  //异步请求地址
            , toolbar: '#toolBar' //数据表格上面的工具栏  右侧的  和自定义的工具栏ID绑定在一块
            , cols: [[//表头  field:与实体类的属性名一致
                //{type: 'checkbox'}
                  {field: 'recordId', width: 120, title: '记录ID', sort: true}
                , {field: 'realName', width: 120, title: '收货员'}
                , {field: 'carNum', width: 120, title: '车牌号'}
                , {field: 'beginTime', width: 160, title: '入场时间'}
                , {field: 'endTime', width: 160, title: '退场时间'}
                , {field: 'beginImg', width: 80, title: '入场图',templet:function (obj){
                        return '<div style="text-align:center ;width:100%;height: 100%;" onclick="show_img(this)" ><img src="${basePath}/'+obj.beginImg+'" ' +
                            'alt="" width="100%" height="100%"></a></div>';}}
                , {field: 'endImg', width: 80, title: '退场图',templet:function (obj){
                        return '<div style="text-align:center ;width:100%;height: 100%;" onclick="show_img(this)" ><img src="${basePath}/'+obj.endImg+'" ' +
                            'alt="" width="100%" height="100%"></a></div>';}}
                , {field: 'beginWeight', width: 160, title: '入场重量(KG)'}
                , {field: 'endWeight', width: 160, title: '退场重量(KG)'}
               // , {fixed: 'right', title: '操作', toolbar: '#barDemo', width: 150},
            ]]
            , page: true//查找所有的数据
        });



        //监听提交
        form.on('submit(formDemo)', function (data) {
            layer.msg(JSON.stringify(data.field));
            return false;
        });
        //监听 头部工具栏的点击toolbar

        table.on('toolbar(LAY-car-page)', function (obj) {
            switch (obj.event) {
                case 'add':
                    openAddWindow();
                    break;
                case 'update':
                    update();
                    break;
                case 'delete':
                    del();
                    break;
            }
        })

        //监听  每一行的点击操作tool
        table.on('tool(LAY-car-page)', function (obj) {

            var event = obj.event;
            var id = obj.data.carId;
            if (event === 'bigPicture') {
                console.log(obj.data.beginImg);
                openPictureWindow(obj.data.beginImg);
            }
        })

        //监听搜索按钮提交的事件
        form.on("submit(LAY-car-search)", function (data) {

            console.log(data);
            tableIns.reload({
                where: data.field,
                page: {
                    curr: 1
                }
            });
            //禁止页面刷新
            return false;
        })


        var url;//提交地址
        var mainIndex;//窗口下标

        //查看大图
        window.show_img=function (t) {
            console.log(t)
            var t = $(t).find("img");
            console.log(t)
            //页面层
            layer.open({
                type: 1,
                title:"图片详情",
                skin: 'layui-layer-rim', //加上边框
                //area: ['350px', '350px'],
                area: ['80%', '80%'], //宽高 t.width() t.height()

                shadeClose: true, //开启遮罩关闭
                end: function (index, layero) {
                    return false;
                },
                content: '<div style="text-align:center ;width: 100%;height:100%;"><img style="width: 100%;height:100%;"  src="' + $(t).attr('src') + '" /></div>'
            });
        }
        //打开查看大图窗口
        function openPictureWindow(img) {
            mainIndex = layer.open({
                type: 1,//弹出层类型
                title: "查看大图",
                area: ['350px', '350px'],
                content: $("#bigPicture"),//引用的窗口代码 divID
                success: function (){
                    $('#picture').attr('src',"${basePath}/"+img);
                }

            });
        }


    });
</script>
</body>
</html>
