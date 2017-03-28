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
    <!-- jquery -->
    <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>

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
   <br><br>
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
<!-- 				<h5>댓글</h5> -->
				
				<!-- 댓글이 나올 테이블 -->
				<table class="table" id="commentTable table-condensed"></table>
					
					<!-- <tr id="r1" name="commentParentCode"> -->
					<!-- <td style="width:1%"><span class="glyphicon glyphicon-arrow-right"></span></td> -->
					
					
<!-- 					<tr> -->
<!-- 						<td><img src="/resources/image/1.png" width="50px" height="50px"></td> -->
<!-- 						<td style="text-align: left;"> -->
<!-- 							<a href="">우정관</a> 2017-03-23 23:11:24<br> -->
<!-- 							요리하기 넘나 어려워요,,,,ㅎㅎ도와줘요 한조! -->
<!-- 						</td> -->
<!-- 						<td align="left"> -->
<!-- 						<button class="btn btn-default btn-xs" style="font-size: 12px">답글</button> -->
<!-- 						<button class="btn btn-default btn-xs" style="font-size: 12px">수정</button> -->
<!-- 						<button class="btn btn-default btn-xs" style="font-size: 12px">삭제</button> -->
<!-- 						</td> -->
<!-- 					</tr> -->


					<table class="table table-condensed">
					<!-- 기본 댓글 입력창(맨아래) -->
					<tr>
						<td width="10%"><img src="/resources/image/1.png" width="50px" height="50px"></td>
						<td width="70%">
							<textarea rows="2" class="form-control" style="resize: none" id="commentParentText"></textarea>
						</td>
						<td width="20%" align="left">
						<input type="checkbox" id="STATE" name="STATE" value="1"> 비밀글<br>
						<button type="button" class="btn btn-danger" id="commentParentSubmit" name="commentParentSubmit">댓글입력</button>
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



<!-- 댓글/대댓글 -->
<script type="text/javascript">
$(function(){
       
    //제일 하단에 있는 depth1의 댓글을 다는 이벤트
    $("#commentParentSubmit").click(function( event ) {
    	
           
        var pText = $("#commentParentText");
        // true면 비밀글임(상태 1로 넣어야 함)
        var stateYN = $("input[name='STATE']").is(":checked")==true;        
           
        console.log("check stateYN " + stateYN);
        
        if($.trim(pText.val())==""){
            alert("내용을 입력하세요.");
            pText.focus();
            return;
        }
        
        var commentParentText = '<tr id="r1" name="commentParentCode">'+
                                '<td width="10%"><img src="/resources/image/1.png" width="50px" height="50px"></td>'+
                                '<td width="70%" style="text-align: left;">'+
                                '<a href="#">댓글작성자</a> 작성일 2017-03-23 23:11:24 <br>'+
                                pText.val().replace(/\n/g, "<br>")+'</td>'+
                                '<td width="20%" align="left">'+
                                '<button class="btn btn-default btn-xs" style="font-size: 12px">답글</button>'+
                                '<button class="btn btn-default btn-xs" style="font-size: 12px">수정</button>'+
                                '<button class="btn btn-default btn-xs" style="font-size: 12px">삭제</button>'+
                                '</td>'+
                                '</tr>';
           
        //테이블의 tr자식이 있으면 tr 뒤에 붙인다. 없으면 테이블 안에 tr을 붙인다.
        if($('#commentTable').contents().size()==0){
            $('#commentTable').append(commentParentText);
        }else{
            $('#commentTable tr:last').after(commentParentText);
        }
           
        $("#commentParentText").val("");
           
    });
       
//     //댓글의 댓글을 다는 이벤트
//     $(document).on("click","#commentChildSubmit", function(){
           
//         var cName = $("#commentChildName");
//         var cPassword = $("#commentChildPassword");
//         var cText = $("#commentChildText");
           
//         if($.trim(cName.val())==""){
//             alert("이름을 입력하세요.");
//             cName.focus();
//             return;
//         }else if($.trim(cPassword.val())==""){
//             alert("패스워드를 입력하세요.");
//             cPassword.focus();
//             return;
//         }else if($.trim(cText.val())==""){
//             alert("내용을 입력하세요.");
//             cText.focus();
//             return;
//         }
           
//         var commentChildText = '<tr name="commentChildCode">'+
//                                     '<td style="width:1%"><span class="glyphicon glyphicon-arrow-right"></span></td>'+
//                                     '<td style="width:99%">'+
//                                         '<strong>'+cName.val()+'</strong> '+cPassword.val()+' <a style="cursor:pointer;" name="cAdd">답글</a> | <a style="cursor:pointer;" name="cDel">삭제</a>'+
//                                         '<p>'+cText.val().replace(/\n/g, "<br>")+'</p>'+
//                                     '</td>'+
//                                 '</tr>';
                                   
//         //앞의 tr노드 찾기
//         var prevTr = $(this).parent().parent().parent().parent().prev();
//         //댓글 적는 에디터 삭제
//         $("#commentEditor").remove();//여기에서 삭제를 해줘야 에디터tr을 안 찾는다.
           
//         //댓글을 타고 올라가며 부모 tr을 찾음
//         while(prevTr.attr("name")!="commentParentCode"){
//             prevTr = prevTr.prev();
//         }
//         //while를 타는지 체크
//         var check = false;
//         //다음 노드가 댓글(depth1)의 댓글인지 찾기위해 next
//         var nextTr = prevTr.next();
//         //뒤에 댓글(depth1)의 댓글(depth2_1)이 없다면 바로 붙인다.
//         if(nextTr.attr("name")!="commentChildCode"){
//             prevTr.after(commentChildText);
//         }else{
//             //댓글(depth1)의 댓글(depth2_n)이 있는경우 마지막까지 찾는다.
//             while(nextTr.attr("name")=="commentChildCode"){
//                 nextTr = nextTr.next();
//                 check = true;
//             }
//         }
           
//         if(check){//댓글(depth1)의 댓글(depth2_n)이 있다면 그 댓글(depth2_n) 뒤에 댓글(depth2_n+1) 추가
//             nextTr = nextTr.prev();//while문에서 검색하느라 next로 넘거갔던거 다시 앞으로 돌려줌
//             nextTr.after(commentChildText);
//         }
           
//     });
       
//     //답글링크를 눌렀을때 에디터 창을 뿌려주는 이벤트, 삭제링크를 눌렀을때 해당 댓글을 삭제하는 이벤트
//     $(document).on("click","table#commentTable a", function(){//동적으로 버튼이 생긴 경우 처리 방식
           
//         if($(this).attr("name")=="pDel"){
//             if (confirm("답글을 삭제 하시면 밑에 답글도 모두 삭제 됩니다. 정말 삭제하시겠습니까?") == true){    //확인
                   
//                 var delComment = $(this).parent().parent();
//                 var nextTr = delComment.next();
//                 var delTr;
//                 //댓글(depth1)의 댓글(depth2_1)이 있는지 검사하여 삭제
//                 while(nextTr.attr("name")=="commentCode"){
//                     nextTr = nextTr.next();
//                     delTr = nextTr.prev();//삭제하고 넘기면 삭제되서 없기 때문에 다음값을 가져오기 어려워 다시 앞으로 돌려서 찾은 다음 삭제
//                     delTr.remove();
//                 }
                   
//                 delComment.remove();
                   
//             }else{   //취소
//                 return;
//             }
//         }else if($(this).attr("name")=="cDel"){
//             if (confirm("정말 삭제하시겠습니까??") == true){    //확인
//                 $(this).parent().parent().remove();
//             }else{   //취소
//                 return;
//             }
//         }else{
//             //자기 부모의 tr을 알아낸다.
//             var parentElement = $(this).parent().parent();
//             //댓글달기 창을 없앤다.
//             $("#commentEditor").remove();
//             //부모의 하단에 댓글달기 창을 삽입
//             var commentEditor = '<tr id="commentEditor">'+
//                                     '<td style="width:1%"> </td>'+
//                                     '<td>'+
//                                         '<span class="form-inline" role="form">'+
//                                             '<p>'+
//                                                 '<div class="form-group">'+
//                                                     '<input type="text" id="commentChildName" name="commentChildName" class="form-control col-lg-2" data-rule-required="true" placeholder="이름" maxlength="10">'+
//                                                 '</div>'+
//                                                 '<div class="form-group">'+
//                                                     ' <input type="password" id="commentChildPassword" name="commentChildPassword" class="form-control col-lg-2" data-rule-required="true" placeholder="패스워드" maxlength="10">'+
//                                                 '</div>'+
//                                                 '<div class="form-group">'+
//                                                     '<button type="button" id="commentChildSubmit" class="btn btn-default">확인</button>'+
//                                                 '</div>'+
//                                             '</p>'+
//                                                 '<textarea id="commentChildText" name="commentChildText" class="form-control" style="width:98%" rows="4"></textarea>'+
//                                         '</span>'+
//                                     '</td>'+
//                                 '</tr>';
                                   
//             parentElement.after(commentEditor); 
//         }
           
//     });
       
});


</script>


<!--중간 END -->




<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>
<!--푸터 START -->
</body>
</html>