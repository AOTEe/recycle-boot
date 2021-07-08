<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<html>
<head>
  <%--获得当前工程名--%>
  <%
    String basePath= request.getContextPath();
    pageContext.setAttribute("basePath",basePath);
  %>
  <meta charset="utf-8">
  <title>设置我的密码</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="${basePath}/layuiadmin/layui/css/layui.css" media="all">
  <link rel="stylesheet" href="${basePath}/layuiadmin/style/admin.css" media="all">

</head>
<body>

  <div class="layui-fluid">
    <div class="layui-row layui-col-space15">
      <div class="layui-col-md12">
        <div class="layui-card">
          <div class="layui-card-header">修改密码</div>
          <div class="layui-card-body" pad15>
            <form id="pwdForm" method="post" class="layui-form layui-form-pane" lay-filter="pwdForm">
              <div class="layui-form-item">
                <label class="layui-form-label">当前密码</label>
                <div class="layui-input-inline">
                  <input type="password" name="oldPwd" lay-verify="required" lay-verType="tips" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">新密码</label>
                <div class="layui-input-inline">
                  <input type="password" name="newPwd" lay-verify="pass" lay-verType="tips" autocomplete="off" id="LAY_password" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">6到16个字符</div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">确认新密码</label>
                <div class="layui-input-inline">
                  <input type="password" name="repassword" lay-verify="repass" lay-verType="tips" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <div class="layui-input-block">
                  <button class="layui-btn" lay-submit lay-filter="setmypass">确认修改</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script src="${basePath}/layuiadmin/layui/layui.js"></script>
  <script src="https://cdn.bootcss.com/blueimp-md5/2.10.0/js/md5.js"></script>
  <script>
  layui.config({
    base: '${basePath}/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index', 'set','form'],function (){
    var $=layui.$
    ,form=layui.form;

    //监听增加和修改的表单提交
    form.on("submit(setmypass)", function (data) {
      console.log(data);
      data.field.oldPwd=md5(data.field.oldPwd);
      data.field.newPwd=md5(data.field.newPwd);
      $.post("${basePath}/updatePwd", data.field, function (result) {
        if (result.success) {
          layer.alert(result.message, {icon: 1});
        } else {
          layer.alert(result.message, {icon: 2});
        }
        $("#pwdForm")[0].reset();//JavaScript中的方法
      }, "json");
      return false;
    });
  })
  </script>
</body>
</html>