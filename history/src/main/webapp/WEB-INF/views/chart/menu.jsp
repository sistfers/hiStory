<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<center>
<br>

<!-- 카테고리 -->
<!-- <div class="panel panel-info">
      <div class="panel-heading">관리</div>
      <div class="panel-body">
      	<a href="control.hi">블로그관리</a> <br><br>
      	<a href="neighbor.hi">나를 추가한 이웃</a>
      </div>
</div> -->
<h5> === 관리===</h5>
<div class="list-group">
	<a class="list-group-item  <%if(request.getRequestURL().toString().contains("control")) out.println("active");%>" href="control.hi">블로그관리</a>
	<a class="list-group-item  <%if(request.getRequestURL().toString().contains("neighbor")) out.println("active");%>" href="neighbor.hi">나를 추가한 이웃</a>
</div>



<!-- 방문자수 -->
<h5> === 통계 ===</h5>
<div class="list-group">
	<a class="list-group-item  <%if(request.getRequestURL().toString().contains("visit")) out.println("active");%>" href="visit.hi">방문자수</a>
	<a class="list-group-item  <%if(request.getRequestURL().toString().contains("age")) out.println("active");%>" href="age.hi">성별 / 연령별</a>
	<a class="list-group-item  <%if(request.getRequestURL().toString().contains("follow")) out.println("active");%>" href="follow.hi">이웃증감수</a>
</div>

<h5> === 순위 ===</h5>
<div class="list-group">
	<a class="list-group-item  <%if(request.getRequestURL().toString().contains("love")) out.println("active");%>" href="love.hi">공감수 순위</a>
	<a class="list-group-item  <%if(request.getRequestURL().toString().contains("comment")) out.println("active");%>" href="comment.hi">댓글수 순위</a>
</div>
<!-- <div class="panel panel-info">
      <div class="panel-heading">통계</div>
      <div class="panel-body">
      	<h4>방문분석</h4><hr>
      	<a href="visit.hi">방문자수</a> <br>
      	<a href="age.hi">성별 / 연령별</a> <br>
      	<a href="follow.hi">이웃증감수</a> <br>
      	<br>
      	<h4>순위</h4><hr>
      	<a href="love.hi">공감수 순위</a> <br>
      	<a href="comment.hi">댓글수 순위</a> <br>   	
      </div>
</div> -->








</center>

