$(document).ready(function(){
		//右侧切换
	$(".gxpt_tabTit li").click(function(){
		$(this).siblings().removeClass("gxpt_tabCurtit");
		$(this).addClass("gxpt_tabCurtit");
		$(".gxpt_single").eq($(".gxpt_tabTit li").index(this)).show().siblings().hide();	
	})
	var getPageSize = function () {
		var pageWidth = window.innerWidth, pageHeight = window.innerHeight;
		var screenWidth = window.screen.width, screenHeight = window.screen.height;

		if ( typeof pageWidth != "number" ){
			if (document.compatMode == "CSS1Compat"){
				pageWidth = document.documentElement.clientWidth;
				pageHeight = document.documentElement.clientHeight;
			} else {
				pageWidth = document.body.clientWidth;
				pageHeight = document.body.clientHeight;
			}
		}
		return { PageW:pageWidth, PageH:pageHeight, ScreenW:screenWidth, ScreenH:screenHeight };
	};

	var resizePage = function(){
		
		$("#container").css( "height", getPageSize().PageH - 82 + "px" );
		$("#leftArea").css( "height", getPageSize().PageH - 82 + "px" );
		$("#rightArea").css( "height", getPageSize().PageH - 90 + "px" );
		
   		 <!--0617结束-->
	};	
	resizePage();
	
	$(window).resize(function(){
		resizePage();
	});

});

