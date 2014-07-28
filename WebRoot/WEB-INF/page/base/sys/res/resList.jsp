<%@include file="/common/common.jsp" %>
<html>
<head>

<style>
.res-show-form { margin-left: 20px; }
.res-show-form label {
	float: left;
	width: 140px;
	text-align: right;
	line-height: 30px;
	color: #fff;
}
.res-show-form input[type="text"] {
	float: left;
	display: block;
	background-color: #5787b0;
	border: 1px solid #7db3e0;
	color: #fff;
	width: 360px;
}
.res-show-form .light-confirm {
	padding-left: 140px;
}
</style>
<css:vendor url="ztree/zTreeStyle/zTreeStyle.css" />
<js:vendor url="ztree/jquery.ztree.all-3.5.min.js" />
</head>
<body>
<div class="p20 clearfix">
	<div class="left sub-panel">
		<div class="sub-panel-head">资源菜单</div>
		<div class="sub-panel-content">
			<div id="res-tree" class="ztree">
			</div>
		</div>
	</div>
	<div class="left ml20">
		<form name="resForm" method="post"   action="${ctx}/base/sys/res/ajax/save" class="res-show-form rkAjaxForm"  id="resSaveForm" >
		   <input type="hidden" id="p_id" name="parentname"  />
		   <input type="hidden" id="c_id" name="id"  />
			<div class="clearfix">
				<label for="parent">上一级菜单：</label>
				<input type="text" id="p_node_id"  readonly />
			</div>
			<div class="mt10 clearfix">
				<label for="res-name"><span class="require">*</span>名称：</label>
				<input type="text" id="node_id"  name="subname"/>
			</div>
			<div class="mt10 clearfix">
				<label for="res-addr"><span class="require">*</span>地址：</label>
				<input type="text" id="url_id" name="url"/>
			</div>
			<div class="mt10 light-confirm">
				<input type="submit" class="button-ok" value="确定" />
			</div>
		</form>
	</div>
</div>
<script>
var treeObj;
var setting = {
		view: {
			addHoverDom: addHoverDom,
			removeHoverDom: removeHoverDom,
			selectedMulti: false
		},
		edit: {
			enable: true,
			editNameSelectAll: true,
			showRemoveBtn: true,
			showRenameBtn: false,
			removeTitle: "删除菜单",
			drag: {
				isMove:true,
				prev:false,
				next:true,
				inner:false
			}
		},
		async: {
			enable: true,
			url:"${ctx}/base/sys/res/ajax/getData",
			autoParam:["id", "name","url"]
		},
		callback: {
			beforeClick: beforeClick,
			onRemove:onRemove,
			onDrop: zTreeOnDrop,
			onAsyncSuccess: onAsyncSuccess
		}
	};
	
    //加载数据完成之后操作
    function onAsyncSuccess(treeId, treeNode){
    	nodeDefault();
    }
    
    //调整菜单的顺序
    function zTreeOnDrop(event, treeId, treeNodes, targetNode, moveType, isCopy){
    	var target_id = targetNode.id;
    	var curr_id = treeNodes[0].id;
    	var url = "${ctx}/base/sys/res/ajax/updateLevel?targetId="+target_id+"&"+"currId="+curr_id;
 	   $.get(url, function(data){
 		   if(data.resultCode=='00'){
 			   R.PageTip.show('调整资源菜单顺序成功!');
 		   }else{
 			   R.PageTip.show('调整资源菜单顺失败!');
 		   }
 	   });
    }
    
    var newCount = 1;
	function addHoverDom(treeId, treeNode) {
		if(treeNode.level<3){
			var sObj = $("#" + treeNode.tId + "_span");
			if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
			var addStr = "<span class='button add' id='addBtn_" + treeNode.tId+ "' title='添加菜单' onfocus='this.blur();'></span>";
			sObj.after(addStr);
			var btn = $("#addBtn_"+treeNode.tId);
			if (btn) btn.bind("click", function(){
				var zTree = $.fn.zTree.getZTreeObj("res-tree");
				zTree.addNodes(treeNode, {id:"", pId:treeNode.id, name:"new node" + (newCount++)});
				return false;
			});
		}
	};
	
	function removeHoverDom(treeId, treeNode) {
		$("#addBtn_"+treeNode.tId).unbind().remove();
	};
	
	function beforeClick(treeId, treeNode) {
		if (treeNode.level<2) {
			return false;
		} else {
			var p_node = treeNode.getParentNode();
			nodeInfoShow(p_node,treeNode);
			return true;
		}
	}
	
	
	//删除节点
	function onRemove(e,treeId, treeNode) {
		 $.ajax({ 
  	       type:"get",
  	       dataType:"json",
  	       url: "${ctx}/base/sys/res/ajax/delete?id="+treeNode.id
	      });
		 nodeDefault();
	}
	
	//展示节点的数据	
	function nodeInfoShow(p_node,treeNode){
		$("#node_id").val('');
		$("#url_id").val('');
		$("#c_id").val('');
		
		$("#p_id").val(p_node.id);
		$("#p_node_id").val(p_node.name);
		$("#c_id").val(treeNode.id);
		$("#node_id").val(treeNode.name);
		$("#url_id").val(treeNode.url);
	}
	
	//默认展示节点的数据
	function nodeDefault(){
		var nodes = treeObj.getNodes();
    	$("#p_id").val(nodes[0].id);
    	$("#p_node_id").val(nodes[0].name);
		$("#c_id").val("");
    	$("#node_id").val("");
		$("#url_id").val("");
	}
	
	$(document).ready(function(){
		treeObj = $.fn.zTree.init($("#res-tree"), setting);
	});

    //校验
	$("#resSaveForm").validate({
		rules : {
			subname:{
				required : true,
				validateNoSpace : true,
				rangelength : [1, 20]
			},
			url:{
				required : true,
				validateNoSpace : true
			}
		}
	});
    
    $('#resSaveForm').data('callbackFun', function() {
    	treeObj = $.fn.zTree.init($("#res-tree"), setting);
    });
	</script>
</body>
</html>