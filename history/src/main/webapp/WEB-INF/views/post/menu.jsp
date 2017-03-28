<%@page import="com.hifive.history.model.CategoryDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	session.setAttribute("id", "1");
	List<CategoryDto> categoryList = (List<CategoryDto>)request.getAttribute("categoryList");
	
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 이웃추가버튼 스타일 -->
<style type="text/css">
.btn-glyphicon {
	padding: 8px;
	background: #ffffff;
	margin-right: 4px;
}

.icon-btn {
	padding: 1px 15px 3px 2px;
	border-radius: 50px;
}
</style>
</head>
<body>
<center>
<br>
<!-- 이용자의 프로필사진을 넣습니다 -->
<img src="/resources/image/1.png" width="150" height="150"><br>
<!-- 이용자의 닉네임을 넣습니다 -->
<h3><a href="">Haengtion.93</a></h3>
<!-- 이용자의 블로그소개를 넣습니다 -->
<h5>초보개발자 블로그</h5>
<!-- 포스트쓰기 Or 이웃추가-->
<a href="write.hi" class="btn btn-info btn-md">
    <span class="glyphicon glyphicon-pencil"></span> 포스트쓰기
</a>
<br><br>
	<a class="btn icon-btn btn-primary btn-sm" href="#">
	<span class="glyphicon btn-glyphicon glyphicon-plus img-circle text-primary"></span>
	이웃추가</a>
<hr>

<!-- 카테고리 -->

<div class="list-group">
<li class="list-group-item active">카테고리</li>

  <%
  	for(int i = 0 ; i < categoryList.size(); ++i){
  %>
    <a class="list-group-item" href="main.hi?CT_SEQ=<%=categoryList.get(i).getSeq() %>">
    <span class="badge"><%=i+2 %></span>		<!-- 카테고리별 글 갯수  -->
    <%=categoryList.get(i).getName() %>
    </a>
  <%
  	}
  %>
</div>

<%-- 선택된 메뉴 색깔 바뀌게 하는것... 나중에 해야함.. 
String updateDiv = request.getAttribute("div").toString();
if(updateDiv == null) updateDiv = "profile";

<a href="/update?div=profile" class="list-group-item btn btn-link <%if(updateDiv.equals("profile")) out.println("active");%>">프로필편집</a> --%> 


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