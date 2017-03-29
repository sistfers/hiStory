<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.hifive.history.model.PostDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hifive.history.model.CategoryDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	List<HashMap<String, Object>> loveRank = new ArrayList();
	loveRank = (List<HashMap<String, Object>>)request.getAttribute("loveRank");
	
%>
<meta name="viewport" content="width=device-width, initial-scale=1">

<script src="/post_inc/datetimepicker/bootstrap-datepicker.js"></script>

<!-- Bootstrap CSS -->
<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
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
<script>
$(function(){
	$('#dd').datepicker({format:"yyyy-mm-dd"}).datepicker("setDate", new Date(2017,03,01) );
});
</script>
</head>
<body>
<!--헤더 START-->
<jsp:include page="../main/header.jsp"/>
<!--헤더 END-->

<!-- 
태마 버전
그린 : rgb(224, 239, 208) / rgb(251, 255, 247)
 -->
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
		       	<p style="font-size: 25px; margin-top: 20px">전체</p>
		        <table class="table" style="margin-top: 10px">
		        	<tr class="info">
						<th>순위</th>
						<th>글제목</th>
						<th>분야</th>
						<th>공감수</th>
						<th>작성일</th>
		        	</tr>
		        	<%
		        		if(loveRank.size()==0){
		        	%>
		        		<tr class="active">
		        		<td colspan="5">공감받은 글이 없습니다.</td>
		        		</tr>
		        	<%
		        		}else{
		        			for(int i = 0; i < loveRank.size(); ++i){	
		        	%>	
		        		<tr class="active">
		        		<td><%=i+1 %>위</td>
		        		<td><%=loveRank.get(i).get("TITLE") %></td>
		        		<td><%=loveRank.get(i).get("FIELD") %></td>
		        		<td><%=loveRank.get(i).get("COUNT(*)") %></td>
		        		<td><%=loveRank.get(i).get("WDATE") %></td>
		        		</tr>
		        	<%
		        			}
		        		}
		        	%>
		        	
		        	
		        </table>
		        <div class="row">
					<div class='col-sm-6'>
						datepicker 
						<input type="text" class="form-control" id="dd"><br>
					</div>
				</div>
		        <form class="form-horizontal" method="post" action="control.hi">
		        
				
		        <table class="table" style="margin-top: 10px">
		        	<tr class="info">
						<th>순위</th>
						<th>글제목</th>
						<th>분야</th>
						<th>공감수</th>
						<th>작성일</th>
		        	</tr>
		        	<%
		        		if(loveRank.size()==0){
		        	%>
		        		<tr class="active">
		        		<td colspan="5">공감받은 글이 없습니다.</td>
		        		</tr>
		        	<%
		        		}else{
		        			for(int i = 0; i < loveRank.size(); ++i){	
		        	%>	
		        		<tr class="active">
		        		<td><%=i+1 %>위</td>
		        		<td><%=loveRank.get(i).get("TITLE") %></td>
		        		<td><%=loveRank.get(i).get("FIELD") %></td>
		        		<td><%=loveRank.get(i).get("COUNT(*)") %></td>
		        		<td><%=loveRank.get(i).get("WDATE") %></td>
		        		</tr>
		        	<%
		        			}
		        		}
		        	%>
		        	
		        	
		        </table>
		        </form>
				<br><br><br>
				
				

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