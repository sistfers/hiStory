<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
	<!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<script type="text/javascript">
		$(document).ready(function () {
			$("#id").blur(function () {
				alert("AAAAA");
            });
        });
	</script>

</head>
<body>

<!--헤더 START-->
<jsp:include page="/header.hi"/>
<!--헤더 END-->
<div class="container" >
<br><br><br><br> <!-- 헤더때문에 윗에 공백 넣어주는거임 -->

<!--내용 START -->
<h1 align="center">회원가입</h1>
<br>
<div class="col-xs-2"></div>	<!--여백용  -->
	<div class="col-xs-8" >
	
		<!-- form명 바꾸면 안되요 : id, name꼭 다시 확인하세요.. 중복된 이름이 있을수도 있음  -->
			<form class="form-horizontal" action="/user/join.hi" method="post">
				<input type="hidden" name="do_join" value="do_join">
				<div class="form-group" >
					<span class="label label-danger">필수입력사항</span>
				</div>

				<div class="form-group" id="divId">
					<label for="divId" class="col-lg-2 control-label">ID</label>
					<div class="col-lg-10">
						<input type="text" class="form-control onlyHangul" id="id"
							name="id" data-rule-required="true" placeholder="원하는ID를 입력하세요"
							maxlength="20">
<!--ajax로 갔다온후 결과 보여주기  -->	<p style="color: red" hidden="hidden" id="idCheck"> ID가 이미 존재합니다. 다른ID를 선택하세요 </p>
					</div>
				</div>

				<div class="form-group" id="divEmail">
					<label for="divEmail" class="col-lg-2 control-label">이메일</label>
					<div class="col-lg-8">
						<input type="email" class="form-control" id="email" name="email"
							placeholder="이메일" maxlength="30">
					</div>
					<div class="col-lg-2">
						<button class="btn btn-success btn-block" id="emailCk"
							name="emailCk">인증</button>
					</div>
				</div>

				<div class="form-group" id="divEmailConfirm">
					<label for="divEmailConfirm" class="col-lg-2 control-label">인증번호 입력</label>
					<div class="col-lg-8">
						<input type="text" class="form-control" id="cknum" name="cknum"
							placeholder="메일확인후 인증번호를 입력하세요" maxlength="30">
					<p style="color: green" hidden="hidden" id="emailCheck"> 인증완료 되었습니다 </p>
					</div>
					<div class="col-lg-2">
						<button class="btn btn-success btn-block" id="emailCkaf"
							name="emailCkaf">확인</button>
					</div>
				</div>

				<div class="form-group" id="divPassword">
					<label for="divPassword" class="col-lg-2 control-label">패스워드</label>
					<div class="col-lg-10">
						<input type="password" class="form-control" id="password"
							name="password" data-rule-required="true" placeholder="패스워드"
							maxlength="20">
					</div>
				</div>

				<div class="form-group" id="divPasswordCheck">
					<label for="divPasswordCheck" class="col-lg-2 control-label">패스워드
						확인</label>
					<div class="col-lg-10">
						<input type="password" class="form-control" id="passwordCheck"
							data-rule-required="true" placeholder="패스워드 확인" maxlength="20">
					</div>
				</div>

				<div class="form-group" id="divName">
					<label for="divName" class="col-lg-2 control-label">닉네임</label>
					<div class="col-lg-10">
						<input type="text" class="form-control onlyHangul" id="name"
							name="name" data-rule-required="true"
							maxlength="20">
					</div>
				</div>

				<div class="form-group" id="divbirthday">
					<label for="divbirthday" class="col-lg-2 control-label">생년월일</label>
					<div class="col-lg-10">
						<%--<input type="text" class="form-control" id="birthday"--%>
							<%--name="birthday" data-rule-required="true"--%>
							<%--placeholder="YYYY/DD/MM" maxlength="20">--%>
						<input type="date" class="form-control" id="birthday" name="birth">
					</div>
				</div>

				<div class="form-group">
					<label class="col-lg-2 control-label" for="select">지역</label>
					<div class="col-lg-10">
						<select class="form-control" id="select" name="area">
							<option>서울</option>
							<option>서울</option>
							<option>서울</option>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label class="col-lg-2 control-label" for="select">성별</label>
					<div class="col-lg-10">
						<div class="btn-group btn-group-justified">
							<button class="btn btn-default">남</button> 
							<button class="btn btn-default">여</button>
						</div>
					</div>
				</div>

<!--아래내용은 라디오 버튼인데.... 위에서 버튼으로 값 넘기는거 못하면 라디오 버튼으로 하세요 ㅋㅋ  -->
				<!-- 				<div class="form-group"> -->
<!-- 					<label class="col-lg-2 control-label">성별</label> -->
<!-- 					<div class="col-lg-10"> -->
<!-- 						<div class="radio"> -->
<!-- 							<label> <input name="optionsRadios" id="optionsRadios1" -->
<!-- 								type="radio" checked="" value="option1"> 남 -->
<!-- 							</label> -->
<!-- 						</div> -->
<!-- 						<div class="radio"> -->
<!-- 							<label> <input name="optionsRadios" id="optionsRadios2" -->
<!-- 								type="radio" value="option2"> 여 -->
<!-- 							</label> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->

				<hr>

				<div class="form-group" id="choose">
				<span class="label label-warning" >선택사항</span>
				</div>

				<div class="form-group" id="divProfileImg">
					<label for="divProfileImg" class="col-lg-2 control-label" style="color: #A6A6A6">프로필사진</label>
					<div class="col-lg-10">
					<img src="/resources/image/girl.png" width="130"><!--사진 첨부터 보여줄건지는 알아서 ㅋㅋ  -->
						<input type="button" class="btn btn-default" value="사진등록" name="profileImg">
					</div>
				</div>

				<div class="form-group" id="divProfileCon">
					<label for="divProfileCon" class="col-lg-2 control-label" style="color: #A6A6A6">프로필내용</label>
					<div class="col-lg-10">
						<input type="text" class="form-control" id="profile"
							name="profileCon" data-rule-required="true" placeholder="안녕하세요."
							maxlength="20">
					</div>
				</div>
				<hr>		<!-- 구분선 -->

				<div class="col-xs-2"></div>	<!--여백용  -->

				<!-- 회원가입/취소 버튼 -->
				<div class="form-group" align="center">
						<button type="submit" class="btn btn-info">회원가입</button>
						<button type="reset" class="btn btn-default">취소</button>
				</div>
			</form>
	</div>
</div>

<br><br>
<!--내용 END -->

<!--푸터 START -->
<jsp:include page="/WEB-INF/views/main/footer.jsp"/>
<!--푸터 START -->



</body>
</html>