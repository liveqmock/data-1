<%@include file="/common/common.jsp" %>
<html>
<head>
<style>
.role-res {
	width: 750px;
	margin-left: auto;
	margin-right: auto;
}
.role-res .sub-panel {
	width: 350px;
}
.res-panel-content {
	background-color: #fff;
}
.panel-head-dark .role-panel-nav,
.panel-head-dark .role-panel-content {
	line-height: 31px;
	color: #fff;
}
.panel-head-dark .role-panel-content {
	text-align: center;
}
.res-panel-content .role-panel-row {
	border-bottom: 1px solid #b4b4b4;
}
.res-panel-content .role-panel-nav,
.res-panel-content .role-panel-content {
	height: 35px;
	line-height: 35px;
}
.res-panel-content .role-panel-content {
	text-indent: 10px;
}
.role-panel-nav {
	float: left;
	width: 40px;
	border-right: 1px solid #b4b4b4;
	text-align: center;
	text-indent: 0;
}
.role-panel-content {
	float: left;
	width: 309px;
}
.role-res .res-panel-content {
	min-height: 200px;
}
.role-res .sub-panel-content {
	min-height: 180px;
	*min-height: 200px;
}
</style>
<css:vendor url="ztree/zTreeStyle/zTreeStyle.css" />
<js:vendor url="ztree/jquery.ztree.all-3.5.min.js" />
</head>
<body>
<div class="role-res mt20">
	<div class="clearfix">
		<div class="sub-panel left">
			<div class="panel-head-dark">
				<div class="clearfix role-panel-row">
					<div class="role-panel-nav">选择</div>
					<div class="role-panel-content">角色</div>
				</div>
			</div>
			<div class="res-panel-content">
			   <c:forEach var="role" items="${roleList}" varStatus="status">
				   	<div class="clearfix role-panel-row">
						<div class="role-panel-nav">
							<input type="radio" name="id" value="${role.id}" onclick="onclick_role(this);" />
						</div>
						<div class="role-panel-content">
							${role.name }
						</div>
					</div>
			   </c:forEach>
			</div>
		</div>
		<div class="sub-panel right">
			<div class="panel-head-dark">资源菜单</div>
			<div class="sub-panel-content">
				<div id="res-tree" class="ztree">
			    </div>
			</div>
		</div>
	</div>
	<div class="mt20 light-confirm tc">
		<input type="button" class="button-ok" value="确定"  onclick="on_click();" >
	</div>
</div>
<script>
var setting = {
		check: {
			enable: true
		},
		view: {
			selectedMulti: false
		},
		async: {
			enable: true,
			url:"${ctx}/base/sys/res/ajax/getData",
			autoParam:["id", "name"]
		},
		callback: {
			beforeClick: beforeClick,
			onAsyncSuccess: onAsyncSuccess
		}
	};
	
	function beforeClick(treeId, treeNode) {
		if (treeNode.id=='0') {
			return false;
		} else {
			
			return true;
		}
	}

	//加载数据完成之后操作
	function onAsyncSuccess(treeId, treeNode){
		
	}
	
	//点击角色
	function onclick_role(obj){
		var url = "${ctx}/base/sys/auth/ajax/getData/"+obj.value;
		$.get(url, function(data){
			 var treeObj = $.fn.zTree.getZTreeObj("res-tree");
			 treeObj.checkAllNodes(false);
			 var r_nodes = treeObj.getNodes()[0].children;
			 for(var i=0;i<r_nodes.length;i++){
				 var p_nodes = r_nodes[i].children
                 
				 for(var n=0;n<p_nodes.length;n++){
					var c_nodes = p_nodes[n].children;
					 if(!p_nodes[n].isParent){
						 for(var j=0;j<data.length;j++){
							 if(data[j].resourceid==p_nodes[n].id){
								 treeObj.checkNode(p_nodes[n], true, true);
							 }
						 }
					 }
					 for(var m=0;m<c_nodes.length;m++){
						 for(var j=0;j<data.length;j++){
							 if(data[j].resourceid==c_nodes[m].id){
								 treeObj.checkNode(c_nodes[m], true, true);
							 }
						 }
					 }
				 }
			 }
		}); 
	}
	
	function on_click(){
	   var treeObj = $.fn.zTree.getZTreeObj("res-tree");
	   var role_id = $('input:radio:checked').val();
	   var rs_id = "";
	   var nodes = treeObj.getCheckedNodes();
	   for(var i=0;i<nodes.length;i++){
		   if(nodes[i].id!='0'){
			   rs_id += nodes[i].id+","
		   }
	   }
	   if(role_id==undefined){
		   R.PageTip.show('请您选择要授权的角色！');
		   return false;
	   }
      var url = "${ctx}/base/sys/auth/ajax/save?roleId="+role_id+"&"+"rsIds="+rs_id;
	   
	   $.get(url, function(data){
		   if(data.resultCode=='00'){
			   R.PageTip.show('授权配置成功!');
		   }else{
			   R.PageTip.show('授权配置失败!');
		   }
	   });
	}
    
	$(document).ready(function(){
	    $.fn.zTree.init($("#res-tree"), setting);
	});

</script>
</body>
</html>