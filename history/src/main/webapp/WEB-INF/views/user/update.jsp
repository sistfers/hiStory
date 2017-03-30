<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hifive.history.model.UserDto" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>회원정보수정</title>
	<!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<script type="text/javascript">
        var emailCheck = true;

        $(document).ready(function () {

            $("#emailCkaf").on("click", function () {
                alert("aaa");
            });

            $("#update").on("click", function () {
                if (joinCheck()) {
                    $("#updateForm").submit();
                }
            });

        });

        function joinCheck() {
            /* if ($("#email").val()=="" || $("#password").val()=="" || $("#passwordCheck").val()==""
                || $("#name").val()=="" || $("#birthday").val()=="") {
                alert("필수 입력 사항을 모두 입력해 주세요.");
                return false;
            }
            if ($("#password").val() != $("#passwordCheck").val()) {
                alert("패스워드가 일치하지 않습니다.");
                return false;
            }
            if (emailCheck == false) {
                alert("이메일이 인증되지 않았습니다.");
                return false;
            } */
            return true;
        }
	</script>

</head>
<body>

<%
	List<String> areaList = (ArrayList<String>)request.getAttribute("areaList");
	UserDto user = (UserDto)session.getAttribute("user");
	String user_id = user.getId();
	String user_name = user.getName();
	String user_password = user.getPassword();
	String user_area = user.getArea();
	String user_birth = user.getBirth();
	String user_email = user.getEmail();
	String user_sex = user.getSex();
	String user_pf_con = user.getPf_content();
	String user_pf_img = user.getPf_image();
	String user_grade = user.getGrade();
%>

<!--헤더 START-->
<jsp:include page="/header.hi"/>
<!--헤더 END-->
<div class="container" >
	<br><br><br><br> <!-- 헤더때문에 윗에 공백 넣어주는거임 -->

	<!--내용 START -->
	<h1 align="center">회원정보수정</h1>
	<br>
	<div class="col-xs-2"></div>	<!--여백용  -->
	<div class="col-xs-8" >

		<!-- form명 바꾸면 안되요 : id, name꼭 다시 확인하세요.. 중복된 이름이 있을수도 있음  -->
		<form class="form-horizontal" action="/user/update.hi" method="post" id="updateForm">
			<input type="hidden" name="do_update" value="do_update">
			<div class="form-group" >
				<span class="label label-danger">개인정보</span>
			</div>

			<div class="form-group" id="divId">
				<label for="divId" class="col-lg-2 control-label">ID</label>
				<div class="col-lg-10">
					<input type="text" class="form-control onlyHangul" id="id"
					       name="id" value="<%=user.getId() %>" readonly="readonly"
					       maxlength="20">
					<!--ajax로 갔다온후 결과 보여주기  -->	<p style="color: green" hidden="hidden" id="idCheckSuccess"> 사용하실 수 있는 ID입니다. </p>
					<!--ajax로 갔다온후 결과 보여주기  -->	<p style="color: red" hidden="hidden" id="idCheckFail"> ID가 이미 존재합니다. 다른 ID를 선택하세요. </p>
				</div>
			</div>

			<div class="form-group" id="divEmail">
				<label for="divEmail" class="col-lg-2 control-label">이메일</label>
				<div class="col-lg-10">
					<input type="email" class="form-control" id="email" name="email"
					       placeholder="이메일" maxlength="30" value="<%=user.getEmail()%>" readonly="readonly">
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
					       name="name" data-rule-required="true" placeholder="사용할 닉네임을 입력하세요"
					       maxlength="20" value="<%=user.getName()%>">
				</div>
			</div>

			<div class="form-group" id="divbirthday">
				<label for="divbirthday" class="col-lg-2 control-label">생년월일</label>
				<div class="col-lg-10">
					<%--<input type="text" class="form-control" id="birthday"--%>
					<%--name="birthday" data-rule-required="true"--%>
					<%--placeholder="YYYY/DD/MM" maxlength="20">--%>
					<input type="text" class="form-control" id="birthday" name="birth" 
					value="<%=user.getBirth()%>" readonly="readonly">
				</div>
			</div>

			<div class="form-group">
				<label class="col-lg-2 control-label" for="select">지역</label>
				<div class="col-lg-10">
					<select class="form-control" id="select" name="area">
						<%
							for (String area : areaList) {
						%>
						<option><%=area%></option>
						<%
							}
						%>
					</select>
				</div>
			</div>

			<div class="form-group">
				<label class="col-lg-2 control-label" for="select">성별</label>
				<div class="col-lg-10">
					<div class="btn-group" data-toggle="buttons">
						<label class="btn btn-default active">
							<input type="radio" name="sex" id="male" autocomplete="off" value="0" checked>
							남
						</label>
						<label class="btn btn-default">
							<input type="radio" name="sex" id="femail" autocomplete="off" value="1">
							여
						</label>
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
				<span class="label label-warning" >프로필</span>
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
					       name="profileCon" data-rule-required="true"
					       maxlength="20" value="<%=user.getPf_content()%>">
				</div>
			</div>
			<hr>		<!-- 구분선 -->

			<div class="col-xs-2"></div>	<!--여백용  -->

			<!-- 회원가입/취소 버튼 -->
			<div class="form-group" align="center">
				<button type="button" class="btn btn-info" id="update">수정완료</button>
				<button type="reset" class="btn btn-default">취소</button>
			</div>
		</form>
	</div>
</div>

<br><br>
<!--내용 END -->

<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>
<!--푸터 START -->



</body>
</html>