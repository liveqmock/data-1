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
	<div id="priceContainer"></div>
</body>
<script type="text/javascript">
	/**创建全局上下文*/
	$.extend(R.ctx, {root : "${ctx}/base/sys/price/ajax/"});
	var priceFrame = new R.DataFrame({
		/**frame位置 为jQuery选择器*/
		containerId: "#priceContainer",
		/**数据表格配置*/
		datatable: {
			/**数据表格选项卡的名称*/
			name: "能耗计价管理",
			/**数据加载的地址 自动添加页码和每页大小*/
			loadUrl: "{ctx.root}getData",
			columns: [
				{id:"id", type:"rowCheck"},//选择列
	            {id:"ecds.name",  name:"能源名称"},
	            {id:"threshold", name:"阶梯",type:function(val){
	            	return val;
	            }},
	            {id:"unitprice", name:"价格",type:function(val){
	            	return Common.toFix(val);
	            }},
	            {id:"buildName",name:"建筑", type: function(){
	            	var build = this.parent.data['build'];
	            	return build ? build.name : '';
	            	
	            }},
	            {id:"regionName",  name:"所属区域", type: function() {
	            	var region = this.parent.data['region'];
	            	return region ? region.name : '';
	            }},
	            {id:"dateStr",   name:"创建时间"}
			],         
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
            ]},
            /*
             * 注册点击表格操作
             */
			eventListener: {
				"open": {
                    /*
                     * style取值: tab、page、open、dialog(默认)
                     */
					//style: "dialog",
					url: "{ctx.root}detailFrame?id={event.info.rowKey}", 
					name:"{event.info.row.data['id']}",
					title: '详情',
					width: 520
				}
			}
		}
	});
	priceFrame.render();
	priceFrame.load();
</script>
</html>