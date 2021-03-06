package com.gh.util;

import java.util.List;


/**
 * @author Administrator
 *分页类
 *
 */
public class PageList<T> {
	 
	    private int page = 1;
	    private int rows = 10;
	    private int total;
	    private List<T> list;
	    private Object datas;
	    
	    
	 
	    public Object getDatas() {
			return datas;
		}

		public void setDatas(Object datas) {
			this.datas = datas;
		}

		public PageList() {
	        super();
	    }
		 public PageList(int page, int rows, int total, Object obj) {
		        super();
		        this.page = page;
		        this.rows = rows;
		        this.total = total;
		        this.datas = obj;
		    }
	    public PageList(int page, int rows, int total, List<T> list) {
	        super();
	        this.page = page;
	        this.rows = rows;
	        this.total = total;
	        this.list = list;
	    }
	 
	    public int getPage() {
	        return page;
	    }
	 
	    public void setPage(int page) {
	        this.page = page;
	    }
	 
	    public int getRows() {
	        return rows;
	    }
	 
	    public void setRows(int rows) {
	        this.rows = rows;
	    }
	 
	    public List<T> getList() {
	        return list;
	    }
	 
	    public void setList(List<T> list) {
	        this.list = list;
	    }
	 
	    public int size(){
	        return null==list?0:list.size();
	    }
	 
	    public int getTotal() {
	        return total;
	    }
	 
	    public void setTotal(int total) {
	        this.total = total;
	    }
	 
}
