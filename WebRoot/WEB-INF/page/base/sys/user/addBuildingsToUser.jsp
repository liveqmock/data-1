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
<!-- 
<div class="dialog-table no-queryer" >
 -->
 <div class="dialog-table" id="viewBuilding">
<input type="hidden" value="${userid}" id="userid" name="userid"/>
<div id="gridContainer" ></div>
<!-- 
	<div class="dialog-button-box">
      	<input type="button" id="trigger-add-btn" class="mt5 btn btn-primary" value="分配"/>
    </div>
     -->
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
			loadUrl: "{ctx.root}getBuildingInfoList?userid="+$("#userid").val(),
			columns: [
				{id:"id", type:"rowCheck"},//选择列
				{id:"buildingid", name:"建筑编码"},
	            {id:"name", name:"建筑名称"},
	            //{id:"address", name:"地址"},
	            {id:"regionid", name:"行政区域"}
	            
			],
	        queryer: {
	        	fields: [[{id:"name", name:"建筑名称"}]]
	        },	          
			/**工具栏配置*/
	
			toolbar: { menus: [
	          {
		            	op: function(conf) { 
		            		var params = conf.datatable.selectRowKeyParams('ids');
		            		$.ajax({
		            			url:  "${ctx}/base/sys/user/ajax/addToUser?" + params + "&userid="+$("#userid").val(),
		            			dataType: 'json',
		            			success: function(result) {
		            				R.PageTip.show('分配成功！');
		            				conf.datatable.load();
		            			}
		            		});
		            	},
		            	/**
		            	name: "分配",
		            	clazz: ["delBtn", "minOne"],
		            	iconClass:"email"
		            	*/
		            	name: "分配",
		            	showId: 'addToGroupBtn',
		            	clazz: ["settingBtn", "minOne"]
		        }
	        ]}
		}
	});
	gridFrame.render();
	gridFrame.load();
	/**
	$('#trigger-add-btn').unbind('click').click(function() {
		$('#addToGroupBtn').trigger('click');
	});
	*/
});
</script>