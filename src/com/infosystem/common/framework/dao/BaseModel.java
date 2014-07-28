package com.infosystem.common.framework.dao;

import java.io.Serializable;
import java.util.Date;
/**
 *model的对象需要继承的类
 * @author hudaowan
 *
 */
public class BaseModel implements Serializable{

    private static final long serialVersionUID = -5315149748105968829L;
    protected Long id;
    protected Date createDate = new Date();
    
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

}
