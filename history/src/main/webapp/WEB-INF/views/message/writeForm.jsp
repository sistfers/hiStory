<%@page import="com.hifive.history.model.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String SENDID = "";
	String TAKEID = "";
	String NAME   = "";

	HttpSession sesson =request.getSession(false);
	UserDto dto = (UserDto) sesson.getAttribute("user");
	
	if(dto != null) {
		SENDID = dto.getId();
		TAKEID = (String) request.getAttribute("TAKEID");
		NAME   = (String) request.getAttribute("NAME");
		
	} else {
		
	}	
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>쪽지함</title>
	<!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet"	type="text/css" />
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.slim.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
/* 글자 수 체크 */
$(document).ready(function() {
	$(function() {
	    $('#realNote').keyup(function (e){
	        var content = $(this).val();
	        $(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
	        $('#counter').html(content.length + '/300');
	    });
	    $('#realNote').keyup();
	});

    $("#TAKE_ID_CK").on("click", function () {
        $(".modal-body").append("");
        <%--<c:if test="${!empty sessionScope.user.id }">--%>
        <%--var id = "${sessionScope.user.id}";--%>
        <%--</c:if>--%>
        <%--$("#followUl").empty();--%>
        <%--$.ajax({--%>
            <%--type:"POST",--%>
            <%--url:"/user/followSearch.hi",--%>
            <%--dataType: "html", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨--%>
            <%--data: {--%>
                <%--"id": id--%>
            <%--},--%>
            <%--success: function (data) {--%>
                <%--// 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.--%>
                <%--var followList = $.parseJSON(data);--%>
                <%--if (followList.length == 0)--%>
                    <%--$("#followUl").append("<li><a href=\"#\">\"이웃을 추가해보세요!\"</a></li>");--%>
                <%--for (var i = 0; i < followList.length; i++) {--%>
                    <%--var followUrl = "/post/main.hi?id=" + followList[i].ID;--%>
                    <%--$("#followUl").append("<li><a href=\"" + followUrl + "\">" + followList[i].TITLE + "</a></li>");--%>
                <%--}--%>
                <%--$("#followUl").append("<li><div class=\"navbar-login\"><div class=\"row\"><div class=\"col-lg-4\"><p class=\"text-center\"><span class=\"glyphicon glyphicon-user icon-size\"></span></p></div><div class=\"col-lg-8\"><p class=\"text-left\"><strong>Mahesh</strong></p><p class=\"text-left small\">justdemo@gmail.com</p><p class=\"text-left\"><a href=\"#\" class=\"btn btn-primary btn-block btn-sm\">Logout</a></p></div></div></div></li>");--%>
            <%--},--%>
            <%--complete: function (data) {--%>
                <%--// 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.--%>
            <%--},--%>
            <%--error: function (xhr, status, error) {--%>
                <%--alert("에러발생");--%>
            <%--}--%>
        <%--});--%>
    });
});

</script>

<style type="text/css">
	#wrap span {
	    position: absolute;
	    bottom: 5px;
	    right: 20px;
	}

	#counter {
		/* background:rgba(255,0,0,0.5);
		border-radius: 0.5em;
		padding: 0 .5em 0 .5em;
		font-size: 0.75em; */
	}	
}

</style>


</head>
<body>

	<!--헤더 START-->
	<jsp:include page="/header.hi" />
	<!--헤더 END-->
	<div class="container">
		<br> <br> <br> <br>
		<!-- 헤더때문에 윗에 공백 넣어주는거임 -->

		<!-- 좌측메뉴 -->
		<div class="col-xs-2">
			<jsp:include page="menu.jsp" />
		</div>

		<!--내용 START -->
		<div class="col-xs-10">
			<center>
				<h2>:: 쪽지쓰기 ::</h2>
			</center>
			<br>
			<div class="col-xs-1"></div>
			<div class="col-xs-8">
				<form action="write.hi" method="post" class="form-horizontal">
					<input type="hidden" name="SEND_ID" value="<%=SENDID %>" />
					<div class="form-group">
						<label class="col-lg-2 control-label">받는사람</label>
						<div class="col-lg-7">
						<%
						if(TAKEID != null) {
						%>
							<input type="text" class="form-control" id=TAKE_ID name="TAKE_ID"
									placeholder="<%=TAKEID %>(<%=NAME %>)" value="<%=TAKEID %>" maxlength="30">
						<%	
						} else {
						%>	
							<input type="text" class="form-control" id=TAKE_ID name="TAKE_ID"
									placeholder="hifive" maxlength="30">
						<% 
						}
						%>
						</div>
						<div class="col-lg-3">
							<button type="button" class="btn btn-info btn-block" data-toggle="modal" data-target="#myModal" id="TAKE_ID_CK"
							        name="TAKE_ID_CK">
								이웃목록보기
							</button>

							<!-- Modal -->
							<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
											<h4 class="modal-title" id="myModalLabel">이웃 목록</h4>
										</div>
										<div class="modal-body">
											...
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div id="wrap" class="form-group">
						<label class="col-lg-2 control-label">내용</label>
						<div class="col-lg-10">
							<textarea id="realNote" name="NOTE" 
							rows="10" maxlength="300" style="resize: none"
							class="form-control"></textarea>
							<span id="counter">###</span>
						</div>
					</div>

					<div class="form-group">
						<button class="btn btn-primary col-lg-3 col-md-offset-3"
							type="submit">보내기</button>
						<button class="btn btn-default col-lg-3 col-md-offset-1"
							type="reset">Cancel</button>
					</div>

				</form>

			</div>
			<div class="col-xs-3"></div>
		</div>
		<br> <br> <br> <br> <br>
	</div>
	<!--푸터 START -->
	<jsp:include page="../main/footer.jsp" />
	<!--푸터 START -->
</body>
</html>