package com.infosystem.common.framework.dao.condition.impl;

public enum Comparator {

   GREATER(">"), LESSTHAN("<"), EQUAL("="), GREATER_EQUAL(">="), LESSTHAN_EQUAL("<="), NOT_EQUAL(
         "!=");
   Comparator(String op) {
      this.operator = op;
   }

   @Override
   public String toString() {
      return this.operator;
   }

   private String operator;
}
