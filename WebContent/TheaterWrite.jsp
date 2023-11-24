<%@page import="java.util.Arrays"%>
<%@page import="movietheater.MovieTheaterDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.container1 {
  padding-right: 600px;
  padding-left: 600px;
  margin-right: auto;
  margin-left: auto;
}
.form-control2 {
  display: inline-block;
  width: 40%;
  height: 34px;
  padding: 6px 12px;
  font-size: 14px;
  line-height: 1.42857143;
  color: #555;
  background-color: #fff;
  background-image: none;
  border: 1px solid #ccc;
  border-radius: 4px;
  -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
          box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
  -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
       -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
          transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}
</style>
<%
	MovieTheaterDAO movietheater = new MovieTheaterDAO();
	String[] Seoul = movietheater.getName("서울");	
	int size = Seoul.length;
	String Seoul_string = "";
	for (int i=0; i<size; i++){
		Seoul_string += Seoul[i] + "\t";
	}
	Seoul_string = Seoul_string.substring(0, Seoul_string.length()-1);
	
	String[] Gyeonggi = movietheater.getName("경기");	
	size = Gyeonggi.length;
	String Gyeonggi_string = "";
	for (int i=0; i<size; i++){
		Gyeonggi_string += Gyeonggi[i] + "\t";
	}
	Gyeonggi_string = Gyeonggi_string.substring(0, Gyeonggi_string.length()-1);
	
	String[] Incheon = movietheater.getName("인천");	
	size = Incheon.length;
	String Incheon_string = "";
	for (int i=0; i<size; i++){
		Incheon_string += Incheon[i] + "\t";
	}
	Incheon_string = Incheon_string.substring(0, Incheon_string.length()-1);
	
	String[] Gangwon = movietheater.getName("강원");	
	size = Gangwon.length;
	String Gangwon_string = "";
	for (int i=0; i<size; i++){
		Gangwon_string += Gangwon[i] + "\t";
	}
	Gangwon_string = Gangwon_string.substring(0, Gangwon_string.length()-1);
	
	String[] Daejeon = movietheater.getName("대전/충청");	
	size = Daejeon.length;
	String Daejeon_string = "";
	for (int i=0; i<size; i++){
		Daejeon_string += Daejeon[i] + "\t";
	}
	Daejeon_string = Daejeon_string.substring(0, Daejeon_string.length()-1);
	
	String[] Daegu = movietheater.getName("대구");	
	size = Daegu.length;
	String Daegu_string = "";
	for (int i=0; i<size; i++){
		Daegu_string += Daegu[i] + "\t";
	}
	Daegu_string = Daegu_string.substring(0, Daegu_string.length()-1);
	
	String[] Busan = movietheater.getName("부산/울산");	
	size = Busan.length;
	String Busan_string = "";
	for (int i=0; i<size; i++){
		Busan_string += Busan[i] + "\t";
	}
	Busan_string = Busan_string.substring(0, Busan_string.length()-1);
	
	String[] Gyeongsang = movietheater.getName("경상");	
	size = Gyeongsang.length;
	String Gyeongsang_string = "";
	for (int i=0; i<size; i++){
		Gyeongsang_string += Gyeongsang[i] + "\t";
	}
	Gyeongsang_string = Gyeongsang_string.substring(0, Gyeongsang_string.length()-1);
	
	String[] Gwangju = movietheater.getName("광주/전라/제주");	
	size = Gwangju.length;
	String Gwangju_string = "";
	for (int i=0; i<size; i++){
		Gwangju_string += Gwangju[i] + "\t";
	}
	Gwangju_string = Gwangju_string.substring(0, Gwangju_string.length()-1);
%>
<script type="text/javascript">
function doChange(srcE, targetId){
    var val = srcE.options[srcE.selectedIndex].value;
    var targetE = document.getElementById(targetId);
    removeAll(targetE);

    if(val == '서울'){
    	var Seoul_js = "<%=Seoul_string%>";
    	var Seoul_sp = Seoul_js.split('\t');
    	for(var i=0; i<Seoul_sp.length;i++){
    		addOption(Seoul_sp[i],targetE)
    	}
    }else if(val == '경기'){
    	var Gyeonggi_js = "<%=Gyeonggi_string%>";
    	var Gyeonggi_sp = Gyeonggi_js.split('\t');
    	for(var i=0; i<Gyeonggi_sp.length;i++){
    		addOption(Gyeonggi_sp[i],targetE)
    	}
    }else if(val == '인천'){
    	var Incheon_js = "<%=Incheon_string%>";
    	var Incheon_sp = Incheon_js.split('\t');
    	for(var i=0; i<Incheon_sp.length;i++){
    		addOption(Incheon_sp[i],targetE)
    	}
    }else if(val == '강원'){
    	var Gangwon_js = "<%=Gangwon_string%>";
    	var Gangwon_sp = Gangwon_js.split('\t');
    	for(var i=0; i<Gangwon_sp.length;i++){
    		addOption(Gangwon_sp[i],targetE)
    	}
    }else if(val == '대전/충청'){
    	var Daejeon_js = "<%=Daejeon_string%>";
    	var Daejeon_sp = Daejeon_js.split('\t');
    	for(var i=0; i<Daejeon_sp.length;i++){
    		addOption(Daejeon_sp[i],targetE)
    	}
    }else if(val == '대구'){
    	var Daegu_js = "<%=Daegu_string%>";
    	var Daegu_sp = Daegu_js.split('\t');
    	for(var i=0; i<Daegu_sp.length;i++){
    		addOption(Daegu_sp[i],targetE)
    	}
    }else if(val == '부산/울산'){
    	var Busan_js = "<%=Busan_string%>";
    	var Busan_sp = Busan_js.split('\t');
    	for(var i=0; i<Busan_sp.length;i++){
    		addOption(Busan_sp[i],targetE)
    	}
    }else if(val == '경상'){
    	var Gyeongsang_js = "<%=Gyeongsang_string%>";
    	var Gyeongsang_sp = Gyeongsang_js.split('\t');
    	for(var i=0; i<Gyeongsang_sp.length;i++){
    		addOption(Gyeongsang_sp[i],targetE)
    	}
    }else if(val == '광주/전라/제주'){
    	var Gwangju_js = "<%=Gwangju_string%>";
    	var Gwangju_sp = Gwangju_js.split('\t');
    	for(var i=0; i<Gwangju_sp.length;i++){
    		addOption(Gwangju_sp[i],targetE)
    	}
    }
}

function addOption(value, e){
    var o = new Option(value);
    try{
        e.add(o);
    }catch(ee){
        e.add(o, null);
    }
}

function removeAll(e){
	e.options.length=1;
}
</script>
</head>
<body>
<jsp:include page="top.jsp" flush="false"/><br><br><br>
<div class="container1">
	<form action="TheaterWriteAction.jsp" method="post" name='MyForm'>
	<script id='dummy'></script>
		지역<select name="city" id="city" class="form-control" onchange="doChange(this, 'movietheater')">
              <option value="서울">서울</option>
              <option value="경기">경기</option>
              <option value="인천">인천</option>
              <option value="강원">강원</option>
              <option value="대전/충청">대전/충청</option>
              <option value="대구">대구</option>
              <option value="부산/울산">부산/울산</option>
              <option value="경상">경상</option>
              <option value="광주/전라/제주">광주/전라/제주</option>
              </select><br>
            영화관 이름<select name="movietheater" id="movietheater" class="form-control">
            <option value="default">===========================================</option>
            </select><br>
       	관 자릿수 &nbsp; &nbsp; &nbsp;
       	행 &nbsp;<input type="number" name="row" min="1" max="20" value="1" class="form-control2">&nbsp;&nbsp;
       	열 &nbsp;<input type="number" name="column" min="1" max="20" value="1" class="form-control2"><br><br><br>
       	<button class="btn btn-lg btn-primary btn-block" type="submit">등록</button><br><br>
	</form>
</div>
</body>
</html>