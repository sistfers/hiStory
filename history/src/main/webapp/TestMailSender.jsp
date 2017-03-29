<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TestMailSender</title>
</head>
<body>
	<form action="mail/sender.hi" method="post">
		<!-- 받는 사람 이메일 -->
		<input type="text" name="reciever" value="kalgoorlie@naver.com"
			size="120" style="width: 100%">
		
		<!-- 제목 -->
		<input type="text" name="title" value="hifive"
			size="120" style="width: 100%">

		<!-- 내용 -->
		<textarea name="content" cols="120" rows="12"
			style="width: 100%; resize: none">welcome</textarea>

		<input type="submit" value="메일 보내기">
	</form>

</body>
</html>


