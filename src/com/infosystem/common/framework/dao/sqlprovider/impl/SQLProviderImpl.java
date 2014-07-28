package com.infosystem.common.framework.dao.sqlprovider.impl;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.ibatis.jdbc.SQL;

import com.infosystem.common.framework.dao.PageInfo;
import com.infosystem.common.framework.dao.annotation.Column;
import com.infosystem.common.framework.dao.annotation.ID;
import com.infosystem.common.framework.dao.annotation.JoinTable;
import com.infosystem.common.framework.dao.annotation.JoinTables;
import com.infosystem.common.framework.dao.annotation.Table;
import com.infosystem.common.framework.dao.annotation.Transient;
import com.infosystem.common.framework.dao.condition.Condition;
import com.infosystem.common.framework.dao.sqlprovider.ISQLProvider;
import com.infosystem.common.util.StringUtil;

public abstract class SQLProviderImpl<T> implements ISQLProvider<Object> {

   protected final Class<T> modelClass;
   private String table;

 @SuppressWarnings("unchecked")
  public SQLProviderImpl() {
      Type t = getClass().getGenericSuperclass();
      ParameterizedType p = (ParameterizedType) t;
      Class<T> c = (Class<T>) p.getActualTypeArguments()[0];
      modelClass = c;
   }

   @Override
   public String getInsert() {
      Table table = modelClass.getAnnotation(Table.class);
      final String tableName = table != null ? table.value() : modelClass
            .getSimpleName();
      Field[] fields = this.getFields();
      final StringBuilder columsString = new StringBuilder();
      final StringBuilder valuesString = new StringBuilder();
      for (Field field : fields) {
         Transient ta = field.getAnnotation(Transient.class);
         if (ta != null)
            continue;
         if (Modifier.isStatic(field.getModifiers()))
            continue;
         String columnName = field.getName();
         Column column = field.getAnnotation(Column.class);
         if (column != null)
            columnName = column.value();
         columsString.append(columnName).append(",");
//         JdbcType type=   field.getAnnotation(JdbcType.class);
        	 valuesString.append("#{" + field.getName() + "}").append(",");
      }
      columsString.deleteCharAt(columsString.length() - 1);
      valuesString.deleteCharAt(valuesString.length() - 1);

      String sql = new SQL() {
         {
            INSERT_INTO(tableName);
            VALUES(columsString.toString(), valuesString.toString());
         }
      }.toString();

      return sql;
   }

   @Override
   public String getSelect() {
      SelectContext context = this.selectWithJoins();
      final String where = context.tableAlias + "." + context.idColumn + "=" + "#{id}";
      context.where = where;
      String sql = context.toSql();
      return sql;
   }

   /**
    *拼写查询的条件
    * @param queryMap
    * @return
    */
   protected abstract String parseQuery(Map queryMap);

   public String getSelectByQueryConditon(Map queryMap) {
      Table table = modelClass.getAnnotation(Table.class);
      final String tableName = table != null ? table.value() : modelClass
            .getSimpleName();
      Field[] fields = getFields();
      final StringBuilder select = new StringBuilder();
      for (Field field : fields) {
         Transient ta = field.getAnnotation(Transient.class);
         if (ta != null)
            continue;
         if (Modifier.isStatic(field.getModifiers()))
            continue;
         String columnName = field.getName();
         Column column = field.getAnnotation(Column.class);
         if (column != null)
            columnName = column.value();
         select.append(columnName).append(" as ").append(field.getName()).append(",");
      }
      select.deleteCharAt(select.length() - 1);
      final String queryCondition = parseQuery(queryMap);

      return new SQL() {
         {
            SELECT(select.toString());
            // to do! need to expand for mulit db support
            FROM(tableName);
            WHERE(queryCondition);
         }
      }.toString();
   }

   @Override
   public String getSelectByIds(Map idMap) {
      final String select = this.select();
      final StringBuffer sbu = new StringBuffer();
      sbu.append("id in (");
      List<String> ids = (List<String>) idMap.get("ids");
      for (String id : ids) {
         sbu.append("'" + id + "'");
         sbu.append(",");
      }
      sbu.deleteCharAt(sbu.length() - 1);
      sbu.append(")");
      final String tableName = this.table;
      return new SQL() {
         {
            SELECT(select);
            // to do! need to expand for mulit db support
            FROM(tableName);
            WHERE(sbu.toString());
         }
      }.toString();
   }

   @Override
   public String getSelectByPage() {
      SelectContext context = this.selectWithJoins();
      String pageString = "order by #{sortColumn} #{sortStyle}  LIMIT #{startRow},#{count}";
      context.pageString = pageString;
      String sql = context.toSql();
      return sql;
   }

   @Override
   public String getSelectAll() {
     SelectContext context =  this.selectWithJoins();
     String sql= context.toSql();
     return sql;
   }

   @Override
   public String getUpdate() {
      Table table = modelClass.getAnnotation(Table.class);
      final String tableName = table != null ? table.value() : modelClass
            .getSimpleName();
      final StringBuilder sets = new StringBuilder();
      Field[] fields = this.getFields();
      String idColumn = "";
      String idProp="id";
      for (Field field : fields) {
         Transient ta = field.getAnnotation(Transient.class);
         if (ta != null)
            continue;
         if (Modifier.isStatic(field.getModifiers()))
            continue;
         String columnName = field.getName();
         Column column = field.getAnnotation(Column.class);
         if (column != null)
            columnName = column.value();

         sets.append(columnName).append("=").append("#{").append(field.getName())
               .append("},");
         ID id = field.getAnnotation(ID.class);
         if (id != null) {
            idColumn = id.value();
            idProp=field.getName();
         } //else {
            if (field.getName().equals("id")) {
               if (column != null)
                  idColumn = column.value();
               else
                  idColumn = "id";
            }
         //}
      }
      sets.deleteCharAt(sets.length() - 1);
      final String where = idColumn + "=" + "#{"+idProp+"}";
      String sql= new SQL() {
         {
            UPDATE(tableName);
            SET(sets.toString());
            WHERE(where);
         }
      }.toString();
      return sql;
   }

   @Override
   public String getDelete() {
      Table table = modelClass.getAnnotation(Table.class);
      final String tableName = table != null ? table.value() : modelClass
            .getSimpleName();
      Field[] fields = this.getFields();
      String idColumn = "";
      for (Field field : fields) {
         ID id = field.getAnnotation(ID.class);
         if (id != null) {
            idColumn = id.value();
            break;
         } else {
            if (field.getName().equals("id")) {
               Column column = field.getAnnotation(Column.class);
               if (column != null)
                  idColumn = column.value();
               else
                  idColumn = "id";
            }
         }
      }
      final String where = idColumn + "=" + "#{id}";
      String sql = new SQL() {
         {
            DELETE_FROM(tableName);
            WHERE(where);
         }
      }.toString();
      return sql;
   }

   @Override
   public String getCount() {
      Table table = modelClass.getAnnotation(Table.class);
      final String tableName = table != null ? table.value() : modelClass
            .getSimpleName();
      return new SQL() {
         {
            SELECT("COUNT(1)");
            FROM(tableName);
         }
      }.toString();
   }

   @Override
   public String getCountByCondition(Map map) {
      Condition condition = (Condition) map.get("condition");
      Table table = modelClass.getAnnotation(Table.class);
       String tname = table != null ? table.value() : modelClass
            .getSimpleName();
    String atable=  condition.getAssociatedTable();
    final  String  tableName=atable.length()>0?(tname+","+atable):tname;
      final String where = " where " + condition.getString();
      String sql = new SQL() {
         {
            SELECT("COUNT(1)");
            FROM(tableName + where);
         }
      }.toString();
      return sql;
   }

   @Override
   public String getFindByPageByCondition(Map map) {
      SelectContext context = this.selectWithJoins();
      Condition condition = (Condition) map.get("condition");
      context.where=condition.getString();
      PageInfo pageInfo = (PageInfo) map.get("pageInfo");
      final StringBuffer orderByBuffer = new StringBuffer();
      orderByBuffer.append(" order by ").append(pageInfo.getSortColumn()).append(" ")
            .append(pageInfo.getSortStyle()).append(" limit ")
            .append(pageInfo.getStartRow()).append(",").append(pageInfo.getCount());
      context.pageString=orderByBuffer.toString();
      String sql = context.toSql();
      return sql;
   }

   protected Field[] getFields() {
      Field[] fields0 = modelClass.getDeclaredFields();
      Class superClass = modelClass.getSuperclass();
      Field[] fields = fields0;
      while(!superClass.equals(Object.class)){
    	  Field[] superFields = superClass.getDeclaredFields();
    	  if(superFields!=null&&superFields.length>0){
    		  Field[] newFiles = new Field[fields.length+superFields.length];
    		  System.arraycopy(fields, 0, newFiles, 0, fields.length);
    		  System.arraycopy(superFields, 0, newFiles, fields.length, superFields.length);
    		  fields=newFiles;
    	  }else{
    		  break;
    	  }
          superClass = superClass.getSuperclass();
      }
      return fields;
   }

   private String select() {
      Table table = modelClass.getAnnotation(Table.class);
      final String tableName = table != null ? table.value() : modelClass
            .getSimpleName();
      this.table = tableName;
      Field[] fields = getFields();
      final StringBuilder select = new StringBuilder();
      for (Field field : fields) {
         Transient ta = field.getAnnotation(Transient.class);
         if (ta != null)
            continue;
         if (Modifier.isStatic(field.getModifiers()))
            continue;
         String columnName = field.getName();
         Column column = field.getAnnotation(Column.class);
         if (column != null)
            columnName = column.value();
         select.append(columnName).append(" as ").append(field.getName()).append(",");
      }
      select.deleteCharAt(select.length() - 1);
      return select.toString();
   }

   private SelectContext selectWithJoins() {
      SelectContext context = new SelectContext();
      Table table = modelClass.getAnnotation(Table.class);
      final String tableName = table != null ? table.value() : modelClass
            .getSimpleName();
      this.table = tableName;
      context.tableAlias = this.table;
      List<String> joinSqlList = new ArrayList<String>();
      List<String> fetchClauses = new ArrayList<String>();
      Set<String> excludeNames = new HashSet<String>();
      JoinTables joinTables = modelClass.getAnnotation(JoinTables.class);
      if (joinTables != null) {
         JoinTable tables[] = joinTables.value();
         for (JoinTable jtable : tables) {
            StringBuilder joinSql = new StringBuilder();
            StringBuilder fetchClause = new StringBuilder();
            String tableAlias =jtable.alias();
            String aliasColumns[] = jtable.aliasColumns();
            String columns[] = jtable.fetchColumns();
            String rtable = jtable.value();
            String rColumn = jtable.referenceColumn();
            String column = jtable.joinColumn();
            joinSql.append(rtable).append(" " + tableAlias + " ").append("  on ")
                  .append(this.table+"." + column).append("=").append(tableAlias)
                  .append("." + rColumn);
            joinSqlList.add(joinSql.toString());
            if (aliasColumns.length != columns.length)
               throw new RuntimeException(
                     "fetchColumns.length dose not equal to aliasColumns.length");

            for (int i = 0; i < aliasColumns.length; i++) {
               fetchClause.append(" , ").append(tableAlias + "." + columns[i])
                     .append(" as ").append(aliasColumns[i]);
               excludeNames.add(aliasColumns[i]);
            }
            fetchClauses.add(fetchClause.toString());
         }
      }
      Field[] fields = getFields();
      String idColumn = "id";
      final StringBuilder select = new StringBuilder();
      for (Field field : fields) {
         Transient ta = field.getAnnotation(Transient.class);
         if (ta != null)
            continue;
         if (Modifier.isStatic(field.getModifiers()))
            continue;
         String columnName = field.getName();
         if (excludeNames.contains(columnName))
            continue;
         Column column = field.getAnnotation(Column.class);
         ID id = field.getAnnotation(ID.class);
         if (id != null)
            idColumn = id.value();
         if (column != null)
            columnName = column.value();
         select.append(this.table+"." + columnName).append(" as ").append(field.getName())
               .append(",");
      }
      select.deleteCharAt(select.length() - 1);
      context.mainSelect = select.toString();
      context.joinSelects = fetchClauses;
      context.table = tableName;
      context.joins = joinSqlList;
      context.idColumn = idColumn;
      return context;
   }

   @Override
   public String getSelectByCondition(Map map) {
      Condition condition = (Condition) map.get("condition");
      SelectContext context = this.selectWithJoins();
      context.where=condition.getString();
      context.associatedTables=condition.getAssociatedTable();
      String sql = context.toSql();
      return sql;
   }

   private class SelectContext {
      String table;
      String tableAlias;
      List<String> joins;
      String mainSelect;
      List<String> joinSelects;
      String idColumn;
      String where;
      String pageString;
      String associatedTables;

      public String toSql() {
         final StringBuilder select = new StringBuilder();
         final String tname = table+(StringUtil.isValid(associatedTables)?","+associatedTables:"");
         final List<String> fjoins = this.joins;
         select.append(mainSelect);
         if (joinSelects != null && joinSelects.size() > 0)
            for (String js : joinSelects) {
               select.append(" ").append(js);
            }
         String sql = new SQL() {
            {
               SELECT(select.toString());
               FROM(tname + " ");
               if (fjoins != null)
                  for (String join : fjoins) {
                     LEFT_OUTER_JOIN(join);
                  }
               if (where != null)
                  WHERE(where);
            }
         }.toString();
         if (this.pageString != null)
            sql += (" " + pageString);
         return sql.toString();
      }
   }

}
