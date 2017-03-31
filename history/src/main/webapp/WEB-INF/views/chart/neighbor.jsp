<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%
	List<Map<String, Object>> neighborList = new ArrayList<>();
	neighborList = (List<Map<String, Object>>)request.getAttribute("neighborList");
%>
<!-- Bootstrap CSS -->
<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>:::::::::::이웃보기:::::::::::::::</title>
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
	        <div class="col-xs-10">
		        <!-- 포스트-->
		        <div class="col-xs-12" style="background-color: rgb(255, 230, 230); margin-top:20px; padding-top: 20px; margin-bottom: 20px">
		 			<p style="font-size: 25px; margin-top: 20px">등록된 카테고리</p>
					<table class="table" style="margin-top: 20px">
					<tr class="info">
						<th> <input type="checkbox"> </th>
						<th>ID [ 닉네임 ]</th>
						<th>상태</th>
					</tr>
					<%
						if(neighborList!=null && neighborList.size()!=0){
							for(int i = 0; i < neighborList.size(); ++i){
					%>
						<tr class="active">
							<td><input type="checkbox"></td>
							<td><a href="/post/main.hi?id=<%=neighborList.get(i).get("MY_ID")%>">
							<%=neighborList.get(i).get("MY_ID")+" " %> [ <%=neighborList.get(i).get("NAME") %> ]</a>
							</td>
							<td><button type="button" class="btn-xs btn-info">추가</button></td>
						</tr>
					<%
							}
						}else{
					%>
						<tr>
						<td rowspan="3" style="text-align: center;">회원님을 팔로우하는 회원이 없습니다.</td>
					<%
						}
					%>
					</table>
				</div>
				
	  		</div>
	  		<div class="col-xs-1"></div>
  		</div>
</div>

<!--중간 END -->

<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>	
<!--푸터 START -->
</body>
</html>