<%@ page import="com.rockontrol.hera.common.GlobalConfig,com.rockontrol.hera.web.util.ResourceFunctions" contentType="text/html;charset=UTF-8" %>
<%@ include file="taglib.jsp"%>
<c:set var="ctx" value="<%=ResourceFunctions.getCtx()%>"/>
<%
	if(request.getAttribute("merge") == null) {
    String mergeMode = GlobalConfig.getProperties().getString("file.mergeMode");
    String compMode = GlobalConfig.getProperties().getString("file.compMode");
    request.setAttribute("merge", "Y".equals(mergeMode) ? true : false);
    request.setAttribute("comp", "Y".equals(compMode) ? true : false);
    request.setAttribute("cssRoot", ResourceFunctions.getCssRoot());
    request.setAttribute("jsRoot", ResourceFunctions.getJsRoot());
    request.setAttribute("vendorRoot", ResourceFunctions.getVendorRoot());
}
%>