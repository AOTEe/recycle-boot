package com.recycle.bean;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class WxPage<T> implements Serializable {
    private Integer pageIndex;//当前页码
    private Integer pageSize=5 ;//每页数据数
    private Integer totalCount ; //总数据数
    private Integer pageTotalCount ; //总页数
    private List<T> list = new ArrayList<T>();//每页显示的数据集合


    public WxPage(){};
    public WxPage(Integer pageIndex, Integer totalCount, List<T> list) {
        this.pageIndex = pageIndex;
        this.totalCount = totalCount;
        this.list = list;
        if (totalCount%this.pageSize==0)
            this.pageTotalCount=totalCount/this.pageSize;
        else
            this.pageTotalCount=totalCount/this.pageSize+1;
    }



    public Integer getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(Integer pageIndex) {
        this.pageIndex = pageIndex;

    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }

    /**
     *
     * @param page
     * @return 返回数据项的index
     */
    public Integer getCurrentIndex(Integer page){
        if (page<=0)
            return 0;
        else
            return (page-1)*this.pageSize;
    }
    //获取总页数
    public Integer getPageTotalCount() {

        return pageTotalCount;
    }

    public void setPageTotalCount() {
        this.pageTotalCount = totalCount/pageSize;
        if(totalCount%pageSize!=0){
            this.pageTotalCount ++;
        }
    }
    public List<T> getList() {
        return list;
    }
    public void setList(List<T> list) {
        this.list = list;
    }
}