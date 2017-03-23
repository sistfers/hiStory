<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 쪽지함 </title>
    <!-- Bootstrap CSS -->
	<link href="../css/bootstrap.css" rel="stylesheet" type="text/css"/>
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
	<button class="btn btn-danger">삭제</button>
    <button class="btn btn-primary">답장</button>
    </div>
				<table class="table">
					<tr class="warning">
						<th width="10%">삭제</th>
						<th width="20%">보낸사람</th>
						<th width="50%">내용</th>
						<th width="20%">날짜</th>
					</tr>
					<tr>
						<td align="center"><input type="checkbox"></td>
						<td>xxx</td>
						<td>xxx</td>
						<td>xxx</td>
					</tr>

				</table>




			</div>
	<div class="col-xs-1"></div>
</div>
<br><br><br><br><br>
</div>
<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>	
<!--푸터 START -->
</body>
</html>