package com.infosystem.common.framework.dao.condition;

public abstract class AbstractCondition implements Condition {

	protected final StringBuffer conditionBuffer = new StringBuffer();
	protected String table;
	protected StringBuffer associatedTableBuffer = new StringBuffer();

	public AbstractCondition() {

	}

	protected void addAssociationCondition(Association association) {
		if (associatedTableBuffer.length() > 0)
			associatedTableBuffer.append(",");
		associatedTableBuffer.append(" ").append(association.getRefTable());
		if (conditionBuffer.length() > 0)
			conditionBuffer.append("and ");
		conditionBuffer.append(association.getRefTable()).append(".")
				.append(association.getRefColumnName()).append("=");
		conditionBuffer.append(association.getTable()).append(".")
				.append(association.getColumnName()).append(" ");
				if(association.getCondition()!=null){
					conditionBuffer.append(" and ")
					.append(association.getCondition());
				}
//				.append("and ");
	}

	public AbstractCondition(String table) {
		this.table = table;
	}

	@Override
	public String getAssociatedTable() {
		return this.associatedTableBuffer.toString();
	}

	@Override
	public void setTable(String table) {
		this.table = table;
	}

	@Override
	public String getTable() {
		return this.table;
	}

	@Override
	public Condition and(Condition c) {
		if(c.getAssociatedTable()!=null&&c.getAssociatedTable().length()>1){
		if (associatedTableBuffer.length() > 0)
			associatedTableBuffer.append(",");
		associatedTableBuffer.append(" ").append(c.getAssociatedTable());
		}
		conditionBuffer.append(" and ").append(c.getString());

		return this;
	}

	@Override
	public Condition or(Condition c) {
		if(c.getAssociatedTable()!=null&&c.getAssociatedTable().length()>1){
		if (associatedTableBuffer.length() > 0)
			associatedTableBuffer.append(",");
		associatedTableBuffer.append(" ").append(c.getAssociatedTable());
		}
		conditionBuffer.append(" or ").append(c.getString());
		return this;
	}

	@Override
	public Condition group() {
		conditionBuffer.insert(0, '(');
		conditionBuffer.append(")");
		return this;
	}

}
