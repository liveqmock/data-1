<%@ include file="/common/common.jsp"%>
<css:vendor url="ztree/zTreeStyle/zTreeStyle.css" />
<js:vendor url="ztree/jquery.ztree.all-3.5.min.js" />
<div class="dialogform rkdialog relative" style="width:100%;">
	<form:form modelAttribute="priceFrom" action="${ctx}/base/sys/price/ajax/save" method="post" id="priceFrom" class="rkAjaxForm">
		<form:hidden path="id"/>
		<table>
			<tr>
            	<th class="w30"><span class="require">*</span>能耗：</th>
                <td>
                	<form:select path="ectypeid">
						<form:options items="${ecdsList}" itemValue="code" itemLabel="name"/>
					</form:select>
                </td>
            </tr>
            <tr>
            	<th><span class="require">*</span>区域：</th>
               	<td>
                	<form:hidden path="regionid" />
                	<input type="text" id="region_id" name="region_id" value="${regionName}" readonly="true" style="cursor:pointer;background:#fff;"  onclick="showMenu();"  />
				</td>
            </tr>
            <tr>
            	<th>建筑：</th>
                <td class="w70">
                	<form:select path="buildingid">
                   		<form:options items="${buildingList}" itemValue="buildingid" itemLabel="name"/>
                   	</form:select>
                </td>
            </tr>
            <tr>
            	<th><span class="require">*</span>阶梯：</th>
                <td><form:input path="threshold"/></td>
            </tr>   
            <tr>
            	<th><span class="require">*</span>价格：</th>
                <td><form:input path="unitprice"/></td>
            </tr>   
        </table>
        <div class="dialog-button-box">
        	<input type="submit" class="ok" value="确定"/>
            <input type="button" class="cancel" value="取消"/>
        </div>
	</form:form>
</div>
	
<script type="text/javascript">
	$("#priceFrom").validate({
		//onfocusout:false,
		rules : {
			ectypeid:{
				required : true,
			},
			region_id:{
				required : true
			},threshold:{
				required : true,
				digits:true,
				maxlength:6,
				remote: {
					url:'${ctx}/base/sys/price/ajax/isExist',
					data:{
						id:function(){return $("#id").val()},
						ectypeid:function(){return $("#ectypeid").val();},
						regionid:function(){return $("#regionid").val();},
						buildingid:function(){
							var val = $("#buildingid").val();
							return val == null ? "":val;},
						threshold:function(){return $("#threshold").val();}
					}
				}
			},unitprice:{
				required : true,
				number:true,
				maxlength:6,
				min:0,
				isDecimal:2,
				remote: {
					url:'${ctx}/base/sys/price/ajax/isExist',
					data:{
						id:function(){return $("#id").val()},
						ectypeid:function(){return $("#ectypeid").val();},
						regionid:function(){return $("#regionid").val();},
						buildingid:function(){
							var val = $("#buildingid").val();
							return val == null ? "":val;},
						unitprice:function(){return $("#unitprice").val();}
					}
				}
			}
		},
		messages:{
			ectypeid:{
				required: "能耗名称不能为空",
			},
			regionid:{
				remote:jQuery.validator.format("{0} 区域编码不存在")
			}
		}});
	
	$.validator.addMethod("isDecimal",function(value, element, param){
		var  accuracy = param;
		if(isNaN(accuracy)) {
			console.error("参数错误，decimal验证的accuracy只能为数字");
			return false;
		}
		
		if(typeof(accuracy) == undefined || accuracy == 0) {
			var regX = /^\d+$/;
		} else {
			var regxStr = "^\\d+(\\.\\d{1,"+accuracy+"})?$";
			var regX = new RegExp(regxStr);
		}
		return this.optional(element) || (regX.test(value));
	},$.validator.format("最多只保留小数点后{0}的数值"));

	var setting = {
			view: {
				selectedMulti: false
			},
			async: {
				enable: true,
				url:"${ctx}/base/dict/ajax/tree?type=region",
				autoParam:["id", "name"]
			},
			callback: {
				beforeClick: beforeClick,
				onClick: onClick
			}
		};
	
	 function beforeClick(treeId, treeNode) {
	    if(treeNode.id=='0'){
	    	return false;
	    }
		return true;
	 }
	
     function onClick(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeMenu");
		var nodes = zTree.getSelectedNodes();
		var v = "";
		var id="";
		nodes.sort(function compare(a,b){return a.id-b.id;});
		for (var i=0, l=nodes.length; i<l; i++) {
			v = nodes[i].name;
			id = nodes[i].id;
			break;
		}
		$("#regionid").attr("value",id);
		$("#region_id").attr("value",v);
		hideMenu() ;
		
		//更新建筑列表
		getBuilding(id);
	}
    
     //菜单树
	function showMenu() {
    	 if($('#treeMenu').length == 0) {
    		 $('<div id="menuContent" class="menuContent" ' + 
    				 'style="display:none; position: absolute;z-index:101; background-color:#fff;width:218px;border:1px solid #ddd;border-top:none;">' +
    			'<ul id="treeMenu" class="ztree" style="margin-top:0; width:160px; higth:100px;"></ul>' +
    		'</div>').appendTo('body');
    	 }
		$.fn.zTree.init($("#treeMenu"), setting);
		var cityObj = $("#region_id");
		var cityOffset = $("#region_id").offset();
		
		
		$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown);
	}
	
	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	
	function onBodyDown(event) {
		if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
			hideMenu();
		}
	}
	
	function getBuilding(regionid){
		$("#buildingid").empty();
		$.getJSON('${ctx}/base/sys/price/ajax/getBuildingByRegionid?regionid='+regionid,function(data){
			var liArray = [];
			var liNum = data.length;
			for(i=0; i<liNum;i++){
				var id = data[i].buildingid;
				var name = data[i].name;
				liArray.push('<option value="'+id+'">'+name+'</option>');
			}
			$("#buildingid").append(liArray.join(''));
		});
	}
</script>
