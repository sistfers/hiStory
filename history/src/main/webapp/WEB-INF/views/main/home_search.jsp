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
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> ★ hiStory ★ </title>
    <!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
	<style type="text/css">
	.table-filter {
	background-color: #fff;
	border-bottom: 1px solid #eee;
}
.table-filter tbody tr td {
	padding: 10px;
	vertical-align: middle;
	border-top-color: #eee;
}
.table-filter tbody tr.selected td {
	background-color: #eee;
}
.table-filter tr td:first-child {
	width: 38px;
}
.table-filter tr td:nth-child(2) {
	width: 35px;
}
.table-filter .media-photo {
	width: 35px;
}
.table-filter .media-body {
    display: block;
    /* Had to use this style to force the div to expand (wasn't necessary with my bootstrap version 3.3.6) */
}
.table-filter .media-meta {
	font-size: 11px;
	color: #999;
}
.table-filter .media .title {
	color: #2BBCDE;
	font-size: 14px;
	font-weight: bold;
	line-height: normal;
	margin: 0;
}
.table-filter .media .title span {
	font-size: .8em;
	margin-right: 20px;
}
.table-filter .media .title span.pagado {
	color: #5cb85c;
}
.table-filter .media .title span.pendiente {
	color: #f0ad4e;
}
.table-filter .media .title span.cancelado {
	color: #d9534f;
}
.table-filter .media .summary {
	font-size: 14px;
}
	</style>
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

<table width="100%" class="table table-hover" >

<%for(int i=0; i<searchList.size(); ++i){ %>
<tr name="search_detail" style="cursor:pointer;">
	<td id="<%=searchList.get(i).get("ID")%>">
	<div class="media">
		<a href="#" class="pull-left">
		<img src='<%=searchList.get(i).get("SAVE_NAME") %>' width="150px" height="100px">
		</a>
	</div>
	</td>
	<td valign="top" id="<%=searchList.get(i).get("SEQ")%>">
		<div class="media-body">
		
		
		<h4 class="title">
		<%=searchList.get(i).get("TITLE") %>
		</h4>
		<p class="summary"><%=searchList.get(i).get("CONTENT") %></p>
		</div>
		<br>
	</td>
	<td align="right" valign="top" >
	<div class="media-body">
	<%=searchList.get(i).get("WDATE") %>
	</div>
	</td>
</tr>

<%} %>
</table>	

</div>
</div>
<!-- 디테일 클릭시 해당 ID, SEQ 들고 폼전송 구간 Start -->
<form name="do_detail" method="get" action="">
<input type="hidden" id="id" name="id" value="">
<input type="hidden" id="seq" name="seq" value="">
</form>
<!-- 검색순위 클릭시 해당 검색어 들고 폼전송 구간 End -->

<script type="text/javascript">
$(document).ready(function () {
	$("tr[name=search_detail]").click(function(){
		
		var frm = document.do_detail;
		frm.id.value = $(this).eq(0).find("td").eq(0).attr('id');	//id
		frm.seq.value = $(this).eq(0).find("td").eq(1).attr('id');	//seq
		console.log("frm.id.value=" + frm.id.value);
		console.log("frm.seq.value=" + frm.seq.value);
		frm.action = "/post/main.hi";
		frm.submit();
	});

 });
</script>

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