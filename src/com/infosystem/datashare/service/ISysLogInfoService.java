package com.infosystem.datashare.service;

import java.util.Map;

import com.infosystem.datashare.model.SysLogInfo;

/**
 * 系统操作日志
 * @author hudaowan
 *
 */
public interface ISysLogInfoService {

	/**
	 * 分页查询
	 *@param userInfo
	 *@param startRow
	 *@param pageSize
	 *@return
	 *        Map<String,Object>
	 *@exception
	 */
	public Map<String,Object> findUserByPage(SysLogInfo sysLogInfo,Integer startRow,Integer pageSize);

	public SysLogInfo findById(String id);

	public boolean findByName(String name);

	public void addSysLogInfo(SysLogInfo sysLogInfo);

	public void updateSysLogInfo(SysLogInfo sysLogInfo);

	public void deleteSysLogInfo(String id);
}
