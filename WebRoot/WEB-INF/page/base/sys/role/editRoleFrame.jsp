<%@ include file="/common/common.jsp"%>
<div class="dialogform rkdialog" style="width:100%;">
	<form:form modelAttribute="roleInfoForm"
		action="${ctx}/base/sys/role/ajax/save" method="post"
        id="roleSaveForm" class="rkAjaxForm">
        		<form:hidden path="id"/>
        		<table>
                <tr>
                    <th><span class="require">*</span>编码：</th>
                    <td>
                    		<form:input path="code"  disabled="${roleInfoForm.isDetail}"/>
                    	</td>
                </tr>
                <tr>
                    <th class="w30"><span class="require">*</span>名称：</th>
                    <td class="w70">
                    		<form:input path="name" disabled="${roleInfoForm.isDetail}" />
                    </td>
                </tr>
            </table>
            <div class="dialog-button-box">
            	  <c:if test="${!roleInfoForm.isDetail}">
              <input type="submit" class="ok" value="确定"/>
              <input type="button" class="cancel" value="取消"/>
              </c:if>
            </div>
	</form:form>
</div>
<script type="text/javascript">
$("#roleSaveForm").validate({
    rules : {
        name : {
            required : true,
            validateNoSpace : true,
            rangelength : [1, 20],
            remote: {
            		url: '${ctx}/base/sys/role/ajax/checkName',
            		data: {
            			id: function() { return $('#id').val(); },
            			name: function() { return $('#name').val(); }
            		}
            }
        },
        code : {
            required : true,
            validateNoSpace : true,
            noCn: true,
            rangelength : [1, 20],
            remote: {
	        		url: '${ctx}/base/sys/role/ajax/checkCode',
	        		data: {
	        			id: function() { return $('#id').val(); },
	        			code: function() { return $('#code').val(); }
	        		}
	        }
        }
    },
    messages:{
		name:{
			required: "角色名称不能为空",
			remote: jQuery.validator.format("{0} 该角色已存在")
		},
		code: {
			required: '编码不能为空',
			remote: jQuery.validator.format("{0} 该编码已存在")
		}
	}
});
</script>