package com.infosystem.common.framework.dao.condition;

public class Association {

	private final String table;
	private final String refTable;
	private final String columnName;
	private final String refColumnName;
	private final StringBuffer conditionBuffer = new StringBuffer();
	public Association(String table, String column, String refTable,
			String refColumn) {
		this.table = table;
		this.columnName = column;
		this.refTable = refTable;
		this.refColumnName = refColumn;
	}

	public String getTable() {
		return table;
	}

	public String getRefTable() {
		return refTable;
	}

	public String getColumnName() {
		return columnName;
	}

	public String getRefColumnName() {
		return refColumnName;
	}

	public void setCondition(Condition condition){
		conditionBuffer.append(condition.getString()).append(" ");
	}

	public String getCondition(){
		return this.conditionBuffer.toString();
	}

}
