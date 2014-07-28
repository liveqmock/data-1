package com.infosystem.common.framework.dao.condition.impl;

import java.util.List;
import java.util.Set;

import com.infosystem.common.framework.dao.condition.AbstractCondition;

public class NotIN extends AbstractCondition {

   public NotIN(String table,String column, List<String> values) {
      super(table);
      conditionBuffer.append(table).append(".").append(column).append(" not in (");
      for (String s : values) {
         this.conditionBuffer.append("'").append(s).append("'").append(",");
      }
      conditionBuffer.deleteCharAt(conditionBuffer.length() - 1);
      conditionBuffer.append(")");
   }
   public NotIN(String column, List<String> values) {
      conditionBuffer.append(column).append(" not in (");
      for (String s : values) {
         this.conditionBuffer.append("'").append(s).append("'").append(",");
      }
      conditionBuffer.deleteCharAt(conditionBuffer.length() - 1);
      conditionBuffer.append(")");
   }

   public NotIN(String table,String column, Set<Integer> values) {
      super(table);
      conditionBuffer.append(table).append(".").append(column).append(" not in (");
      for (Integer v : values) {
         conditionBuffer.append(v.intValue()).append(",");
      }
      conditionBuffer.deleteCharAt(conditionBuffer.length() - 1);
      conditionBuffer.append(")");
   }
   public NotIN(String column, Set<Integer> values) {
      conditionBuffer.append(column).append(" not in (");
      for (Integer v : values) {
         conditionBuffer.append(v.intValue()).append(",");
      }
      conditionBuffer.deleteCharAt(conditionBuffer.length() - 1);
      conditionBuffer.append(")");
   }

   @Override
   public String getString() {

      return conditionBuffer.toString();
   }

}
