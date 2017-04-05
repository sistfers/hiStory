<%@page import="com.hifive.history.model.BlogDto"%>
<%@page import="com.hifive.history.model.LoveDto"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.hifive.history.model.UserDto"%>
<%@page import="com.hifive.history.model.PostDto"%>
<%@page import="com.hifive.history.util.PagingUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	// 해시태그 잘라서 보여주기
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
	// 로그인한 세션정보
	UserDto userDto = (UserDto) session.getAttribute("user");

	// 보여질 블로그 id
	String id		= request.getParameter("id");
	
	Date today = new Date();
	
	// 포스트 내용 1건 보여주기
	PostDto DTO = (PostDto)request.getAttribute("DTO");
	
	// 해당글의 댓글 보여주기
	ArrayList commentList = (ArrayList)request.getAttribute("commentList");
	//System.out.println("commentList"+commentList.toString());
	
	int intTotalCount 	= 0;	// 총글수
	int page_num 		= 1;	// 선택된 페이지
	
	List<HashMap<String, Object>> data = new ArrayList<HashMap<String, Object>>();
	data 	   = (ArrayList<HashMap<String, Object>>)request.getAttribute("lists");
	HashMap<String, Object> dataCnt = null;
	
	if(DTO != null){
		String PAGE_NUM 	= "1";	// 선택된 페이지
		PAGE_NUM 	= request.getAttribute("PAGE_NUM").toString();	// 선택된 페이지
		
		if(PAGE_NUM != null)  page_num  = Integer.parseInt(PAGE_NUM);
		
		if(data != null && data.size()>0){
			dataCnt = data.get(0);
			intTotalCount = Integer.parseInt(dataCnt.get("TOT_CNT").toString());
		}	
	}else{
		DTO = new PostDto();
		DTO.setSeq(0);
	}
	
	//해당 포스트에 공감을 했는지 체크
	LoveDto loveCheck = (LoveDto)request.getAttribute("loveCheck");
	
	BlogDto blogdto = (BlogDto)request.getAttribute("blogdto");
	String THEME;
	// 테마 색깔 
	if(blogdto.getTheme().equals("DEFAULT_THEME")){
		THEME = "#747474";
	}else{
		THEME = blogdto.getTheme();
	}
%>    


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
    <!-- jquery -->
    <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<title><%=blogdto.getTitle()%></title>

<style type="text/css">
	.mydiv{						/* 왼쪽 메뉴 영역  */
		width:20%;
		margin-right:0.5%;
		border-radius: 15px;
	}
	.mydiv2{					/* 블로그 내용 영역 */
		width:78%;
		margin-left:0.5%;
		border-radius: 15px;
	}
	table,th{					/* 테이블 내 가운데 정렬 */
		text-align: center;
	}
	.tbList,#commentTable{		/* 글 목록의 글자크기 */
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

<script type="text/javascript">
/* 글 수정 */
function go_update(){
	var frm = document.postUdateForm;
	frm.submit();
}

/* 글 삭제 */ 
function go_delete(){
	var frm = document.postDeleteForm;
	frm.submit();
}

</script>


</head>
<body>
<!--헤더 START-->
<jsp:include page="/header.hi"/>
<!--헤더 END-->




<!-- 메인내용 START -->
   <br><br>
   <div class="container" style="margin-top: 30px">
   
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
		        
				<%
				if(DTO.getSeq() == 0){	// 글 내용 없을때 
				%>	
					<div class="col-xs-12">
							<br><br><br><br><br><br><br><br><br><br><br><br>
							<center><h3>해당 카테고리에 포스트가 없습니다.</h3></center>
							<br><br><br><br><br><br><br><br><br><br><br><br>
					</div>
				<%}else{  %>
	
				<form name="postUdateForm" action="updateDetail.hi" method="get">			<!-- 글수정 -->
					<input type="hidden" name="seq" value="<%=DTO.getSeq()%>">  
					<input type="hidden" name="id" value="<%=id%>">
				</form> 
				<form name="postDeleteForm" action="delete.hi" method="get">				<!-- 글삭제 -->
					<input type="hidden" name="seq" value="<%=DTO.getSeq()%>">
					<input type="hidden" name="id" value="<%=id%>">  
				</form> 
				<form name="postForm" action="main.hi" method="get">						<!-- 페이지 열릴때, 페이지 새로고침할때  -->
					<input type="hidden" name="PAGE_NUM" value="">  
					<input type="hidden" name="id" value="<%=id%>">  
					<input type="hidden" name="seq" value="<%=DTO.getSeq()%>">    
				</form> 


		        <div class="col-xs-12" style="word-wrap : break-word;" >
		        <table width="100%" >
		        <tr>
<!-- 포스트 제목 -->
		        <td width="80%" align="left" >
		        <h2 style="word-wrap : break-word; width: 500px"><%=DTO.getTitle() %></h2>
		        </td>
		        
		        
		        
		        <td width="20%" rowspan="2" >
<!--공감하기  -->
		        <%
		       	 	if (loveCheck != null) {
		        %>
		        	<button class="btn btn-default btn-sm" style="color: red" id="postLove"><h6>♥ 공감취소</h6> </button> 
		        	<input type="hidden" id="loveState" value="loveDelete.hi">
		        <%
		       	 	}else{
		        %>
		       	 	<button class="btn btn-default btn-sm" style="color: red" id="postLove"><h6>♡ 공감</h6> </button>
		       	 	<input type="hidden" id="loveState" value="loveInsert.hi">
		        <%} %>
<!--글 수정/삭제 버튼  -->
				<%if (userDto != null && id.equals(userDto.getId())) {%>
			        <br>
			        <button class="btn btn-danger btn-sm" onclick="javascript:go_update();" style="margin-top: 5px">글수정</button> 
			        <button class="btn btn-danger btn-sm" onclick="javascript:go_delete();" style="margin-top: 5px">글삭제</button>
				<%} %>
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
				
				
<!-- 해시태그 부분 -->
				<div class="col-xs-12" style="margin-bottom: 10px" >
				<hr>
				<button type="button" class="btn btn-default btn-sm disabled">
				 <span class="glyphicon glyphicon-tags"></span> 태그
        		</button>&nbsp;&nbsp;&nbsp;&nbsp;
        		
        		<%
        			if (DTO.getHashtag() != null) {
        				String str[] = split(DTO.getHashtag());
        				for(int i = 0; i < str.length; ++i){
        		%>
        					<a href="#"><%="#" + str[i] %></a>
        		<%
        				}
        			}
        		%>
				</div>
				
<!-- 댓글 ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★-->
				<div class="col-xs-12">
					<h5>댓글</h5>

					<!-- 댓글이 나올 테이블 -->
					<table class="table table-condensed" id="commentTable">
						<%
							if (commentList != null) {
									for (int i = 0; i < commentList.size(); i++) {
										HashMap<String, Object> commentdata = (HashMap<String, Object>) (commentList.get(i));
						%>
						<tr id="r1" name="commentParentCode">
							<%
								if (!commentdata.get("PARENT").toString().equals(commentdata.get("SEQ").toString())) {
							%>
							<!--대댓글  -->
							<td style="width: 1%"><span
								class="glyphicon glyphicon-arrow-right"></span></td>
							<td width=10%>
								<!-- 사진  --> <img src="<%=commentdata.get("PF_IMAGE")%>"
								width="40px" height="40px" onerror="src='/resources/image/noimg.png'">
							</td>

							<%
								if (commentdata.get("STATE").equals("0")) {
							%>
							<!-- if(commentdata.get("STATE").equals("0") || (userDto != null && userDto.getId().equals(commentdata.get("ID"))) ) {%> -->
							<!-- 작성자/작성일 -->
							<td width="69%" style="text-align: left;" name="contentsTd"><a href="#"> <%=commentdata.get("NAME")%>
							</a> <%=commentdata.get("WDATE")%><br> <!-- 댓글내용 --> <span name="contentsSpan"><%=commentdata.get("CONTENT")%></span>
							</td>

							<td width="20%" align="right" id="<%=commentdata.get("SEQ")%>">
								<%
									if (userDto != null && userDto.getId().equals(commentdata.get("ID"))) {
								%>
								<button class="btn btn-default btn-xs" style="font-size: 12px"
									name="pUp">수정</button>
								<button class="btn btn-default btn-xs" style="font-size: 12px"
									name="pDel">삭제</button> <%
							 	}
							%>
							</td>
							<%
								} else if (commentdata.get("STATE").equals("1")) {
													if (userDto != null && userDto.getId().equals(commentdata.get("ID"))) {
							%>
							<!-- 작성자/작성일 -->
							<td width="69%" style="text-align: left;" name="contentsTd"><a href="#"> <%=commentdata.get("NAME")%>
							</a> <%=commentdata.get("WDATE")%><br> <!-- 댓글내용 --> <span
								class="glyphicon glyphicon-lock"></span><span name="contentsSpan"><%=commentdata.get("CONTENT")%></span>
							</td>

							<td width="20%" align="right" id="<%=commentdata.get("SEQ")%>">

								<%
									if (userDto != null && userDto.getId().equals(commentdata.get("ID"))) {
								%>
								<button class="btn btn-default btn-xs" style="font-size: 12px"
									name="pUp">수정</button>
								<button class="btn btn-default btn-xs" style="font-size: 12px"
									name="pDel">삭제</button> <%
							 	}
							 %>
							</td>

							<%
								} else {
							%>
							<td colspan="2" align="left" style="color: #8C8C8C;"><span
								class="glyphicon glyphicon-lock"></span> 비밀글입니다</td>
							<%
								}
							%>
							<%
								} else if (commentdata.get("STATE").equals("2")) { //if end
							%>
							<td colspan="2" align="left" style="color: #BDBDBD;"><span
								class="glyphicon glyphicon-fire"></span> 삭제된 댓글입니다</td>
							<%
								} //if end
							%>


							<%
								} else {
							%>
							<!--댓글  -->
							<td width=11% colspan=2 align="left">
								<!-- 사진  --> <img src="<%=commentdata.get("PF_IMAGE")%>"
								width="40px" height="40px" onerror="src='/resources/image/noimg.png'">
							</td>

							<%
								if (commentdata.get("STATE").equals("0")) {
							%>

							<!-- 작성자/작성일 -->
							<td width="69%" style="text-align: left;" name="contentsTd"><a href="#"> <%=commentdata.get("NAME")%>
							</a> <%=commentdata.get("WDATE")%><br> <!-- 댓글내용 --> <span name="contentsSpan"><%=commentdata.get("CONTENT")%></span>
							</td>

							<td width="20%" align="right" id="<%=commentdata.get("SEQ")%>">
								<c:set var='login' value="${sessionScope.user}" /> <c:if
									test="${!empty login}">
									<!-- 로그인정보 없으면 안보임 -->
									<button class="btn btn-default btn-xs" style="font-size: 12px"
										name="pAdd">답글</button>
									<%
										if (userDto != null && userDto.getId().equals(commentdata.get("ID"))) {
									%>
									<button class="btn btn-default btn-xs" style="font-size: 12px"
										name="pUp">수정</button>
									<button class="btn btn-default btn-xs" style="font-size: 12px"
										name="pDel">삭제</button>
									<%
										}
									%>
								</c:if>
							</td>
							<%
								} else if (commentdata.get("STATE").equals("1")) {
													if (userDto != null && userDto.getId().equals(commentdata.get("ID"))) {
							%>
							<!-- 작성자/작성일 -->
							<td width="69%" style="text-align: left;" name="contentsTd"><a href="#"> <%=commentdata.get("NAME")%>
							</a> <%=commentdata.get("WDATE")%><br> <!-- 댓글내용 --> <span
								class="glyphicon glyphicon-lock"></span><span name="contentsSpan"><%=commentdata.get("CONTENT")%></span>
							</td>

							<td width="20%" align="right" id="<%=commentdata.get("SEQ")%>">

								<%
									if (userDto != null && userDto.getId().equals(commentdata.get("ID"))) {
								%>
								<button class="btn btn-default btn-xs" style="font-size: 12px"
									name="pUp">수정</button>
								<button class="btn btn-default btn-xs" style="font-size: 12px"
									name="pDel">삭제</button> <%
 	}
 %>
							</td>

							<%
								} else {
							%>
							<td colspan="2" align="left" style="color: #8C8C8C;"><span
								class="glyphicon glyphicon-lock"></span> 비밀글입니다</td>
							<%
								}
							%>
							<%
								} else if (commentdata.get("STATE").equals("2")) { //if end
							%>
							<td colspan="2" align="left" style="color: #BDBDBD;"><span
								class="glyphicon glyphicon-fire"></span> 삭제된 댓글입니다</td>
							<%
								} //if end
							%>





						</tr>
						<%
							}
						%>
						<%
							} //for end 
								} // if end
						%>
					</table>
					<%-- <center> 우선 페이징 없이 20개씩 보여주기 했는데... 댓글 페이징은 천천히 합시다 
<!-- Paging Area Start -->
<%=PagingUtil.renderPaging(intTotalCount, page_num, 5, 5, "main.hi", "do_search_page")%>
<!-- Paging Area end //--> 					<!--밑에 페이지 갯수 몇개씩 보여줄건지   -->	
</center> --%>



					<!-- 로그인 정보 없으면 댓글창 안보여줌 -->
					<c:set var='login' value="${sessionScope.user}" />
					<c:if test="${!empty login}">
						<table class="table table-condensed">
							<!-- 기본 댓글 입력창(맨아래) -->
							<tr>
								<td width="11%"><img src="${sessionScope.user.pf_image}"
									width="40px" height="40px"></td>
								<td width="69%"><textarea rows="2" class="form-control"
										style="resize: none" id="commentParentText"></textarea></td>
								<td width="20%" align="left"><input type="checkbox"
									id="STATE" name="STATE" value="1"> 비밀글<br>
									<button type="button" id="commentParentSubmit"
										name="commentParentSubmit" class="btn btn-danger">댓글입력</button>
								</td>
							</tr>
						</table>
					</c:if>
				</div>



				<!--글 목록 보여주기 ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ -->
				<div class="col-xs-12">
					<table class="table table-hover tbList">
					<tr class="warning">
						<th width="10%">글번호</th>
						<th width="70%" >제목</th>
						<th width="20%">작성일</th>
					</tr>

					<%
						if (data != null) {
					
							for (int i = 0; i < data.size(); i++) {
					
								HashMap<String, Object> mapdatas = (HashMap<String, Object>) (data.get(i));
								String wdate = ((mapdatas.get("WDATE")).toString()).substring(0, 10);
					%>
					<tr>
						<td><%=i+1 %></td>
						<td align="left">
						<div style="text-overflow : ellipsis; width: 400px; overflow: hidden;">
							<a href="/post/main.hi?seq=<%=mapdatas.get("SEQ") %>&id=<%=id%>"> <%=mapdatas.get("TITLE") %></a>
							<%--style="cursor:pointer; --%>
						</div></td>
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
<%} //if end %>	

	  		</div>
	  		<div class="col-xs-1"></div>
  		</div>
</div>

<!--메인내용 END -->



























<script type="text/javascript">
$(function(){
	
// 글 공감 ajax
	$("#postLove").bind("click", function() {
		 
		var loveState = document.getElementById('loveState').value;

		$.ajax({
			type:"POST",
			url:loveState,			// 컨트롤러에 보낼 이름
			dataType:"html",
			data:{
				"seq" 	: <%=DTO.getSeq()%>,
				
			},
			success:function(data){
				console.log("data"+data);
				var flag = $.parseJSON(data);
				
				if (flag.msg=="intrue") {	
					document.getElementById('postLove').innerHTML ="<h6>♥ 공감취소</h6>";
					document.getElementById('loveState').value = "loveDelete.hi";
				}else if(flag.msg=="deltrue") {	
					document.getElementById('postLove').innerHTML ="<h6>♡ 공감</h6>";
					document.getElementById('loveState').value = "loveInsert.hi";
				}

			},
			complete : function(data) {
				// 실패, 성공 상관없이 무조건 수행
			},
			error:function(){
				 alert("로그인이 필요하다아아아~~!!!");
			}
		});  
		
	});

       
//제일 하단에 있는 depth1의 댓글을 다는 이벤트=========================================================
    $("#commentParentSubmit").click(function( event ) {
           
        var pText = $("#commentParentText");
        // true면 비밀글임(상태 1로 넣어야 함)
        var stateYN = $("input[name='STATE']").is(":checked")==true;   
           
        console.log("true면 비밀글임 stateYN = " + stateYN);
        
        if($.trim(pText.val())==""){
            alert("내용을 입력하세요.");
            pText.focus();
            return;
        }
		var d = new Date();
		var today =    d.getFullYear() + "-" +
					("00" + (d.getMonth() + 1)).slice(-2) + "-" +
					("00" + d.getDate()).slice(-2) +
	 				("00" + d.getHours()).slice(-2) + ":" +
					("00" + d.getMinutes()).slice(-2) + ":" +
					("00" + d.getSeconds()).slice(-2)					
					
        // 댓글로 들어갈 내용
        var commentParentText = '<tr id="r1" name="commentParentCode">'+
                                '<td colspan=2 width=11% align="left">'+
                                '<img src="${sessionScope.user.pf_image}" width="40px" height="40px">'+
                                '</td>'+
                                '<td width="69%" style="text-align: left;" name="contentsTd">'+
                                '</span> <a href="#">${sessionScope.user.name}</a> '+today+' <br> '+
                                pText.val().replace(/\n/g, "<br>")+'</td>'+
                                '<td width="20%" align="right">'+
                                '<button class="btn btn-default btn-xs" style="font-size: 12px;margin-right:4px;" name="pAdd">답글</button>'+
                                '<button class="btn btn-default btn-xs" style="font-size: 12px;margin-right:4px;" name="pUp">수정</button>'+
                                '<button class="btn btn-default btn-xs" style="font-size: 12px;margin-right:4px;" name="pDel">삭제</button>'+
                                '</td>'+
                                '</tr>';
           
        $.ajax({
			type:"POST",
			url:"replyInsert.hi",			// 컨트롤러에 보낼 이름
			dataType:"html",
			data:{
				"POST_SEQ" 	: <%=DTO.getSeq()%>,
 				"STATE"	 	: stateYN,
				"CONTENT" 	: pText.val()
			},
			success:function(data){
				console.log("data"+data);
				var flag = $.parseJSON(data);
				
				if (flag.msg=="true") {			// 댓글이 정상적으로 insert되면 화면에 보여주기
					//테이블의 tr자식이 있으면 tr 뒤에 붙인다. 없으면 테이블 안에 tr을 붙인다.
			        if($('#commentTable tr').size()==0){
			            $('#commentTable').append(commentParentText);
			        }else{
			            $('#commentTable tr:last').after(commentParentText);
			        }
			           
			        $("#commentParentText").val("");
			        //location.reload();
				} else {
					alert("댓글등록 실패");
				}
			},
			complete : function(data) {
				// 실패, 성공 상관없이 무조건 수행
			},
			error:function(){
				 alert("에러냐아아앙!!! ");
			}
		});  
    });
       
//댓글의 댓글을 다는 이벤트 ====================================================================================
    $(document).on("click","#commentChildSubmit", function(){
           
    	console.log("댓글부모번호2="+$(this).parent().attr('id'));
    	
        var cText = $("#commentChildText");
        var stateYN = $("input[name='STATE']").is(":checked")==true;   
        
        console.log("true면 비밀글임 stateYN = " + stateYN);
        
        var d = new Date();
		var today =    d.getFullYear() + "-" +
					("00" + (d.getMonth() + 1)).slice(-2) + "-" +
					("00" + d.getDate()).slice(-2) +
					("00" + d.getHours()).slice(-2) + ":" +
					("00" + d.getMinutes()).slice(-2) + ":" +
					("00" + d.getSeconds()).slice(-2)	
           
        if($.trim(cText.val())==""){
            alert("내용을 입력하세요. 대댓글!!");
            cText.focus();
            return;
        }
					
					
        // 대댓글로 들어갈 내용
        var commentChildText = '<tr name="commentChildCode">'+
        						'<td style="width:1%"><span class="glyphicon glyphicon-arrow-right"></span></td> '+
                                '<td width=10% align="left">'+
                                '<img src="${sessionScope.user.pf_image}" width="40px" height="40px">'+
                                '</td>'+
                                '<td width="69%" style="text-align: left;" name="contentsTd">'+
                                '</span> <a href="#">${sessionScope.user.name}</a> '+today+' <br> '+
                                cText.val().replace(/\n/g, "<br>")+'</td>'+
                                '<td width="20%" align="right">'+
                                '<button class="btn btn-default btn-xs" style="font-size: 12px;margin-right:4px;" name="pUp">수정</button>'+
                                '<button class="btn btn-default btn-xs" style="font-size: 12px;margin-right:4px;" name="pDel">삭제</button>'+
                                '</td>'+
                                '</tr>';
                                
                                
        
        $.ajax({
			type:"POST",
			url:"rereInsert.hi",			// 컨트롤러에 보낼 이름
			dataType:"html",
			data:{
				"POST_SEQ" 	: <%=DTO.getSeq()%>,
				"PARENT"	: $(this).parent().attr('id'),
 				"STATE"	 	: stateYN,
				"CONTENT" 	: cText.val()
			},
			success:function(data){
				console.log("data"+data);
				var flag = $.parseJSON(data);
				
				if (flag.msg=="true") {			// 댓글이 정상적으로 insert되면 화면에 보여주기

	 				  //var prevTr = $(this).parent().parent().parent().parent().prev();
// 				        //댓글 적는 에디터 삭제
// 				        $("#commentEditor").remove();//여기에서 삭제를 해줘야 에디터tr을 안 찾는다.
				           
//  				        //댓글을 타고 올라가며 부모 tr을 찾음
// 				        while(prevTr.attr("name")!="commentParentCode"){
// 				            prevTr = prevTr.prev();
// 				        } 
				        
// 				        //while를 타는지 체크
// 				        var check = false;
				        
// 				        //다음 노드가 댓글(depth1)의 댓글인지 찾기위해 next
// 				        var nextTr = prevTr.next();
				        
//  				        //뒤에 댓글(depth1)의 댓글(depth2_1)이 없다면 바로 붙인다.
// 				        if(nextTr.attr("name")!="commentChildCode"){
// 				            prevTr.after(commentChildText);
// 				        }else{
// 				            //댓글(depth1)의 댓글(depth2_n)이 있는경우 마지막까지 찾는다.
// 				            while(nextTr.attr("name")=="commentChildCode"){
// 				                nextTr = nextTr.next();
// 				                check = true;
// 				            }
// 				        } 
				           
// 				        if(check){//댓글(depth1)의 댓글(depth2_n)이 있다면 그 댓글(depth2_n) 뒤에 댓글(depth2_n+1) 추가
// 				            nextTr = nextTr.prev();//while문에서 검색하느라 next로 넘거갔던거 다시 앞으로 돌려줌
// 				            nextTr.after(commentChildText);
// 				        } 
	 				 	
					setTimeout(location.reload.bind(location), 1);
				} else {
					alert("댓글등록 실패");
				}
			},
			complete : function(data) {
				// 실패, 성공 상관없이 무조건 수행
			},
			error:function(){
				 alert("에러냐아아앙!!! ");
			}
		});                                
           
           
    });
       
       
    //답글 눌렀을때 에디터 창을 뿌려주는 이벤트, 삭제링크를 눌렀을때 해당 댓글을 삭제하는 이벤트
    $(document).on("click","table#commentTable button", function(){//동적으로 버튼이 생긴 경우 처리 방식

        if($(this).attr("name")=="pDel"){
        	console.log("댓글번호"+$(this).parent().attr('id'));
        	
            if (confirm("정말 삭제하시겠습니까?") == true){    //확인
                   
                var delComment = $(this).parent().parent();
                var nextTr = delComment.next();
                var delTr;
                
                $.ajax({
        			type:"POST",
        			url:"replyDelete.hi",			// 컨트롤러에 보낼 이름
        			dataType:"html",
        			data:{
        				"seq" 	: $(this).parent().attr('id')
        			},
        			success:function(data){
        				console.log("data"+data);
        				var flag = $.parseJSON(data);
        				
        				if (flag.msg=="true") {			// 댓글이 정상적으로 insert되면 화면에 보여주기

        	                //댓글(depth1)의 댓글(depth2_1)이 있는지 검사하여 삭제
        	                while(nextTr.attr("name")=="commentCode"){
        	                    nextTr = nextTr.next();
        	                    delTr = nextTr.prev();//삭제하고 넘기면 삭제되서 없기 때문에 다음값을 가져오기 어려워 다시 앞으로 돌려서 찾은 다음 삭제
        	                    delTr.remove();
        	                }
        	                   
        	                delComment.remove();
        				} else {
        					alert("댓글삭제 실패");
        				}
        			},
        			complete : function(data) {
        				// 실패, 성공 상관없이 무조건 수행
        			},
        			error:function(){
        				 alert("에러냐아아앙!!! ");
        			}
        		});  
                
            }else{   //취소
                return;
            }
        }else if($(this).attr("name")=="pAdd"){
             //자기 부모의 tr을 알아낸다.
            var parentElement = $(this).parent().parent();
            
            console.log("댓글부모번호 ="+$(this).parent().attr('id'));
            
            //댓글달기 창을 없앤다.
            $("#commentEditor").remove();
            	
            //부모의 하단에 댓글달기 창을 삽입
            var commentEditor = '<tr id="commentEditor">'+
                                '<td style="width:1%"><span class="glyphicon glyphicon-arrow-right"></span></td>'+
                                '<td style="width:10%">'+
                                '<img src="${sessionScope.user.pf_image}" width="40px" height="40px"></td>'+
                                '<td width="69%">'+
                                '<textarea rows="2" class="form-control" style="resize: none" id="commentChildText"></textarea>'+
                                '</td>'+
                                '<td width="20%" align="left" id="'+$(this).parent().attr('id')+'">'+
                                '<input type="checkbox" id="STATE" name="STATE" value="1"> 비밀글<br>'+
                                '<button type="button" id="commentChildSubmit" name="commentChildSubmit" class="btn btn-warning">답글입력</button>'+
                                '</td>'+
                                '</tr>';
                                   
            parentElement.after(commentEditor); 
        }else if($(this).attr("name")=="pUp"){
            //자기 부모의 tr을 알아낸다.
            var parentElement = $(this).parent().parent();
            
            console.log("본인댓글번호 ="+$(this).parent().attr('id'));
            var thisContents = parentElement.find("[name=contentsTd]").find("[name=contentsSpan]").html();
            console.log("댓글 내용 = " + thisContents);
            
            //댓글달기 창을 없앤다.
            $("#commentEditor").remove();
            	
            //부모의 하단에 댓글달기 창을 삽입
            var commentEditor = '<tr id="commentEditor">'+
                                '<td style="width:1%"><span class="glyphicon glyphicon-arrow-right"></span></td>'+
                                '<td style="width:10%">'+
                                '<img src="${sessionScope.user.pf_image}" width="40px" height="40px"></td>'+
                                '<td width="69%">'+
                                '<textarea rows="2" class="form-control" style="resize: none" id="commentChildText">' + thisContents + '</textarea>'+
                                '</td>'+
                                '<td width="20%" align="left" id="'+$(this).parent().attr('id')+'">'+
                                '<input type="checkbox" id="STATE" name="STATE" value="1"> 비밀글<br>'+
                                '<button type="button" id="commentChildSubmit" name="commentChildSubmit" class="btn btn-warning">수정</button>'+
                                '</td>'+
                                '</tr>';
                                   
            parentElement.after(commentEditor); 
        }
           
    });
       
});

</script>







<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>
<!--푸터 START -->
</body>
</html>