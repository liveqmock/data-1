<%@include file="/common/common.jsp" %>
<html>
<head>
<style type="text/css">
.rkdt table { table-layout: fixed; }
.rkdt table tr th:first-child { width: 5%; }
.rkdt table tr td { word-break: break-all; }
</style>
</head>
<body>
	<div id="warningContainer"></div>
</body>
<script type="text/javascript">
	/**创建全局上下文*/
	$.extend(R.ctx, {root : "${ctx}/base/sys/warning/ajax/"});
	var userFrame = new R.DataFrame({
		/**frame位置 为jQuery选择器*/
		containerId: "#warningContainer",
		/**数据表格配置*/
		datatable: {
			/**数据表格的唯一标识*/
			id: "warning",
			/**数据表格选项卡的名称*/
			name: "告警设置",
			/**数据加载的地址 自动添加页码和每页大小*/
			loadUrl: "{ctx.root}getData",
			columns: [
				{id:"id", type:"rowCheck"},//选择列
	            {id:"etypeid", name:"能耗类型"},
	            {id:"thresholdval", name:"告警阀值(%)"},
	            {id:"level", name:"告警级别",type:function(status){return status=='0'?'预警':'告警'}}
	         ],
	      //  queryer: {
	      //  	fields: [[{id:"username", name:"用户名"},{id:"loginname", name:"登陆账号"}]]
	       // },	          
			/**工具栏配置*/

			toolbar: { menus: [
	            { 
	            	op: { 
	            		url: "{ctx.root}addFrame", 
	            		width: 520, 
	            		title: "添加" 
	            	}, 
	            	name: "添加", 
	            	id: "addFrame",
                    /*
                     * clazz: 用于设定一系列常见操作 类型：string or array
                     * 可选值: add - 添加； edit - 编辑； del - 删除；
                     *        eqOne - 选中一条数据； minOne - 至少选中一条数据
                     */
	            	clazz: "add"
                    /*
                     * iconClass: 用于设定操作图标
                     * 可选值: add edit del dft key mail enable disable
                     *        exp refresh validate setting analyse
                     * 提示: 其中的add、edit、del操作已经通过clazz设置 不必额外设置iconClass值
                     */
                    //iconClass: 'email'
	            }, {
	            	op: { 
	            		url: "{ctx.root}editFrame?id={datatable.selectRowKeys()[0]}", 
	            		width: 520 
	            	}, 
	            	name: "编辑", 
	            	id: "editFrame", 
	            	clazz: "edit"
	            }, {
	            	op: { 
	            		url: "{ctx.root}delete?{datatable.selectRowKeyParams('ids')}", 
	            		opType: "ajaxGet" 
	            	}, 
	            	name: "删除",
	            	clazz: ["del", "minOne"]
	            }
            ]}
		}
	});
	userFrame.render();
	userFrame.load();
</script>
</html>