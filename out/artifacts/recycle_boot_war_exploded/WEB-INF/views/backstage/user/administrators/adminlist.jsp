<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>后台角色管理</title>

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
    </div>
</div>
<!--lay-event名字自己取-->
<!--每一行后面的删除和修改按钮-->
<div id="barDemo" style="display: none">
    <a class="layui-btn layui-btn-xs" lay-event="detail">详情</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-xs" lay-event="resetPwd">重置密码</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</div>

<%--添加管理员div--%>
<div id="addAdmin" style="display: none;margin: 10px">
    <form id="addAdminForm" method="post" enctype="multipart/form-data" class="layui-form layui-form-pane"
          lay-filter="dataFrm">
        <div class="layui-form-item">
            <%--将Id隐藏起来--%>
            <input type="text" style="display: none" name="wasteId" autocomplete="off" class="layui-input">

        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">角色类型</label>
                <div class="layui-input-block">
                    <select name="role">
                        <option value="1">超级管理员</option>
                        <option value="2">普通管理员</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">登录名</label>
                <div class="layui-input-block">
                    <input type="text" name="account" required lay-verify="required" placeholder="请输入"
                           autocomplete="off"
                           class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-block">
                    <input type="text" name="realName" required lay-verify="required" placeholder="请输入"
                           autocomplete="off"
                           class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">手机</label>
                <div class="layui-input-block">
                    <input type="text" name="mobile" required lay-verify="required" placeholder="请输入" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">性别</label>
                <div class="layui-input-block">
                    <input type="radio" name="gender" value="1" title="男">
                    <input type="radio" name="gender" value="0" title="女" checked="true">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block" style="text-align: right">
                <button class="layui-btn" lay-submit lay-filter="formAdmin">添加</button>
            </div>
        </div>
    </form>
</div>

<%--修改管理员信息--%>
<div id="editAdmin" style="display: none;margin: 10px">
    <form id="editAdminForm" method="post" enctype="multipart/form-data" class="layui-form layui-form-pane"
          lay-filter="dataEditFrm">

        <div class="layui-form-item">
            <label class="layui-form-label">头像</label>
            <div class="layui-input-inline">
                <div style="width:100px;height:100px;border:3px solid #0099CC;border-radius: 5px;padding: 3px;">
                    <img style="width: 100%;height:100%;" id="avatar"
                         src="">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-inline" style="display: none">
                <input type="text" name="avatar"
                       autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">账号ID</label>
                <div class="layui-input-inline">
                    <input type="text" name="id"  readonly lay-verify="" id="id"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">用户名</label>
                <div class="layui-input-inline">
                    <input type="text" name="account"  readonly
                           class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-inline">
                    <input type="text" name="realName"  readonly  lay-verify="require"
                           autocomplete="off"
                           class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">角色类型</label>
                <div class="layui-input-block">
                    <select name="role" id="role">
                        <option value="1">超级管理员</option>
                        <option value="2">普通管理员</option>
                    </select>
                </div>
            </div>
        </div>


        <div class="layui-form-item">
            <div class="layui-input-block" style="text-align: right">
                <button class="layui-btn" lay-submit lay-filter="formAdminEdit" id="changeRole">修改</button>
            </div>
        </div>
    </form>
</div>

<%--查看管理员详情--%>
<div class="layui-fluid" id="adminDetail" style="display: none;margin: 10px">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body" pad15>
                    <form class="layui-form layui-form-pane" action="" lay-filter="detailForm">
                        <div class="layui-form-item">
                            <label class="layui-form-label">头像</label>
                            <div class="layui-input-inline">
                                <div style="width:100px;height:100px;border:3px solid #0099CC;border-radius: 5px;padding: 3px;">
                                    <img style="width: 100%;height:100%;" id="preview"
                                         src="">
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-inline" style="display: none">
                                <input type="text" name="avatar" id="imageUrl"
                                       autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">账号ID</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="id"  readonly lay-verify=""
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label" style="width: auto">上次登录IP</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="lastIp"  readonly
                                           class="layui-input">
                                </div>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">用户名</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="account"  readonly
                                           class="layui-input">
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label" style="width: auto">上次登录时间</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="lastTime"
                                           readonly class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">姓名</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="realName"  readonly  lay-verify="require"
                                           autocomplete="off"
                                           class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">角色</label>
                            <div class="layui-input-inline">
                                <select name="role" disabled="disabled">
                                    <option value="1" >超级管理员</option>
                                    <option value="2" >普通管理员</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">性别</label>
                            <div class="layui-input-block">
                                <input type="radio" name="gender" value="1" title="男" id="radio-detail1" disabled>
                                <input type="radio" name="gender" value="0" title="女" id="radio-detail0" disabled>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">手机</label>
                            <div class="layui-input-inline">
                                <input type="text" name="mobile"  readonly lay-verify="phone"
                                       autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>
<%--条件搜索--%>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">姓名</label>
                    <div class="layui-input-block">
                        <input type="text" name="realName" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">手机号</label>
                    <div class="layui-input-block">
                        <input type="text" name="mobile" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">角色类型</label>
                    <div class="layui-input-block">
                        <select name="role">
                            <option value="">全部角色</option>
                            <option value="1">超级管理员</option>
                            <option value="2">普通管理员</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn layuiadmin-btn-useradmin" lay-submit lay-filter="LAY-admin-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>

        <div>

            <table id="car-page" lay-filter="LAY-admin-page"></table>

        </div>
    </div>
</div>

<script src="${basePath}/layuiadmin/layui/layui.js"></script>
<script>
    layui.config({
        base: '${basePath}/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'useradmin', 'table','layer'], function () {
        var $ = layui.$
            , form = layui.form
            , table = layui.table
            , layer = layui.layer;
        //表格条目

        var tableIns=table.render({
            elem: '#car-page'
            , url: '${basePath}/adminLists'
            , toolbar: '#toolBar' //数据表格上面的工具栏  右侧的  和自定义的工具栏ID绑定在一块
            , cols: [[//表头  field:与实体类的属性名一致
                {type: 'checkbox'}
                , {field: 'id', width: 110, title: '管理员ID', sort: true}
                , {field: 'account', width: 120, title: '登录名'}
                , {field: 'realName', width: 160, title: '真实姓名'}
                , {field: 'mobile', width: 160, title: '电话号码'}
                , {field: 'gender', width: 80, title: '性别',templet: function (obj) {
                        if (obj.gender == 1) return '男';
                        else return '女';
                    } }
                , {field: 'lastIp', width: 160, title: '最后登录的Ip地址'}
                , {field: 'lastTime', width: 160, title: '最后登录时间'}
                , {
                    field: 'role', width: 160, title: '角色', templet: function (obj) {
                        if (obj.role == 1) return '超级管理员';
                        else return '普通管理员';
                    }
                }
                , {fixed: 'right', title: '操作', toolbar: '#barDemo', width: 250}
            ]]
            , page: true//查找所有的数据
        });


        //搜索
        //监听搜索按钮提交的事件
        form.on("submit(LAY-admin-search)", function (data) {

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

        //监听增加表单提交
        form.on("submit(formAdmin)", function (data) {
            console.log(data.field)
            $.post("addAdmin", data.field, function (result) {
                if (result.success) {
                    layer.alert(result.message, {icon: 1});
                    //刷新数据表格
                    tableIns.reload();
                } else {
                    layer.alert(result.message, {icon: 2});
                }
                //关闭窗口
                layer.close(mainIndex);

            }, "json");
            return false;
        });
        // 查看管理员详情
        function openDetailWindow(data) {
            //回显radio
            if (data.gender==1)
                $("#radio-detail1").prop("checked",true)
            else
                $("#radio-detail0").prop("checked",true)
            mainIndex = layer.open({
                type: 1,//弹出层类型
                title: "管理员信息",
                area: ['800px', '600px'],
                //area: ['60%', '60%'],
                content: $("#adminDetail"),//引用的窗口代码 divID
                success: function () {
                    form.val("detailForm", data); //表单数据的回显

                    //将对应的URL写入框中的src
                    $('#preview').attr('src', data.avatar);
                }
            });
        }

        //添加管理员窗口方法
        function openAddWindow() {
            mainIndex = layer.open({
                type: 1,//弹出层类型
                title: "添加管理员",
                area: ['450px', '420px'],
                //area: ['60%', '60%'],
                content: $("#addAdmin"),//引用的窗口代码 divID
                success: function () {
                    //清空表单数据
                    $("#addAdminForm")[0].reset();//JavaScript中的方法
                }
            });
        }
        var editIndex;
        //修改管理员窗口方法
        function openEditWindow(data) {
            $("#avatar").attr("src","${basePath}/"+data.avatar)


            editIndex = layer.open({
                type: 1,//弹出层类型
                title: "修改管理员权限",
                area: ['450px', '550px'],
                //area: ['60%', '60%'],
                content: $("#editAdmin"),//引用的窗口代码 divID
                success: function () {

                    form.val("dataEditFrm", data); //表单数据的回显

                }
            });
        }

        //监听  每一行的点击操作
        table.on('tool(LAY-admin-page)', function (obj) {
            var event = obj.event;
            var id = obj.data.id;
            var realName=obj.data.realName;
            console.log(id)
            if(id==${admin.id}){
                layer.msg(("不能对当前账号进行此操作！"), {
                    icon: 5,//失败的表情
                    time: 2000 })//1秒关闭（如果不配置，默认是3秒
                return false;
            }
            if (event === 'detail') {
                openDetailWindow(obj.data);
            } else if (event === 'del') {
                del(id,realName)
            }else if(event=='resetPwd'){
                resetPwd(id,realName)
            }else if (event === 'edit') {
/*                if(${amdin.role eq '2'}){//是否是普通管理员
                    layer.msg(("您不是超级管理员,无此权限"), {
                        icon: 5,//失败的表情
                        time: 2000 })//1秒关闭（如果不配置，默认是3秒
                    return false;
                }*/
                openEditWindow(obj.data);
            }

        })
        //删除函数
        function del(id,realName) {
/*            if(${amdin.role eq '2'}){//是否是普通管理员
                layer.msg(("您不是超级管理员,无此权限"), {
                    icon: 5,//失败的表情
                    time: 2000 })//1秒关闭（如果不配置，默认是3秒
                return false;
            }*/
            layer.confirm("确定删除管理员【"+realName+"】吗？", function (index) {
                $.ajax({
                    url: 'delAdmin',
                    type: 'post',
                    data: {id: id},
                    dataType: "json",
                    success: function (res) {
                        layer.msg(res.message, {
                            icon: 6,//成功的表情
                            time: 1000 //1秒关闭（如果不配置，默认是3秒）
                        });
                    }
                })

                layer.close(index);
                tableIns.reload();
            });

        }
        //重置密码
        function resetPwd(id,realName) {
/*            if(${amdin.role eq '2'}){//是否是普通管理员
                layer.msg(("您不是超级管理员,无此权限"), {
                    icon: 5,//成功的表情
                    time: 2000 })//1秒关闭（如果不配置，默认是3秒
                return false;
            }*/
            layer.confirm("确定重置管理员【"+realName+"】的密码吗？", function (index) {
                $.ajax({
                    url: 'resetAdminPwd',
                    type: 'post',
                    data: {id: id},
                    dataType: "json",
                    success: function (res) {
                        layer.msg(res.message, {
                            icon: 6,//成功的表情
                            time: 1000 //1秒关闭（如果不配置，默认是3秒）
                        });
                    }
                })

                layer.close(index);
                tableIns.reload();
            });
        }
        //修改管理员权限 为修改按钮绑定单机时间
        $("#changeRole").click(function (){
            $.ajax({
                url: 'changeRole',
                type: 'post',
                data: {id: $("#id").val(),role:$("#role").val()},
                dataType: "json",
                success: function (res) {
                    layer.msg(res.message, {
                        icon: 6,//成功的表情
                        time: 1000 //1秒关闭（如果不配置，默认是3秒）
                    });
                }

            })
            layer.close(editIndex);
            tableIns.reload();
            return false;
        })



        //监听 头部工具栏的点击toolbar
        table.on('toolbar(LAY-admin-page)', function (obj) {
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
    });



    function update() {
        alert("fun:update");
    }

    function del() {
        alert("fun:del");
    }
</script>
</body>
</html>
