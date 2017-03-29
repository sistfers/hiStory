<%@page import="com.hifive.history.model.CategoryDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	List<CategoryDto> categoryList = (List<CategoryDto>)request.getAttribute("categoryList");
%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS -->
<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>:::::::::::블로그 관리:::::::::::::::</title>
<style type="text/css">
.mydiv{
width:20%;
margin-right:0.5%;http://localhost:8190/chart/comment.hi
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
<jsp:include page="../main/header.jsp"/>
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
	        <div class="col-xs-10" style="margin-top: 20px; margin-bottom : 20px; background-color: rgb(255, 230, 230);">
		       	<p style="font-size: 25px; margin-top: 20px">등록된 카테고리</p>
		        <table class="table" style="margin-top: 10px">
		        	<tr class="info">
						<th>No</th>
						<th>카테고리명</th>
						<th>공개여부</th>
		        	</tr>
		        	<%
		        		for(int i = 0; i < categoryList.size(); ++i){
		        	%>
		        	<tr class="active">
		        		<td><%=categoryList.get(i).getSeq() %></td>
		        		<td><%=categoryList.get(i).getName() %></td>
		        		<td><%=categoryList.get(i).getState().equals("0")?"전체공개":"나만보기" %></td>
		        	</tr>
		        	<%
		        		}
		        	%>
		        	
		        </table>
				<br><br><br>
				
				<form class="form-horizontal" method="post" action="control.hi">
					<fieldset>
						<legend>카테고리 등록</legend>
						<div class="form-group">
							<label for="inputEmail" class="col-lg-2 control-label">카테고리명</label>
							<div class="col-lg-9">
								<input type="text" class="form-control" id="name" name="name"
									placeholder="카테고리명 입력">
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-lg-2 control-label">공개 설정</label>
							<div class="col-lg-9">
									<label class="radio-inline"> <input type="radio" name="state"
										id="optionsRadios1" value="true" checked="">공개
									</label>
								
									<label class="radio-inline"> <input type="radio" name="state"
										id="optionsRadios2" value="false"> 비공개
									</label>
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-lg-offset-9 col-lg-3">
								<button type="reset" class="btn btn-default"> 초기화 </button>
								<button type="submit" class="btn btn-primary"> 추가 </button>
							</div>
						</div>
						
					</fieldset>
				</form>
				<br><br><br>
				
				<form class="form-horizontal" method="post" action="control.hi">
					<fieldset>
						<legend>블로그 설정</legend>
						<div class="form-group">
							<label for="inputEmail" class="col-lg-2 control-label">제목</label>
							<div class="col-lg-9">
								<input type="text" class="form-control" id="title" name="title"
									placeholder="원래 블로거의 제목 불러와 주세요">
							</div>
						</div>
						
						
						<div class="form-group">
							<label for="select" class="col-lg-2 control-label">Selects</label>
							<div class="col-lg-9">
								<br>
								<select multiple="" class="form-control" name="theme">
									<option>1</option>
									<option>2</option>
									<option>3</option>
									<option>4</option>
									<option>5</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-offset-9 col-lg-3">
								<button type="reset" class="btn btn-default">취소</button>
								<button type="submit" class="btn btn-primary">적용</button>
							</div>
						</div>
					</fieldset>
				</form>


				<div class="col-xs-1"></div>
  		</div>
</div>

<!--중간 END -->
</div>

<!--중간 END -->

<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>	
<!--푸터 START -->
</body>
</html>