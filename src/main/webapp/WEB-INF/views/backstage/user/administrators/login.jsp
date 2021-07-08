<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html>


<!DOCTYPE html>
<html>
<head>
  <%--获得当前工程名--%>
  <%
    String basePath= request.getContextPath();
    pageContext.setAttribute("basePath",basePath);
  %>
  <meta charset="utf-8">
  <title>后台管理员登录</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="${basePath}/layuiadmin/layui/css/layui.css" media="all">
  <link rel="stylesheet" href="${basePath}/layuiadmin/style/admin.css" media="all">
  <link rel="stylesheet" href="${basePath}/layuiadmin/style/login.css" media="all">
</head>
<body style="background: url(${basePath}/layuiadmin/images/recycle_01.jpg);
        background-size: 100% 100%;">

<div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">

  <div class="layadmin-user-login-main" >
    <div class="layadmin-user-login-box layadmin-user-login-header">
      <h2>后台管理员登录</h2>
    </div>
    <div class="layadmin-user-login-box layadmin-user-login-body layui-form">
      <div class="layui-form-item">
        <label class="layadmin-user-login-icon layui-icon layui-icon-username" for="LAY-user-login-username"></label>
        <input type="text" name="username" id="username" lay-verify="required" placeholder="用户名" class="layui-input"
               value="${cookie.userName.value}">
      </div>
      <div class="layui-form-item">
        <label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-password"></label>
        <input type="password" name="password" id="password" lay-verify="required" placeholder="密码" class="layui-input"
                >
      </div>
      <div class="layui-form-item">
        <div class="layui-row">
          <div class="layui-col-xs7">
            <label class="layadmin-user-login-icon layui-icon layui-icon-vercode" for="LAY-user-login-vercode"></label>
            <input type="text" name="vCode"   placeholder="验证码" class="layui-input">
          </div>
          <div class="layui-col-xs5">
            <div style="margin-left: 10px;">
              <img id="vCode" src="${basePath}/verifyCode" title="点击更换"
                   onclick="this.setAttribute('src','${basePath}/verifyCode?'+Math.random());" class="layadmin-user-login-codeimg">
            </div>
          </div>
        </div>
      </div>
     <%-- <tr>
        <td>
          <input type="text" class="txtVerifyCode input" placeholder="验证码" name="verifyCode" id="verifyCode" value="${user.verifyCode }">
          <img id="vCode" src="${basePath}/verifyCode" title="点击更换"
               onclick="this.setAttribute('src','${basePath}/verifyCode?'+Math.random());"/>
        </td>
      </tr>--%>
      <%--<div class="layui-form-item" style="margin-bottom: 20px;">
        <input type="checkbox" name="remember" lay-skin="primary" checked="checked" value="1" title="记住密码">
      </div>--%>
      <div class="layui-form-item">
        <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="LAY-user-login-submit">登 入</button>
      </div>

    </div>
  </div>

<%--  <div class="layui-trans layadmin-user-login-footer">

    <p>© 2018 <a href="http://www.layui.com/" target="_blank">layui.com</a></p>
    <p>
      <span><a href="http://www.layui.com/admin/#get" target="_blank">获取授权</a></span>
      <span><a href="http://www.layui.com/admin/pro/" target="_blank">在线演示</a></span>
      <span><a href="http://www.layui.com/admin/" target="_blank">前往官网</a></span>
    </p>
  </div>--%>

  <!--<div class="ladmin-user-login-theme">
    <script type="text/html" template>
      <ul>
        <li data-theme=""><img src="{{ layui.setter.base }}style/res/bg-none.jpg"></li>
        <li data-theme="#03152A" style="background-color: #03152A;"></li>
        <li data-theme="#2E241B" style="background-color: #2E241B;"></li>
        <li data-theme="#50314F" style="background-color: #50314F;"></li>
        <li data-theme="#344058" style="background-color: #344058;"></li>
        <li data-theme="#20222A" style="background-color: #20222A;"></li>
      </ul>
    </script>
  </div>-->

</div>

<script src="${basePath}/layuiadmin/layui/layui.js"></script>
<script src="https://cdn.bootcss.com/blueimp-md5/2.10.0/js/md5.js"></script>
<script>
  layui.config({
    base: '${basePath}/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index', 'user','form','jquery'], function(){
    var $ = layui.$
            ,form = layui.form;


    //退出时退出iframe
    $(document).ready(function () {
      if (window != top) {
        top.location.href = location.href;
      }
    });

    //提交
    form.on('submit(LAY-user-login-submit)', function(obj){

      obj.field.password=md5(obj.field.password)

      //请求登入接口
      $.post("${basePath}/login",obj.field,function(res){
          if (res.success){
            //请求成功后，写入 access_token
/*
            layui.data(setter.tableName, {
              key: setter.request.tokenName
              ,value: res.data.access_token
            });
*/
            //登入成功的提示与跳转
            layer.msg('登入成功', {
              offset: '15px'
              ,icon: 1
              ,time: 500
            }, function(){
              location.href = '${basePath}/toIndex'; //后台主页
            });
          }
          else{
            layer.msg(res.message, {
              offset: '15px'
              ,icon: 2
              ,time: 2000
            });
          }
        },"json");

    });


  });
</script>
</body>
</html>