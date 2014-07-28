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
<js:vendor name="jquery-form" />
<js:vendor name="jquery-validation" />
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
<css:common url="app/govHome.css" />
</head>
<body>
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
					<c:when
						test="${status.index == meunStatus.mainMenuIndex && (status.index == 6)}">
						<a href="${ctx}/${menu.url}" class="menu-sel menu-last">${menu.name}</a>
					</c:when>
					<c:when test="${status.index == meunStatus.mainMenuIndex}">
						<a href="${ctx}/${menu.url}" class="menu-sel">${menu.name}</a>
					</c:when>
					<c:when test="${status.index == 6}">
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
		<div class="clearfix gov-home">
			<div class="w40 left">
				<div class="gov-chart-box">
					<div class="gov-chart-box-inner">
						<div class="gov-panel-head">
							<div class="gov-panel-arrow"></div>
							<div class="gov-panel-title gov-qushi">${regionName}${year}年能耗趋势</div>
						</div>
						<div class="gov-chart" id="qushi-chart"></div>
					</div>
				</div>
				<div class="gov-chart-box">
					<div class="gov-chart-box-inner">
						<div class="gov-panel-head">
							<div class="gov-panel-arrow"></div>
							<div class="gov-panel-title gov-zhibiao">${regionName}${year}年能耗指标</div>
						</div>
						<div class="gov-chart" id="zhibiao-chart"></div>
					</div>
				</div>
			</div>
			<div class="w60 left">
				<div class="gov-right">
					<div class="gov-info clearfix">
						<div class="gov-info-total left">
							<div class="gov-info-num"><fmt:formatNumber value="${totalEn}" pattern="#,##0"/></div>
							<div class="gov-info-num"><fmt:formatNumber value="${saveEn}" pattern="#,##0"/></div>
						</div>
						<div class="gov-info-text">
							${regionName}总能耗是指截止${year}年${month}月${day}日之前各下属市级单位总共产生的能耗，共统计辖区大厦共<fmt:formatNumber value="${buildingCount}" pattern="#,###"/>座。
						</div>
					</div>
					<div class="gov-building-box clearfix">
						<div class="w50 left">
							<div class="gov-building-left">
								<div class="gov-panel">
									<div class="gov-panel-head">
										<div class="gov-panel-arrow"></div>
										<div class="gov-panel-title gov-biaogan">${regionName}标杆建筑</div>
									</div>
									<div class="gov-panel-content">
										<c:forEach items="${bgList}" var="bg" varStatus="status"> 
										<div class="standard-item">
											<div class="standard-info clearfix">
												<div class="standard-name">${bg.name}</div>
												<div class="standard-energy">
													<fmt:formatNumber value="${bg.avgval}" pattern="#,##0.00"/> kW.h
												</div> 
											</div>
											<div class="stadnard-progress">
												<div class="progress-gray">
													<em class="l"></em><em class="r"></em>
												</div>
												<div class="progress-blue" style="width:${(bg.avgval / bgMax) * 100}%;">
													<em class="l"></em><em class="m"></em><em class="r"></em>
												</div>
											</div>
										</div>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
						<div class="w50 right">
							<div class="gov-building-right">
								<div class="gov-panel">
									<div class="gov-panel-head">
										<div class="gov-panel-arrow"></div>
										<div class="gov-panel-title gov-zhongdian">${regionName}重点能耗建筑</div>
									</div>
									<div class="gov-panel-content">
										<div class="key-box">
											<c:forEach items="${zdList}" var="zd" varStatus="status"> 
											<div class="key-item clearfix">
											<c:choose>
												<c:when test="${status.index < 2}">
												<div class="key-num key-num-red">${status.index + 1}</div>
												</c:when>
												<c:otherwise>
												<div class="key-num ">${status.index + 1}</div>
												</c:otherwise>
											</c:choose>
												<div class="key-name">${zd.name}</div>
												<div class="key-energy">
													<fmt:formatNumber value="${zd.avgval}" pattern="#,##0.00"/> kW.h
												</div>
											</div>
											</c:forEach>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="foot">Copyright © 2004-2012 RocKontrol Corporation.
		All rights reserv</div>
</body>
<script>
var showTip = function(valObj, x, y) {
    var month = valObj['month'];
    var value = valObj['value'];
    $('body').append($('<div style="width:100px;height:30px;background:#ffffff;">' + month + '</div>').position({
        top: 0, left: 0
    }));
};

var Chart = (function() {
	var enList = [];
	var loaded = false;
	var qushiChartConf = {};
	var zhibiaoChartConf = {};
	var indicator = 0;
	var _getChartConf = function(dataObj) {
		var chartConf =  {
		    chart: {
		        type: 'area',
		        backgroundColor: 'none',
		        marginTop: 20,
		        marginRight: 20
		    },
		    subtitle: { text: null },
		    title: { text: null },
		    xAxis: {
		        lineWidth: 2,
		        lineColor: '#6aade0',
		        categories: dataObj.categories,
		        labels: {
		            style: { color: '#ffffff', fontWeight: 'normal' }
		        }
		    },
		    yAxis: {
		        lineWidth: 2,
		        lineColor: '#6aade0',
		        title: {
		            align: 'high',
		            //offset: 0,
		            text: '<b>kW.h</b>',
		            rotation: 1,
		            y: -6,
		            x: 22,
		            style: {
		                color: '#ffffff'
		            }
		        },
		        tickPixelInterval: 40,
		        labels: {
		            enabled: true,
		            formatter: function() {
		                return this.value;
		            },
		            style: {color: '#ffffff', fontWeight: 'normal'}
		        }
		    },
		    tooltip: {
		        shared: false,
		        useHTML: true,
		        borderWidth: 0,
		        backgroundColor: 'none',
		        shadow: false,
		        headerFormat: '<div class="area-tip-box"><div class="pt10">{point.key}</div>',
		        pointFormat: '<div class="f16 mt5 lh20 fb">{point.y}</div>',
		        footerFormat: '<div>kW.h</div></div>'
		    },
		    plotOptions: {
		        area: {
		            pointStart: 0,
		            marker: {
		                enabled: true,
		                fillColor: '#000000',
		                symbol: 'circle',
		                radius: 5,
		                states: {
		                    hover: { enabled: true }
		                }
		            }
		        },
		        series: {
		            cursor: 'pointer',
		            point: {
		                events: {
		                    mouseOver: function() {
		                        showTip('1yue', this.plotX, this.plotY);
		                    },
		                    mouseOut: function() {}
		                }
		            }
		        }
		    },
		    series: [{
		        name: 2013,
		        color: '#a7cc57',
		        lineColor: '#f0fb7a',
		        lineWidth: 4,
		        animation: { duration: 2000 },
		        marker: {
		            fillColor: '#dddddd',
		            lineWidth: 2,
		            lineColor: '#dddd44' // inherit from series
		        },
		        data: dataObj.datas
		    }],
		    credits: { enabled: false },
		    legend: { enabled: false }
		};
		return chartConf;
	};

	var _formEnData = function(enList, type) {
		var mainObj = {};
		var categories = [];
		var datas = [];
		for(var i = 0; i < enList.length; i++) {
			var obj = enList[i];
			categories.push(obj['date'].substring(5, 7) + '月');
			var val = type == 'qushi' ? 
					parseFloat(Common.toFix(obj.val, 0)) :
					parseFloat(Common.toFix(obj.avgval));
			if(i != enList.length - 1) {
				datas.push(val);
			} else {
				datas.push({
		            dataLabels: {
		                align: 'left',
		                crop: false,
		                color: '#eeee00',
		                style: {
		                    fontWeight: 'normal'
		                },
		                x: 4,
		                verticalAlign: 'middle',
		                enabled: true,
		                format: "${year}"
		            },
		            y: val
		        });
			}
		}
		mainObj.categories = categories;
		mainObj.datas = datas;
		return mainObj;
	};

	var _show = function(chartHeight, enList) {
		var qushiDataObj = _formEnData(enList, 'qushi');
		var zhibiaoDataObj = _formEnData(enList, 'zhibiao');
		qushiChartConf = _getChartConf(qushiDataObj);
		zhibiaoChartConf = _getChartConf(zhibiaoDataObj);
		
		qushiChartConf.chart.height = chartHeight;
		zhibiaoChartConf.chart.height = chartHeight;
		
		$('#qushi-chart').highcharts(qushiChartConf);
		$('#zhibiao-chart').highcharts(zhibiaoChartConf);
		
		var zhibiaoChart = $('#zhibiao-chart').highcharts();
		zhibiaoChart.yAxis[0].addPlotLine({
	        value: indicator,
	        color: '#ffb000',
	        width: 2,
	        zIndex: 10,
	        label: {
	        		text: '能耗指标',
	        		align: 'right',
	        		style: {
	        			color: '#eeee00'
	        		}
	        },
	        id: 'plot-line'
	    });
	};
	
	var loadAndShow = function(chartHeight) {
		if(!loaded) {
			$.ajax({
				url: "${ctx}/gov/audit/region/${regionId}/regionEnAnalysis",
				dataType: 'json',
				data: {
					dateType: 'byYear',
					year: ${year}
				},
				success: function(result) {
					loaded = true;
					enList = result.data;
					indicator = result.count;
					_show(chartHeight, enList);
				}
			});
		} else {
			_show(chartHeight, enList);
		}
	};
	return {
		loadAndShow: loadAndShow
	}
}).call(this);

var PageResize = function() {
	var mainHeight = $('.middle').height();
	var chartBoxHeight = (mainHeight - 60) / 2;
	var chartHeight = chartBoxHeight - 40;
	$('.gov-chart').height(chartHeight > 150 ? chartHeight : 150);
	Chart.loadAndShow(chartHeight);
	
	var contentHeight  = mainHeight - 170;
	$('.gov-panel-content').height(contentHeight > 300 ? contentHeight : 300);
};

$(function() {
	PageResize();
	$(window).resize(PageResize);
});

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

</script>
</html>