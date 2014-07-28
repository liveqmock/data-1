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
	<div id="userContainer"></div>
</body>
<script type="text/javascript">
	/**创建全局上下文*/
	$.extend(R.ctx, {root : "${ctx}/base/sys/user/ajax/"});
	var userFrame = new R.DataFrame({
		/**frame位置 为jQuery选择器*/
		containerId: "#userContainer",
		/**数据表格配置*/
		datatable: {
			/**数据表格的唯一标识*/
			id: "user",
			/**数据表格选项卡的名称*/
			name: "用户管理",
			/**数据加载的地址 自动添加页码和每页大小*/
			loadUrl: "{ctx.root}getData",
			columns: [
				{id:"id", type:"rowCheck"},//选择列
	            {id:"username", name:"用户名"},
	            {id:"loginname", name:"登陆账号"},
	            {id:"role.name", name:"角色"},
	            {id:"regionid", name:"所属区域"},
	            {id:"contact", name:"电话"},
	            {id:"status", name:"状态", type: function(status) { 
	            		return status=='1'? '启用': '禁用';
	            }},
	            {id:"dateStr", name:"创建时间"}
			],
	        queryer: {
	        	fields: [[{id:"username", name:"用户名"},{id:"loginname", name:"登陆账号"}]]
	        },	          
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
	            },{
	            	op: { 
	            		url: "{ctx.root}update/1?{datatable.selectRowKeyParams('ids')}", 
	            		opType: "ajaxGet" 
	            	}, 
	            	name: "启用",
	            	clazz: ["minOne"],
	            	confirm : "确认启用所选记录?"
	            },{
	            	op: { 
	            		url: "{ctx.root}update/0?{datatable.selectRowKeyParams('ids')}", 
	            		opType: "ajaxGet" 
	            	}, 
	            	name: "禁用",
	            	clazz: ["minOne"],
	            	confirm : "确认禁止所选记录?"
	            },{
	            	op: { 
	            		url: "{ctx.root}updatepass?id={datatable.selectRowKeys()[0]}", 
	            		opType: "ajaxGet" 
	            	}, 
	            	name: "密码重置",
	            	clazz: ["minOne"],
	            	confirm : "确定要重置所选用户密码?"
	            },{
	                op: {
	                    url: "{ctx.root}addBuildingsToUser?id={datatable.selectRowKeys()[0]}",
	                    width: 840
	                },
	                name: "分配建筑",
	                id:"addBuildingsToUser",
	                beforeOp: function(operation) {
						var data = operation.datatable.selectRows[0].data;
						var ret = data.roleid == 2 && true;
						if(!ret) {
							R.PageTip.show('非业主角色不能分配建筑!');
						}
						return ret;
	                },
	                clazz: ["add","eqOne"]
	            }, {
	                op: {
	                    url: "{ctx.root}viewBuildingsByUser?id={datatable.selectRowKeys()[0]}",
	                    width: 840
	                },
	                name: "移除建筑",
	                id:"viewBuildingsByUser",
	                beforeOp: function(operation) {
						var data = operation.datatable.selectRows[0].data;
						var ret = data.roleid == 2 && true;
						if(!ret) {
							R.PageTip.show('非业主角色没有分配建筑!');
						}
						return ret;
	                },
	                clazz: ["add","eqOne"]
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
					name:"{event.info.row.data['username']}",
					title: '详情',
					width: 520
				}
			}
		}
	});
	userFrame.render();
	userFrame.load();
</script>
</html>