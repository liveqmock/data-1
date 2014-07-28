<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js">
<!--<![endif]-->
<html>
<%@ include file="common/decommon.jsp"%>
<%@ include file="common/doctype.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-store, must-revalidate">
<meta http-equiv="Expires" content="0">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
<title>建筑能耗监测平台</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width">

<%@ include file="common/head.jsp"%>
<%@ include file="/common/baseCss.jsp"%>
<css:vendor url="jquery-multiselect/jquery.multiselect.css" />
<css:common url="rockjs.css" root="${ctx}/static/js/rockjs" />
<css:common url="app/common.css" />
<css:common url="app/norm.css" />
<%@ include file="/common/baseJs.jsp"%>
<js:vendor url="jstree/jquery.jstree.js" />
<js:vendor name="jquery-form" />
<js:vendor name="jquery-validation" />
<js:vendor url="FusionCharts/FusionCharts.js" />
<js:vendor url="FusionCharts/FusionCharts.jqueryplugin.js" />
<js:vendor name="jquery-multiselect" />
<js:vendor url="Highcharts-3.0.2/js/highcharts.js" />
<js:common url="flashcheck.js" />
<js:common name="rockjs" />
<js:common url="app/common.js" />
<js:common url="app/tab.js" />
<js:common url="app/totalInfo.js" />

<!--[if lt IE 9]>
<script src="vendor/plugin/html5.js"></script>
<![endif]-->
</head>
<body>
	<!--[if lt IE 7]>
<p class="chromeframe">您正在使用 <strong>陈旧</strong> 的浏览器。 请 <a href="http://browsehappy.com/">升级您的浏览器</a> 或 <a href="http://www.google.com/chromeframe/?redirect=true">使用Google浏览器内嵌框架</a> 以获得更优秀的体验。</p>
<![endif]-->
	<%@ include file="common/ietip.jsp"%>
	<div class="head">
		<div class="logo"></div>
		<div class="head-info">
			<div class="head-info-arrow"></div>
			<div class="clearfix">
				<div class="left head-star">${currentUserInfo.username }(${currentUserInfo.regionName })</div>
				<div class="left ml20 clearfix">
					<a href="javascript:{}" id="set-user" class="block left">设置密码</a> <span class="block left p05">|</span>
					<a href="#" class="block left">帮助</a> <span class="block left p05">|</span>
					<a href="${ctx}/auth/logout" class="block left">退出</a>
				</div>
			</div>
		</div>
		<div class="head-menu clearfix" id="mainMenu">
			<c:forEach items="${meunStatus.module.menuList}" var="menu"
				varStatus="status">
				<c:choose>
					<c:when test="${menu.index == 100}"></c:when>
					<c:when test="${status.index == meunStatus.mainMenuIndex && (status.index == 7 || menu.name == \"数据字典\")}">
					<a href="${ctx}/${menu.url}" class="menu-sel menu-last">${menu.name}</a>
					</c:when>
					<c:when test="${status.index == meunStatus.mainMenuIndex}">
					<a href="${ctx}/${menu.url}" class="menu-sel">${menu.name}</a>
					</c:when>
					<c:when test="${status.index == 7 || menu.name == \"数据字典\"}">
					<a href="${ctx}/${menu.url}" class="menu-last">${menu.name}</a>
					</c:when>
					<c:otherwise>
					<a href="${ctx}/${menu.url}">${menu.name}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
	</div>
	<div class="middle">
		<div class="layout <c:if test="${fn:length(meunStatus.mainMenu.subMenuList) == 0}">layout-one-content</c:if>">
			<div class="main">
				<div class="main-wrap" id="main-wrap">
					<div class="panel">
						<div class="panel-head">表格</div>
						<div class="panel-content">
							<div id="content">
							</div>
						</div>
					</div>
				</div>
			</div>
			<c:if test="${fn:length(meunStatus.mainMenu.subMenuList) > 0}">
			<div class="sub">
				<div class="sub-wrap">
					<div class="panel">
						<div class="panel-head">菜单</div>
						<div class="panel-content content-load">
							<div class="tree-box" id="subMenu">
	                           <ul>
									<c:if test="${fn:length(meunStatus.mainMenu.subMenuList)>0}">
									<li>
										<a disabled="true">${meunStatus.mainMenu.name}</a>
										<ul>
											<c:forEach items="${meunStatus.mainMenu.subMenuList}"
												var="menu" varStatus="status">
											<li><a class="tree-link" shref="${ctx}/${menu.url}">${menu.name}</a></li>
											</c:forEach>
										</ul>
									</li>
									</c:if>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
			</c:if>
		</div>
	</div>
	<div class="foot">Copyright © 2004-2012 RocKontrol Corporation. All rights reserv</div>
</body>
<script>
$(function() {
    Common.initLeft();
    $('#set-user').click(function(){
    	var op = {
    		url: '${ctx}/base/sys/common/user/ajax/setUpFrame',
    		name: "设置密码",
   			title: "设置密码",
   			width: 520,
   			higth:450
    	};
    	var operation = R.opFactory.create(op);
    	operation.exec()
    })
});
</script>
</html>