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
	List<Map<String, Object>> lovepostList = new ArrayList<>();
	lovepostList = (List<Map<String, Object>>)request.getAttribute("lovepostList");
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
<jsp:include page="/header.hi"/>
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
		 			<p style="font-size: 25px; margin-top: 20px">나의 팔로우 보기</p>
					<table class="table" style="margin-top: 20px" id="neighbor">
					<tr class="info">
						<th>No</th>
						<th>ID</th>
						<th>제목</th>
					</tr>
					<%
						if(lovepostList!=null && lovepostList.size()!=0){
							for(int i = 0; i < lovepostList.size(); ++i){
					%>
						<tr class="active">
							<td><%=i+1 %></td>
							<td><a href="/post/main.hi?id=<%=lovepostList.get(i).get("POSTID")%>">
							<%=lovepostList.get(i).get("POSTID")+" "%></a>
							</td>
							<td><a href="/post/main.hi?id=<%=lovepostList.get(i).get("POSTID")%>">
							<%=lovepostList.get(i).get("TITLE") %></a>
							</td>
						</tr>
					<%
							}
					%>
						<tr>
							<td colspan="4" style="text-align: center;">
							<%
							int tot = Integer.parseInt(lovepostList.get(0).get("TOT_CNT").toString())/10+1;
							for(int i = 1; i<= tot; ++i){							
							%>
								<a href="" id="PAGE_NUM">
								<%=i %>
								</a>
							<%
							}
							%>
							</td>
						</tr>
					<%
						}else{
					%>
						<tr class="active">
						<td colspan="4" style="text-align: center;">회원님을 팔로우하는 회원이 없습니다.</td> 
						</tr>
						
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