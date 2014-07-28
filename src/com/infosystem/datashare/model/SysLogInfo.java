package com.infosystem.datashare.model;

import com.infosystem.common.framework.dao.BaseModel;
import com.infosystem.common.framework.dao.annotation.Table;
import com.infosystem.common.framework.dao.annotation.Transient;
/**
 * 操作日志
 * @author hudaowan
 */
@Table("sysloginfo")
public class SysLogInfo extends BaseModel{

	private static final long serialVersionUID = 3035640590926676595L;
	private String operation;//操作
	private String status;//操作状态
	private String modelName;
	private Long userId;
	@Transient
	private String userName;
	
	public String getOperation() {
		return operation;
	}
	public void setOperation(String operation) {
		this.operation = operation;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getModelName() {
		return modelName;
	}
	public void setModelName(String modelName) {
		this.modelName = modelName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
    	
}
