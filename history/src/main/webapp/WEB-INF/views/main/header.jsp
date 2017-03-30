<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		</div>

		<!-- 로그인전 =============================================================================== -->
		<% if (session.getAttribute("user") == null) { %>
		<!-- 오른쪽 로그인/회원가입 버튼 -->
		<ul class="nav navbar-nav navbar-right">
			<li><button class="btn btn-default navbar-btn" onclick="do_login()">Login</button></li>
			<li>&nbsp;&nbsp;&nbsp;</li> <!-- 버튼 사이 공백 넣어주려고 -->
			<li><button class="btn btn-default navbar-btn" onclick="do_join()">Join</button></li>
		</ul>

		<!-- 로그인후 =============================================================================== -->
		<% } else { %>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="javascript:go_myblog();">내블로그</a></li>
			<li><a href="javascript:search_follow();">이웃</a></li>
			<li class="dropdown" id="followDropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">이웃</a>
				<ul class="dropdown-menu" role="menu" id="followUl">
					<li><a href="#">Action</a></li>
					<li><a href="#">Another action</a></li>
					<li><a href="#">Something else here</a></li>
					<li><a href="#">Separated link</a></li>
				</ul>
			</li>
			<li><a href="/chart/control.hi">블로그관리</a></li>
			<li><a href="javascript:do_message(); ">쪽지함</a></li>
			<li><a href="">내정보</a></li>
			<li><a href="javascript:do_logout();" > [${sessionScope.user.name}님] 로그아웃</a></li>
		</ul>
		<% } %>

	</div>
</nav>

<!--페이지이동  -->
<script type="text/javascript">

    function go_myblog() {
        var frm = document.myblogfrm;
        frm.submit();
    }
    function search_follow() {

    }
    function do_logout(){
        var frm = document.logoutfrm;
        frm.submit();
    }
    function do_login(){
        var frm = document.loginfrm;
        frm.submit();
    }
    function do_join(){
        var frm = document.joinfrm;
        frm.submit();
    }
    function do_message(){
        var frm = document.messagefrm;
        frm.submit();
    }
    $("#followDropdown").on("click", function () {
        var id = 0;
        <c:if test="${!empty sessionScope.user.id }">
	        id = ${sessionScope.user.id};
        </c:if>
        alert(id);
        $("#followUl").empty();
//        $.ajax({
//            type:"POST",
//            url:"/user/followSearch.hi",
//            dataType: "html", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
//            data: {
//                "id": id
//            },
//            success: function (data) {
//                // 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.
//                var flag = $.parseJSON(data);
//                if (flag.msg == "true") {
//                    $("#idCheckSuccess").show();
//                    idCheck = true;
//                }
//                $("#followUl").append("<li><a href=\"#\">Action</a></li>")
//                else {
//                    $("#idCheckFail").show();
//                    idCheck = false;
//                }
//
//            },
//            complete: function (data) {
//                // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
//            },
//            error: function (xhr, status, error) {
//                alert("에러발생");
//            }
//        });
    });
</script>

<form name="myblogfrm" action="/post/main.hi">
	<input type="hidden" name="id" value="${sessionScope.user.id}">
</form>
<form name="logoutfrm" action="/main/logout.hi"></form>
<form name="loginfrm" action="/main/login.hi" method="post"></form>
<form name="joinfrm" action="/user/join.hi" method="post"></form>
<form name="messagefrm" action="/message/receive.hi" method="post"></form>