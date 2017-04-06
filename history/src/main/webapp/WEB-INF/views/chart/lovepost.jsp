<%@page import="com.hifive.history.model.BlogDto"%>
<%@page import="com.hifive.history.util.PagingUtil"%>
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
	
	BlogDto blogdto = (BlogDto)request.getAttribute("blogdto");
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
      <div class="col-xs-2 mydiv" style="background-color: <%=blogdto.getTheme() %>; border-radius: 15px">
         <jsp:include page="menu.jsp"/>
      </div>
      <!--내용 START -->
        <div class="col-xs-10 mydiv2" style="background-color: <%=blogdto.getTheme()%>;">
	        <div class="col-xs-1"></div>
	        <div class="col-xs-10">
		        <!-- 포스트-->
		        <div class="col-xs-12" style="background-color: #f2f7ff; margin-top:20px; padding-top: 20px; margin-bottom: 20px">
		 			<p style="font-size: 25px; margin-top: 20px">내가 공감한 글</p>
					<table class="table" style="margin-top: 20px" id="neighbor">
					<tr class="warning">
						<th>No</th>
						<th>ID</th>
						<th>제목</th>
						<th>공감일</th>
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
							<td><a href="/post/main.hi?id=<%=lovepostList.get(i).get("POSTID")%>&seq=<%=lovepostList.get(i).get("POST_SEQ")%>">
							<%=lovepostList.get(i).get("TITLE") %></a>
							</td>
							<td><%=lovepostList.get(i).get("LDATE") %></td>
						</tr>
					<%
							}
					%>
						<tr>
							<td colspan="4" style="text-align: center;">
							<ul class="pagination pagination-sm">
							 <li class="disabled"><a href="#">&laquo;</a></li>
							<%
							int tot = Integer.parseInt(lovepostList.get(0).get("TOT_CNT").toString())/10+1;
							if(request.getParameter("PAGE_NUM")==null){
								for(int i = 1; i<= tot; ++i){
									if(i==1){
								%>
									<li class="active"><a href="lovepost.hi?PAGE_NUM=<%=i %>"><%=i %></a></li>
								<%
									}else{
								%>
									<li><a href="lovepost.hi?PAGE_NUM=<%=i %>"><%=i %></a></li>
								<%
									}
								}
							}else{
								for(int i = 1; i<= tot; ++i){
								%>
									<li <%if((Integer.parseInt(request.getParameter("PAGE_NUM"))==i)){%>class="active"<%} %>><a href="lovepost.hi?PAGE_NUM=<%=i %>">
									<%=i %></a></li>
								<%
								}
							}
								%>
							<li><a href="#">&raquo;</a></li>
							</ul>
							</td>
						</tr>
					<%
						}else{
					%>
						<tr class="active">
						<td colspan="4" style="text-align: center;">회원님이 공감하신 글이 없습니다.</td> 
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