<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<center>
<br>
<!-- 이용자의 프로필사진을 넣습니다 -->
<img src="../img/1.png" width="150" height="150"><br>
<!-- 이용자의 닉네임을 넣습니다 -->
<h3><a href="">Haengtion.93</a></h3>
<!-- 이용자의 블로그소개를 넣습니다 -->
<h5>초보개발자 블로그</h5>
<!-- 포스트쓰기 Or 이웃추가-->
<a href="write.jsp" class="btn btn-info btn-md">
    <span class="glyphicon glyphicon-pencil"></span> 포스트쓰기
</a>
<br><br>
<a href="#" class="btn btn-info btn-md">
     <span class="glyphicon glyphicon-heart-empty"></span> 이웃추가
</a>
<hr>

<!-- 카테고리 -->
<!-- <table class="table">
	<tr class="active">
		<th>category &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <span class="glyphicon glyphicon-chevron-down"></span></th>
	</tr>
	카테고리 개수만큼 뿌려주기
	<tr>
		<td><a href="">여행 <span class="badge">14</span></a></td>
	</tr>
	<tr>
		<td><a href="">먹방<span class="badge">7</span></a></td>
	</tr>
	<tr>
		<td><a href="">코딩 <span class="badge">9</span></a></td>
	</tr>			
</table> -->

<!-- 카테고리 -->
<div class="panel panel-info">
      <div class="panel-heading">카테고리</div>
      <div class="panel-body">
      	<ul class="list-group">
		  <li class="list-group-item">
		    <!-- 여기에 카테고리내에 글 수와 카테고리명을 입력하세요 -->
		    <span class="badge">14</span>여행
		  </li>
		  <li class="list-group-item">
		    <span class="badge">2</span>먹방
		  </li>
		  <li class="list-group-item">
		    <span class="badge">1</span>코딩
		  </li>
		</ul>
      </div>
</div>

<!-- 방문자수 -->
<div class="panel panel-info">
      <div class="panel-heading">방문자수</div>
      <div class="panel-body">
      	Today 10<br>
      	Total 2559
      </div>
</div>
		


</center>
</body>
</html>