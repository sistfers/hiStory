<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	Calendar cal = Calendar.getInstance();
	List<Map<String,Object>> visitAgeList = new ArrayList<Map<String,Object>>();
	visitAgeList = (List<Map<String,Object>>)request.getAttribute("visitAgeList");
	
	Date date = new Date();
	SimpleDateFormat sd = new SimpleDateFormat("YY/MM/dd");
	String comment2 = sd.format(date);
	date.setDate(date.getDate()-7);
	String comment1 = sd.format(date);
	
	if(request.getAttribute("comment1")!=null){
		comment1 = (String)request.getAttribute("comment1");
		comment2 = (String)request.getAttribute("comment2");
	}
%>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS -->
<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawVisualization);

function drawVisualization() {
  // Some raw data (not necessarily accurate)
  var data = google.visualization.arrayToDataTable([
   ['Month', '남자' , '여자'],
   ['10대',  <%=visitAgeList.get(0).get("MEN10") %>, <%=visitAgeList.get(0).get("WOMEN10") %>],
   ['20대',  <%=visitAgeList.get(0).get("MEN20") %>, <%=visitAgeList.get(0).get("WOMEN20") %>],
   ['30대',  <%=visitAgeList.get(0).get("MEN30") %>,  <%=visitAgeList.get(0).get("WOMEN30") %>],
   ['40대',  <%=visitAgeList.get(0).get("MEN40") %>, <%=visitAgeList.get(0).get("WOMEN40") %>],
   ['50대',  <%=visitAgeList.get(0).get("MEN50") %>, <%=visitAgeList.get(0).get("WOMEN50") %>]

]);

var options = {
title : 'haengtion님의 성별 분석',
vAxis: {title: '방문수'},
hAxis: {title: '<%=comment2%> ~ <%=comment1%>'},
seriesType: 'bars',
series: {5: {type: 'line'}}
};

var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
chart.draw(data, options);
}
</script>
<script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['ages', 'Hours per Day'],
          ['10대', <%=Integer.parseInt(visitAgeList.get(0).get("MEN10").toString()) + Integer.parseInt(visitAgeList.get(0).get("WOMEN10").toString()) %>],
          ['20대', <%=Integer.parseInt(visitAgeList.get(0).get("MEN20").toString()) + Integer.parseInt(visitAgeList.get(0).get("WOMEN20").toString()) %>],
          ['30대', <%=Integer.parseInt(visitAgeList.get(0).get("MEN30").toString()) + Integer.parseInt(visitAgeList.get(0).get("WOMEN30").toString()) %>],
          ['40대', <%=Integer.parseInt(visitAgeList.get(0).get("MEN40").toString()) + Integer.parseInt(visitAgeList.get(0).get("WOMEN40").toString()) %>],
          ['50대', <%=Integer.parseInt(visitAgeList.get(0).get("MEN50").toString()) + Integer.parseInt(visitAgeList.get(0).get("WOMEN50").toString()) %>]
        ]);

        var options = {
          title: 'haengtion님의 연령별 분석',
          pieHole: 0.4,
        };

        var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
        chart.draw(data, options);
      }
    </script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>:::::::::::블로그 관리:::::::::::::::</title>
<style type="text/css">
.mydiv{
width:20%;
margin-right:0.5%;
border-radius: 15px;
}
.mydiv2{
width:78%;
margin-left:0.5%;
border-radius: 15px;
}
</style>

</head>
<body>
<!--헤더 START-->
<jsp:include page="/header.hi"/>
<!--헤더 END-->

<!-- 중간 START -->
   <br><br><br><br>
   <div class="container" >
      <div class="col-xs-2 mydiv" style="background-color: rgb(255, 191, 191); border-radius: 15px">
         <jsp:include page="menu.jsp"/>
      </div>
      <!--내용 START -->
        <div class="col-xs-10 mydiv2" style="background-color: rgb(255, 191, 191);">
	        <div class="col-xs-1"></div>
	        <div class="col-xs-10" style="margin-top: 20px; margin-bottom : 20px; background-color: rgb(255, 230, 230);">
		       	<p style="font-size: 25px; margin-top: 20px">방문자수</p>
		       	<form class="form-horizontal" method="post" action="age.hi">
		       	<div class="form-group" id="startdate" style="margin-top: 10px">
					<div class="col-lg-1">
					</div>
					<div class="col-lg-4">
						<input type="date" class="form-control" id="startdate" name="startdate">
					</div>
					<div class="col-lg-4">
						<input type="date" class="form-control" id="enddate" name="enddate">
					</div>
					<div class="col-lg-2">
						<button type="submit" class="btn btn-primary"> 조회 </button>
					</div>
				</div>
				</form>
		       	<div class="col-xs-12" id="chart_div" style="height: 500px;">
		       	</div>
		       	<div class="col-xs-12" id="donutchart" style="height: 500px;"></div>
			<div class="col-xs-1"></div>
  		</div>
</div>

<!--중간 END -->
</div>

<!--중간 END -->

<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>	
<!--푸터 START -->
</body>
</html>