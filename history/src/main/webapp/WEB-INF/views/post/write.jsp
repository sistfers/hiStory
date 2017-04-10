<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="com.hifive.history.model.CategoryDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	List<CategoryDto> categoryList = ((List<CategoryDto>)request.getAttribute("categoryList"));
	List<Map<String, Object>> themeCode = new ArrayList<Map<String, Object>>(); 	//Page코드 : 100
	List<Map<String, Object>> reviewCode = new ArrayList<Map<String, Object>>(); 	//Page코드 : 130
	List<Map<String, Object>> postViewCode = new ArrayList<Map<String, Object>>(); 	//Page코드 : 140
	
	themeCode = (List<Map<String, Object>>)request.getAttribute("themeCode");
	reviewCode = (List<Map<String, Object>>)request.getAttribute("reviewCode");
	postViewCode = (List<Map<String, Object>>)request.getAttribute("postViewCode");
	
	String id = request.getParameter("id");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title> 포스트쓰기 </title>

	<!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
	
	<!-- ckeditor -->
	<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	
</head>
<body>
<!--헤더 START-->
<jsp:include page="../main/header.jsp"/>
<!--헤더 END-->
<br><br><br><br>

<!-- 중간 START -->
<div class="container" >
	<form class="form-horizontal postForm" action="writeInsert.hi" method="post" enctype="multipart/form-data">
	
	<input type="hidden" name="id" value="<%=id%>"/>
<!-- 카테고리 -->
		<div class="form-group col-xs-3" style="margin-left: 7px">
			<select class="form-control" id="category" name="ct_seq">
			       <%if(categoryList.size() != 0){
			       		for(int i=0; i<categoryList.size(); ++i){%>
			       <option value="<%=categoryList.get(i).getSeq()%>">
			       <%=categoryList.get(i).getName() %></option>
			       
			       <%	}
			       	 } else{ %>
			       <option>선택안함</option>
			       <%} %>
		    </select>
	    </div>
	    
<!--제목  -->	    
		<div class="col-xs-9">
			<input type="text" name="title" id="TITLE" class="form-control" placeholder="제목을 입력해 주세요" maxlength="60">
		</div>
		
<!--내용  -->		
		<div class="col-xs-12">
		<textarea name="content" id="content" rows="500"></textarea>
		<script type="text/javascript">
			CKEDITOR.replace( 'content',{
				height : '400px',
				filebrowserUploadUrl: 'ckeditorImageUpload.hi'
			}); 
		</script>
		</div>
		<br>
		
<!-- 첨부 파일 업로드 시작  -->
		<div class="col-xs-3">
		<label for="field"> 파일 선택 </label>
		<a href="#" class="btn" id="addFile">파일 추가</a>
		</div>
		
		<div id="fileDiv" class="col-xs-9">
			<p>
				<input type="file" id="file" name="file_0">
			</p>		
		</div>
		<div class="col-xs-12">
		</div>
<!-- 첨부 파일 업로드 끝  -->		
		<div class="form-group col-xs-4" style="margin-left: 7px; padding-top: 10px;">
			<label for="field"> 주제 선택 </label>
			<select class="form-control" id="FIELD" name="field">
			       <%if(themeCode.size() != 0){
			       		for(int i=0; i<themeCode.size(); ++i){%>
			       <option value="<%=themeCode.get(i).get("CD_D_NM") %>"><%=themeCode.get(i).get("CD_D_NM") %></option>
			       <%	}
			       	 } else{ %>
			       <option>오류:::</option>
			       <%} %>
		    </select>
	    </div>
	    <div class="form-group col-xs-4" style="margin-left: 7px; padding-top: 10px;">
	    	<label for="field"> 댓글허용</label>
			<select class="form-control" id="CO_STATE" name="co_state">
			       <%if(reviewCode.size() != 0){
			       		for(int i=0; i<reviewCode.size(); ++i){%>
			       <option value="<%=reviewCode.get(i).get("CD_D_ID") %>"><%=reviewCode.get(i).get("CD_D_NM") %></option>
			       <%	}
			       	 } else{ %>
			       <option>오류:::</option>
			       <%} %>
		    </select>
	    </div>
	    <div class="form-group col-xs-4" style="margin-left: 7px; padding-top: 10px;">
	    	<label for="field"> 공개범위</label>
			<select class="form-control" id="STATE" name="state">
			       <%if(postViewCode.size() != 0){
			       		for(int i=0; i<postViewCode.size(); ++i){%>
			       <option value="<%=postViewCode.get(i).get("CD_D_ID") %>"><%=postViewCode.get(i).get("CD_D_NM") %></option>
			       <%	}
			       	 } else{ %>
			       <option>오류:::</option>
			       <%} %>
		    </select>
	    </div>
	
	
	<div class="col-xs-8" style="margin-left: 7px;">
		<input type="text" name="tag_w" id="tag_w" class="form-control" size="30" placeholder="태그입력"/></div>
	<div class="col-xs-3"><span style="color: #4374D9; font-size: 14px;"> *태그를 입력하고 스페이스바를 눌러주세요.</span></div>
	<div class="col-xs-1"></div>
	
	<!-- 태그 뿌려지는 부분 -->
	<div id="after_tag" class="col-xs-12"></div>
    <input type="hidden" name="tag" id="tag"/>
	<!--연결된 태그값 넘기기  -->


<div class="clearfix"></div><br><br>	 <!--줄띄기  -->

<!-- 버튼 -->
		<button class="btn btn-danger col-xs-2 col-xs-offset-4" id="save">
			<span class="glyphicon glyphicon-pencil"></span>
			&nbsp;&nbsp; <b>확&nbsp;&nbsp;인</b>&nbsp;
		</button>
		<button class="btn btn-default col-xs-2 col-xs-offset-1" id="cancle"> &nbsp;&nbsp; 취&nbsp;&nbsp;소&nbsp;</button>
</form>
</div>

<script>
var gfv_count = 1;	//파일 추가 카운트를 위한 전역변수
/* 태그 달기 js입니다 */       
	$(document).ready(function(){
		$("#addFile").on("click", function(e){ //파일 추가 버튼
			e.preventDefault();
			fn_addFile();
		});
		
		$("[name='delete']").on("click", function(e){ //삭제 버튼
			e.preventDefault();
			fn_deleteFile($(this));
		});
		
		$("input:text").keydown(function(evt) 
				{ 
			if (evt.keyCode == 13) return false;
			});


		
	    $("#tag_w").on('keyup',function(e){
	
	        var children = $("#after_tag").children('span').length;
	        var special =  /[`~!@#$%^&*|\\\'\";:\/?]/gi;

	        var check = $(this).val();
	        
	        if(special.test(check) == true){
	        
	            alert('특수문자는 사용할 수 없습니다.');
	            $("#tag_w").val("");
	            return false;
	        }
	        
	        if(e.which == 32 || e.which == 188){
	            
	            var tag = $("#tag_w").val();
	            tag = tag.trim();
	            
	            if(tag != "" && tag != ',' ){
	        
	                if(tag.match(',')){
	                    tag = tag.substring(0 , tag.length-1);
	                }

	            var resister_tag = "<span class='before_tag' id='tag_"+children+"' style='margin-left:7px;'>#<b>"+tag+"</b>"+
	        					    "<a href='javascript:deltag("+children+")' style='margin-left:7px; color:red;'>"+
	        					    "<b>x</b></a></span>";
	        					    
	            $("#after_tag").append(resister_tag);
	            
	            //초기화
	            $("#tag_w").val("");
	        
	            }else{
	            
	                if(tag == ""){
	                    alert("첫단어 공백은 불가합니다.");
	                    $("#tag_w").val("");
	                    return false;
	                }else{
	                    alert("첫단어 쉼표는 불가합니다.");
	                    $("#tag_w").val("");
	                    return false;}
	            }
	        }
	    });
	});
	 
	function deltag(n){
	    var id = "#tag_" + n;
	    $(id).remove();
	}
	 
	function tag_post(){
	    var ts = "#";
	    var t = $("#after_tag").children('span').children('b');
	    t.each(function(){
	            var v = $(this).html();
	            var rt = v.split('<a');
	            ts += rt[0] +"#";
	    });
	   	$("#tag").val(ts).val();			/* 태그들 다 연결되어 붙은 값 */
	    console.log("해시태그 ="+$("#tag").val(ts).val());
	}
	function fn_addFile(){
		var str = "<p><input type='file' name='file_"+(gfv_count++)+"'><a href='#this' class='btn' name='delete'>삭제</a></p>";
		$("#fileDiv").append(str);
		$("a[name='delete']").on("click", function(e){ //삭제 버튼
			e.preventDefault();
			fn_deleteFile($(this));
		});
	}
	
	function fn_deleteFile(obj){
		obj.parent().remove();
	}
</script>
	
<script type="text/javascript">
/* 글쓰기 눌렀을때 액션 */
$("#save").click(function(){
	
	tag_post();
	
	var frm = document.postForm;
	
   if(!$("#TITLE").val()){
       alert('제목을 입력해주세요.');
       $("#TITLE").focus();
       return false;
   }
   if(!$("#content").val()){
       alert('내용을 입력해주세요.');
       $("#content").focus();
       return false;
   }
   frm.submit();
});

/* 취소버튼 */
$("#cancle").click(function(){
	if(confirm("글 작성을 취소하시겠습니까?")){
		location.href = history.go(-1);
	}
});

</script>
	<!--중간 END -->

<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>
<!--푸터 START -->

</body>
</html>