package com.infosystem.common.framework.dao.sqlprovider;

import java.util.Map;

public interface ISQLProvider<T> {

   public String getInsert();

   public String getSelect();

   public String getSelectByIds(Map idMap);

   public String getUpdate();

   public String getDelete();

   public String getCount();

   public String getSelectByPage();

   public String getSelectAll();

   public String getSelectByCondition(Map map);

   public String getCountByCondition(Map map);

   public String getFindByPageByCondition(Map map);

}
