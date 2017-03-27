<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
	<!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
	
</head>
<body>

<!--헤더 START-->
<jsp:include page="header.jsp"/>
<!--헤더 END-->
<div class="container" >
<br><br><br><br> <!-- 헤더때문에 윗에 공백 넣어주는거임 -->

<!--내용 START -->
<br><br>
<div class="jumbotron">
<h1 align="center">LOGIN</h1>
<br><br>
<div class="col-xs-2"></div>	<!--여백용  -->
	<div class="col-xs-8">
	<input type="text" name="id" class="form-control input-lg" max="20" placeholder="YOUR ID*">
	<br>
	<input type="password" name="password" class="form-control input-lg" max="20" placeholder="YOUR PASSWORD*">
	<br><center>
	<input type="submit" class="btn btn-primary btn-lg btn-block" value="LOGIN" />
	<div class="clearfix"></div><br>	<!-- 줄 띄기  -->
	<a href='join.jsp'>회원가입</a>
</center>
</div>
<div class="col-xs-2"></div><!--여백용  -->

<br><br><br><br>	<!--밑에 여백 맞추려고 br넣었음 -->
<br><br><br><br>
<br><br><br><br>
<br><br><br><br>
</div>
<br>
</div>
<!--내용 END -->

<!--푸터 START -->
<jsp:include page="footer.jsp"/>
<!--푸터 START -->

</body>
</html>