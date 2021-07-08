package com.recycle.utils;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

public class ImgUploadUtils {
    /**
     *
     * @param request
     * @param tailPath  形如：/upload/img
     * @param picture  图片对象
     * @return  项目名之后的部分图片url
     */
    public static String imgUpload(HttpServletRequest request, String tailPath , MultipartFile picture){
        String path=request.getServletContext().getRealPath(tailPath);
        File file=new File(path);//创建文件目录对象
        if(!file.exists()){
            file.mkdirs(); //创建目录
        }

        //新文件名=UUID+图片的后缀名
        String newFileName= UUID.randomUUID()+".jpg";
        try {
            picture.transferTo(new File(path, newFileName));
        } catch (IOException e) {
            e.printStackTrace();
        }

        String imagePath=tailPath.substring(1)+"/"+newFileName;  //数据库中的url
        return imagePath;
    }
}
