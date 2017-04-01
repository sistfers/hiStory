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
	
	List<Map<String, Object>> followIncList = new ArrayList<Map<String,Object>>();
	followIncList = (List<Map<String,Object>>)request.getAttribute("followIncList");
	
	List<Map<String, Object>> followDecList = new ArrayList<Map<String,Object>>();
	followDecList = (List<Map<String,Object>>)request.getAttribute("followDecList");
%>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS -->
<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['내 팔로우 감소 추이', '증가', '감소'],
          ['<%=followIncList.get(0).get("CUR_DATE")%>',  <%=followIncList.get(0).get("CNT")%>, <%=followDecList.get(0).get("CNT")%>],
          ['<%=followIncList.get(1).get("CUR_DATE")%>',  <%=followIncList.get(1).get("CNT")%>, <%=followDecList.get(1).get("CNT")%>],
          ['<%=followIncList.get(2).get("CUR_DATE")%>',  <%=followIncList.get(2).get("CNT")%>, <%=followDecList.get(2).get("CNT")%>],
          ['<%=followIncList.get(3).get("CUR_DATE")%>',  <%=followIncList.get(3).get("CNT")%>, <%=followDecList.get(3).get("CNT")%>],
          ['<%=followIncList.get(4).get("CUR_DATE")%>',  <%=followIncList.get(4).get("CNT")%>, <%=followDecList.get(4).get("CNT")%>],
          ['<%=followIncList.get(5).get("CUR_DATE")%>',  <%=followIncList.get(5).get("CNT")%>, <%=followDecList.get(5).get("CNT")%>],
          ['<%=followIncList.get(6).get("CUR_DATE")%>',  <%=followIncList.get(6).get("CNT")%>, <%=followDecList.get(6).get("CNT")%>]
        ]);

        var options = {
          title: '이웃증감 분석',
          hAxis: {title: '범위 내 분석',  titleTextStyle: {color: '#111'}},
          vAxis: {minValue: 0}
        };

        var chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
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
		       	<p style="font-size: 25px; margin-top: 20px">이웃증감</p><hr>
		       	<form class="form-horizontal" method="post" action="follow.hi">
		        	<div class="form-group" id="endday" style="margin-top: 10px">
						<div class="col-lg-1">
						</div>
						<div class="col-lg-4">
							<input type="date" class="form-control" id="endday" name="endday">
						</div>
						<div class="col-lg-3">
							<button type="submit" class="btn btn-primary"> 조회 </button>
						</div>
						<div class="col-lg-4">
						</div>
					</div>
				</form>
				<div id="chart_div" style="width: 100%; height: 500px;"></div>
				
		       	
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