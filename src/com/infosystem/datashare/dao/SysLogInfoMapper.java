package com.infosystem.datashare.dao;

import java.util.List;

import org.apache.ibatis.annotations.DeleteProvider;
import org.apache.ibatis.annotations.InsertProvider;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;

import com.infosystem.common.framework.dao.IBaseMapper;
import com.infosystem.common.framework.dao.PageInfo;
import com.infosystem.common.framework.dao.condition.Condition;
import com.infosystem.datashare.dao.sqlprovider.SysLogInfoSQLProvider;
import com.infosystem.datashare.model.SysLogInfo;

/**
 * 系统操作日志
 * @author hudaowan
 *
 */
public interface SysLogInfoMapper extends IBaseMapper<SysLogInfo>{
	/** 
	 * 分页查询
	 */
	@Override
	@SelectProvider(method="getFindByPageByCondition",type=SysLogInfoSQLProvider.class)
	public List<SysLogInfo> findByPageByCondition(@Param("condition")Condition condition,@Param("pageInfo")PageInfo pageInfo);
	
	/**
	 *得到查询数据的总数
	 * Integer  
	 *@exception
	 */
   @Override
   @SelectProvider(method="getCountByCondition",type=SysLogInfoSQLProvider.class)
   public int countByCondition(@Param("condition")Condition condition);
   
   @Override
   @SelectProvider(method="getCount",type=SysLogInfoSQLProvider.class)
   public int countAll();
	
   @Override
   @InsertProvider(method="getInsert",type=SysLogInfoSQLProvider.class)
   public void add(SysLogInfo t);
   
   @Override
   @DeleteProvider(method="getUpdate",type=SysLogInfoSQLProvider.class)
   public void update(SysLogInfo t);

   @Override
   @SelectProvider(method="getSelect",type=SysLogInfoSQLProvider.class)
   public SysLogInfo get(Object id);

   @Select("select * from sysloginfo where modelName = #{modelName}")
   public List<SysLogInfo> findByName(@Param("modelName") String modelName);
   
   @Override
   @DeleteProvider(method="getDelete",type=SysLogInfoSQLProvider.class)
   public void delete(String id);
   
   @Override
   @SelectProvider(method="getSelectByPage",type=SysLogInfoSQLProvider.class)
   public List<SysLogInfo> findByPage(PageInfo pageInfo);
   
   @Override
   @SelectProvider(method="getSelectAll",type=SysLogInfoSQLProvider.class)
   public List<SysLogInfo> findAll();
}
