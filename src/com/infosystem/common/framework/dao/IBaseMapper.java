package com.infosystem.common.framework.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.infosystem.common.framework.dao.condition.Condition;

public interface IBaseMapper<T> {

   public void add(T t);

   public T get(Object id);

   public void delete(String id);

   public void update(T t);

   public int countAll();

   public List<T> findByPage(PageInfo pageInfo);

   public List<T> findByPageByCondition(@Param("condition")Condition condition,@Param("pageInfo")PageInfo pageInfo);

   public List<T> findByCondition(@Param("condition") Condition condition);

   public int countByCondition(@Param("condition")Condition condition);

   public List<T> findAll();

   public List<T> findByIds(List<String> ids);

}
