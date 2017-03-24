<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

	 <!-- 검색박스 -->
	 <div class="col-xs-6">
	 <input type="text" class="form-control" placeholder="검색어를 입력하세요" max="20" name="search_word" ></div>
		
	 <!-- 조회 버튼 -->
	 <div class="col-xs-1">
 	 <input type="button" class="btn btn-primary" value="조 회" onclick="javascript:do_search()">
	 </div>
</div>
<br>

<!-- HISTORY START -->
<br><br>
<div class="row">
<div class="col-lg-12">
<h3 class="page-header" style="color: #F361A6"> :: HISTORY 검색결과 :: </h3>

<p>내용</p>
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
<jsp:include page="/views/main/footer.jsp"/>
<!--푸터 START -->
</body>
</html>