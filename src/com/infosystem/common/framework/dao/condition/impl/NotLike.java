package com.infosystem.common.framework.dao.condition.impl;

import com.infosystem.common.framework.dao.condition.AbstractCondition;
import com.infosystem.common.framework.dao.condition.Association;

public class NotLike extends AbstractCondition {

	public NotLike(String table, String column, String pattern) {
		super(table);
		this.conditionBuffer.append(table).append(".").append(column)
				.append(" not like ").append("'").append(pattern).append("'");
	}

	public NotLike(String column, String pattern) {
		this.conditionBuffer.append(column).append(" not like ").append("'")
				.append(pattern).append("'");
	}

	public NotLike(Association association, String column, String pattern) {
		this.addAssociationCondition(association);
		conditionBuffer.append(association.getRefTable()).append(".")
		.append(column).append(" not like ").append("'")
				.append(pattern).append("'");
	}

	@Override
	public String getString() {

		return conditionBuffer.toString();
	}

}
