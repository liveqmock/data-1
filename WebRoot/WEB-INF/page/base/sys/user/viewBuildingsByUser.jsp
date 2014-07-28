<%@include file="/common/common.jsp" %>
<html>
<head>
<style type="text/css">
     .rkdt table { table-layout: fixed; }
     .rkdt table tr th:first-child { width: 5%; }
     .rkdt table tr td { word-break: break-all; }
     #gridContainer .rkfs .white { color: #000; }
	#viewBuilding .rkfs {
		width: 300px;
		float: left;
		padding: 10px 0;
		margin: 0 0 0 10px;
	}
	#viewBuilding .toolbar {
		width: 100px;
		padding: 10px 0;
		float: left;
		background: none;
	}
	#viewBuilding .toolbar li {
		background: none;
	}
	#viewBuilding .toolbar li a {
		margin-top: 0;
	}
	#viewBuilding .rkfs td {
		padding: 0;
	}
</style>
</head>
<div class="dialog-table" id="viewBuilding">

<input type="hidden" value="${userid}" id="userid" name="userid"/>
<div id="gridContainer" ></div>
	</div>
<script type="text/javascript">
/**创建全局上下文*/
$.extend(R.ctx, {root : "${ctx}/base/sys/user/ajax/"});
$(function(){
	var gridFrame = new R.DataFrame({
		/**frame位置 为jQuery选择器*/
		containerId: "#gridContainer",
		/**数据表格配置*/
		datatable: {
			/**数据表格的唯一标识*/
			id: "user",
			/**数据表格选项卡的名称*/
			name: "用户管理",
			/**数据加载的地址 自动添加页码和每页大小*/
			loadUrl: "{ctx.root}getBuildingUserList?userid="+$("#userid").val(),
			columns: [
				{id:"id", type:"rowCheck"},//选择列
				{id:"userName", name:"业主名称"},
	            {id:"buildingName", name:"建筑名称"},
	            {id:"regionName",name:"行政区域"}
	            
			],
	        queryer: {
	        	fields: [[{id:"buildingName", name:"建筑名称"}]]
	        },	          
			/**工具栏配置*/
	
			toolbar: { menus: [
	            {
	            	op: function(conf) { 
	            		var params = conf.datatable.selectRowKeyParams('ids');
	            		$.ajax({
	            			url:  "${ctx}/base/sys/user/ajax/deleteBuildingUser?" + params,
	            			dataType: 'json',
	            			success: function(result) {
	            				R.PageTip.show('删除成功！');
	            				conf.datatable.load();
	            			}
	            		});
	            	}, 
	            	/**
	            	name: "删除",
	            	clazz: ["setting", "minOne"],
	            	iconClass:"email"
	            	*/
	            	name: "删除",
	            	showId: 'addToGroupBtn',
	            	clazz: ["delBtn", "minOne"]
	            	/**
		            	op: { 
		            		url: "{ctx.root}deleteBuildingGroup?{datatable.selectRowKeyParams('ids')}", 
		            		opType: "ajaxGet" 
		            	},*/ 
		        }
	        ]}
		}
	});
	gridFrame.render();
	gridFrame.load();
})
</script>