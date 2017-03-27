<%@page import="com.hifive.history.model.PostDto"%>
<%@page import="com.hifive.history.util.PagingUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String PAGE_NUM 	= "1";	// 선택된 페이지
PAGE_NUM 	= request.getAttribute("PAGE_NUM").toString();	// 선택된 페이지
out.print("PAGE_NUM="+PAGE_NUM);
int page_num 		= 1;	// 선택된 페이지
if(PAGE_NUM != null)  page_num  = Integer.parseInt(PAGE_NUM);

int intTotalCount 	= 0;	// 총글수

	List<HashMap<String, Object>> data = new ArrayList<HashMap<String, Object>>();
	data 	   = (ArrayList<HashMap<String, Object>>)request.getAttribute("lists");
	HashMap<String, Object> dataCnt = null;
	
	if(data != null && data.size()>0){
		dataCnt = data.get(0);
		intTotalCount = Integer.parseInt(dataCnt.get("TOT_CNT").toString());
	}	
	
	// 페이지수 구하기
	int pageCount = intTotalCount/5;
	if(intTotalCount%5 != 0) pageCount++;
	
	PostDto DTO = (PostDto)request.getAttribute("DTO");
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Bootstrap CSS -->
<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>여기에 블로그 타이틀이 들어가면 좋겠음</title>

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
	table,th,.tbList{
	text-align: center;
	font-size: 12px;
	}
</style>
<script type="text/javascript">
// 페이징
function do_search_page(url, page_num)
{
	  console.log(url+"\t"+page_num);
	 
	  var frm = document.searchForm;
	  frm.PAGE_NUM.value = page_num;
	  frm.action = url;
	  frm.submit();
}
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
   
   <!--좌측 메뉴 START  -->
      <div class="col-xs-2 mydiv" style="background-color: rgb(255, 191, 191); border-radius: 15px">
         <jsp:include page="menu.jsp"/>
      </div>
   <!--좌측 메뉴 END  -->
   
      <!--내용 START -->
        <div class="col-xs-10 mydiv2" style="background-color: rgb(255, 191, 191);">
	        <div class="col-xs-1"></div>
	        <div class="col-xs-10">
		        <!-- 포스트-->
		        <div class="col-xs-12" style="background-color: rgb(255, 230, 230); margin-top:20px; padding-top: 20px">
		        <!-- 포스트 제목 -->
		        <h2><%=DTO.getTitle() %></h2>
		        <!-- 포스트 작성일 -->
		        <h5><%=DTO.getWdate() %></h5><hr>
		        <!-- 포스트 내용 -->
				<%=DTO.getContent() %>
				</div>
				
				<!-- 태그 부분 -->
				<div class="col-xs-12" style="background-color: rgb(255, 230, 230);">
				<br><br><hr>
				<button type="button" class="btn btn-default btn-sm">
				 <span class="glyphicon glyphicon-tags"></span> 태그
        		</button>&nbsp&nbsp&nbsp&nbsp
        		
<!-- 태그 # 별로 어떻게 자르지????? =============================================================================-->
        		
        		<a href=""><%=DTO.getHashtag() %></a>
       		
        		
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
				
				
<!--글 목록 보여주기  -->
				<div class="col-xs-12" style="background-color: rgb(255, 230, 230); margin-bottom: 20px">
					<table class="table table-hover tbList">
					<tr class="warning">
						<th>글번호</th>
						<th>제목</th>
						<th>작성일</th>
					</tr>

					<%
						if (data.size() > 0) {
					
							for (int i = 0; i < data.size(); i++) {
					
								HashMap<String, Object> mapdatas = (HashMap<String, Object>) (data.get(i));
								String wdate = ((mapdatas.get("WDATE")).toString()).substring(0, 10);
					%>

					<tr>
						<td><%=i+1 %></td>
						<td><%=mapdatas.get("TITLE") %></td>
						<td><%=wdate %></td>
					</tr>
					
					<%} //FOR END
					} // IF END%>					
	

					</table>
					
				<center>
					<!-- Paging Area Start -->
					<%=PagingUtil.renderPaging(intTotalCount, page_num, 5, 5, "main.hi", "do_search_page")%>
					<!-- Paging Area end //--> 					<!--밑에 페이지 갯수 몇개씩 보여줄건지   -->	
				</center>
				
				</div>
	  		</div>
	  		<div class="col-xs-1"></div>
  		</div>
</div>

<!--중간 END -->

<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>
<!--푸터 START -->
</body>
</html>