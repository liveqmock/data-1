package com.infosystem.common.framework.dao.condition.impl;

import com.infosystem.common.framework.dao.condition.AbstractCondition;
import com.infosystem.common.framework.dao.condition.Association;

public class Like extends AbstractCondition {

	public Like(String table, String column, String pattern) {
		super(table);
		this.conditionBuffer.append(table).append(".").append(column)
				.append(" like ").append("'").append(pattern).append("'");
	}

	public Like(String column, String pattern) {
		this.conditionBuffer.append(column).append(" like ").append("'")
				.append(pattern).append("'");
	}

	public Like(Association association, String column, String pattern) {
		this.addAssociationCondition(association);
		conditionBuffer.append(association.getRefTable()).append(".")
				.append(column);
		conditionBuffer.append(" like ").append("'" + pattern + "'");

	}

	@Override
	public String getString() {

		return conditionBuffer.toString();
	}

}
