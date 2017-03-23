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
	<div class="col-xs-1"></div>
	<div class="col-xs-8">
	<form class="form-horizontal">
				<div class="form-group" id="divEmail">
					<label for="inputEmail" class="col-lg-2 control-label">받는사람</label>
					<div class="col-lg-8">
						<input type="text" class="form-control" id="email" name="email"
							placeholder="이메일" maxlength="30">
					</div>
					<div class="col-lg-2">
						<button class="btn btn-success btn-block" id="emailCk"
							name="emailCk">인증</button>
					</div>
				</div>
				</div>
</form>
<div class="col-xs-3"></div>
</div>

</div>
<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>	
<!--푸터 START -->
</body>
</html>