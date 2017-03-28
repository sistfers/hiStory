<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>:::::::::::포스트수정::::::::::</title>
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
	<form class="form-horizontal" action="" method="post">
		<!-- 카테고리 뿌려 주세요 -->
		<div class="form-group col-xs-3" style="margin-left: 10px">
			<select class="form-control" id="category">
			       <option>카테고리선택</option>
			       <option>여행</option>
			       <option>요리</option>
			       <option>축구</option>
		    </select>
	    </div>
		<div class="col-xs-7">
			<input type="text" class="form-control" name="title" placeholder="제목을 입력해 주세요">
		</div>
		<div class="col-xs-2">
			<button type="submit" class="btn btn-info btn-md">
          		<span class="glyphicon glyphicon-envelope"></span> POSTING
        	</button>
		</div>
		
		<div class="col-xs-12">
		<textarea name="contents" rows="500"></textarea>
		<script type="text/javascript">
			CKEDITOR.replace( 'contents',{
				filebrowserUploadUrl: '/ckeditor/upload.jsp'
			}); 
		</script>
		</div>
		
		<div class="form-group col-xs-5" style="margin-left: 10px; padding-top: 10px;">
			<label for="field"> 주제 선택 </label>
			<select class="form-control" id="field">
			       <option>주제선택</option>
			       <option>선택안함</option>
			       <option>일상</option>
			       <option>기타</option>
			       <option>IT</option>
			       <option>게임</option>
			       <option>영화</option>
		    </select>
	    </div>
	    <div class="form-group col-xs-2" style="padding-top: 10px;"></div>
	    <div class="form-group col-xs-5" style="padding-top: 10px;">
	    	<label for="field"> 공개범위</label>
			<select class="form-control" id="state">
			       <option>공개범위설정</option>
			       <option>전체공개</option>
			       <option>비공개</option>
			       <option>이웃공개</option>
		    </select>
	    </div>
	</form>
	
	<div class="col-xs-12" style="margin-top: 20px;">
	<div class="col-xs-4">
			<input type="text" name="tag_w" id="tag_w" class="form-control" size="30" placeholder="태그입력"/>
	     	&nbsp; <span> *태그를 입력하고 스페이스바를 눌러주세요.</span>
	</div>
	<div id="after_tag" class="col-xs-8"></div>
	    	<div>
	    	<input type="hidden" name="tag" id="tag"/>
	    	</div>
	</div>
	<script>
	/* 태그 달기 js입니다 */
	$(document).ready(function(){
	 
	    $("#tag_w").on('keyup',function(e){
	
	        var children = $("#after_tag").children('span').length;
	        var special = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
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
	                
	            var resister_tag = "<span class='before_tag' id='tag_"+children+"'>#"+tag+"<a href='javascript:deltag("+children+")' style='margin-left:7px' >x</a></span>";
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
	 
	    var ts = "";
	    var t = $("#after_tag").children('span');
	    t.each(function(){
	            var v = $(this).html();
	            var rt = v.split('<a');
	            ts += rt[0] +"/";
	    });
	    $("#tag").val(ts);
	}
	 
	 
	</script>
	
</div>
<!--중간 END -->

<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>
<!--푸터 START -->

</body>
</html>