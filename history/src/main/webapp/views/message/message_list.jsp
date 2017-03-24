<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<jsp:include page="/views/main/header.jsp"/>
<!--헤더 END-->
<div class="container" >
<br><br><br><br> <!-- 헤더때문에 윗에 공백 넣어주는거임 -->

<!-- 좌측메뉴 -->
<div class="col-xs-2">
	<jsp:include page="/views/message/menu.jsp"/>
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
					<tr>
						<td align="center"><input type="checkbox"></td>
						<td>김미현</td>
						<td>아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아 몇글자까지 넣을수 있는거냐~~~</td>
						<td>2017-03-23</td>
					</tr>

					<tr>
						<td align="center"><input type="checkbox"></td>
						<td>xxx</td>
						<td>xxx</td>
						<td>xxx</td>
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

이건 블로그에 넣으라고 찾아놓은것 
<a class="btn icon-btn btn-info" href="#"><span class="glyphicon btn-glyphicon glyphicon-plus img-circle text-info"></span>이웃추가</a>
<br><br><br><br><br>
</div>
<!--푸터 START -->
<jsp:include page="/views/main/footer.jsp"/>
<!--푸터 START -->
</body>
</html>