package com.infosystem.common.framework.dao.condition;

public interface Condition {

  public String getString();

  public Condition and(Condition c);

  public Condition or(Condition c);

  public Condition group();

  public String getTable();

  public String getAssociatedTable();

  public void setTable(String table);

}
