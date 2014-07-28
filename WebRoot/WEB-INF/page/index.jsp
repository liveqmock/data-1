<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="../public/css/reset.css" type="text/css" rel="stylesheet" />
<link href="../public/css/layout.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="../public/js/jquery.min.js"></script>
<script type="text/javascript" src="../public/js/function.js"></script>
<script>
	function myscrollLesft(turn){
		var width=$('.navbar ul li').width();
		if(turn=='right'){
			if(document.getElementById('scroll').scrollWidth-document.getElementById('scroll').scrollLeft>=width){
				for(var i=0;i<=width;i++){
					document.getElementById('scroll').scrollLeft=document.getElementById('scroll').scrollLeft+1;
				}
			}
		}else{
			if(document.getElementById('scroll').scrollLeft>=width){
				for(var i=0;i<=width;i++){
					document.getElementById('scroll').scrollLeft=document.getElementById('scroll').scrollLeft-1;
				}
			}
		}
	}
</script>
</head>

<body>
<div id="minstyle">
<!--头部-->
    <div class="header">
        <div class="headin clearfix">
            <div class="left clearfix"><h2 class="logo"></h2></div>
            <div class="navbar right">
                <a href="#" class="prev" onclick="myscrollLesft('left')"></a>
                <div id="scroll" class="navcon"  style="overflow-x:hidden;width:390px;">
                    <ul style="width:600px">
                        <li><a href="#">数据共享日志</a></li>
                        <li><a href="#" class="cur">共享数据浏览</a></li>
                        <li><a href="#">接口状态</a></li>
                        <li><a href="#">基础库浏览</a></li>
                        <li><a href="#">测试001</a></li>
                        <li><a href="#">页签002</a></li>
                    </ul>
                </div>
                <a href="#" class="next" onclick="myscrollLesft('right')"></a>
            </div>
        </div>
    </div>
<!--内容区-->
    <div class="container clearfix">
        <div class="twocolumn clearfix">
            <div id="leftArea" class="leftbar left">
                <div class="treearea">
                    <img src="images/tree.png" width="147" height="486" />
                </div>
              </div>
        	<div id="rightArea" class="rightcon">
            	<div class="location"><img src="images/home.png" width="12" height="12" /><a href="#">首页 > </a> 数据共享日志</div>
                <div class="datashow">
                	<div class="searchbox">
                    	<label>申请人姓名</label><input name="" type="text" class="inputbg" />
                        <span class="timestyle">
                        	<label>开始时间</label>
                        	<input name="" type="text" class="inputbg" />
                        	<label>结束时间</label>
                       	    <input name="" type="text" class="inputbg" /></span>
                        <span class="btnbox"><input name="" type="button" class="searchbtn" value="&nbsp;查询"/></span>
                    </div>
                    <div class="h10"></div>
                    <div class="tablearea">
                    	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table01">
                              <tr>
                                <th>序号</th>
                                <th>名称</th>
                                <th>状态</th>
                                <th>数据量</th>
                                <th>共享方式</th>
                                <th>共享时间</th>
                              </tr>
                              <tr>
                                <td>1</td>
                                <td>存储房交易平台</td>
                                <td>成功</td>
                                <td>10</td>
                                <td>接口</td>
                                <td><b>2014-06-10</b></td>
                              </tr>
                              <tr>
                                <td>2</td>
                                <td>存储房交易平台</td>
                                <td>成功</td>
                                <td>10</td>
                                <td>接口</td>
                                <td><b>2014-06-10</b></td>
                              </tr>
                              <tr>
                                <td>3</td>
                                <td>存储房交易平台</td>
                                <td>成功</td>
                                <td>10</td>
                                <td>接口</td>
                                <td><b>2014-06-10</b></td>
                              </tr>
                              <tr>
                                <td>4</td>
                                <td>存储房交易平台</td>
                                <td>成功</td>
                                <td>10</td>
                                <td>接口</td>
                                <td><b>2014-06-10</b></td>
                              </tr>
                        </table>
                        <div class="tabs_foot clearfix pagebg">
                            <span class="page pageR">共 <span class="page_orange">24</span> 页/ <span class="page_green" >240</span> 条记录&nbsp;&nbsp;<a href="#"><img src="images/p_1.png"/></a><a href="#"><img src="images/p_2.png" /></a>&nbsp;&nbsp;<span><a href="#" class="page_s">1</a><a href="#">2</a><a href="#">3</a><a href="#">4</a><a href="#">5</a><a href="#">...</a><a href="#">9</a> <a href="#">10</a></span>&nbsp;&nbsp;<a href="#"><img src="images/p_4.png"  /></a><a href="#"><img src="images/p_5.png" /></a><span style="padding-left:20px;">每页</span> <span>
                              <select name="">
                                <option>10</option>
                                <option>20</option>
                                <option>30</option>
                              </select>
                          </span> <span>条</span></span>
                 	 </div>
                   </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
<!--尾部-->
    <div class="footer">
        <p><span>主办：北京市住房和城乡建设委员会</span><span>承办：北京市建设信息中心</span></p>
    </div>
</div>
</body>
</html>
