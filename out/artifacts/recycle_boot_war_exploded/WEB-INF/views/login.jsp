<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <%--获得当前工程名--%>
  <%
    String basePath= request.getContextPath();
    pageContext.setAttribute("basePath",basePath);
  %>
  <!-- 自适应 -->
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>Insert title here</title>
  <link rel="stylesheet" href="${basePath}/layuiadmin/css/font.css">
  <link rel="stylesheet" href="${basePath}/layuiadmin/css/login.css">
  <link rel="stylesheet" href="${basePath}/layuiadmin/css/xadmin.css">
  <script src="${basePath}/layuiadmin/layui/layui.js"></script>
</head>

<body class="login-bg">
<div class="login layui-anim layui-anim-up">
  <div class="message">后台管理员登录</div>
  <div id="darkbannerwrap"></div>

  <form method="post" class="layui-form" >
    <input name="loginName" placeholder="用户名"  type="text" lay-verify="required" class="layui-input" >
    <hr class="hr15">
    <input name="password" lay-verify="required" placeholder="密码"  type="password" class="layui-input">
    <hr class="hr15">
    <input value="登录" lay-submit lay-filter="login" style="width:100%;" type="submit">
    <hr class="hr20" >
  </form>
</div>
</body>


<script type="text/javascript">
  //layui.user(加载使用的模块),我们这里只使用了form,还可以加载table,jquery等等
  layui.use('form',function(){
    var form=layui.form;
    //监听form的提交 监听lay-filter
    form.on(submit('formDemo'),function(data){
      //console.log();
      alert(data.field);
    })


  })
</script>

</body>
</html>