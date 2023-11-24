<%@page import="movie.Movie"%>
<%@page import="java.util.ArrayList"%>
<%@page import="movie.MovieDAO"%>
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
  width: 96.5%;
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
	String[] Seoul = movietheater.getName_Condition("서울");	
	int[] Seoul_theater = movietheater.getTheater("서울");
	int size = Seoul.length;
	String Seoul_string = "";
	String Seoul_theaters = "";
	for (int i=0; i<size; i++){
		Seoul_string += Seoul[i] + "\t";
		Seoul_theaters += Integer.toString(Seoul_theater[i]) + "\t";
	}
	Seoul_string = Seoul_string.substring(0, Seoul_string.length()-1);	
	Seoul_theaters = Seoul_theaters.substring(0, Seoul_theaters.length()-1);
	
	String[] Gyeonggi = movietheater.getName_Condition("경기");
	int[] Gyeonggi_theater = movietheater.getTheater("경기");
	size = Gyeonggi.length;
	String Gyeonggi_string = "";
	String Gyeonggi_theaters = "";
	for (int i=0; i<size; i++){
		Gyeonggi_string += Gyeonggi[i] + "\t";
		Gyeonggi_theaters += Integer.toString(Gyeonggi_theater[i]) + "\t";
	}
	Gyeonggi_string = Gyeonggi_string.substring(0, Gyeonggi_string.length()-1);
	Gyeonggi_theaters = Gyeonggi_theaters.substring(0, Gyeonggi_theaters.length()-1);
	
	String[] Incheon = movietheater.getName_Condition("인천");
	int[] Incheon_theater = movietheater.getTheater("인천");
	size = Incheon.length;
	String Incheon_string = "";
	String Incheon_theaters = "";
	for (int i=0; i<size; i++){
		Incheon_string += Incheon[i] + "\t";
		Incheon_theaters += Integer.toString(Incheon_theater[i]) + "\t";
	}
	Incheon_string = Incheon_string.substring(0, Incheon_string.length()-1);
	Incheon_theaters = Incheon_theaters.substring(0, Incheon_theaters.length()-1);
	
	String[] Gangwon = movietheater.getName_Condition("강원");	
	int[] Gangwon_theater = movietheater.getTheater("강원");
	size = Gangwon.length;
	String Gangwon_string = "";
	String Gangwon_theaters = "";
	for (int i=0; i<size; i++){
		Gangwon_string += Gangwon[i] + "\t";
		Gangwon_theaters += Integer.toString(Gangwon_theater[i]) + "\t";
	}
	Gangwon_string = Gangwon_string.substring(0, Gangwon_string.length()-1);
	Gangwon_theaters = Gangwon_theaters.substring(0, Gangwon_theaters.length()-1);
	
	String[] Daejeon = movietheater.getName_Condition("대전/충청");
	int[] Daejeon_theater = movietheater.getTheater("대전/충청");
	size = Daejeon.length;
	String Daejeon_string = "";
	String Daejeon_theaters = "";
	for (int i=0; i<size; i++){
		Daejeon_string += Daejeon[i] + "\t";
		Daejeon_theaters += Integer.toString(Daejeon_theater[i]) + "\t";
	}
	Daejeon_string = Daejeon_string.substring(0, Daejeon_string.length()-1);
	Daejeon_theaters = Daejeon_theaters.substring(0, Daejeon_theaters.length()-1);
	
	String[] Daegu = movietheater.getName_Condition("대구");	
	int[] Daegu_theater = movietheater.getTheater("대구");
	size = Daegu.length;
	String Daegu_string = "";
	String Daegu_theaters = "";
	for (int i=0; i<size; i++){
		Daegu_string += Daegu[i] + "\t";
		Daegu_theaters += Integer.toString(Daegu_theater[i]) + "\t";
	}
	Daegu_string = Daegu_string.substring(0, Daegu_string.length()-1);
	Daegu_theaters = Daegu_theaters.substring(0, Daegu_theaters.length()-1);
	
	String[] Busan = movietheater.getName_Condition("부산/울산");	
	int[] Busan_theater = movietheater.getTheater("부산/울산");
	size = Busan.length;
	String Busan_string = "";
	String Busan_theaters = "";
	for (int i=0; i<size; i++){
		Busan_string += Busan[i] + "\t";
		Busan_theaters += Integer.toString(Busan_theater[i]) + "\t";
	}
	Busan_string = Busan_string.substring(0, Busan_string.length()-1);
	Busan_theaters = Busan_theaters.substring(0, Busan_theaters.length()-1);
	
	String[] Gyeongsang = movietheater.getName_Condition("경상");	
	int[] Gyeongsang_theater = movietheater.getTheater("경상");
	size = Gyeongsang.length;
	String Gyeongsang_string = "";
	String Gyeongsang_theaters = "";
	for (int i=0; i<size; i++){
		Gyeongsang_string += Gyeongsang[i] + "\t";
		Gyeongsang_theaters += Integer.toString(Gyeongsang_theater[i]) + "\t";
	}
	Gyeongsang_string = Gyeongsang_string.substring(0, Gyeongsang_string.length()-1);
	Gyeongsang_theaters = Gyeongsang_theaters.substring(0, Gyeongsang_theaters.length()-1);
	
	String[] Gwangju = movietheater.getName_Condition("광주/전라/제주");
	int[] Gwangju_theater = movietheater.getTheater("광주/전라/제주");
	size = Gwangju.length;
	String Gwangju_string = "";
	String Gwangju_theaters = "";
	for (int i=0; i<size; i++){
		Gwangju_string += Gwangju[i] + "\t";
		Gwangju_theaters += Integer.toString(Gwangju_theater[i]) + "\t";
	}
	Gwangju_string = Gwangju_string.substring(0, Gwangju_string.length()-1);
	Gwangju_theaters = Gwangju_theaters.substring(0, Gwangju_theaters.length()-1);
	
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

function doChange2(srcE, targetId){
    var val = srcE.options[srcE.selectedIndex].value;
    var targetE = document.getElementById(targetId);
    removeAll2(targetE);
    var Seoul_st = "<%=Seoul_string%>";
	var Seoul_str = Seoul_st.split('\t');
    var Seoul_th = "<%=Seoul_theaters%>";
    var Seoul_ths = Seoul_th.split('\t');
    for(var i=0;i<Seoul_str.length;i++){
    	if(val==Seoul_str[i]){
    		var Seoul_count = parseInt(Seoul_ths[i]);
    		for(var j=0;j<Seoul_count;j++){
    			addOption(j+1,targetE)
    		}
    	}
    }
    var Gyeonggi_st = "<%=Gyeonggi_string%>";
	var Gyeonggi_str = Gyeonggi_st.split('\t');
    var Gyeonggi_th = "<%=Gyeonggi_theaters%>";
    var Gyeonggi_ths = Gyeonggi_th.split('\t');
    for(var i=0;i<Gyeonggi_str.length;i++){
    	if(val==Gyeonggi_str[i]){
    		var Gyeonggi_count = parseInt(Gyeonggi_ths[i]);
    		for(var j=0;j<Gyeonggi_count;j++){
    			addOption(j+1,targetE)
    		}
    	}
    }   
    var Incheon_st = "<%=Incheon_string%>";
	var Incheon_str = Incheon_st.split('\t');
    var Incheon_th = "<%=Incheon_theaters%>";
    var Incheon_ths = Incheon_th.split('\t');
    for(var i=0;i<Incheon_str.length;i++){
    	if(val==Incheon_str[i]){
    		var Incheon_count = parseInt(Incheon_ths[i]);
    		for(var j=0;j<Incheon_count;j++){
    			addOption(j+1,targetE)
    		}
    	}
    }
    
    var Gangwon_st = "<%=Gangwon_string%>";
	var Gangwon_str = Gangwon_st.split('\t');
    var Gangwon_th = "<%=Gangwon_theaters%>";
    var Gangwon_ths = Gangwon_th.split('\t');
    for(var i=0;i<Gangwon_str.length;i++){
    	if(val==Gangwon_str[i]){
    		var Gangwon_count = parseInt(Gangwon_ths[i]);
    		for(var j=0;j<Gangwon_count;j++){
    			addOption(j+1,targetE)
    		}
    	}
    }
    
    var Daejeon_st = "<%=Daejeon_string%>";
	var Daejeon_str = Daejeon_st.split('\t');
    var Daejeon_th = "<%=Daejeon_theaters%>";
    var Daejeon_ths = Daejeon_th.split('\t');
    for(var i=0;i<Daejeon_str.length;i++){
    	if(val==Daejeon_str[i]){
    		var Daejeon_count = parseInt(Daejeon_ths[i]);
    		for(var j=0;j<Daejeon_count;j++){
    			addOption(j+1,targetE)
    		}
    	}
    }
    
    var Daegu_st = "<%=Daegu_string%>";
	var Daegu_str = Daegu_st.split('\t');
    var Daegu_th = "<%=Daegu_theaters%>";
    var Daegu_ths = Daegu_th.split('\t');
    for(var i=0;i<Daegu_str.length;i++){
    	if(val==Daegu_str[i]){
    		var Daegu_count = parseInt(Daegu_ths[i]);
    		for(var j=0;j<Daegu_count;j++){
    			addOption(j+1,targetE)
    		}
    	}
    }
    
    var Busan_st = "<%=Busan_string%>";
	var Busan_str = Busan_st.split('\t');
    var Busan_th = "<%=Busan_theaters%>";
    var Busan_ths = Busan_th.split('\t');
    for(var i=0;i<Busan_str.length;i++){
    	if(val==Busan_str[i]){
    		var Busan_count = parseInt(Busan_ths[i]);
    		for(var j=0;j<Busan_count;j++){
    			addOption(j+1,targetE)
    		}
    	}
    }
    
    var Gyeongsang_st = "<%=Gyeongsang_string%>";
	var Gyeongsang_str = Gyeongsang_st.split('\t');
    var Gyeongsang_th = "<%=Gyeongsang_theaters%>";
    var Gyeongsang_ths = Gyeongsang_th.split('\t');
    for(var i=0;i<Gyeongsang_str.length;i++){
    	if(val==Gyeongsang_str[i]){
    		var Gyeongsang_count = parseInt(Gyeongsang_ths[i]);
    		for(var j=0;j<Gyeongsang_count;j++){
    			addOption(j+1,targetE)
    		}
    	}
    }
    
    var Gwangju_st = "<%=Gwangju_string%>";
	var Gwangju_str = Gwangju_st.split('\t');
    var Gwangju_th = "<%=Gwangju_theaters%>";
    var Gwangju_ths = Gwangju_th.split('\t');
    for(var i=0;i<Gwangju_str.length;i++){
    	if(val==Gwangju_str[i]){
    		var Gwangju_count = parseInt(Gwangju_ths[i]);
    		for(var j=0;j<Gwangju_count;j++){
    			addOption(j+1,targetE)
    		}
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

function removeAll2(e){
	e.options.length=0;
}

</script>
</head>
<body>
<jsp:include page="top.jsp" flush="false"/><br><br><br>
<div class="container1">
	<form action="ShowingWriteAction.jsp" method="post" name='MyForm'>
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
                          영화관 이름<select name="movietheater" id="movietheater" class="form-control" onchange="doChange2(this, 'theater')">
                          <option value="default">===========================================</option>
            </select><br>
            관 이름<br><select name="theater" id="theater" class="form-control2">
            </select>&nbsp;&nbsp;관<br><br>          
       영화제목<select name="movie" id="movie" class="form-control" >
       <%
	   	MovieDAO movie = new MovieDAO();
	   	ArrayList<Movie> list = movie.getShowingList();
	   	int list_size = list.size();
       for (int i=0;i<list_size;i++){%>
    		<option value="<%=list.get(i).getMOVIE_TITLE()%>"><%=list.get(i).getMOVIE_TITLE()%></option>
    	<% 
       }
       %>

       </select><br>
       상영일<input type="date" name="show_date" class="form-control"><br>
      <input type="time" name="show_time" class="form-control"><br><br>
      <button class="btn btn-lg btn-primary btn-block" type="submit">등록</button><br><br>
     </form>
</div>
</body>
</html>