<%@ include file="/common/common.jsp"%>
<css:vendor url="ztree/zTreeStyle/zTreeStyle.css" />
<js:vendor url="ztree/jquery.ztree.all-3.5.min.js" />
<div class="dialogform rkdialog relative" style="width:100%;">
	<form:form modelAttribute="userForm" action="${ctx}/base/sys/common/user/ajax/save" method="post" id="userSaveForm" class="rkAjaxForm">
		<form:hidden path="id" />
		<form:hidden path="regionid"/>
		<form:hidden path="roleid"/>
			<table>
			    <tr>
                    <th class="w30"><span class="require">*</span>用户名：</th>
                    <td class="w70"><form:input path="username"  /></td>
                </tr>
                <tr>
                    <th class="w30"><span class="require">*</span>登陆账号：</th>
                    <td class="w70"><form:input path="loginname" readonly="true"/></td>
                </tr>
                <tr>
                    <th class="w30"><span class="require">*</span>当前密码：</th>
                    <td class="w70"><input type="password" id="currentPassword" name="currentPassword"/></td>
                </tr>
                <tr>
                    <th class="w30"><span class="require">*</span>新密码：</th>
                    <td class="w70"><form:password path="password"/></td>
                </tr>
                <tr>
                    <th class="w30"><span class="require">*</span>确认新密码：</th>
                    <td class="w70"><form:password path="confirmPassword"/></td>
                </tr>
                 <tr>
                    <th><span class="require">*</span>区域：</th>
                    <td>
	                 	<input type="text" value="${regionName}" readonly="true"/>
					</td>
                </tr>
                <tr>
                    <th><span class="require">*</span>角色：</th>
                    <td>
                        <input type="text" value="${roleInfo.name }" readonly="true"/>
                    </td>
                </tr>
                <tr>
                    <th>电话：</th>
                    <td><form:input path="contact"/></td>
                </tr>   
                 <tr>
                    <th>邮件：</th>
                    <td><form:input path="mail"/></td>
                </tr>   
            </table>
            <div class="dialog-button-box">
              <input type="submit" class="ok" value="确定"/>
              <input type="button" class="cancel" value="取消"/>
            </div>
	</form:form>
	</div>
<script type="text/javascript">
$("#userSaveForm").validate({
	rules : {
		username:{
			required : true,
			validateNoSpace : true
		},
		currentPassword:{
			required:true,
			rangelength:[6,20],
			validateNoSpace : true,
			remote: {
				url:'${ctx}/base/sys/common/user/ajax/check',
				type:'post',
				dataType:'json',
				data:{
					id:function(){return $("#id").val();},
					currentPassword:function(){ return $("#currentPassword").val();}	
					}
			}
		},
		password:{
			required:true,
			rangelength:[6,20]
		},
		confirmPassword:{
			required:true,
			rangelength:[6,20],
			equalTo:"#password"
		},
		region_id:{
			required : true
		},contact:{
			required : false,
			validateMobile : true
		},mail:{
			required : false,
			rangelength : [0, 50],
			email:true
		}
	},
	messages:{
		loginname:{
			required: "登陆名称不能为空",
			remote:jQuery.validator.format("{0} 用户已存在")
		},
		currentPassword:{
			remote:jQuery.validator.format("所提供的密码不正确")
		},
		regionid:{
			remote:jQuery.validator.format("{0} 区域编码不存在")
		}
	}});

</script>