<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.hifive.history.model.UserDto"%>
<%@page import="com.hifive.history.model.CategoryDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String id = request.getParameter("id");
	// 해당블로그 유저정보 받아오기
	
	List<CategoryDto> categoryList = (List<CategoryDto>)request.getAttribute("categoryList");
	
	UserDto loginuser = (UserDto)session.getAttribute("user");

	Map<String, Integer> visit = new HashMap<>();
	visit = (Map<String, Integer>)request.getAttribute("visit");
	
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
<h3><%=loginuser.getName() %></h3>

<!-- 이용자의 블로그소개를 넣습니다 -->
<h5><%=loginuser.getPf_content() %></h5>

<%
if(loginuser != null){
	if(id.equals(loginuser.getId())){ %>
		<a href="write.hi?id=<%=id %>" class="btn btn-default btn-md">
		    <span class="glyphicon glyphicon-pencil"></span> 포스트쓰기
		</a>
	<%}else if(!id.equals(loginuser.getId())){ %>
		<a class="btn icon-btn btn-warning btn-sm" href="#">
		<span class="glyphicon btn-glyphicon glyphicon-plus img-circle text-warning"></span>
		이웃추가</a>
	<%}
}%>
<br>
<hr>

<!-- 카테고리 -->
<div class="list-group">
<a href="main.hi?id=<%=id%>" class="list-group-item active">카테고리 &nbsp;&nbsp;&nbsp;&nbsp;
<span class="glyphicon glyphicon-chevron-down"></span></a>

  <%
  	for(int i = 0 ; i < categoryList.size(); ++i){
  %>
    <a class="list-group-item" href="main.hi?ct_seq=<%=categoryList.get(i).getSeq() %>&id=<%=id%>">
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
      	Today <%=visit.get("today") %><br>
      	Total <%=visit.get("total") %>
      </div>
</div>
		


</center>
</body>
</html>