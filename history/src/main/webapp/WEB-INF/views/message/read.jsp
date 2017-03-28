<%@page import="com.hifive.history.model.MessageDto"%>
<%@page import="org.omg.CosNaming.NamingContextPackage.NotEmpty"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	MessageDto data = new MessageDto();
	data = (MessageDto) request.getAttribute("note");
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>쪽지함</title>
<!-- Bootstrap CSS -->
<link href="/resources/css/bootstrap.css" rel="stylesheet"
	type="text/css" />
</head>
<body>

	<!--헤더 START-->
	<jsp:include page="../main/header.jsp" />
	<!--헤더 END-->
	<div class="container">
		<br>
		<br>
		<br>
		<br>
		<!-- 헤더때문에 윗에 공백 넣어주는거임 -->

		<!-- 좌측메뉴 -->
		<div class="col-xs-2">
			<jsp:include page="menu.jsp" />
		</div>

		<!--내용 START -->
		<div class="col-xs-10">
			<center>
				<h2>:: 쪽지읽기 ::</h2>
			</center>
			<br>
			<div class="col-xs-1"></div>
			<div class="col-xs-8">
				<form action="message/write.hi" method="post" class="form-horizontal">
					<div class="form-group">
						<label class="col-lg-2 control-label">보낸사람</label>
						<div class="col-lg-7">
							<input type="text" class="form-control" id=TAKE_ID name="TAKE_ID"
								placeholder="<%=data.getSend_id() %>" maxlength="30">
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 control-label">내용</label>
						<div class="col-lg-10">
							<textarea rows="10" class="form-control" style="resize: none"><%=data.getContents()%></textarea>
						</div>
					</div>

					<div class="form-group">
						<button class="btn btn-primary col-lg-3 col-md-offset-3"
							type="submit">답장</button>
						<button class="btn btn-default col-lg-3 col-md-offset-1"
							type="reset">Cancel</button>
					</div>
				</form>
			</div>
			<div class="col-xs-3"></div>
		</div>
		<br>
		<br>
		<br>
		<br>
		<br>
	</div>
	<!--푸터 START -->
	<jsp:include page="../main/footer.jsp" />
	<!--푸터 START -->
</body>
</html>


