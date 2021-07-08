package com.recycle.controller.interceptor;

import com.recycle.bean.Admin;
import com.recycle.utils.SessionUtil;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

public class BackStageInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Admin admin= (Admin) request.getSession().getAttribute("admin");
        if (admin==null){
            response.sendRedirect(request.getContextPath()+"/toLogin");
            return false;

        }
        if (SessionUtil.userExist(admin.getId(),request.getSession())){
            response.setContentType("text/html; charset=UTF-8"); //转码

            PrintWriter out = response.getWriter();
            String basePath=request.getContextPath();
            String scriptStr="<html>\n<script src=\""+basePath+"/layuiadmin/layui/layui.js\"></script>\n" +
                    "<script>\n" +
                    "    layui.config({\n" +
                    "        base: '"+basePath+"/layuiadmin/' \n" +
                    "    }).extend({\n" +
                    "        index: 'lib/index' \n" +
                    "    }).use(['index', 'useradmin', 'layer'], function () {\n" +
                    "        var $ = layui.$\n" +
                    "            , layer = layui.layer;\n";

            scriptStr+="        layer.alert('您的账号在别地登录，您被迫下线',{icon:0},function (){\n" +
                "            window.location='"+basePath+"/toLogin';\n"
                        + "        });\n"
                        +"    });"
                        + "</script>\n"
                        + "</html>"

            ;

            out.println(scriptStr);
            return false;

           // out.println("layer.alert('您的账号在别地登录，您被迫下线')");
            //response.sendRedirect(request.getContextPath()+"/toLogin");
            /*out.println("window.open ('" + request.getContextPath()
                    + "/toLogin,'_top');");*/
           //ut.println("    });\n" +
            //      "</script>");
           //ut.println("</html>");
            // arg0.getRequestDispatcher("login.jsp").forward(arg0,arg1);

            /*PrintWriter out = response.getWriter();
            out.write("账号在别处登录");
            out.close();
            response.sendRedirect(request.getContextPath()+"/toLogin");
            return false;*/

        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
