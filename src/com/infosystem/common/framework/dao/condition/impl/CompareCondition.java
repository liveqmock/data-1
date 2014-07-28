package com.infosystem.common.framework.dao.condition.impl;

import com.infosystem.common.framework.dao.condition.AbstractCondition;
import com.infosystem.common.framework.dao.condition.Association;

public class CompareCondition extends AbstractCondition {

   public CompareCondition(String table, String column, String value,
         Comparator compartor) {
      super(table);
      this.conditionBuffer.append(table).append(".").append(column).append(" ")
            .append(compartor).append("'").append(value).append("'");
   }

   public CompareCondition(String column, String value, Comparator compartor) {
      this.conditionBuffer.append(column).append(" ")
            .append(compartor).append("'").append(value).append("'");
   }
   public CompareCondition(Association association,String column, String value, Comparator compartor) {
	   this.addAssociationCondition(association);
	   conditionBuffer.append(" and ");
		conditionBuffer.append(association.getRefTable()).append(".")
		.append(column).append(" ")
	            .append(compartor).append("'").append(value).append("'");
	   }

   public CompareCondition(Association association){
	   this.addAssociationCondition(association);
   }
   public CompareCondition(String table, String column, int value, Comparator compartor) {
      super(table);
      this.conditionBuffer.append(table).append(".").append(column).append(" ")
            .append(compartor).append(value);
   }

   public CompareCondition(Association association,String column, int value, Comparator compartor) {
	   this.addAssociationCondition(association);
	   conditionBuffer.append(" and ");
		conditionBuffer.append(association.getRefTable()).append(".")
		.append(column).append(" ")
            .append(compartor).append(value);
   }
   public CompareCondition(String column, int value, Comparator compartor) {
	      this.conditionBuffer.append(column).append(" ")
	            .append(compartor).append(value);
	   }

   public CompareCondition(String table, String column, long value, Comparator compartor) {
      super(table);
      this.conditionBuffer.append(table).append(".").append(column).append(" ")
            .append(compartor).append(value);
   }

   public CompareCondition(String column, long value, Comparator compartor) {
      this.conditionBuffer.append(column).append(" ")
            .append(compartor).append(value);
   }

   public CompareCondition(Association association,String column, long value, Comparator compartor) {
	   this.addAssociationCondition(association);
	   conditionBuffer.append(" and ");
		conditionBuffer.append(association.getRefTable()).append(".")
		.append(column).append(" ")
	            .append(compartor).append(value);
	   }

   public CompareCondition(String table, String column, float value, Comparator compartor) {
      super(table);
      this.conditionBuffer.append(table).append(".").append(column).append(" ")
            .append(compartor).append(value);
   }

   public CompareCondition(String column, float value, Comparator compartor) {
      this.conditionBuffer.append(column).append(" ")
            .append(compartor).append(value);
   }

   public CompareCondition(Association association,String column, float value, Comparator compartor) {
	   this.addAssociationCondition(association);
	   conditionBuffer.append(" and ");
		conditionBuffer.append(association.getRefTable()).append(".")
		.append(column).append(" ")
	            .append(compartor).append(value);
	   }

   public CompareCondition(String table, String column, double value,
         Comparator compartor) {
      super(table);
      this.conditionBuffer.append(table).append(".").append(column).append(" ")
            .append(compartor).append(value);
   }

   public CompareCondition(String column, double value, Comparator compartor) {
      this.conditionBuffer.append(column).append(" ")
            .append(compartor).append(value);
   }


   public CompareCondition(Association association,String column, double value, Comparator compartor) {
	   this.addAssociationCondition(association);
	   conditionBuffer.append(" and ");
		conditionBuffer.append(association.getRefTable()).append(".")
		.append(column).append(" ")
            .append(compartor).append(value);
   }

   @Override
   public String getString() {
      return conditionBuffer.toString();
   }

}
