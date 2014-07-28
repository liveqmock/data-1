<%@ include file="/common/common.jsp"%>
<css:vendor url="ztree/zTreeStyle/zTreeStyle.css" />
<js:vendor url="ztree/jquery.ztree.all-3.5.min.js" />
<div class="dialogform rkdialog relative" style="width:100%;">
	<form:form modelAttribute="priceFrom" action="${ctx}/base/sys/price/ajax/save" method="post" id="priceFrom" class="rkAjaxForm">
		<form:hidden path="id"/>
		<table>
			<tr>
            	<th class="w30"><span class="require">*</span>能耗：</th>
  				<td><form:input path="ecds.name" readonly="true"/></td>
            </tr>
            <tr>
            	<th><span class="require">*</span>区域：</th>
				<td><form:input path="region.name" readonly="true"/></td>
            </tr>
            <tr>
            	<th>建筑：</th>
				<td><form:input path="build.name" readonly="true"/></td>
            </tr>
            <tr>
            	<th><span class="require">*</span>阶梯：</th>
                <td><form:input path="threshold" readonly="true"/></td>
            </tr>   
            <tr>
            	<th><span class="require">*</span>价格：</th>
                <td><form:input path="unitprice" readonly="true"/></td>
            </tr>   
        </table>
	</form:form>
</div>