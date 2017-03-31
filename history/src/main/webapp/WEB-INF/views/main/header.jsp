<%@ page import="com.hifive.history.util.PagingUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<style type="text/css">
	img#logo{		/* 로고 윗부분 마진 */
		margin-top: 10px;
	}
	.navbar-login
	{
		width: 350px;
		padding: 10px;
		padding-bottom: 0px;
	}

	.navbar-login-session
	{
		padding: 10px;
		padding-bottom: 0px;
		padding-top: 0px;
	}

	.scrollable-menu {
		height: auto;
		max-height: 200px;
		overflow-x: hidden;
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
			<li class="dropdown" id="followDropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">이웃</a>
				<ul class="dropdown-menu scrollable-menu" role="menu" id="followUl" ></ul>
			</li>
			<li><a href="/chart/control.hi">블로그관리</a></li>
			<li><a href="javascript:do_message(); ">쪽지함</a></li>
			<li><a href="javascript:do_update()">내정보</a></li>
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
    function do_update() {
        var frm = document.updatefrm;
        frm.submit();
    }
    function do_message(){
        var frm = document.messagefrm;
        frm.submit();
    }

    $("#followDropdown").on("click", function (e) {
        dropdownSet();
    });

	function dropdownSet() {
        <c:if test="${!empty sessionScope.user.id }">
            var id = "${sessionScope.user.id}";
        </c:if>
//		var PAGE_NUM = pagenum;
        $("#followUl").empty();
        $.ajax({
            type:"POST",
            url:"/user/followSearch.hi",
            dataType: "html", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
            data: {
                "id": id,
//	            "PAGE_NUM": PAGE_NUM
            },
            success: function (data) {
                // 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.
                var followList = $.parseJSON(data);
                if (followList.length == 0) {
                    $("#followUl").append("<li><a href=\"#\">\"이웃을 추가해보세요!\"</a></li>");
                } else {
                    for (var i = 0; i < followList.length; i++) {
                        var followUrl = "/post/main.hi?id=" + followList[i].ID;
                        $("#followUl").append("<li><a href=\"" + followUrl + "\">" + followList[i].TITLE + "</a></li>");
                    }

//                    // 페이징
//                    var pagingString = paging(followList[0].TOT_CNT, pagenum, 10, 10, "dropdownSet");
//                    $("#followUl").append("<center><table><tr><td style='text-align: center;'>" + pagingString + "</td></tr></table></center>");
//                    $("#followUl").append("<li><div class=\"navbar-login\"><div class=\"row\"><div class=\"col-lg-4\"><p class=\"text-center\"><span class=\"glyphicon glyphicon-user icon-size\"></span></p></div><div class=\"col-lg-8\"><p class=\"text-left\"><strong>Mahesh</strong></p><p class=\"text-left small\">justdemo@gmail.com</p><p class=\"text-left\"><a href=\"#\" class=\"btn btn-primary btn-block btn-sm\">Logout</a></p></div></div></div></li>");
                }
            },
            complete: function (data) {
                // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
            },
            error: function (xhr, status, error) {
                alert("에러발생");
            }
        });
    }

    function paging(maxnum, currpageno, rowperpage, bottomcount, scriptname) {
        var maxNum = 0; // 총 갯수
        var currPageNo = 1; // 현재 페이지 번호 : page_num
        var rowPerPage = 10; // 한페이지에 보여질 행수 : page_size
        var bottomCount = 10; // 바닥에 보여질 페이지 수: 10

        maxNum = maxnum;
        currPageNo = currpageno;
        rowPerPage = rowperpage;
        bottomCount = bottomcount;

        var scriptName = scriptname; // 호출 자바스크립트

        var maxPageNo = ((maxNum - 1) / rowPerPage) + 1;
        var startPageNo = ((currPageNo - 1) / bottomCount) * bottomCount + 1;//
        var endPageNo = ((currPageNo - 1) / bottomCount + 1) * bottomCount;
        var nowBlockNo = ((currPageNo - 1) / bottomCount) + 1;
        var maxBlockNo = ((maxNum - 1) / bottomCount) + 1;

        var inx = 0;
        var html = "";
        if (currPageNo > maxPageNo) {
            return "";
        }
        html = html + "<table border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n";
        html = html + "<tr>\n";
        html = html + "<td class=\"list_num\">\n";
        html = html + "<ul class=\"pagination pagination-sm\">\n";
        // <<
        if (nowBlockNo > 1 && nowBlockNo <= maxBlockNo) {
            html = html + "<li><a href=\"javascript:" + scriptName + "( 1 );\">\n";
            html = html + "&laquo;\n";
            html = html + "</a></li>\n";
        }

        // <
        if (startPageNo > bottomCount) {
            html = html + "<li><a href=\"javascript:" + scriptName + "( " + (startPageNo - 1)+ ");\"> \n";
            html = html + "<        \n";
            html = html + "</a></li>     \n";
        }

        // 1 2 3 ... 10	(숫자보여주기)
        for (inx = startPageNo; inx <= maxPageNo && inx <= endPageNo; inx++) {

            if (inx == currPageNo) {
                html = html + "<li class='active'><a href='#'>" + inx	+ "</a></li>";
            } else {
                html = html + "<li><a href=\"javascript:" + scriptName + "(" + inx+ ");\" class=\"num_text\">" + inx + "</a></li> \n";
            }
        }

        // >
        if (maxPageNo >= inx) {
            html = html + "<li><a href=\"javascript:" + scriptName + "("+ ((nowBlockNo * bottomCount) + 1) + ");\"> \n";
            html = html + ">                       \n";
            html = html + "</a></li>              \n";
        }

        // >>
        if (maxPageNo >= inx) {
            html = html + "<li><a href=\"javascript:" + scriptName + "(" + maxPageNo+ ");\">      \n";
            html = html + "&raquo;     \n";
            html = html + "</a></li>    \n";
        }
        html = html + "</ul>		\n";
        html = html + "</td>  	\n";
        html = html + "</tr>  	\n";
        html = html + "</table>   \n";

        return html;
    }

</script>

<form name="myblogfrm" action="/post/main.hi">
	<input type="hidden" name="id" value="${sessionScope.user.id}">
</form>
<form name="logoutfrm" action="/main/logout.hi"></form>
<form name="loginfrm" action="/main/login.hi" method="post"></form>
<form name="joinfrm" action="/user/join.hi" method="post"></form>
<form name="updatefrm" action="/user/update.hi" method="post"></form>
<form name="messagefrm" action="/message/receive.hi" method="post"></form>