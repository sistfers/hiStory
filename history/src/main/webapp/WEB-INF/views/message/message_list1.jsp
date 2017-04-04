<%@page import="com.hifive.history.util.PagingUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
List<Map<String, Object>> datas = new ArrayList<Map<String, Object>>();
datas = (ArrayList<Map<String, Object>>) request.getAttribute("getList");

int intTotalCount = 0;
int page_num = 1;
String my_id = "";


if((String) request.getAttribute("PAGE_NUM") != null) {
	page_num = Integer.parseInt((String) request.getAttribute("PAGE_NUM"));
} 

if((String) request.getAttribute("My_Id") != null) {
	my_id = (String) request.getAttribute("My_Id");
} else {
	
}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 받은쪽지함 </title>
    <!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<!-- http://aramk.tistory.com/21 -->
<script type="text/javascript">
/* 내용 검색  */
$(document).ready(function() {
	$("#words").on("click", function() {
		var words = $('#searchbox').val();
		var id	  = $('#My_ID').val();
        
		$.ajax({
			type : "POST",
			url : "filtered.hi",
			dataType : "html", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
			data : {
				"condi" : 'receiver',
				"words" : words,
				"id"	: id
			},
			success : function(data) {
				// 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.
				
				$('#filteredForm').remove();
				// alert('success ' +data);
				
				var item = $.parseJSON(data);
				/* $.each(item,function(key,value) {
					alert('key:'+key+', idx:'+value.IDX+', seq:'+value.SEQ+
							', send_id:'+value.SEND_ID+', take_id:'+value.TAKE_ID+
							', contents:'+value.CONTENTS+', wdate:'+value.WDATE+
							', rdate:'+value.RDATE+', state:'+value.STATE+
							', name:'+value.NAME+', TOTAL:'+value.TOTAL);
				});	 */			
				
				if (item.length == 0) {
					alert('item.length ' +item.length);
					$("#wrapfilteredForm").append('<table id="filteredForm" class="table"><tr class="warning" ><th width="10%" style="text-align: center;"><input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAl();" /></th><th width="20%" style="text-align: center;">보낸사람</th><th width="40%" style="text-align: center;">내용</th><th width="20%" style="text-align: center;">날짜</th><th width="10%" style="text-align: center;">읽음</th><tr><td align="center" colspan="5">쪽지가 없습니다.</td></tr>');
				}
				else {
					var filteredForm = '<table id="filteredForm" class="table"><tr class="warning" >';
					filteredForm = filteredForm + '<th width="10%" style="text-align: center;"><input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAl();" /></th>';
					filteredForm = filteredForm + '<th width="20%" style="text-align: center;">보낸사람</th>';
					filteredForm = filteredForm + '<th width="40%" style="text-align: center;">내용</th>';
					filteredForm = filteredForm + '<th width="20%" style="text-align: center;">날짜</th>';
					filteredForm = filteredForm + '<th width="10%" style="text-align: center;">읽음</th>';
											
					for (var i = 0; i < item.length; i++) {
						var idx		 = item[i].IDX;
						var seq		 = item[i].SEQ;
						var send_id	 = item[i].SEND_ID;
						var take_id	 = item[i].TAKE_ID;
						var contents = item[i].CONTENTS;
						var wdate	 = item[i].WDATE;
						var rdate	 = item[i].RDATE;
						var state	 = item[i].STATE;
						var name	 = item[i].NAME;
						var total	 = item[i].TOTAL;
						
						if(contents.length > 15) {
							contents = contents.substring(0, 15) + '...';
							// alert(contents);
						}
						
						filteredForm = filteredForm + '<tr><td align="center"><input type="checkbox" name="checkRow" value='+seq+'</td>';
						filteredForm = filteredForm + '<td>'+send_id+'('+name+')</td>';
						filteredForm = filteredForm + '<td><a href=read.hi?note='+seq+'>'+contents+'</a></td>';
						filteredForm = filteredForm + '<td>'+wdate+'</td>';						

						if(state == '0') {
							filteredForm = filteredForm + '<td>읽지 않음</td></tr>';
						} else {
							filteredForm = filteredForm + '<td>'+rdate+'</td></tr>';
						}						
					}
					
					// pagination
					var total_pg = item[0].TOTAL / 10;  
					
					// 나머지가 있다면 1페이지 추가
					if (item[0].TOTAL % 10 > 0) {
						total_pg++;
					}
					
					
					
					
					filteredForm = filteredForm + '</table>';
					// alert(filteredForm);
					$("#wrapfilteredForm").append(filteredForm);
				}
			},
			complete : function(data) {
				// 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
			},
			error : function(xhr, status, error) {
				alert("에러 발생");
			}
		});		
	});	
});

// 페이징
function do_search_page(url, page_num) 
{
	  console.log(url+"\t"+page_num);
	 
	  var frm = document.searchForm;
	  frm.PAGE_NUM.value = page_num;
	  frm.action = url;
	  frm.submit();
}

/* 체크박스 전체선택, 전체해제 */
function checkAl() { 
	if( $("#th_checkAll").is(':checked') ){
        $("input[name=checkRow]").prop("checked", true);
      }else{
        $("input[name=checkRow]").prop("checked", false);
      }
}

/* 삭제(체크박스된 것 전부) */
function deleteAction(){
	var checkRow = "";
	$( "input[name='checkRow']:checked" ).each (function (){
	  checkRow = checkRow + $(this).val()+"," ;
	});
	checkRow = checkRow.substring(0,checkRow.lastIndexOf( ",")); //맨끝 콤마 지우기
	alert('삭제 ' +checkRow);	
	
	if(checkRow == ''){
		alert("삭제할 대상을 선택하세요.");
		return false;
	}
	console.log("### checkRow => {}"+checkRow);
	
	if(confirm("정보를 삭제 하시겠습니까?")){	    
		location.href='delete.hi?idx='+checkRow+'&to=receive';
	//  "${rc.contextPath}/test_proc.do?idx="+checkRow+"&goUrl="+url;
	}
}

/* 답장(체크박스된 것 전부) */
function replyAction() {
	var checkRow = "";
	$( "input[name='checkRow']:checked" ).each (function (){		
		var index = checkRow.indexOf($(this).closest('td').next().html());
		
		if(index != -1) {
			
		} else {
			checkRow = checkRow + $(this).closest('td').next().html()+",";
		}
	});
	
	<%-- <tr>
	<td align="center"><input type="checkbox" name="checkRow" value="<%=item.get("SEQ") %>"></td>					
	<td><%=item.get("SEND_ID") %>(<%=item.get("NAME") %>)</td>
	<td><a href='read.hi?note=<%=item.get("SEQ") %>'><%=subContents %></a></td>
	<td><%=item.get("WDATE") %></td> --%>	
	
	checkRow = checkRow.substring(0,checkRow.lastIndexOf( ",")); //맨끝 콤마 지우기
	alert('답장 대상 ' +checkRow);
	
	if(checkRow == ''){
		alert("답장할 대상을 선택하세요.");
		return false;
	}
	console.log("### checkRow => {}"+checkRow);
	
	if(confirm("정말 보내겠습니까?")){	    
		location.href='writeForm.hi?list='+checkRow;
	}
}

function viewAll() {
	location.href='receive.hi';
}


</script>	
</head>
<body>

<!--헤더 START-->
<jsp:include page="/header.hi"/>
<!--헤더 END-->
<div class="container" >
<br><br><br><br> <!-- 헤더때문에 윗에 공백 넣어주는거임 -->

<!-- 좌측메뉴 -->
<div class="col-xs-2">
	<jsp:include page="menu.jsp"/>
</div>

<!--내용 START -->
<div class="col-xs-10" style="min-height: 600px">
<center><h2> :: 받은쪽지함 ::</h2></center><br>
	<div class="col-xs-1">
	</div>
	<form name="searchForm" action="" method="POST">
		<input type="hidden" name="PAGE_NUM" value="" />
		<input type="hidden" id="My_ID" value="<%=my_id %>" />
	<div class="col-xs-11" >
		<div class="form-group">
	 		<!-- 버튼 -->	
	 		<div class="col-xs-3" align="left">
				<input type="button" value="삭제" onclick="deleteAction();" class="btn btn-danger" />
				<input type="button" value="답장" onclick="replyAction();" class="btn btn-danger" />
			</div>
			<div class="col-xs-7" align="left">
				<div class="input-group"> 
			 	<span class="input-group-addon"><i class="glyphicon glyphicon-search"></i></span>
				<input type="text" id="searchbox" class="form-control" placeholder="검색어를 입력하삼"/>
				<span class="input-group-btn"><input type="button" id="words" value="검색" class="btn btn-info" /></span>
				</div>
			</div>
			
			<div class="col-xs-2" align="right">	
				<input type="button" id="viewall" value="전체보기" onclick="viewAll();" class="btn btn-default" />
			</div>		
		</div>	
    	<br><br>
    	<div id="wrapfilteredForm" >
		<table  id="filteredForm" class="table">
			<tr class="warning" >
				<th width="10%" style="text-align: center;">
				<input type="checkbox" name="checkAll" id="th_checkAll" onclick="checkAl();" /></th>
				<th width="20%" style="text-align: center;">보낸사람</th>
				<th width="40%" style="text-align: center;">내용</th>
				<th width="15%" style="text-align: center;">받은날짜</th>
				<th width="15%" style="text-align: center;">수신확인</th>
			</tr>
			
			<%
			if(datas != null && datas.size() > 0) {	
				Map<String, Object> cnt = datas.get(0);
				intTotalCount = (Integer) cnt.get("TOTAL");
				
				for(int i = 0; i < datas.size(); i++) {
					Map<String, Object> item = datas.get(i);
					String subContents = (String) item.get("CONTENTS");
					
					if(subContents.length() > 15) {
						subContents = subContents.substring(0, 15) + "...";
						
					} else {
						
					}
			%>
				<tr>
					<td align="center"><input type="checkbox" name="checkRow" value="<%=item.get("SEQ") %>"></td>					
					<td><%=item.get("NAME") %> <span style="font-size: 11px; color :#670000 ">(<%=item.get("SEND_ID") %>)</span> </td>
					<td><a href='read.hi?note=<%=item.get("SEQ") %>'><%=subContents %></a></td>
					<td align="center"><%=item.get("WDATE") %></td>
				
				<% 
				if(item.get("STATE").equals("0")) {
				%>
					<td align="center">미확인</td>
				<%	
				} else {
				%>
					<td align="center"><%=item.get("RDATE") %></td>
				<%	
				}
				%>
				</tr>
			<%
				}
			} else {
			%>
				<tr>
					<td align="center" colspan="5">쪽지가 없습니다.</td>
				</tr>
			<%	
			}
			%>
		</table>
	



		</div>
<center>
<table><tr><td style="text-align: center;">
<!-- Paging Area Start -->
<%=PagingUtil.renderPaging(
		intTotalCount, page_num, 10, 10, "receive.hi", "do_search_page")%>
<!-- Paging Area end //--> 	<!--밑에 페이지 갯수 몇개씩 보여줄건지   -->	
</td></tr>
</table>
</center>
	</div>
	</form>
</div>


<br><br><br><br><br>
</div>
<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>
<!--푸터 START -->
</body>
</html>


