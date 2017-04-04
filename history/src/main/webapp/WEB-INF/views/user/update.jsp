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
            if ($("#email").val()=="" || $("#password").val()=="" || $("#passwordCheck").val()==""
                || $("#name").val()=="" || $("#birthday").val()=="") {
                alert("빈칸이 존재합니다");
                return false;
            }
            if ($("#password").val() != $("#passwordCheck").val()) {
                alert("패스워드가 일치하지 않습니다.");
                return false;
            }
            if (emailCheck == false) {
                alert("이메일이 인증되지 않았습니다.");
                return false;
            }
            return true;
        }

        function loadname(img, previewName, defaultImagePath){
            var isIE = (navigator.appName=="Microsoft Internet Explorer");
            var path = img.value;
            var default_path = defaultImagePath;
            var ext = path.substring(path.lastIndexOf('.') + 1).toLowerCase();
            var incorrect = "";

            if (ext == "gif" || ext == "jpeg" || ext == "jpg" ||  ext == "png" ) {
                if (isIE) {
                    $('#'+ previewName).attr('src', path);
                } else {
                    if (img.files[0]) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            $('#'+ previewName).attr('src', e.target.result);
                        }
                        reader.readAsDataURL(img.files[0]);
                    }
                }

            } else if (ext != "") {
                $('#'+ previewName).attr('src', default_path);
                if (isIE) {
                    $('#fileInput').replaceWith( $('#fileInput').clone(true) );
                } else {
                    $('#fileInput').val("");
                }
                incorrect += "파일 형식이 올바르지 않습니다.";
                alert(incorrect);

            } else {
                $('#'+ previewName).attr('src', default_path);
                incorrect += "incorrect file type";
            }

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
	String grades[] = {"몽땅연필", "색연필", "만년필"};
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
		<form class="form-horizontal" action="/user/update.hi" method="post" id="updateForm" enctype="multipart/form-data">
			<input type="hidden" name="do_update" value="do_update">
			<div class="form-group" >
				<span class="label label-danger">개인정보</span>
			</div>

			<div class="form-group" id="divId">
				<label for="divId" class="col-lg-2 control-label">ID</label>
				<div class="col-lg-10">
					<input type="text" class="form-control onlyHangul" id="id"
					       name="id" value="<%=user_id %>" readonly="readonly"
					       maxlength="20">
					<!--ajax로 갔다온후 결과 보여주기  -->	<p style="color: green" hidden="hidden" id="idCheckSuccess"> 사용하실 수 있는 ID입니다. </p>
					<!--ajax로 갔다온후 결과 보여주기  -->	<p style="color: red" hidden="hidden" id="idCheckFail"> ID가 이미 존재합니다. 다른 ID를 선택하세요. </p>
				</div>
			</div>

			<div class="form-group" id="divEmail">
				<label for="divEmail" class="col-lg-2 control-label">이메일</label>
				<div class="col-lg-10">
					<input type="email" class="form-control" id="email" name="email"
					       placeholder="이메일" maxlength="30" value="<%=user_email%>" readonly="readonly">
				</div>
			</div>

			<div class="form-group" id="divGrade">
				<label for="divGrade" class="col-lg-2 control-label">등급</label>
				<div class="col-lg-10">
					<input type="text" class="form-control" id="grade" name="grade"
					       placeholder="등급" maxlength="30" value="<%=grades[Integer.parseInt(user_grade)]%>" readonly="readonly">
				</div>
			</div>

			<div class="form-group" id="divPassword">
				<label for="divPassword" class="col-lg-2 control-label">패스워드</label>
				<div class="col-lg-10">
					<input type="password" class="form-control" id="password"
					       name="password" data-rule-required="true" placeholder="패스워드" maxlength="20" value="<%=user_password%>">
				</div>
			</div>

			<div class="form-group" id="divPasswordCheck">
				<label for="divPasswordCheck" class="col-lg-2 control-label">패스워드
					확인</label>
				<div class="col-lg-10">
					<input type="password" class="form-control" id="passwordCheck"
					       data-rule-required="true" placeholder="패스워드 확인" maxlength="20" value="<%=user_password%>">
				</div>
			</div>

			<div class="form-group" id="divName">
				<label for="divName" class="col-lg-2 control-label">닉네임</label>
				<div class="col-lg-10">
					<input type="text" class="form-control onlyHangul" id="name"
					       name="name" data-rule-required="true" placeholder="사용할 닉네임을 입력하세요"
					       maxlength="20" value="<%=user_name%>">
				</div>
			</div>

			<div class="form-group" id="divbirthday">
				<label for="divbirthday" class="col-lg-2 control-label">생년월일</label>
				<div class="col-lg-10">
					<input type="text" class="form-control" id="birthday" name="birth"
					value="<%=user_birth%>" readonly="readonly">
				</div>
			</div>

			<div class="form-group">
				<label class="col-lg-2 control-label" for="select">지역</label>
				<div class="col-lg-10">
					<select class="form-control" id="select" name="area">
						<%
							for (String area : areaList) {
						%>
						<option <%if(user_area.equals(area)){%> selected="selected"<%} %>><%=area%></option>
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
							<input type="radio" name="sex" id="male" autocomplete="off" value="0" <%if (user_sex.equals("0")){%>checked<%}%> >
							남
						</label>
						<label class="btn btn-default">
							<input type="radio" name="sex" id="femail" autocomplete="off" value="1" <%if (user_sex.equals("1")){%>checked<%}%> >
							여
						</label>
					</div>
				</div>
			</div>

			<hr>

			<div class="form-group" id="choose">
				<span class="label label-warning" >프로필</span>
			</div>

			<div class="form-group" id="divProfileImg">
				<label for="divProfileImg" class="col-lg-2 control-label" style="color: #A6A6A6">프로필사진</label>
				<div class="col-lg-10">
					<img src="<%=user_pf_img%>" width="130" name="previewimg" id="previewimg" alt="">
					<input type="file" accept="image/*" id="fileInput" name="profileImg" onchange="loadname(this,'previewimg', '<%=user_pf_img%>')" >
				</div>
			</div>

			<div class="form-group" id="divProfileCon">
				<label for="divProfileCon" class="col-lg-2 control-label" style="color: #A6A6A6">프로필내용</label>
				<div class="col-lg-10">
					<input type="text" class="form-control" id="profile"
						name="profileCon" data-rule-required="true" placeholder="안녕하세요."
						maxlength="20" value="<%=user_pf_con%>">
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