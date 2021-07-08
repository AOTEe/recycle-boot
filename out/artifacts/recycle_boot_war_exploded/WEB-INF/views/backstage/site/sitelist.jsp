<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>回收站管理</title>

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

<%--修改的弹出层页面  将Id隐藏起来--%>
<div id="editSite" style="display: none;margin: 10px">
    <form id="editSiteForm" method="post" class="layui-form layui-form-pane" lay-filter="dataFrm">
        <div class="layui-form-item">
            <%--将Id隐藏起来--%>
            <input type="text" style="display: none" id="siteId-edit" name="siteId" autocomplete="off" class="layui-input">

        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">站点名称</label>
            <div class="layui-input-block">
                <input type="text" id="siteName-edit" name="siteName" required lay-verify="required" placeholder="请输入车牌号" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" id="area-picker">
            <div class="layui-form-label">地区选择</div>
            <div class="layui-input-inline" style="width: 200px;">
                <select name="province" class="province-selector" value=""  data-value="" lay-filter="province-1" id="province-edit">
                    <option value="">请选择省</option>
                </select>
            </div>
            <div class="layui-input-inline" style="width: 200px;">
                <select name="city" class="city-selector" value="" data-value="" lay-filter="city-1" id="city-edit">
                    <option value="">请选择市</option>
                </select>
            </div>
            <div class="layui-input-inline" style="width: 200px;">
                <select name="county" class="county-selector" value="" data-value="" lay-filter="county-1" id="county-edit">
                    <option value="">请选择区</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">详细地址</label>
            <div class="layui-input-block">
                <input type="text" id="address-edit" name="address" required lay-verify="required" placeholder="请输入详细地址" autocomplete="off"
                       class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="formCar">立即提交</button>
                <%--<button type="reset" class="layui-btn layui-btn-primary">重置</button>--%>
            </div>
        </div>
    </form>
</div>
<%--定义添加弹出层页面 --%>
<div id="addSite" style="display: none;margin: 10px">
    <form id="addSiteForm" method="post" class="layui-form layui-form-pane" lay-filter="dataFrm">
        <div class="layui-form-item">
            <%--将Id隐藏起来--%>
            <input type="text" style="display: none" name="siteId" autocomplete="off" class="layui-input">
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">站点名称</label>
            <div class="layui-input-block">
                <input type="text"  name="siteName" required lay-verify="required" placeholder="请输入站点名称" autocomplete="off"
                       class="layui-input" id="siteName-add">
            </div>
        </div>
        <div class="layui-form-item" id="area-picker-add">
            <div class="layui-form-label">地区选择</div>
            <div class="layui-input-inline" style="width: 200px;">
                <select name="province" class="province-selector"  lay-filter="province-1" id="province-add"  lay-verify="required" >
                    <option value="">请选择省</option>
                </select>
            </div>
            <div class="layui-input-inline" style="width: 200px;">
                <select name="city" class="city-selector" lay-filter="city-1" id="city-add"  lay-verify="required" >
                    <option value="">请选择市</option>
                </select>
            </div>
            <div class="layui-input-inline" style="width: 200px;">
                <select name="county" class="county-selector"  lay-filter="county-1" id="county-add" lay-verify="required" >
                    <option value="">请选择区/县</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">详细地址</label>
            <div class="layui-input-block">
                <input type="text" name="address" required lay-verify="required" placeholder="请输入详细地址" autocomplete="off"
                       class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block" style="text-align: right">
                <button class="layui-btn" lay-submit lay-filter="formCar">立即提交</button>
                <%--<button type="reset" class="layui-btn layui-btn-primary">重置</button>--%>
            </div>
        </div>
    </form>
</div>


<div class="layui-fluid">
    <div class="layui-card">
        <form class="layui-form layui-card-header layuiadmin-card-header-auto" id="search">
            <div class="layui-form-item" id="area-picker-search">
                <div class="layui-form-label">地区选择</div>
                <div class="layui-input-inline" style="width: 200px;">
                    <select name="province" class="province-selector" id="province-search" lay-filter="province-1">
                        <option value="">请选择省</option>
                    </select>
                </div>
                <div class="layui-input-inline" style="width: 200px;">
                    <select name="city" class="city-selector" id="city-search"  lay-filter="city-1">
                        <option value="">请选择市</option>
                    </select>
                </div>
                <div class="layui-input-inline" style="width: 200px; display: none">
                    <select name="county" class="county-selector" id="county-search" lay-filter="county-1">
                        <option value="">请选择区</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">站点名称</label>
                    <div class="layui-input-block">
                        <input type="text" id="siteName" name="siteName" placeholder="请输入" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn layuiadmin-btn-useradmin" lay-submit lay-filter="LAY-car-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn">查询站点</i>
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
    }).use(['index', 'useradmin', 'table', 'layer','layarea'], function () {
        var $ = layui.$
            , form = layui.form
            , table = layui.table
            , layer = layui.layer
            , layarea=layui.layarea;




        function searchRender(){
            layarea.render({
                elem: '#area-picker-search',
                data: {
                    province: searchProvince,
                    city: searchCity,
                    county: searchCounty,
                },
                change: function (res) {
                    //选择结果
                    console.log(res);
                }
            });
        }

            function areaRender(){
                //地区三级联动
                layarea.render({
                    elem: '#area-picker',
                    change: function (res) {
                        //选择结果
                        console.log(res);
                    }
                });
                layarea.render({
                    elem: '#area-picker-add',
                    change: function (res) {
                        //选择结果
                        console.log(res);
                    }
                });
                layarea.render({
                    elem: '#area-picker-search',
                    change: function (res) {
                        //选择结果
                        console.log(res);
                    }
                });
            }

            areaRender();

        //正则表达式分割地址
        let regex="(?<province>[^省]+自治区|.*?省|.*?行政区|.*?市)(?<city>[^市]+自治州|.*?地区|.*?行政单位|.+盟|市辖区|.*?市|.*?县)(?<county>[^县]+县|.+区|.+市|.+旗|.+海域|.+岛)?(?<town>[^区]+区|.+镇|.+街道办事处|.+街道)?(?<village>.*)"
        //let regex = "(?<province>[^省]+省|.+自治区)(?<city>[^自治州]+自治州|[^市]+市|[^盟]+盟|[^地区]+地区|.+区划)(?<county>[^市]+市|[^县]+县|[^旗]+旗|.+区)?(?<town>[^区]+区|.+镇)?(?<village>.*)";


        //表格条目

        var tableIns = table.render({
            elem: '#car-page'  //绑定表格元素，使用ID选择器
            , url: '${basePath}/getSiteList'  //异步请求地址
            , toolbar: '#toolBar' //数据表格上面的工具栏  右侧的  和自定义的工具栏ID绑定在一块
            , cols: [[//表头  field:与实体类的属性名一致
                {type: 'checkbox'}
                , {field: 'siteId', width: 120, title: '站点ID', sort: true}
                , {field: 'siteName', width: 120, title: '站点名称'}
                , {field: 'address', width: 300, title: '地址'}
                , {field: 'lng', width: 120, title: '经度'}
                , {field: 'lat', width: 120, title: '纬度'}
                , {fixed: 'right', title: '操作', toolbar: '#barDemo', width: 150}
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
            var id = obj.data.siteId;
            if (event === 'singleEdit') {
                console.log(obj.data);
                openUpdateWindow(obj.data);
            } else if (event === 'singleDel') {
                layer.confirm("确定删除该站点[ID:"+id+"]吗？", {icon:3,title:"提示"},function (index) {

                    $.ajax({
                        url: 'delOneSite',
                        type: 'post',
                        data: {'siteId': id},
                        dataType: "json",
                        success: function () {
                            layer.alert('删除成功', {
                                icon: 6,//成功的表情
                                //time: 2000 1秒关闭（如果不配置，默认是3秒）
                            });
                            tableIns.reload();
                            searchRender();
                        }
                    })
                    layer.close(index);
                });
            }
        })


        //定义省市区的全局参数，用于地区的回显
        var searchProvince="-请选择省-";
        var searchCity="-请选择市";
        var searchCounty="-请选择区/县-";
        //监听搜索按钮提交的事件
        form.on("submit(LAY-car-search)", function (data) {
            searchProvince=data.field.province;
            searchCity=data.field.city;
            searchCounty=data.field.county;
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
        //打开添加窗口
        function openAddWindow() {

            //清空表单数据
            $("#addSiteForm")[0].reset();//JavaScript中的方法

            mainIndex = layer.open({
                type: 1,//弹出层类型
                title: "添加站点",
                area: ['780px', '300px'],
                //area: ['60%', '60%'],
                content: $("#addSite"),//引用的窗口代码 divID
                success: function () {

                    layarea.render({
                        elem: '#area-picker-add',
                        change: function (res) {
                            //选择结果
                            console.log(res);
                        }
                    });

/*

                    $("#province-add").attr("data-value","-请选择省-")
                    $("#city-add").attr("data-value","-请选择市-")
                    $("#county-add").attr("data-value","-请选择区/县-")
*/

                    url = "${basePath}/addSite";
                },
                cancel: function(){

                    searchRender();
                }


            });
        }

        //打开编辑窗口
        function openUpdateWindow(data) {


            //使用正则表达式进行分割
            var region=data.region;
            console.log(region)

            var node=region.match(regex);
            var province=node.groups.province;
            var city=node.groups.city;
            var county=node.groups.county;


            //弃用
            /*var province=region.substring(0,region.indexOf('省')+1);
            var city=region.substring(region.indexOf('省')+1,region.indexOf('市')+1);
            var county=region.substring(region.indexOf('市')+1);*/


            layarea.render({
                elem: '#area-picker',
                data: {
                     province: province,
                     city: city,
                     county: county,
                 },
                change: function (res) {

                    //选择结果
                    console.log(res);
                }
            });


            //信息的回显
            var address=data.address
            $("#siteId-edit").val(data.siteId)
            $("#siteName-edit").val(data.siteName)

/*            console.log(address.indexOf(region))*/
            $("#address-edit").val(address.replace(region,""))

/*            console.log(province)
            console.log(city)
            console.log(county)*/
            mainIndex = layer.open({
                type: 1,//弹出层类型
                title: "编辑站点",
                area: ['780px', '300px'],
                //area: ['60%', '60%'],
                content: $("#editSite"),//引用的窗口代码 divID
                success: function () {






                    /*$("#province").val(province)
                    $("#city").val(city)
                    $("#county").val(county)*/






                    url = "${basePath}/updateSite";
                },
                cancel: function(){


                    searchRender();
                }

            });
        }

        //修改和添加的表单提交
        form.on("submit(formCar)", function (data) {
            $.post(url, data.field, function (result) {
                searchRender();
                console.log("我们都一样")

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
                    idArr.push(checkStatus.data[i].siteId);
                }
                console.log(idArr);
                var ids = idArr.join(",");//以字符串数组以分割，默认是 ,
                layer.confirm("确定要删除这<font color='red'>" + checkStatus.data.length + "</font>条数据吗？", {
                    icon: 3,
                    title: "提示"
                }, function (index) {
                    //请求ajax
                    $.post("${basePath}/siteBatchDel", {"ids": ids}, function (result) {
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
                url: 'delOneSite',
                type: 'post',
                data: {siteId: id},
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
