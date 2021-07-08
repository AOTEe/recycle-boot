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
    <a class="layui-btn layui-btn-xs" lay-event="detail">订单详情</a>
    <a class="layui-btn layui-btn-xs" lay-event="comment">查看评价</a>
</div>

<%--评论弹出层--%>
<div id="comment" style="display: none;margin: 10px">
    <div class="layui-form-item">
        <%--将Id隐藏起来--%>
        <input type="text" style="display: none" name="carId" autocomplete="off" class="layui-input">

    </div>
    <div class="layui-form-item">
        <div class="layui-row">
        <div class="layui-col-md3">
            <label class="layui-form-label">评价星级</label>
        </div>
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center">

        <div id="star" ></div>

    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">详细描述</label>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block" id="comment01"></div>
    </div>
</div>



<div class="layui-fluid">
    <div class="layui-card">
        <form class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">下单时间</label>
                    <div class="layui-input-block">
                        <input type="text" id="orderTimeBegin" name="orderTimeBegin" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    至
                </div>
                <div class="layui-inline">
                    <div class="layui-input-inline">
                        <input type="text" id="orderTimeEnd" name="orderTimeEnd" class="layui-input">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">派单时间</label>
                    <div class="layui-input-inline">
                        <input type="text" id="assignTimeBegin" name="assignTimeBegin" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    至
                </div>
                <div class="layui-inline">
                    <div class="layui-input-inline">
                        <input type="text" id="assignTimeEnd" name="assignTimeEnd"  class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">订单号</label>
                    <div class="layui-input-block">
                        <input type="text" id="orderId" name="orderId" class="layui-input">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">订单状态</label>
                    <div class="layui-input-block">
                        <select name="state"  placeholder="请选择">
                            <option value="">全部订单</option>
                            <option value="0">待接单</option>
                            <option value="1">已接单</option>
                            <option value="2">已完成</option>
                            <option value="3">已取消</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn layuiadmin-btn-useradmin" lay-submit lay-filter="LAY-car-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn">查看订单</i>
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

        //日期模块
        laydate.render({
            elem:"#orderTimeBegin"
        })
        laydate.render({
            elem:"#orderTimeEnd"
        })
        laydate.render({
            elem:"#assignTimeBegin"
        })
        laydate.render({
            elem:"#assignTimeEnd"
        })

        //表格条目

        var tableIns = table.render({
            elem: '#car-page'  //绑定表格元素，使用ID选择器
            , url: '${basePath}/orders'  //异步请求地址
            , toolbar: '#toolBar' //数据表格上面的工具栏  右侧的  和自定义的工具栏ID绑定在一块
            , cols: [[//表头  field:与实体类的属性名一致
                //{type: 'checkbox'}
                  {field: 'orderId', width: 90, title: '订单号', sort: true}
                , {field: 'user.userId', width: 90, title: '用户ID' ,templet: function (d){
                            return d.user.userId
                    }}
                , {field: 'carrier.realName', width: 120, title: '接单员'
                        ,templet: function (d){
                            if(d.carrier!=null)
                                return d.carrier.realName
                            else
                                return ''
                        }}
                , {field: 'orderTime', width: 160, title: '下单时间' }
                , {field: 'assignTime', width: 160, title: '接单时间'}
                , {field: 'state', width: 100, title: '订单状态',
                    templet: function(d){
                    if(d.state == 0){return '未接单'}
                    else if(d.state == 1){return '已接单'}
                    else if(d.state==2){return '已完成'}
                    else return '已取消'}}
                , {field: 'confirmImg', width: 80, title: '收货图',templet:function (obj){
                        if (obj.state==2){
                            return '<div onclick="show_img(this)" ><img src="${basePath}/'+obj.confirmImg+'" ' +
                                'alt="" width="50px" height="50px"></a></div>';
                        }
                        else return "订单未完成";
                        }}
                , {field: 'sellerName', width: 160, title: '收货人姓名'}
                , {field: 'sellerMobile', width: 120, title: '收货人手机'}
                , {field: 'address',width: 160, title: '收货地址'}
                , {fixed: 'right', title: '操作', toolbar: '#barDemo', width: 170}
            ]]
            , page: true//查找所有的数据
        });


        //单击图片查看大图
        window.show_img=function (t) {
            console.log(t)
            var t = $(t).find("img");
            //页面层
            layer.open({
                type: 1,
                skin: 'layui-layer-rim', //加上边框
                //area: ['600px', '600px'],
                area: ['80%', '80%'], //宽高 t.width() t.height()

                shadeClose: true, //开启遮罩关闭
                end: function (index, layero) {
                    return false;
                },
                content: '<div style="text-align:center ;width:100%;height: 100%;"><img style="width: 100%;height:100%;" src=" ' + $(t).attr('src') + '" /></div>'
            });
        }


        //监听提交
        form.on('submit(formDemo)', function (data) {
            layer.msg(JSON.stringify(data.field));
            return false;
        });
        //监听 头部工具栏的点击toolbar

        table.on('toolbar(LAY-car-page)', function (obj) {
            switch (obj.event) {
                case 'add':
                    openDetailWindow();
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
            if (event === 'detail') {
                openDetailWindow(obj.data.orderItems,obj.data.weight,obj.data.totalPrice);
                console.log(obj.data.orderItems)

            } else if (event === 'comment') {
                console.log(obj.data)
                if (obj.data.state != 2) {
                    layer.alert('订单尚未完成！', {icon: 2})
                } else
                    openCommentWindow(obj.data)
            }
        })

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


        var url;//提交地址
        var mainIndex;//窗口下标
        //打开订单详情窗口
        function openDetailWindow(data,weight,totalPrice) {
            var s;
            var src;
            s='<table lay-even lay-skin="line" lay-size="lg">\n' +
                '    <table class="layui-table">\n' +
                '        <colgroup>\n' +
                '            <col width="150">\n' +
                '            <col width="200">\n' +
                '            <col>\n' +
                '        </colgroup>\n' +
                '        <thead>\n' +
                '        <tr>\n' +
                '            <th>图片</th>\n' +
                '            <th>废品名称</th>\n' +
                '            <th>单价</th>\n' +
                '            <th>单位</th>\n' +
                '            <th>数量</th>\n' +
                '            <th>小计</th>\n' +
                '        </tr>\n' +
                '        </thead>\n' +
                '        <tbody>\n';
            for (let i = 0; i < data.length; i++) {
                var count=data[i].count;
                var itemPrice=data[i].itemPrice;
                if (count==null) count="待确认";
                if(itemPrice==null) itemPrice="待确认";

                //地址的url
                src="${basePath}/"+data[i].waste.imageUrl;
                console.log(count)
                console.log(itemPrice)
                console.log(src);
                s+= '    <tr>\n' +
                    '        <td><img width=80 height=80 src='+src+' ></td>\n' +
                    '        <td>'+data[i].waste.wasteName+'</td>\n' +
                    '        <td>'+data[i].waste.price+'</td>\n' +
                    '        <td>'+data[i].waste.unit+'</td>\n' +
                    '        <td>'+count+'</td>\n' +
                    '        <td>'+itemPrice+'</td>\n' +
                    '    </tr>\n' ;
            }
            s+='        </tbody>\n' +
                '</table>';
            if(weight!=null&&totalPrice!=null)
                s+= '        <div style="text-align:right"><h3>订单总重: '+weight+' KG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h3></div>\n' +
                    '        <div style="text-align:right"><h3>订单总价: '+totalPrice+' 元&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h3></div>\n';


            mainIndex = layer.open({
                type: 1,//弹出层类型
                title: "订单详情",
                area: ['500px', '500px'],
                content: s
            });
        }

        //打开评价窗口
        function openCommentWindow(data) {
            //只读
            rate.render({
                elem: '#star'
                ,value: data.star
                ,readonly: true
            });
            if(data.comment==null){
                $("#comment01").text("该用户很懒,未编写评价...");
            }
            else
                $("#comment01").text(data.comment);
            mainIndex = layer.open({
                type: 1,//弹出层类型
                title: "订单评价",
                area: ['500px', '400px'],
                content: $("#comment")
            });
        }

        //监听增加和修改的表单提交
        form.on("submit(formCar)", function (data) {
            $.post(url, data.field, function (result) {
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

        function update() {
            alert("fun:update");
        }

        function del() {

            //获取表格对象
            var checkStatus = table.checkStatus('car-page'); //idTest 即为基础参数 id 对应的值

            if (checkStatus.data.length > 0) {
                //定义数组，保存要删除的ID
                var idArr = [];
                for (var i = 0; i < checkStatus.data.length; i++) {
                    idArr.push(checkStatus.data[i].carId);
                }
                console.log(idArr);
                var ids = idArr.join(",");//以字符串数组以分割，默认是 ,
                layer.confirm("确定要删除这<font color='red'>" + checkStatus.data.length + "</font>条数据吗？", {
                    icon: 3,
                    title: "提示"
                }, function (index) {
                    //请求ajax
                    $.post("${basePath}/carBatchDel", {"ids": ids}, function (result) {
                        if (result.success) {
                            layer.alert(result.message, {icon: 1});
                            //刷新数据表格
                            tableIns.reload();
                        } else {
                            layer.alert(result.message, {icon: 2});
                        }
                    }, "json")
                    //关闭提示框
                    layer.close(index);
                });

            } else
                layer.msg("请选择要删除的项");
            console.log(checkStatus.data) //获取选中行的数据
            console.log(checkStatus.data.length) //获取选中行数量，可作为是否有选中行的条件
        }

        //单个删除函数
        function singleDel(id, data) {
            $.ajax({
                url: 'delOneCar',
                type: 'post',
                data: {carId: id},
                dataType: "json",
                success: function () {
                    layer.msg(data.msg, {
                        icon: 6,//成功的表情
                        time: 1000 //1秒关闭（如果不配置，默认是3秒）
                    });
                }
            })
        }
    });
</script>
</body>
</html>
