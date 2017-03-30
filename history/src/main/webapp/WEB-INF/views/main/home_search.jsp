<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<Map<String, Object>> searchList = (List<Map<String, Object>>)request.getAttribute("searchList");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> ★ hiStory ★ </title>
    <!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
</head>
<body>

<!--헤더 START-->
<jsp:include page="header.jsp"/>
<!--헤더 END-->
<div class="container" >
<br><br><br><br> <!-- 헤더때문에 윗에 공백 넣어주는거임 -->

<!--내용 START -->

<!-- 검색하기 -->
<div class="form-group">
<div class="col-xs-2"></div>
<div class="col-xs-8">
	<div class="form-group">
	  	<div class="input-group">
		    <span class="input-group-addon input-lg"><i class="glyphicon glyphicon-search"></i></span>
		     <input type="text" class="form-control input-lg" placeholder="검색어를 입력하세요" max="20" name="search_word" size=20>
	    	<span class="input-group-btn">
	     	<input type="button" class="btn btn-primary btn-lg" value="조 회" onclick="javascript:do_search()">
	    	</span>
	  	</div>
	</div>  
</div> 
<div class="col-xs-2"></div>
<br>

<!-- HISTORY START -->
<br><br>
<div class="row">
<div class="col-lg-12">
<h3 class="page-header" style="color: #F361A6"> :: HISTORY 검색결과 :: </h3>

<table width="100%" >
<%for(int i=0; i<searchList.size(); ++i){ %>
<tr>
	<td rowspan="2"><img src='<%=searchList.get(i).get("SAVE_NAME") %>' width="40px" height="40px"></td>
	<td><%=searchList.get(i).get("TITLE") %></td>
	<td><%=searchList.get(i).get("WDATE") %></td>
</tr>
<tr>
	<td colspan="2"><%=searchList.get(i).get("CONTENT") %></td>
</tr>
<%} %>
</table>
</div>
</div>


<br><br><br><br>
<br><br><br><br>


<!--페이징  -->
<center>
<ul class="pagination pagination-sm">
  <li class="disabled"><a href="#">&laquo;</a></li>
  <li class="active"><a href="#">1</a></li>
  <li><a href="#">2</a></li>
  <li><a href="#">3</a></li>
  <li><a href="#">4</a></li>
  <li><a href="#">5</a></li>
  <li><a href="#">&raquo;</a></li>
</ul>
</center>
<!-- HISTORY END -->

<br><br><br><br>
<br><br><br><br>


<!-- 네이버 검색결과 START -->
<br><br>
<div class="row">
<div class="col-lg-12">
<h3 class="page-header" style="color: #2F9D27"> :: 네이버 검색결과 :: </h3>

<p>내용</p>
</div>
</div>

<!-- 네이버 검색결과 END -->


<br><br><br><br>
<br><br><br><br>
<br><br><br><br>
<br><br><br><br>




</div>
<!--푸터 START -->
<jsp:include page="footer.jsp"/>
<!--푸터 START -->
</body>
</html>