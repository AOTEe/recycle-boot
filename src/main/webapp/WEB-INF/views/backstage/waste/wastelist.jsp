<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>车辆管理</title>

    <%--获得当前工程名--%>
    <%
        String basePath= request.getContextPath();
        pageContext.setAttribute("basePath",basePath);
    %>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${basePath}/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${basePath}/layuiadmin/style/admin.css" media="all">
</head>
<body>


<!--自定义的工具栏-->
<div id="toolBar" style="display: none"> <!--无论table加不加载div都会显示一次，所以设置为none-->
    <div class="layui-btn-group">
        <button type="button" class="layui-btn" lay-event="add">增加 <i class="layui-icon">&#xe654;</i></button>
        <button type="button" class="layui-btn layui-btn-danger" lay-event="delete">批量删除 <i class="layui-icon">&#xe640;</i></button>
    </div>
</div>


<!--lay-event名字自己取-->
<!--每一行后面的删除和修改按钮-->
<div id="barDemo" style="display: none">
    <a class="layui-btn layui-btn-xs" lay-event="singleEdit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="singleDel">删除</a>
</div>

<%--定义添加/修改的弹出层页面  将Id隐藏起来--%>
<div id="addWaste" style="display: none;margin: 10px">
    <form id="wasteForm" method="post" enctype="multipart/form-data" class="layui-form layui-form-pane"lay-filter="dataFrm" >
        <div class="layui-form-item">
            <%--将Id隐藏起来--%>
                <input type="text" style="display: none" name="wasteId"    autocomplete="off" class="layui-input">

        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <div style="width:150px;height:150px;border:3px solid #0099CC;border-radius: 5px;padding: 3px;">
                    <img style="width: 100%;height:100%;" id="preview">
                </div>
                <button type="button" class="layui-btn" id="upload" name="picture">
                    <i class="layui-icon">&#xe67c;</i>选择图片
                </button>
            </div>
        </div>
        <div class="layui-form-item" >
            <label class="layui-form-label">废品名称</label>
            <div class="layui-input-block">
                <input type="text" name="wasteName" required  lay-verify="required" placeholder="请输入废品名称" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" >
            <label class="layui-form-label">单价</label>
            <div class="layui-input-block">
                <input type="text" name="price" required  lay-verify="required" placeholder="请输入单价" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" >
            <label class="layui-form-label">单位</label>
            <div class="layui-input-block">
                <input type="text" name="unit" required  lay-verify="required" placeholder="请输入计量单位" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" >
            <label class="layui-form-label">描述</label>
            <div class="layui-input-block">
                <input type="text" name="describe" required  lay-verify="required" placeholder="请输入对废品的描述" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" >
                <input type="text" name="imageUrl"  id="imageUrl" class="layui-input" value="" style="display: none">
        </div>


        <div class="layui-form-item">
            <div class="layui-input-block" style="text-align: right">
                <button class="layui-btn" lay-submit lay-filter="formWaste">立即提交</button>
            </div>
        </div>
    </form>
</div>

<%------------条件搜索-----------%>
<div class="layui-fluid">
    <div class="layui-card">
        <form class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">废品名称</label>
                    <div class="layui-input-block">
                        <input type="text" id="wasteName" name="wasteName" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-inline">
                    <button class="layui-btn layuiadmin-btn-useradmin" lay-submit lay-filter="LAY-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </form>


        <%--表格--%>
        <div >
            <%-- 通过Lay-filer来监听每一行--%>
            <table id="waste-page" lay-filter="LAY-page"></table>

        </div>
    </div>
</div>

<%--<script src="${basePath}/layuiadmin/layui/layui.js"></script>
<script>
    layui.config({
        base: '${basePath}/layuiadmin/'
    }).extend({
        index: 'lib/index'
    }).use(['index', 'useradmin', 'layer'], function () {
        var $ = layui.$
            , layer = layui.layer--%>

<script src="${basePath}/layuiadmin/layui/layui.js"></script>
<script>
    layui.config({
        base: '${basePath}/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'useradmin', 'table', 'layer','upload'], function () {
        var $ = layui.$
            , form = layui.form
            , table = layui.table
            , layer = layui.layer
            , upload=layui.upload;




        //图片上传
        upload.render({
            elem: '#upload',//绑定元素
            url: '${basePath}/uploadPicture', //上传接口
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
                $("#imageUrl").val(res.data.pictureUrl);
                layer.alert("选择图片成功！", {icon: code})
            },
            //上传错误回调
            error: function (index, upload) {
                layer.alert('上传失败！' + index);
            }
        });

        //表格条目
        var tableIns = table.render({
            elem: '#waste-page'  //绑定表格元素，使用ID选择器
            , url: '${basePath}/getWasteList'  //异步请求地址
            , toolbar: '#toolBar' //数据表格上面的工具栏  右侧的  和自定义的工具栏ID绑定在一块
            , cols: [[//表头  field:与实体类的属性名一致
                {type: 'checkbox'}
                , {field: 'wasteId', width: 120, title: '废品ID', sort: true}
                , {field: 'wasteName', width: 120, title: '废品名称'}
                , {field: 'price', width: 80,sort:true, title: '单价'}
                , {field: 'unit', width: 80, title: '单位'}
                , {field: 'describe', title: '描述'}
                , {field: 'image', width: 80, title: '缩略图',templet:function (obj){
                        return '<div onclick="show_img(this)" ><img src="${basePath}/'+obj.imageUrl+'" ' +
                            'alt="" width="50px" height="50px"></a></div>';}}
                , {fixed: 'right', title: '操作', toolbar: '#barDemo', width: 150}
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
                skin: 'layui-layer-rim', //加上边框
                area: ['450px', '450px'],
                //area: ['60%', '60%'], //宽高 t.width() t.height()

                shadeClose: true, //开启遮罩关闭
                end: function (index, layero) {
                    return false;
                },
                content: '<div style="text-align:center ;width: 100%;height: 100%;"><img style="width: 100%;height: 100%;" src="' + $(t).attr('src') + '"/></div>'
            });
        }


        //监听 头部工具栏的点击toolbar

        table.on('toolbar(LAY-page)', function (obj) {
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
        table.on('tool(LAY-page)', function (obj) {

            console.log(obj);
            var event = obj.event;
            var id = obj.data.wasteId;
            var imageUrl=obj.data.imageUrl;
            if (event === 'singleEdit') {
                console.log(obj.data);
                openUpdateWindow(obj.data);
            } else if (event === 'singleDel') {
                layer.confirm("确定删除该废品[ID:"+id+"]吗？",{icon:3,title:"提示"}, function (index) {

                    $.ajax({
                        url: 'delWaste',
                        type: 'post',
                        data: {'wasteId': id,'imageUrl':imageUrl},
                        dataType: "json",
                        success: function () {
                            layer.alert('删除成功', {
                                icon: 6,//成功的表情
                                //time: 2000 1秒关闭（如果不配置，默认是3秒）
                            });
                            tableIns.reload();
                        }
                    })
                    layer.close(index);
                });
            }
        })

        //监听搜索按钮提交的事件
        form.on("submit(LAY-search)", function (data) {

            console.log(data);
            tableIns.reload({
                where: data.field
                /*                    {//设置表格异步接口的额外参数
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
            mainIndex = layer.open({
                type: 1,//弹出层类型
                title: "添加废品",
                area: ['500px', '580px'],
                content: $("#addWaste"),//引用的窗口代码 divID
                success: function () {
                    //清空表单数据
                    $("#wasteForm")[0].reset();//JavaScript中的方法
                    url = "${basePath}/addWaste";
                    $('#preview').attr('src', "");
                }
            });
        }

        //打开编辑窗口
        function openUpdateWindow(data) {
            console.log(data);
            mainIndex = layer.open({
                type: 1,//弹出层类型
                title: "编辑废品信息",
                area: ['500px', '580px'],
                content: $("#addWaste"),//引用的窗口代码 divID
                success: function () {

                    form.val("dataFrm", data); //表单数据的回显
                    // url = "/bill/addBill";
                    url = "${basePath}/updateWaste";

                    //将对应的URL写入框中的src
                    $('#preview').attr('src', data.imageUrl);
                }
            });
        }

        //监听增加和修改的表单提交
        form.on("submit(formWaste)", function (data) {
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
            var checkStatus = table.checkStatus('waste-page'); //idTest 即为基础参数 id 对应的值

            if (checkStatus.data.length > 0) {
                //定义数组，保存要删除的ID
                var idArr = [];
                var urlArr =[];
                for (var i = 0; i < checkStatus.data.length; i++) {
                    idArr.push(checkStatus.data[i].wasteId);
                    urlArr.push(checkStatus.data[i].imageUrl);
                }
                console.log(idArr);
                console.log(urlArr);
                var ids = idArr.join(",");//以字符串数组以分割，默认是 ,
                var ulrs=urlArr.join(",");
                layer.confirm("确定要删除这<font color='red'>" + checkStatus.data.length + "</font>条数据吗？", {
                    icon: 3,
                    title: "提示"
                }, function (index) {
                    //请求ajax
                    $.post("${basePath}/wasteBatchDel", {"ids": ids,"urls":ulrs}, function (result) {
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
                url: 'addWaste',
                type: 'post',
                data: {wasteId: id},
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
