<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>收货员管理</title>

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
                    <label class="layui-form-label">回收员姓名</label>
                    <div class="layui-input-block">
                        <input type="text" id="realName" name="realName" placeholder="请输入" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">身份证号</label>
                    <div class="layui-input-block">
                        <input type="text" id="idNumber" name="idNumber" placeholder="请输入" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">电话号码</label>
                    <div class="layui-input-block">
                        <input type="text" id="mobile" name="mobile" placeholder="请输入" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">

                </div>

                <div class="layui-form-item" id="area-picker">
                    <div class="layui-form-label">地区选择</div>
                    <div class="layui-input-inline" style="width: 200px;">
                        <select name="province" class="province-selector" data-value="福建省" lay-filter="province-1">
                            <option value="">请选择省</option>
                        </select>
                    </div>
                    <div class="layui-input-inline" style="width: 200px;">
                        <select name="city" class="city-selector" data-value="福州市" lay-filter="city-1">
                            <option value="">请选择市</option>
                        </select>
                    </div>
                    <div class="layui-input-inline" style="width: 200px;">
                        <select name="county" class="county-selector"  lay-filter="county-1">
                            <option value="">请选择区</option>
                        </select>
                    </div>
                </div>
                <div class="layui-input-block" style="text-align: right">
                    <button class="layui-btn layuiadmin-btn-useradmin" lay-submit lay-filter="LAY-car-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn">查询回收员</i>
                    </button>
                </div>
            </div>
        </form>


        <%--表单 layUI的form模板--%>
        <div>
            <%-- 通过Lay-filer来监听每一行--%>
            <table id="car-page" lay-filter="LAY-car-page"></table>

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

        //地区三级联动
        layarea.render({
            elem: '#area-picker',
            change: function (res) {
                //选择结果
                console.log(res);
            }
        });

        //表格条目
        var tableIns = table.render({
            elem: '#car-page'  //绑定表格元素，使用ID选择器
            , url: '${basePath}//getCarrierList'  //异步请求地址
            //, toolbar: '#toolBar' //数据表格上面的工具栏  右侧的  和自定义的工具栏ID绑定在一块
            , cols: [[//表头  field:与实体类的属性名一致
                  {field: 'carrierId', width: 120, title: '回收员ID', sort: true}
                , {field: 'openId', width: 120, title: 'openId'}
                , {field: 'realName', width: 120, title: '真实姓名'}
                , {field: 'idNumber', width: 160, title: '身份证号'}
                , {field: 'mobile', width: 140, title: '手机号'}
                , {field: 'gender', width: 60, title: '性别',
                    templet: function(d){if(d.gender == 1){return '男'}else{return '女'}}}
                , {field: 'region', width: 160, title: '地区'}
            ]]
            , page: true//查找所有的数据
        });


        //监听提交
        form.on('submit(formDemo)', function (data) {
            layer.msg(JSON.stringify(data.field));
            return false;
        });



        //监听搜索按钮提交的事件
        form.on("submit(LAY-car-search)", function (data) {
            var carNum = $("#carNum").val();
            var carType = $("#carType").val();
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
