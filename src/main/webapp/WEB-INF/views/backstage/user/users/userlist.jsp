<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!DOCTYPE html>
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
</head>

<body>


<!--自定义的工具栏-->
<div id="toolBar" style="display: none"> <!--无论table加不加载div都会显示一次，所以设置为none-->
    <div class="layui-btn-group">
        <button type="button" class="layui-btn" lay-event="add">增加 <i class="layui-icon">&#xe654;</i></button>
        <button type="button" class="layui-btn" lay-event="update">编辑 <i class="layui-icon">&#xe642;</i></button>
        <button type="button" class="layui-btn layui-btn-danger" lay-event="delete">批量删除 <i
                class="layui-icon">&#xe640;</i></button>
    </div>
</div>
<!--lay-event名字自己取-->
<!--每一行后面的删除和修改按钮-->
<div id="barDemo" style="display: none">
    <a class="layui-btn layui-btn-xs" lay-event="singleEdit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="singleDel">删除</a>
</div>



<div class="layui-fluid">
    <div class="layui-card">
        <form class="layui-form layui-card-header layuiadmin-card-header-auto">

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">用户ID</label>
                    <div class="layui-input-block">
                        <input type="text" id="userId" name="userId" placeholder="请输入" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn layuiadmin-btn-useradmin" lay-submit lay-filter="LAY-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn">查询用户</i>
                    </button>
                </div>
            </div>
        </form>
        <%--表格--%>
        <div>
            <%-- 通过Lay-filer来监听每一行--%>
            <table id="user-page" lay-filter="LAY-user-page"></table>

        </div>
    </div>
</div>


<script src="${basePath}/layuiadmin/layui/layui.js"></script>
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




        //表格条目

        var tableIns = table.render({
            elem: '#user-page'  //绑定表格元素，使用ID选择器
            , url: '${basePath}/getUserList'  //异步请求地址
            //, toolbar: '#toolBar' //数据表格上面的工具栏  右侧的  和自定义的工具栏ID绑定在一块
            , cols: [[//表头  field:与实体类的属性名一致
                //{type: 'checkbox'}
                  {field: 'userId', width: 100, title: '用户ID', sort: true}
                , {field: 'nickName', width: 120, title: '昵称'}
                , {field: 'gender', width: 80, title: '性别',
                    templet: function(d){
                        if(d.gender == 0){return '女'}
                        else if(d.gender == 1){return '男'}
                        else return ''}}
                , {field: 'mobile', width: 160, title: '手机号'}
                , {field: 'restMoney', width: 80, title: '余额'}
                , {field: 'image', width: 80, title: '收款码',templet:function (obj){
                        return '<div style="text-align:center ;width:100%;height: 100%;" onclick="show_img(this)" ><img src="${basePath}/'+obj.moneyCode+'" ' +
                            'alt="" width="100%" height="100%"></a></div>';}}
              //  , {fixed: 'right', title: '操作', toolbar: '#barDemo', width: 150}
            ]]
            , page: true//查找所有的数据
        });


        //查看大图
        window.show_img=function (t) {
            console.log(t)
            var t = $(t).find("img");
            console.log(t)
            //页面层
            layer.open({
                type: 1,
                title:"收款码",
                skin: 'layui-layer-rim', //加上边框
                area: ['500px', '500px'],
                //area: ['50%', '50%'], //宽高 t.width() t.height()

                shadeClose: true, //开启遮罩关闭
                end: function (index, layero) {
                    return false;
                },
                content: '<div style="text-align:center ;width:100%;"><img style="width:100%;height: 100%;"src="' + $(t).attr('src') + ' "/></div>'
            });
        }
        //监听搜索按钮提交的事件
        form.on("submit(LAY-search)", function (data) {

            console.log(data);
            tableIns.reload({
                where: data.field
                /* {//设置表格异步接口的额外参数
                        carNum:carNum,
                        carType:carType
                                }*/,
                page: {
                    curr: 1
                }
            });
            //禁止页面刷新
            return false;
        })



    });
</script>
</body>
</html>
