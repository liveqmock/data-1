package com.infosystem.common.framework.dao.condition.impl;

import com.infosystem.common.framework.dao.condition.AbstractCondition;
import com.infosystem.common.framework.dao.condition.Association;

public class ISNull extends AbstractCondition {

	public ISNull(String table, String column) {
		super(table);
		this.conditionBuffer.append(table).append(".").append(column)
				.append(" is null");
	}

	public ISNull(String column) {
		this.conditionBuffer.append(column).append(" is null");
	}

	public ISNull(Association association, String column) {
		this.addAssociationCondition(association);
		conditionBuffer.append(association.getRefTable()).append(".")
		.append(column).append(" is null");
	}

	@Override
	public String getString() {
		return conditionBuffer.toString();
	}

}
