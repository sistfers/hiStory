<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<style type="text/css">
img#logo{		/* 로고 윗부분 마진 */
margin-top: 10px;
}
</style>

<!-- 네이게이션 바.. 상단고정 -->
<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container">		<!-- 양 옆에 공백 -->
	
		<div class="navbar-header" style="vertical-align: center">
		
		<!-- 왼쪽로고. 클릭시 첫화면으로 이동함 -->
		<a href="/"><img src="/resources/image/logo_sm.png" width="150" id="logo"></a>
		<!-- 검정로고 -->
		</div>
		
		<!-- 로그인전 =============================================================================== -->
		<!-- 오른쪽 로그인/회원가입 버튼 -->
		<ul class="nav navbar-nav navbar-right">
			<li><button class="btn btn-default navbar-btn" onclick="do_login()">Login</button></li>
			<li>&nbsp;&nbsp;&nbsp;</li> <!-- 버튼 사이 공백 넣어주려고 --> 
			<li><button class="btn btn-default navbar-btn" onclick="do_join()">Join</button></li>
		</ul>
		
		<!-- 로그인후 =============================================================================== -->
		<ul class="nav navbar-nav navbar-right">
		<li><a href="#">내블로그</a></li>
		<li><a href="#">내블로그</a></li>
<!-- 		<li><a href="#">내블로그</a></li> -->
<!-- 		<li><a href="#">내블로그</a></li> -->
<!-- 		<li><a href="#">내블로그</a></li> -->
		<li><a href="#">로그아웃</a></li>
		</ul>
			      
			      
	</div>
</nav>

<!--페이지이동  -->
<script type="text/javascript">
function do_logout(){
	var frm = document.frmWrite;	
	frm.submit();
}
function do_login(){
	location.href = "../main/login.jsp";
}
function do_join(){
	location.href = "../user/join.jsp";
}
</script>
