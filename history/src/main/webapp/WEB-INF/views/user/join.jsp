<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
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
		var idCheck = false;
		var emailCheck = true;

		$(document).ready(function () {

            $("#id").on({
				focus: function () {
				    idCheck = false;
                    $("#idCheckSuccess").hide();
                    $("#idCheckFail").hide();
                },

	            blur: function () {
                    var id = $("#id").val();
                    if (id != "") {
                        $.ajax({
                            type: "POST",
                            url: "/user/idCheck.hi",
                            dataType: "html", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
                            data: {
                                "id": id
                            },
                            success: function (data) {
                                // 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.
                                var flag = $.parseJSON(data);
                                if (flag.msg == "true") {
                                    $("#idCheckSuccess").show();
                                    idCheck = true;
                                }
                                else {
                                    $("#idCheckFail").show();
                                    idCheck = false;
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
                }
            });
            
            $("#emailCk").on("click", function () {
				alert("이메일을 보내보자~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
				
				var email = $('#email').val();
				alert('내가 입력한 이메일 ' +email);
				
				$.ajax({
                    type: "POST",
                    url: "/user/generated.hi",
                    dataType: "html", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
                    data: {
                        "email": email
                    },
                    success: function (data) {
                        // 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.
                        var flag = $.parseJSON(data);     
                        
                        if (flag.msg == "true") {
                            alert("메일 확인 해주세요~~");
                            
                            var digit = flag.digit;
                            alert("digit " + digit);
                         // alert('나의 인증 번호는 ' +flag.digit);
                            $('#hiddenDigit').val(digit);
                           
                        }
                        /* else {
                            $("#idCheckFail").show();
                            idCheck = false;
                        } */
                    },
                    complete: function (data) {
                        // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
                    },
                    error: function (xhr, status, error) {
                        alert("에러발생");
                    }
                });		
            });

			$("#emailCkaf").on("click", function () {
				alert("인증번호 맞는지 알려줘~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
				
				if($('#hiddenDigit').val() == $('#cknum').val()) {
					alert('맞았어요');
				} else {
					alert('틀렸어요');
				}
				
				
            });

            $("#join").on("click", function () {
                if (joinCheck()) {
                    $("#joinForm").submit();
                }
            });

        });

		function joinCheck() {
		    if ($("#id").val()=="" || $("#email").val()=="" || $("#password").val()=="" || $("#passwordCheck").val()==""
			    || $("#name").val()=="" || $("#birthday").val()=="") {
		        alert("필수 입력 사항을 모두 입력해 주세요.");
		        return false;
		    }
		    if ($("#password").val() != $("#passwordCheck").val()) {
                alert("패스워드가 일치하지 않습니다.");
                return false;
		    }
		    if (idCheck == false) {
		        alert("사용할 수 없는 ID입니다.");
			    return false;
		    }
		    if (emailCheck == false) {
		        alert("이메일이 인증되지 않았습니다.");
			    return false;
		    }
			return true;
        }
	</script>

</head>
<body>

<%
	List<String> areaList = (ArrayList<String>)request.getAttribute("areaList");
%>

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
			<form class="form-horizontal" action="/user/join.hi" method="post" enctype="multipart/form-data" id="joinForm">
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
<!--ajax로 갔다온후 결과 보여주기  -->	<p style="color: green" hidden="hidden" id="idCheckSuccess"> 사용하실 수 있는 ID입니다. </p>
<!--ajax로 갔다온후 결과 보여주기  -->	<p style="color: red" hidden="hidden" id="idCheckFail"> ID가 이미 존재합니다. 다른 ID를 선택하세요. </p>
					</div>
				</div>

				<div class="form-group" id="divEmail">
					<label for="divEmail" class="col-lg-2 control-label">이메일</label>
					<div class="col-lg-8">
						<input type="email" class="form-control" id="email" name="email"
							placeholder="이메일" maxlength="30">
					</div>
					<div class="col-lg-2">
						<button type="button" class="btn btn-success btn-block" id="emailCk"
						        name="emailCk">인증</button>
					</div>
				</div>

				<div class="form-group" id="divEmailConfirm">
					<label for="divEmailConfirm" class="col-lg-2 control-label">인증번호 입력</label>
					<div class="col-lg-8">
						<input type="hidden" id="hiddenDigit" value="" />
						<input type="text" class="form-control" id="cknum" name="cknum"
							placeholder="메일확인후 인증번호를 입력하세요" maxlength="30">
						<p style="color: green" hidden="hidden" id="emailCheckSuccess"> 인증이 완료되었습니다. </p>
						<p style="color: red" hidden="hidden" id="emailCheckFail"> 인증번호가 틀렸습니다. </p>
					</div>
					<div class="col-lg-2">
						<button type="button" class="btn btn-success btn-block" id="emailCkaf"
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
							name="name" data-rule-required="true" placeholder="사용할 닉네임을 입력하세요"
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

				<hr>

				<div class="form-group" id="choose">
				<span class="label label-warning" >선택사항</span>
				</div>

				<div class="form-group" id="divProfileImg">
					<label for="divProfileImg" class="col-lg-2 control-label" style="color: #A6A6A6">프로필사진</label>
					<div class="col-lg-10">
						<img src="/resources/image/girl.png" width="130" name="previewimg" id="previewimg" alt="">
						<input type="file" accept="image/*" id="fileInput" name="profileImg" onchange="loadname(this,'previewimg')" >
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
						<button type="button" class="btn btn-info" id="join">회원가입</button>
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


<script type="text/javascript">
    function loadname(img, previewName){

        var isIE = (navigator.appName=="Microsoft Internet Explorer");
        var path = img.value;
        var default_path = "/resources/image/girl.png";
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
</body>
</html>