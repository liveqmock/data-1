<%@ include file="/common/common.jsp"%>
<div class="dialogform rkdialog" style="width:100%;">
	<form:form modelAttribute="userForm" action="${ctx}/base/sys/user/ajax/save" method="post" id="userSaveForm" class="rkAjaxForm">
			<table>
			    <tr>
                    <th class="w30"><span class="require">*</span>用户名：</th>
                    <td class="w70"><form:input path="username"  readonly="true"/></td>
                </tr>
                <tr>
                    <th class="w30"><span class="require">*</span>登陆账号：</th>
                    <td class="w70"><form:input path="loginname" readonly="true"/></td>
                </tr>
                 <tr>
                    <th><span class="require">*</span>区域：</th>
                    <td>
	                    <form:input path="regionid" readonly="true"/>
					</td>
                </tr>
                <tr>
                    <th><span class="require">*</span>角色：</th>
                    <td>
                         <form:select path="roleid" readonly="true">
							<form:option value="" label="--请选择用户的角色--"/>
							<form:options items="${roleList}" itemValue="id" itemLabel="name"/>
						</form:select>
                    </td>
                </tr>
                <tr>
                    <th>电话：</th>
                    <td><form:input path="contact" readonly="true"/></td>
                </tr>   
                 <tr>
                    <th>邮件：</th>
                    <td><form:input path="mail" readonly="true"/></td>
                </tr>   
            </table>
            
            <div class="dialog-button-box">
            </div>
	</form:form>
	</div>
	<script type="text/javascript">
	$("#userSaveForm").validate({
		rules : {
			contact:{
				required : false,
				validateMobile : true
			},
		    loginname:{
				required : true,
				validateNoSpace : true,
				rangelength : [1, 20]
			}
		},
		messages:{
			loginName:{
				remote:jQuery.validator.format("{0} 用户已存在")
			},
			    regionid:{
				remote:jQuery.validator.format("{0} 区域编码不存在")
			}
		}});
	</script>