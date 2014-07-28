<%@ include file="/common/common.jsp"%>
<css:vendor url="ztree/zTreeStyle/zTreeStyle.css" />
<js:vendor url="ztree/jquery.ztree.all-3.5.min.js" />
<div class="dialogform rkdialog relative" style="width:100%;">
	<form:form modelAttribute="warningForm" action="${ctx}/base/sys/warning/ajax/save" method="post" id="warningForm" class="rkAjaxForm">
		  <form:hidden path="id"/>
			<table>
			   <tr>
                    <th><span class="require">*</span>能耗类型：</th>
                    <td>
                     <form:hidden path="etypeid"/>
                     <input type="text" id="region_id" name="region_id" readonly="true" style="cursor:pointer;background:#fff;"  onclick="showMenu();"  />
					</td>
                </tr>
                
                <tr>
                    <th class="w30"><span class="require">*</span>告警级别：</th>
                    <td class="w70">
                    	<form:select path="level">
                    	    <form:option value="" label="--请选择--"/>
							<form:option value="0" label="预警"/>
							<form:option value="1" label="告警"/>
						</form:select>
                    </td>
                </tr>
                
			    <tr>
                    <th class="w30"><span class="require">*</span>阀值(%)：</th>
                    <td class="w70"><form:input path="thresholdval"/></td>
                </tr>
                
            
            </table>
            <div class="dialog-button-box">
              <input type="submit" class="ok" value="确定"/>
              <input type="button" class="cancel" value="取消"/>
            </div>
	</form:form>
	</div>
	
<script type="text/javascript">
	$("#warningForm").validate({
		rules : {
			region_id:{
				required : true
			},thresholdval:{
				required : true,
				ptInteger : true,
				rangelength : [1, 3]
			},level:{
				required : true,
				remote: {
	        		url: '${ctx}/base/sys/warning/ajax/isExist',
	        		data: {
	        			id: function() { return $('#id').val(); },
	        			region_id: function() { return $('#etypeid').val(); },
	        			thresholdval: function() { return $('#level').val(); }
	        		}
	            }
			}
		},
		messages:{
			loginname:{
				required: "登陆名称不能为空",
				remote:jQuery.validator.format("{0} 用户已存在")
			},
		     	level:{
				remote:jQuery.validator.format("已设置过")
			}
		}});

	var setting = {
			view: {
				selectedMulti: false
			},
			async: {
				enable: true,
				url:"${ctx}/base/dict/ajax/tree?type=ecds",
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
		$("#etypeid").attr("value",id);
		$("#region_id").attr("value",v);
		hideMenu() ;
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
</script>