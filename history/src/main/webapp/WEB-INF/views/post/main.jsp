<%@page import="com.hifive.history.model.PostDto"%>
<%@page import="com.hifive.history.util.PagingUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	public String[] split(String str){
		int count = 0;
		for(int i = 0; i < str.length(); ++i){
			if(str.charAt(i)=='#'){
				++count;
			}
		}
		if(count!=0){
			count = count-1;
		}
		String hashString[] = new String[count];
		for(int i = 0; i < hashString.length; ++i){
			hashString[i]="";
		}
		int start = 0;
		for(int i = 1; i < str.length(); ++i){
			if(str.charAt(i)!='#'){
				hashString[start]+=str.charAt(i);
			}else{
				++start;
			}
		}
		return hashString;
	}
%>
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
	
	//String THEME = "#FFFFDE";		// 노랑
	//String THEME = "#C6E8FF";		// 하늘
	//String THEME = "#DAD9FF";		// 보라
	//String THEME = "#FFD8D8";		// 살구
	String THEME = "#8C8C8C";		// 회색
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
	table,th{
		text-align: center;
	}
	.tbList{
		font-size: 13px;
	}
</style>
<script type="text/javascript">
// 페이징
function do_search_page(url, page_num)
{
	  console.log(url+"\t"+page_num);
	 
	  var frm = document.postForm;
	  frm.PAGE_NUM.value = page_num;
	  frm.action = url;
	  frm.submit();
}
</script>	

<!--  --><script type="text/javascript">
/* 글 수정으로 이동(글 번호 가져가야함) */
function go_update(){
	var frm = document.postupdateForm;
	frm.submit();
}

/* 글 삭제 */ /* 어디로 가서 어떻게 처리해야하지? ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ */
function go_delete(){
}
</script>
</head>
<body>
<!--헤더 START-->
<jsp:include page="../main/header.jsp"/>
<!--헤더 END-->


<!-- 중간 START -->
   <br><br><br><br>
   <div class="container" >
   
   <!--좌측 메뉴 START  -->
      <div class="col-xs-2 mydiv" style="background-color: <%=THEME %>; border-radius: 15px">
         <jsp:include page="/post/menu.hi"/>
      </div>
   <!--좌측 메뉴 END  -->
   
      <!--내용 START -->
        <div class="col-xs-10 mydiv2" style="background-color: <%=THEME %>">
	        <div class="col-xs-1"></div>
	        <div class="col-xs-10" style="background-color: #FCFCFC; margin-top:20px; margin-bottom: 20px; border-radius: 15px">
	        
<!-- 글 내용 ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★-->	         
<form name="postupdateForm" action="update.hi" method="get">		
<input type="hidden" name="seq" value="<%=DTO.getSeq()%>">  
</form> 

<form name="postForm" action="main.hi" method="get">		
<input type="hidden" name="PAGE_NUM" value="">     
</form> 
		        <div class="col-xs-12">
		        
		        <table width="100%" >
		        <tr>
		        <!-- 포스트 제목 -->
		        <td width="80%" align="left" ><h2><%=DTO.getTitle() %></h2> 
		        
		        </td>
		        <td width="20%" rowspan="2" >
		        
		        <!--공감하기  -->
		        <button class="btn btn-default btn-sm" style="color: red"><span class="glyphicon glyphicon-heart"></span> &nbsp;공감 (1)</button> 
				

		        <!--글 수정하기 버튼  -->
		        <br><br>
		        <button class="btn btn-danger btn-sm" onclick="javascript:go_update();">글수정</button> 
		        <button class="btn btn-danger btn-sm" onclick="javascript:go_delete();">글삭제</button>
		        
		        </td>		        
		        </tr>
		        
		        <!-- 포스트 작성일 -->
		        <tr>
		        <td align="left"><h6>&nbsp;&nbsp;<%=DTO.getWdate() %></h6></td>
		        <td></td>
		        </tr>
		        </table>
		        
				<hr>		        
		        <!-- 포스트 내용 -->
				<%=DTO.getContent() %>
				</div>
				
				<!-- 태그 부분 -->
				<div class="col-xs-12" >
				<hr>
				<button type="button" class="btn btn-default btn-sm disabled">
				 <span class="glyphicon glyphicon-tags"></span> 태그
        		</button>&nbsp&nbsp&nbsp&nbsp
        		
        		<%
        			String str[] = split(DTO.getHashtag());
        			for(int i = 0; i < str.length; ++i){
        		%>
        		<a href=""><%="#" + str[i] %></a>
        		<%
        			}
        		%>
				</div>
				
<!-- 댓글 ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★-->				
				<div class="col-xs-12">
				<br><br>
				<table class="table table-striped" id="commentTable">
					<tr>
						<th width="10%">댓글 3</th>
						<th width="70%"></th>
						<th width="20%"></th>
					</tr>
					<tr>
						<td><img src="/resources/image/1.png" width="50px" height="50px"></td>
						<td style="text-align: left;">
							<a href="">우정관</a> 2017-03-23 23:11:24<br>
							요리하기 넘나 어려워요,,,,ㅎㅎ도와줘요 한조!
						</td>
						<td align="left">
						<button class="btn btn-default btn-xs" style="font-size: 12px">답글</button>
						<button class="btn btn-default btn-xs" style="font-size: 12px">수정</button>
						<button class="btn btn-default btn-xs" style="font-size: 12px">삭제</button>
						</td>
					</tr>
					<tr>
						<td><img src="/resources/image/1.png" width="50px" height="50px"></td>
						<td>
							<textarea rows="2" class="form-control" style="resize: none"></textarea>
						</td>
						<td align="left">
						<input type="checkbox"> 비밀글<br>
						<button type="button" class="btn btn-danger">댓글입력</button>
						</td>
					</tr>			
				</table>
				</div>
				
				
				
				
				
				
				
				
				
<!--글 목록 보여주기 ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ -->
				<div class="col-xs-12">
					<table class="table table-hover tbList" >
					<tr class="warning">
						<th width="10%">글번호</th>
						<th width="70%">제목</th>
						<th width="20%">작성일</th>
					</tr>

					<%
						if (data.size() > 0) {
					
							for (int i = 0; i < data.size(); i++) {
					
								HashMap<String, Object> mapdatas = (HashMap<String, Object>) (data.get(i));
								String wdate = ((mapdatas.get("WDATE")).toString()).substring(0, 10);
					%>
					<tr>
						<td><%=i+1 %></td>
						<td align="left"><%=mapdatas.get("TITLE") %></td>
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