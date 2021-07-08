<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>提现管理</title>

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
<%--<div id="toolBar" style="display: none"> <!--无论table加不加载div都会显示一次，所以设置为none-->
    <div class="layui-btn-group">
        <button type="button" class="layui-btn" lay-event="add">增加 <i class="layui-icon">&#xe654;</i></button>
        <button type="button" class="layui-btn" lay-event="update">编辑 <i class="layui-icon">&#xe642;</i></button>
        <button type="button" class="layui-btn layui-btn-danger" lay-event="delete">批量删除 <i
                class="layui-icon">&#xe640;</i></button>
    </div>
</div>--%>
<!--lay-event名字自己取-->
<!--每一行后面的删除和修改按钮-->
<div id="barDemo" style="display: none">
    <a class="layui-btn layui-btn-xs" lay-event="pay">支付</a>
</div>

<%--支付弹出层--%>
<div id="payConfirm" style="display: none;margin: 10px">
    <form id="payForm" method="post" class="layui-form layui-form-pane" lay-filter="dataFrm">
        <div class="layui-form-item">
            <%--将Id隐藏起来--%>
            <input type="text" style="display: none" id="withdrawId" name="withdrawId" autocomplete="off"
                   class="layui-input">

        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">提现金额</label>
            <div class="layui-input-block">
                <input type="text" id="money" name="money" readonly autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">转账凭证</label>
            <div class="layui-input-block">
                <input type="text" name="wxOrderno" lay-verify="required" requ placeholder="请在微信转账后输入转账凭证单号"
                       autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <div style="width:200px;height:200px;border:3px solid #0099CC;border-radius: 5px;padding: 3px;">
                    <img style="width: 100%;height:100%;" id="moneyCode" onclick="show_img(this)">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="formPay">提交</button>
            </div>
        </div>
    </form>
</div>


<div class="layui-fluid">
    <div class="layui-card">
        <form class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">提现用户ID</label>
                    <div class="layui-input-block">
                        <input type="text"  name="userId" placeholder="请输入" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">审核人员ID</label>
                    <div class="layui-input-block">
                        <input type="text"  name="adminId" placeholder="请输入" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">支付状态</label>
                    <div class="layui-input-block">
                        <select name="state"  placeholder="请选择">
                            <option value="">全部状态</option>
                            <option value="0">待支付</option>
                            <option value="1">已支付</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="layui-form-item"  style="text-align: right">
                <div class="layui-inline">
                    <button class="layui-btn layuiadmin-btn-useradmin" lay-submit lay-filter="LAY-pay-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn">查询提现记录</i>
                    </button>
                </div>
            </div>
        </form>


        <%--表格--%>
        <div>
            <%-- 通过Lay-filer来监听每一行--%>
            <table id="pay-page" lay-filter="LAY-pay-page"></table>

        </div>
    </div>
</div>


<script src="${basePath}/layuiadmin/layui/layui.js"></script>
<script>
    layui.config({
        base: '${basePath}/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'useradmin', 'table', 'layer','rate','laydate'], function () {
        var $ = layui.$
            , form = layui.form
            , table = layui.table
            , layer = layui.layer
            , rate = layui.rate
            , laydate =layui.laydate;


        //表格条目

        var tableIns = table.render({
            elem: '#pay-page'  //绑定表格元素，使用ID选择器
            , url: '${basePath}/getWithdrawList'  //异步请求地址
            , toolbar: '#toolBar' //数据表格上面的工具栏  右侧的  和自定义的工具栏ID绑定在一块
            , cols: [[//表头  field:与实体类的属性名一致
               // {type: 'checkbox'}
                  {field: 'withdrawId', width: 110, title: '提现单号', sort: true}
                , {field: 'userId', width: 110, title: '用户ID'}
                , {field: 'money', width: 90, title: '提现金额'}
                , {field: 'subTime', width: 160, title: '提现时间'}
                , {field: 'state', width: 90, title: '支付状态',templet:function (obj){
                    if (obj.state==0) return'未支付'; else return '已支付'}}
                /*, {field: 'image', width: 80, title: '缩略',templet:function (obj){
                        return '<div onclick="show_img(this)" ><img src="${basePath}/'+obj.moneyCode+'" ' +
                            'alt="" width="50px" height="50px"></a></div>';}}*/
                , {field: 'adminId', width: 110, title: '付款管理员'}
                , {field: 'wxOrderno', width: 120, title: '微信转账单号'}
                , {field: 'payTime', width: 160, title: '支付时间'}
                , {fixed: 'right', title: '操作', toolbar: '#barDemo', width: 100}
            ]]
            , page: true//查找所有的数据
        });

        var mainIndex;
        //查看大图
        window.show_img=function (t) {
            console.log(t)
          /*  var t = $(t).attr("src");
            console.log(t)*/
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
                content: '<div style="text-align:center ;width:100%;"><img style="width:100%;height: 100%;"src="' + $(t).attr("src") + ' "/></div>'
            });
        }



        //监听  每一行的点击操作tool
        table.on('tool(LAY-pay-page)', function (obj) {

            var event = obj.event;
            var id = obj.data.carId;
            if (event === 'pay') {
                if (obj.data.state==1){
                    layer.alert('该条提现记录已支付!', {icon: 2})
                }
                else{//支付弹窗
                    openPayWindow(obj.data);
                }

            }
        })

        //提交支付信息
        form.on("submit(formPay)", function (data) {
            $.post("${basePath}/payWithdraw", data.field, function (result) {

                console.log(data.field)
                if (result.success) {
                    layer.alert(result.message, {icon: 1});
                    //关闭窗口
                    layer.close(mainIndex);
                    //刷新数据表格
                    tableIns.reload();
                } else {
                    layer.alert(result.message, {icon: 2});
                }
            }, "json");
            return false;
        });



        //监听搜索按钮提交的事件
        form.on("submit(LAY-pay-search)", function (data) {

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



        //打开支付窗口
        function openPayWindow(data) {
            //清空表单数据
            $("#payForm")[0].reset();//JavaScript中的方法

            //数据回显
            $("#withdrawId").val(data.withdrawId);
            $("#money").val(data.money);
            $('#moneyCode').attr('src', data.moneyCode);
            mainIndex = layer.open({
                type: 1,//弹出层类型
                title: "提现支付",
                area: ['500px', '500px'],
                content: $("#payConfirm")
            });
        }



    });
</script>
</body>
</html>
