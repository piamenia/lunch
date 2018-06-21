<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp" %>
<!--[if lt IE 9]><script language="javascript" type="text/javascript" src="excanvas.js"></script><![endif]-->
<script type="text/javascript" src="resources/jqplot/jquery.jqplot.min.js"></script>
<script type="text/javascript" src="resources/jqplot/plugins/jqplot.barRenderer.js"></script>
<script type="text/javascript" src="resources/jqplot/plugins/jqplot.pieRenderer.js"></script>
<script type="text/javascript" src="resources/jqplot/plugins/jqplot.categoryAxisRenderer.js"></script>
<script type="text/javascript" src="resources/jqplot/plugins/jqplot.pointLabels.js"></script>
<link rel="stylesheet" type="text/css" href="resources/jqplot/jquery.jqplot.min.css" />
<div class="row">
<div style="text-align:center">
	<!-- <img src="./resources/img/main_img.jpg" width="30%"> -->
	<div style="margin:auto; width:80%;" id="chart"></div>
</div>
<script>
// ajax를 이용해 log 파일을 읽어서 그래프로 출력
$.ajax({
	url: 'loginlog',
	data:{},
	dataType: 'json',
	success:function(data){
		var count = new Array();
        var nickname = new Array();
		for(key in data){
			nickname.push(key);
			count.push(data[key]);
		}
		
		$.jqplot.config.enablePlugins = true;         
        plot1 = $.jqplot('chart', [count], {
            // Only animate if we're not using excanvas (not in IE 7 or IE 8)..
            animate: !$.jqplot.use_excanvas,
            seriesDefaults:{
                renderer:$.jqplot.BarRenderer,
                pointLabels: { show: true }
            },
            axes: {
                xaxis: {
                    renderer: $.jqplot.CategoryAxisRenderer,
                    ticks: nickname
                },
            	yaxis: {
                    tickOptions: {formatString: '%d'}
            	}
            },
            highlighter: { show: false }
        });
     
        $('#chart').bind('jqplotDataClick', 
            function (ev, seriesIndex, pointIndex, data) {
                $('#info1').html('series: '+seriesIndex+', point: '+pointIndex+', data: '+data);
            }
        );
	}
});
</script>
</div>
<!-- 메시지 대화상자 -->
<c:if test="${msg != null}">
<div id="dialog-message" title="" style="display:none">
	<p>
		<span class="ui-icon ui-icon-circle-check"
			style="float: left; margin: 0 7px 50px 0;"></span> ${msg}
	</p>
</div>
<script>
	$("#dialog-message").dialog({
		modal : true,
		buttons : {
			Ok : function() {
				$(this).dialog("close");
			}
		}
	});
</script>
</c:if>
<%@ include file="include/footer.jsp" %>