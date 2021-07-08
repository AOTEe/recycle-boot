<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
    <title>设置我的资料</title>
    <!-- 引入el标识所需要的标签 -->
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">设置我的资料</div>
                <div class="layui-card-body" pad15>
                    <form class="layui-form" action="">
                        <div class="layui-form-item">
                            <label class="layui-form-label">头像</label>
                            <div class="layui-input-inline">
                                <div style="width:100px;height:100px;border:3px solid #0099CC;border-radius: 5px;padding: 3px;">
                                    <img style="width: 100%;height:100%;" id="preview" src="${basePath}/${admin.avatar}">
                                </div>
                                <button type="button" class="layui-btn" id="upload" >
                                    <i class="layui-icon">&#xe67c;</i>更换头像
                                </button>
                            </div>
                        </div>
                        <div class="layui-form-item" >
                            <div class="layui-input-inline" style="display: none">
                                <input type="text" name="avatar" id="imageUrl" value="${admin.avatar}"  autocomplete="off"
                                       class="layui-input" >
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline">
                            <label class="layui-form-label">账号ID</label>
                            <div class="layui-input-inline">
                                <input type="text" name="id" value="${admin.id}" readonly lay-verify="" autocomplete="off" class="layui-input">
                            </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label" style="width: auto">上回登录IP</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="lastIp" value="${admin.lastIp}" readonly class="layui-input">
                                </div>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">用户名</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="account" value="${admin.account}" readonly class="layui-input">
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label"style="width: auto">上回登录时间</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="lastTime"  value="<fmt:formatDate  value="${admin.lastTime}" pattern="yyyy-MM-dd HH:mm:ss"/> " readonly class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">姓名</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="realName" value="${admin.realName}" lay-verify="require" autocomplete="off"
                                           class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">角色</label>
                            <div class="layui-input-inline">
                                <select name="role" disabled="disabled">
                                    <option value="1" <c:if test="${'1' eq admin.role}">selected</c:if>>超级管理员</option>
                                    <option value="2" <c:if test="${'2' eq admin.role}">selected</c:if>>普通管理员</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">性别</label>
                            <div class="layui-input-block">
                                <input type="radio" name="gender" value="1" title="男"
                                       <c:if test="${'1' eq admin.gender}">checked</c:if>>
                                <input type="radio" name="gender" value="0" title="女"
                                       <c:if test="${'0' eq admin.gender}">checked</c:if>>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">手机</label>
                            <div class="layui-input-inline">
                                <input type="text" name="mobile" value="${admin.mobile}" lay-verify="phone" autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <button class="layui-btn" lay-submit lay-filter="info">确认修改</button>
                            </div>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>
</div>

<script src="${basePath}/layuiadmin/layui/layui.js"></script>
<script>
    layui.config({
        base: '${basePath}/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'set','layer','upload'],function (){

        var $ = layui.$
            , form = layui.form
            , layer = layui.layer
            , upload=layui.upload;


        //图片上传
        upload.render({
            elem: '#upload',//绑定元素
            url: '${basePath}/avatarUpload', //上传接口
            field: "picture",  //添加这个属性与后台名称保存一致
            //auto: false,//选择文件后不自动上传
            //bindAction: '#commit',
            //上传前的回调
            before: function () {
                this.data = {
                    name: $('input[name="name"]').val()
                }
            },
            //选择文件后的回调
            choose: function (obj) {
                obj.preview(function (index, file, result) {

                    $('#preview').attr('src', result);

                })
            },
            //操作成功的回调
            done: function (res, index, upload) {//res 返回的json数据，index文件索引 upload重新上传
                var code = res.code === 0 ? 1 : 2;
                console.log(res,index,upload);
                console.log(res.data.imgUrl);
                $("#imageUrl").val(res.data.imgUrl);
                layer.alert("选择图片成功！", {icon: code})
            },
            //上传错误回调
            error: function (index, upload) {
                layer.alert('上传失败！' + index);
            }
        });


        //监听提交
        form.on('submit(info)', function(data){
            var id=data.field.id;
            var realName=data.field.realName;
            var mobile=data.field.mobile;
            var role=data.field.role;
            var avatar=data.field.avatar;
            var gender=data.field.gender;
            $.ajax({
                url: 'updateAdminInfo',
                type: 'post',
                data: {id:id,realName:realName,mobile:mobile,role:role,avatar:avatar,gender:gender},
                dataType: "json",
                success: function (result) {
                    if (result.success) {
                        layer.alert(result.message, {icon: 1});
                    } else {
                        layer.alert(result.message, {icon: 2});
                    }
                    }});
            return false;
            })


    })

</script>
</body>
</html>