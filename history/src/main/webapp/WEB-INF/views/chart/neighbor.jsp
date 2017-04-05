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
<jsp:include page="/header.hi"/>
<!--헤더 END-->
<script>
function do_add(id) {
	//var id = $("#neighbor").find("td").eq(1).text();
	if(confirm(id + "을 이웃으로 추가 하시겠습니까?")){
		$("#addid").val(id);
		var frm = document.addForm;
		frm.submit();
	}
}
function do_del(id) {
	//var id = $("#neighbor").find("td").eq(1).text();
	if(confirm(id + "님을 정말로 차단하시겠습니까?")){
		$("#delid").val(id);
		var frm = document.delForm;
		frm.submit();
	}
}
</script>
<form name="addForm" action="neighbor.hi" method="post">
	<input type="hidden" name="id" id="addid" value="">
	<input type="hidden" name="addordel" value="add">
</form>
<form name="delForm" action="neighbor.hi" method="post">
	<input type="hidden" name="id" id="delid" value="" >
	<input type="hidden" name="addordel" value="del">
</form>
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
						<th> <input type="checkbox"> </th>
						<th>ID [ 닉네임 ]</th>
						<th>블로그타이틀</th>
						<th style="text-align: center;">상태</th>
					</tr>
					<%
						if(neighborList!=null && neighborList.size()!=0){
							for(int i = 0; i < neighborList.size(); ++i){
					%>
						<tr class="active">
							<td><input type="checkbox"></td>
							<td><a href="/post/main.hi?id=<%=neighborList.get(i).get("MY_ID")%>">
							<%=neighborList.get(i).get("MY_ID")+" "%> [ <%=neighborList.get(i).get("NAME")+" "%> ]</a>
							</td>
							<td><%=neighborList.get(i).get("TITLE") %></td>
							<td style="text-align: center;">
							<button type="button" class="btn-xs btn-info" id="addNeighbor" onclick="do_add('<%=neighborList.get(i).get("MY_ID")%>')">이웃추가</button>
							<button type="button" class="btn-xs btn-danger" id="delNeighbor" onclick="do_del('<%=neighborList.get(i).get("MY_ID")%>')">차단</button>
							</td>
						</tr>
					<%
							}
					%>
						<tr>
							<td colspan="4" style="text-align: center;">
							<%
							int tot = Integer.parseInt(neighborList.get(0).get("TOT_CNT").toString())/10+1;
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