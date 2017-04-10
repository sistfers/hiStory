<%@page import="com.hifive.history.model.MessageDto"%>
<%@page import="org.omg.CosNaming.NamingContextPackage.NotEmpty"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

MessageDto data = new MessageDto();
String bt_yn 	= "";

int unReadNotes = 0;

if(session.getAttribute("user") != null) {
	if(request.getAttribute("NOTE") != null) {
		data = (MessageDto) request.getAttribute("NOTE");
		
		bt_yn = (String) request.getAttribute("BT_YN");
		
	} else {
		// javascript:history.back()
	}	
	
	if(request.getAttribute("UNREADNOTES") != null) {
		unReadNotes = (Integer) request.getAttribute("UNREADNOTES");
	}
} else {
	response.sendRedirect("../main/login");
}

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>쪽지함</title>
<!-- Bootstrap CSS -->
<link href="/resources/css/bootstrap.css" rel="stylesheet"	type="text/css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

	<!--헤더 START-->
	<jsp:include page="/header.hi"/>
	<!--헤더 END-->
	<div class="container">
		<br> <br> <br> <br>
		<!-- 헤더때문에 윗에 공백 넣어주는거임 -->

		<!-- 좌측메뉴 -->
		<div class="col-xs-2">
		<jsp:include page="menu.jsp" flush="false">
			<jsp:param name="unReadNotes" value="<%=unReadNotes%>" />
		</jsp:include>
		</div>

		<!--내용 START -->
		<div class="col-xs-10" style="min-height: 600px">
			<center>
				<h2>:: 쪽지읽기 ::</h2>
			</center>
			<br>
			<div class="col-xs-1"></div>
			<div class="col-xs-8">
				<form action="writeForm.hi" method="post" class="form-horizontal">
					<input type="hidden" name="SENDID" value="Patricia" /> 
					<input type="hidden" name="TAKEID" value="<%=data.getSend_id() %>"  />
					<input type="hidden" name="NAME"   value="<%=data.getName() %>"/>

					<div class="form-group">
						<label class="col-lg-2 control-label">보낸사람</label>
						<div class="col-lg-10">
							<input type="text" class="form-control" id=TAKE_ID name="TAKE_ID" readonly="readonly"
								value="<%=data.getSend_id()%>(<%=data.getName()%>)" maxlength="30">
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 control-label">보낸날짜</label>
						<div class="col-lg-10">
							<input type="text" class="form-control" id=TAKE_ID name="TAKE_ID" 
								readonly="readonly" value="<%=data.getWdate()%>" maxlength="30">
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 control-label">내용</label>
						<div class="col-lg-10">
							<textarea name="contents" rows="10" class="form-control" readonly="readonly"
								style="resize: none"><%=data.getContents()%></textarea>
						</div>
					</div>

					<div class="form-group">
					<%
						if(bt_yn.equals("bty")) {
					%>
							<button type="submit" class="btn btn-danger col-lg-3 col-md-offset-3">답장</button>
					<%							
						} else {
						
						}
					%>						
						<button type="button" onclick="historyBack()" class="btn btn-default col-lg-3 col-md-offset-1">Cancel</button>
					</div>
				</form>
			</div>
			<div class="col-xs-3"></div>
		</div>
		<br> <br> <br> <br> <br>
		<script type="text/javascript">
		function historyBack() {
			if ( document.referrer && document.referrer.indexOf("http://localhost:8080") != -1 ) { 
				history.back();
			}
			else {			
				location.href = "http://hi-history.com/";
			}
		}
		</script>
	</div>
	<!--푸터 START -->
	<jsp:include page="../main/footer.jsp" />
	<!--푸터 START -->
</body>
</html>


