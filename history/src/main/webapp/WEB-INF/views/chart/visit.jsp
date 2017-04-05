<%@page import="com.hifive.history.model.BlogDto"%>
<%@page import="com.hifive.history.model.UserDto"%>
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
	List<Map<String,Object>> visitList = new ArrayList<Map<String,Object>>();
	visitList = (List<Map<String,Object>>)request.getAttribute("visitList");
	
	Date date = new Date();
	SimpleDateFormat sd = new SimpleDateFormat("YY/MM/dd");
	String comment2 = sd.format(date);
	date.setDate(date.getDate()-7);
	String comment1 = sd.format(date);
	
	//블로그 테마색 불러오기
	if(session.getAttribute("user")!=null){
		UserDto user = (UserDto)session.getAttribute("user");
	}
	
	BlogDto blogdto = (BlogDto)request.getAttribute("blogdto");
	
%>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS -->
<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/3.2.1/css/font-awesome.min.css">
<script type="text/javascript">
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawVisualization);

function drawVisualization() {
  // Some raw data (not necessarily accurate)
  var data = google.visualization.arrayToDataTable([
	['Month', '방문자', {role:'style'}],
   	['<%=visitList.get(0).get("CUR_DATE")%>',  <%=visitList.get(0).get("CNT")%>, 'color: #bff1ff'],
   	['<%=visitList.get(1).get("CUR_DATE")%>',  <%=visitList.get(1).get("CNT")%>, 'color: #bff1ff'],
   	['<%=visitList.get(2).get("CUR_DATE")%>',  <%=visitList.get(2).get("CNT")%>, 'color: #bff1ff'],
   	['<%=visitList.get(3).get("CUR_DATE")%>',  <%=visitList.get(3).get("CNT")%>, 'color: #bff1ff'],
   	['<%=visitList.get(4).get("CUR_DATE")%>',  <%=visitList.get(4).get("CNT")%>, 'color: #bff1ff'],
   	['<%=visitList.get(5).get("CUR_DATE")%>',  <%=visitList.get(5).get("CNT")%>, 'color: #bff1ff'],
   	['<%=visitList.get(6).get("CUR_DATE")%>',  <%=visitList.get(6).get("CNT")%>, 'color: #bff1ff'],
]);

	var options = {
	title : 'haengtion님의 방문자 분석',
	vAxis: {title: '방문수'},
	hAxis: {title: '<%=comment1%> ~ <%=comment2%>'},
	seriesType: 'bars',
	series: {7: {type: 'line'}}
	};

	var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
	chart.draw(data, options);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>블로그 관리/통계</title>
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
	<jsp:include page="/header.hi" />
	<!--헤더 END-->

<!-- 중간 START -->
   <br><br><br><br>
   <div class="container" >
       <div class="col-xs-2 mydiv" style="background-color: <%=blogdto.getTheme() %>; border-radius: 15px">
         <jsp:include page="menu.jsp"/>
      </div>
      <!--내용 START -->
        <div class="col-xs-10 mydiv2" style="background-color: <%=blogdto.getTheme() %>;">
        	<div class="col-xs-1"></div>
	        <div class="col-xs-10" style="margin-top: 20px; margin-bottom : 20px; background-color: #FCFCFC;">
		       	<p style="font-size: 25px; margin-top: 20px;"> 방문자수</p><hr>
		       	<form class="form-horizontal" method="post" action="visit.hi">
		       	<div class="form-group" id="startdate" style="margin-top: 10px">
					<div class="col-xs-1">
					</div>
					<div class="col-xs-4">
						<input type="date" class="form-control" id="enddate" name="enddate">
					</div>
					<div class="col-xs-2">
						<button type="submit" class="btn btn-primary"> 조회 </button>
					</div>
					<div class="col-xs-5">
						* 7일간의 데이터를 불러옵니다.
					</div>
				</div>
				</form>
		       	<div class="col-xs-12" id="chart_div" style="height: 400px;"></div>
		       	<div class="col-xs-12">
		       		<table class="table" style="margin-top: 10px">
		        	<tr class="warning">
		        		<th colspan="8" style="text-align: center;">방문자수</td>
		        	</tr>
		        	<tr class="active">
						<td>날짜</td>
						<%
							for(int i =0; i < visitList.size(); ++i){
						%>
						<td><%=visitList.get(i).get("CUR_DATE") %></td>
						<%
							}
						%>
		        	</tr>
		        	<tr class="active">
		        		<td>방문</td>
		        		<%
							for(int i =0; i < visitList.size(); ++i){
						%>
						<td style="text-align: center; "><%=visitList.get(i).get("CNT") %>명</td>
						<%
							}
						%>
		        	</tr>
		        	</table>
		       	</div>
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