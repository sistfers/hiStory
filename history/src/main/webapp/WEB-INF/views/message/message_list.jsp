<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
List<Map<String, Object>> datas = new ArrayList<Map<String, Object>>();
datas = (ArrayList<Map<String, Object>>) request.getAttribute("getList");

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 쪽지함 </title>
    <!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>

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

<!--헤더 START-->
<jsp:include page="../main/header.jsp"/>
<!--헤더 END-->
<div class="container" >
<br><br><br><br> <!-- 헤더때문에 윗에 공백 넣어주는거임 -->

<!-- 좌측메뉴 -->
<div class="col-xs-2">
	<jsp:include page="menu.jsp"/>
</div>

<!--내용 START -->
<div class="col-xs-10">
<center><h2> :: 받은쪽지함 ::</h2></center><br>
	<div class="col-xs-1"></div>
	<div class="col-xs-10">
		<!-- 버튼 -->	
		<div class="form-group">			
	<button class="btn btn-warning">삭제</button>
    <button class="btn btn-warning">답장</button>
    
    </div>
				<table class="table">
					<tr class="warning" >
						<th width="10%"  style="text-align: center;">삭제</th>
						<th width="20%" style="text-align: center;">보낸사람</th>
						<th width="50%" style="text-align: center;">내용</th>
						<th width="20%" style="text-align: center;">날짜</th>
					</tr>
					
					<%
					if(datas != null && datas.size() > 0) {
						for(int i = 0; i < datas.size(); i++) {
							Map<String, Object> item = datas.get(i);
					%>
						<tr>
						<td align="center"><input type="checkbox"></td>
						<td><%=item.get("SEND_ID") %></td>
						<td><%=item.get("CONTENTS") %></td>
						<td><%=item.get("WDATE") %></td>
					</tr>
					<%
						}
					} else {
					%>
						<tr>
						<td align="center" colspan="4">쪽지가 없습니다.</td>
						</tr>
					<%	
					}
					%>

				</table>
			</div>
	<div class="col-xs-1"></div>
</div>

이건 블로그에 넣으라고 찾아놓은것 
<a class="btn icon-btn btn-info" href="#"><span class="glyphicon btn-glyphicon glyphicon-plus img-circle text-info"></span>이웃추가</a>
<br><br><br><br><br>
</div>
<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>
<!--푸터 START -->
</body>
</html>