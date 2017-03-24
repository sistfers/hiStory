<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS -->
<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>:::::::::::post_main:::::::::::::::</title>
<style type="text/css">
.mydiv{
width:20%;
margin-right:0.5%;
border-radius: 15px;
}
.mydiv2{
width:78%;
margin-left:0.5%;
border-radius: 15px;
}
</style>
</head>
<body>
<!--헤더 START-->
<jsp:include page="/views/main/header.jsp"/>
<!--헤더 END-->

<!-- 
태마 버전
그린 : rgb(224, 239, 208) / rgb(251, 255, 247)
 -->
<!-- 중간 START -->
   <br><br><br><br>
   <div class="container" >
      <div class="col-xs-2 mydiv" style="background-color: rgb(255, 191, 191); border-radius: 15px">
         <jsp:include page="menu.jsp"/>
      </div>
      <!--내용 START -->
        <div class="col-xs-10 mydiv2" style="background-color: rgb(255, 191, 191);">
	        <div class="col-xs-1"></div>
	        <div class="col-xs-10">
		        <!-- 포스트-->
		        <div class="col-xs-12" style="background-color: rgb(255, 230, 230); margin-top:20px; padding-top: 20px">
		        <!-- 포스트 제목 -->
		        <h2>알고리즘_10한수</h2>
		        <!-- 포스트 작성일 -->
		        <h5>2017-03-22 18:22:05</h5><hr>
		        <!-- 포스트 내용 -->
				이거슨 아주 귀여운 문제로 123이라는 수 이면 각 자리수가 1씩증가한다.
				 즉, 등차가 1인 등차수열이라고 할수있다
				이러한 수를 문제에서는 한수라고 정의한다.<br>
				 따라서, 각자리수를 저장하고 n의자리수-(n-1)의 자리수의 차가 모두 일정하다면 한수라는 말이다.<br>
				이와 같이 접근하여, 다음과 같이 나왔다!!!<br>
				</div>
				
				<!-- 태그 부분 -->
				<div class="col-xs-12" style="background-color: rgb(255, 230, 230);">
				<br><br><hr>
				<button type="button" class="btn btn-default btn-sm">
				 <span class="glyphicon glyphicon-tags"></span> 태그
        		</button>&nbsp&nbsp&nbsp&nbsp
        		<a href="">#백준</a>&nbsp&nbsp
        		<a href="">#알고리즘</a>&nbsp&nbsp
        		<a href="">#문제풀기</a>&nbsp&nbsp
        		<a href="">#한수</a>&nbsp&nbsp
				</div>
				
				<div class="col-xs-12" style="background-color: rgb(255, 230, 230)">
				<br><br>
				<table class="table">
					<tr class="active">
						<th>댓글 3</th>
						<th></th>
						<th></th>
					</tr>
					<tr>
						<td><img src="/resources/image/1.png" width="50px" height="50px"></td>
						<td style="text-align: left;">
							<a href="">haengtion93</a> 2017-03-23 23:11:24<br>
							UI짜기 넘나 어려워요,,,,ㅎㅎ도와줘요 한조!
						</td>
						<td>
						<a href="">답글</a>
						<a href="">수정</a>
						<a href="">삭제</a>
						</td>
					</tr>	
					<tr>
						<td><img src="/resources/image/1.png" width="50px" height="50px"></td>
						<td style="text-align: left;">
							<a href="">근혜공주</a> 2017-03-23 23:11:24<br>
							재취업 넘나 어려워요,,,,ㅎㅎ도와줘요 한조!
						</td>
						<td>
						<a href="">답글</a>
						<a href="">수정</a>
						<a href="">삭제</a>
						</td>
					</tr>
					<tr>
						<td><img src="/resources/image/1.png" width="50px" height="50px"></td>
						<td style="text-align: left;">
							<a href="">우정관</a> 2017-03-23 23:11:24<br>
							요리하기 넘나 어려워요,,,,ㅎㅎ도와줘요 한조!
						</td>
						<td>
						<a href="">답글</a>
						<a href="">수정</a>
						<a href="">삭제</a>
						</td>
					</tr>
					<tr>
						<td><img src="/resources/image/1.png" width="50px" height="50px"></td>
						<td>
							<textarea rows="3" class="form-control" style="resize: none"></textarea>
						</td>
						<td>
						<button type="button" class="btn btn-default">comment</button>
						</td>
					</tr>			
				</table>
				</div>
				
				<div class="col-xs-12" style="background-color: rgb(255, 230, 230); margin-bottom: 20px">
					<table class="table">
					<tr class="active">
						<th>글번호</th>
						<th>제목</th>
						<th>작성일</th>
					</tr>
					<tr>
						<td>1</td>
						<td>코딩이 제일 쉬웠어요!</td>
						<td>2017.03.22</td>
					</tr>
					<tr>
						<td>2</td>
						<td>푸딩이 제일 쉬웠어요!</td>
						<td>2017.03.21</td>
					</tr>
					<tr>
						<td>3</td>
						<td>초딩이 제일 쉬웠어요!</td>
						<td>2017.03.21</td>
					</tr>		
					</table>
					<h6 align="center"> << < 1 2 3 4 5 > >></h6>
				</div>
				
	  		</div>
	  		<div class="col-xs-1"></div>
  		</div>
</div>

<!--중간 END -->

<!--푸터 START -->
<jsp:include page="/views/main/footer.jsp"/>
<!--푸터 START -->
</body>
</html>