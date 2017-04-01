<%@page import="com.hifive.history.model.BlogDto"%>
<%@page import="com.hifive.history.model.UserDto"%>
<%@page import="com.hifive.history.model.CategoryDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	List<CategoryDto> categoryList = (List<CategoryDto>)request.getAttribute("categoryList");
	if(session.getAttribute("user")!=null){
		UserDto user = (UserDto)session.getAttribute("user");
	}
	
	BlogDto blogdto = (BlogDto)request.getAttribute("blogdto");
%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS -->
<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>:::::::::::블로그 관리::::::::!!!:::::::</title>
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
<script>
	$(document).ready(function name() {
		$("#categoryTable tr").click(function trclick() {
			var id = $(this).attr("id");
			var name = $(this).eq(0).find("td").eq(1).text();
			var state = $(this).eq(0).find("td").eq(2).text();
			alert(" [ " + name + " ] 카테고리를 수정하시 겠습니까??? " + state);
			//$("#output").attr("value") = name;
			$("#catename").val(name);
			$("#cateseq").val(id);
			/* state=="전체공개"?$("#optionsRadios1").attr("checked",true):$("#optionsRadios2").attr("checked",true); */
			if(state=="전체공개"){
				$("#optionsRadios1").attr("checked",true);
				$("#optionsRadios2").attr("checked",false);
			}else{
				$("#optionsRadios2").attr("checked",true);
				$("#optionsRadios1").attr("checked",false);
			}
	})
});
</script>
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
		       	
		       	<p style="font-size: 25px; margin-top: 20px; margin-bottom: 20px">등록된 카테고리</p>
		       	<div class="col-xs-12" style="background-color: white; padding-bottom: 20px; padding-top: 20px;">
		        <div class="col-xs-6" style="overflow: scroll;overflow-x:hidden; height: 300px; ">
		       	<table class="table table-striped table-hover" id="categoryTable">
		        	<tr class="info">
						<th>No</th>
						<th>카테고리명</th>
						<th>공개여부</th>
		        	</tr>
		        	<%
		        		for(int i = 0; i < categoryList.size(); ++i){
		        	%>
		        	<tr class="active" id="<%=categoryList.get(i).getSeq() %>">
		        		<td><%=i+1 %></td>
		        		<td><%=categoryList.get(i).getName() %></td>
		        		<td><%=categoryList.get(i).getState().equals("0")?"전체공개":"나만보기" %></td>
		        	</tr>
		        	<%
		        		}
		        	%>
		        </table>
				</div>
				<div class="col-xs-6" style="height: 200px;" >
				<form class="form-horizontal" method="post" action="control.hi" id="ouput" name="output">
						<div class="form-group">
							<br><br><br><br>
							<label for="inputEmail" class="col-lg-4 control-label">카테고리</label>
							<div class="col-lg-6">
								<input type="text" class="form-control" id="catename" name="catename"
									placeholder="카테고리명 입력" value="">
								<input type="hidden" id="cateseq" name="cateseq" value="">
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-lg-4 control-label">공개 설정</label>
							<div class="col-lg-6">
									<label class="radio-inline"> <input type="radio" name="catestate"
										id="optionsRadios1" value="true" >공개
									</label>
								
									<label class="radio-inline"> <input type="radio" name="catestate"
										id="optionsRadios2" value="false" > 비공개
									</label>
							</div>
						</div>
						<br>
						<div class="form-group">
							<div class="col-lg-offset-3 col-lg-9">
								<button type="reset" class="btn btn-warning"> 삭제 </button>
								
								<button type="submit" class="btn btn-primary"> 수정 </button>
							</div>
						</div>
				</form>
				</div>
				</div>
				<div class="col-xs-12" style="margin-top: 50px; ">
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
										id="optionsRadios1" value="true">공개
									</label>
								
									<label class="radio-inline"> <input type="radio" name="state"
										id="optionsRadios2" value="false"> 비공개
									</label>
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-lg-offset-9 col-lg-3">
								<button type="reset" class="btn btn-default"> 리셋 </button>
								<button type="submit" class="btn btn-primary"> 추가 </button>
							</div>
						</div>
						
					</fieldset>
				</form>
				</div>
				
				<div class="col-xs-12">
				<form class="form-horizontal" method="post" action="control.hi">
					<fieldset>
						<legend>블로그 설정</legend>
						<div class="form-group">
							<label for="inputEmail" class="col-lg-2 control-label">제목</label>
							<div class="col-lg-9">
								<input type="text" class="form-control" id="title" name="title"
									value="<%=blogdto.getTitle()%>">
							</div>
						</div>
						
						
						<div class="form-group">
							<label for="select" class="col-lg-2 control-label">테마설정</label>
							<div class="col-lg-9">
								<br>
								<select multiple="" class="form-control" name="theme">
									<option style="background-color: #cee1ff; text-align: center;" value="#f7e3a3"></option>
									<option style="background-color: #cefffb; text-align: center;" value="#baffcc"></option>
									<option style="background-color: #ceffd7; text-align: center;" value="#bac5ff"></option>
									<option style="background-color: #f8ffce; text-align: center;" value="#debaff"></option>
									<option style="background-color: #ffceeb; text-align: center;" value="#ffbae2"></option>
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
				</div>

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