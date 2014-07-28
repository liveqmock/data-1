package com.infosystem.common.framework.dao.condition.impl;

import com.infosystem.common.framework.dao.condition.AbstractCondition;
import com.infosystem.common.framework.dao.condition.Association;

public class NotNull extends AbstractCondition {
	public NotNull(String table, String column) {
		super(table);
		this.conditionBuffer.append(table).append(".").append(column)
				.append(" is not null");
	}

	public NotNull(String column) {
		this.conditionBuffer.append(column).append(" is not null");
	}

	public NotNull(Association association, String column) {
		this.addAssociationCondition(association);
		conditionBuffer.append(association.getRefTable()).append(".")
		.append(column).append(" is not null");
	}

	@Override
	public String getString() {
		return conditionBuffer.toString();
	}

}
