package com.infosystem.datashare.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Service;

import com.infosystem.common.framework.dao.PageInfo;
import com.infosystem.common.framework.dao.condition.Condition;
import com.infosystem.common.framework.dao.condition.impl.Comparator;
import com.infosystem.common.framework.dao.condition.impl.CompareCondition;
import com.infosystem.common.framework.dao.condition.impl.Like;
import com.infosystem.common.util.IDIntegerCreater;
import com.infosystem.datashare.dao.SysLogInfoMapper;
import com.infosystem.datashare.model.SysLogInfo;
import com.infosystem.datashare.service.ISysLogInfoService;

@Service("sysLogInfoService")
public class SysLogInfoServiceImpl implements ISysLogInfoService {
    private Long idGenerator = IDIntegerCreater.createID();
	@Autowired
	private SysLogInfoMapper sysLogInfoMapper;
	
	@Override
	@Transactional(readOnly = true)
	public Map<String, Object> findUserByPage(SysLogInfo sysLogInfo,Integer startRow, Integer pageSize) {
		List<SysLogInfo> list = new ArrayList<SysLogInfo>();
	    PageInfo pageInfo = new PageInfo(startRow,pageSize,"date",PageInfo.SORT_DESC);
	    Condition condition = new CompareCondition("1",1,Comparator.EQUAL);
	    if(!"".equals(sysLogInfo.getModelName().trim())){
	    	condition.and(new Like("username","%"+sysLogInfo.getModelName()+"%"));
	    }
	    list = this.sysLogInfoMapper.findByPageByCondition(condition, pageInfo);
		Integer count = this.sysLogInfoMapper.countByCondition(condition);
		Map<String,Object> rsmap = new HashMap<String,Object>();
		rsmap.put("data", list);
		rsmap.put("count", count);
		return rsmap;
	}

	@Override
	@Transactional(readOnly = true)
	public SysLogInfo findById(String id) {
		SysLogInfo sysLogInfo = this.sysLogInfoMapper.get(id);
		return sysLogInfo;
	}

	@Override
	@Transactional(readOnly = true)
	public boolean findByName(String name) {
		boolean flag = false;
		List<SysLogInfo> sysLogInfo = this.sysLogInfoMapper.findByName(name);
		if(sysLogInfo.size()>0){
			flag = true;
		}
	  return flag;
	}

	@Override
	@Transactional
	public void addSysLogInfo(SysLogInfo logInfo) {
		logInfo.setId(idGenerator);
		this.sysLogInfoMapper.add(logInfo);
	}

	@Override
	@Transactional
	public void updateSysLogInfo(SysLogInfo logInfo) {
	   this.sysLogInfoMapper.update(logInfo);

	}

	@Override
	@Transactional
	public void deleteSysLogInfo(String id) {
		this.sysLogInfoMapper.delete(id);

	}

}
