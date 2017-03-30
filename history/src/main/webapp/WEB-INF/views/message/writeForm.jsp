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

<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.slim.min.js"></script>
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

<!-- Bootstrap CSS -->
<link href="/resources/css/bootstrap.css" rel="stylesheet"
	type="text/css" />
</head>
<body>

	<!--헤더 START-->
	<jsp:include page="../main/header.jsp" />
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
							<button class="btn btn-info btn-block" id="TAKE_ID_CK"
								name="TAKE_ID_CK">이웃목록보기</button>
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