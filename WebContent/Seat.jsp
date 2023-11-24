
<%@page import="reservation.Reservation_Detail"%>
<%@page import="java.util.ArrayList"%>
<%@page import="reservation.ReservationDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="showing.Showing_Detail"%>
<%@page import="theater.Theater"%>
<%@page import="showing.ShowingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/seat.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel='stylesheet'
	href='//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css' />
<script
	src='//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js'></script>
<link rel="stylesheet"
	href="fonts/material-design-iconic-font/css/material-design-iconic-font.min.css">
<!-- MATERIAL DESIGN ICONIC FONT -->

</head>
<style>
.select-container1 {
    margin-top: 40px;
}
</style>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String userID = null;
	if(session.getAttribute("userID") != null)
	{
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요한 화면입니다.')");		
		script.println("history.back()");
		script.println("</script>");
	}
	int SHOWING_NO = 0;
	if(request.getParameter("SHOWING_NO")!=null){
		SHOWING_NO= Integer.parseInt(request.getParameter("SHOWING_NO"));
	}
	int SHOWING_ROUND = 0;
	if(request.getParameter("SHOWING_ROUND")!=null){
		SHOWING_ROUND= Integer.parseInt(request.getParameter("SHOWING_ROUND"));
	}
	ShowingDAO showing = new ShowingDAO();
	Theater theater = showing.getTheater(SHOWING_NO, SHOWING_ROUND);
	int row = theater.getTHEATER_ROW();
	int column = theater.getTHEATER_COLUMN();
	int seat = row * column;
	String movietitle = showing.getMovie(SHOWING_NO);
	String movietheater = showing.getMovietheater(SHOWING_NO);
	String theatername = theater.getTHEATER_NAME() + "관";
	Showing_Detail showing_detail = showing.getShowingDetail(SHOWING_NO, SHOWING_ROUND);
	String date = showing_detail.getSHOWING_TIME().substring(0,10);
	String time = showing_detail.getSHOWING_TIME().substring(11,16);
	int visitor = showing_detail.getSHOWING_VISITOR();
	
 	ReservationDAO reservationdao = new ReservationDAO();
	ArrayList<Reservation_Detail> reservation = reservationdao.getReservation(SHOWING_NO, SHOWING_ROUND);
	String reservation_string = "";
	if(reservation!=null){		
		for(int i=0; i<reservation.size();i++){
			String reservationrow = Integer.toString(reservation.get(i).getRESERVATION_ROW());
			String reservationcolumn = Integer.toString(reservation.get(i).getRESERVATION_COLUMN());
			reservation_string += reservationcolumn + reservationrow + "\t";
		}
		if(reservation_string != ""){
			reservation_string = reservation_string.substring(0, reservation_string.length()-1);
		}
	}
%>
<jsp:include page="top.jsp" flush="false"/>
	<div class="select-container1">
		<div class="select-wrapper">
			<div class="select-title">인원/좌석</div>
			<div class="select-seat-container">
				<div class="select-seat-number-container">
					<div class="select-seat-number-wrapper">
						<div class="select-seat">
							<div class="select-seat-age">일반</div>
							<div class="select-seat-number">
								<ul class="select-seat-ul select-seat-ul-normal">
									<li class="select-number-normal ">0</li>
									<li class="select-number-normal">1</li>
									<li class="select-number-normal">2</li>
									<li class="select-number-normal">3</li>
									<li class="select-number-normal">4</li>
									<li class="select-number-normal">5</li>
									<!--  <li class="select-number-normal">6</li>
                                    <li class="select-number-normal">7</li>
                                    <li class="select-number-normal">8</li> -->
								</ul>
							</div>
						</div>
						<div class="select-seat">
							<div class="select-seat-age">청소년</div>
							<div class="select-seat-number">
								<ul class="select-seat-ul select-seat-ul-teen">
									<li class="select-number-teen">0</li>
									<li class="select-number-teen">1</li>
									<li class="select-number-teen">2</li>
									<li class="select-number-teen">3</li>
									<li class="select-number-teen">4</li>
									<li class="select-number-teen">5</li>
									<!-- <li class="select-number-teen">6</li>
                                    <li class="select-number-teen">7</li>
                                    <li class="select-number-teen">8</li> -->
								</ul>
							</div>
						</div>
						<div class="select-seat">
							<div class="select-seat-age">우대</div>
							<div class="select-seat-number">
								<ul class="select-seat-ul  select-seat-ul-old">
									<li class="select-number-old">0</li>
									<li class="select-number-old">1</li>
									<li class="select-number-old">2</li>
									<li class="select-number-old">3</li>
									<li class="select-number-old">4</li>
									<li class="select-number-old">5</li>
									<!-- <li class="select-number-old">6</li>
                                    <li class="select-number-old">7</li>
                                    <li class="select-number-old">8</li> -->
								</ul>
							</div>
						</div>

					</div>
					<div class="reserve-number-wrapper">
						<div class="reserve-number-title">선택된 좌석 수</div>
						<div class="reserve-number">0</div>
					</div>
				</div>
				<div class="select-seat-information">
					<div class="selected-movie"><%=movietitle%></div>
					<div class="select-seat-information-wrapper">
						<div class="select-theater-place selected-theater-place-info"><%=movietheater %></div>
						<div class="select-theater-place selected-theater-place-info"><%=theatername %></div>
						<div class="select-theater-place">
							<span>남은좌석</span><span class="remain-seats">152</span>/<span
								class="all-seats"><%=seat %></span>
						</div>

					</div>
					<div class="select-theater-date">
						<div class="theater-date"><%=date%></div>
						<div class="theater-time"><%=time%></div>
					</div>
					<div class="selected-seats-wrapper">
						<span class="selected-seats-title">좌석번호</span> <span
							class="selected-seats">선택한 좌석이 없습니다.</span>
					</div>
					<div class="ticket-price-wrapper">
						<div class="ticket-price-title">가격</div>
						<div class="ticket-price">0원</div>
					</div>
					<form action="ReservationAction.jsp?SHOWING_NO=<%=SHOWING_NO %>&SHOWING_ROUND=<%=SHOWING_ROUND %>" class="seatForm" method="post">
						<input type="hidden" class="title" name="title"> 
						<input type="hidden" class="selectedTheater" name="selectedTheater">
						<input type="hidden" class="reserveDate" name="movieDate">
						<input type="hidden" class="runningTime" name="runningTime">
						<input type="hidden" class="movieAge" name="movieAge" value="<%=1%>">
						<!-- 티켓의수(선택한 좌석) -->
						<input type="hidden" class="ticketNumber" name="ticketNumber">
						<input type="hidden" class="selectedSeat" name="selectedSeat">
						<!-- 결제 정보 -->
						<input type="hidden" class="payMoney" name="payMoney">
						<button type="button" class="reserve-button" >예매하기
						</button>
					</form>
				</div>

			</div>
			<div class="seat-container">

				<div class="seat-wrapper">
					<div class="screen-view-wrapper">
						<div class="screen-view">SCREEN</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
let test = [];
let selectedSeatsArray = new Array();
const seatWrapper = document.querySelector('.seat-wrapper');
let clicked = '';
let div = '';
let seat = document.querySelectorAll('.seat');
const selectedSeats = document.querySelector('.selected-seats');
const allSeat = document.querySelector('.all-seats');
const remainSeat = document.querySelector('.remain-seats');
const reserveNumber = document.querySelector('.reserve-number');
const selectSeatListNormal = document.querySelectorAll(
    '.select-seat-ul-normal li'
);
const selectSeatListTeen = document.querySelectorAll('.select-seat-ul-teen li');
const selectSeatListOld = document.querySelectorAll('.select-seat-ul-old li');
let selectSeatListUlActive = '';
let normalNumber = 0;
let teenNumber = 0;
let oldNumber = 0;
let allNumber = 0;
let prevNumber = 0;
let normalMoney = 0;
let teenMoney = 0;
let oldMoney = 0;
let allMoney = 0;

const selectNumberNormal = document.querySelectorAll('.select-number-normal');
const selectNumberTeen = document.querySelectorAll('.select-number-teen');
const selectNumberOld = document.querySelectorAll('.select-number-old');

//예약 관련
const selectedMovie = document.querySelector('.selected-movie');
const selectedTheaterPlaceInfo = document.querySelectorAll(
    '.selected-theater-place-info'
);
const theaterTime = document.querySelector('.theater-time');
const theaterDate = document.querySelector('.theater-date');
const ticketPrice = document.querySelector('.ticket-price');
const payMoney = document.querySelector('.payMoney');

const seatForm = document.querySelector('.seatForm');
const reserveButton = document.querySelector('.reserve-button');
const title = document.querySelector('.title');
const selectedTheater = document.querySelector('.selectedTheater');
const reserveDate = document.querySelector('.reserveDate');
const runningTime = document.querySelector('.runningTime');
const ticketNumber = document.querySelector('.ticketNumber');
const selectedSeat = document.querySelector('.selectedSeat');

var a = "<%=reservation_string%>";
var b = a.split('\t');



toastr.options = {
    positionClass: 'toast-top-right',
    progressBar: true,
    timeOut: 1000,
    preventDuplicates: true,
};

//버튼클릭시 다른 class 추가 초기화해주기
function selectSeatList(list) {
    allNumber = 0;
    allMoney = 0;
    list.forEach(li => {
        //클릭시에 다른 class초기화해주기
        initList(list, li);
    });
}

function initList(list, li) {
    li.addEventListener('click', function() {
        list.forEach(li => {
            li.classList.remove('select-seat-ul-active');
        });
        li.classList.add('select-seat-ul-active');
        selectSeatListUlActive = document.querySelectorAll(
            '.select-seat-ul-active'
        );
        console.log(selectSeatListUlActive);
        selectListUiFunction(selectSeatListUlActive);
        console.log('머니머니' + allMoney);

        console.log(normalNumber);
        console.log(teenNumber);
        console.log(oldNumber);
        console.log(allNumber);
    });
}

function selectListUiFunction(selectSeatListUlActive) {
    selectSeatListUlActive.forEach(li => {
        if (li.parentNode.classList.contains('select-seat-ul-normal')) {
            normalNumber = Number(li.innerHTML);
            normalMoney = 11000 * normalNumber;
            allMoney = normalMoney + teenMoney + oldMoney;
            allNumber = normalNumber + teenNumber + oldNumber;
            ticketPrice.innerHTML = allMoney + '원';
            if (allNumber > 16) {
                li.classList.remove('select-seat-ul-active');
                allMoney -= normalMoney;
                allNumber = allNumber - normalNumber;

                selectNumberNormal[0].classList.add('select-seat-ul-active');
                ticketPrice.innerHTML = allMoney + '원';
            }
        } else if (li.parentNode.classList.contains('select-seat-ul-teen')) {
            teenNumber = Number(li.innerHTML);
            teenMoney = 8000 * teenNumber;
            allMoney = normalMoney + teenMoney + oldMoney;
            allNumber = normalNumber + teenNumber + oldNumber;
            ticketPrice.innerHTML = allMoney + '원';
            if (allNumber > 16) {
                li.classList.remove('select-seat-ul-active');
                //normalNumber = teenNumber = oldNumber = 0;
                allMoney -= teenMoney;
                allNumber = allNumber - teenNumber;

                selectNumberTeen[0].classList.add('select-seat-ul-active');
                ticketPrice.innerHTML = allMoney + '원';
            }
        } else if (li.parentNode.classList.contains('select-seat-ul-old')) {
            oldNumber = Number(li.innerHTML);
            oldMoney = 8000 * oldNumber;
            allMoney = normalMoney + teenMoney + oldMoney;
            allNumber = normalNumber + teenNumber + oldNumber;
            ticketPrice.innerHTML = allMoney + '원';
            if (allNumber > 16) {
                li.classList.remove('select-seat-ul-active');

                allMoney -= oldMoney;
                allNumber = allNumber - oldNumber;

                selectNumberOld[0].classList.add('select-seat-ul-active');
                ticketPrice.innerHTML = allMoney + '원';
            }
        }

        // allNumber = normalNumber + teenNumber + oldNumber;
        // allMoney = normalMoney + teenMoney + oldMoney;
        console.log(allNumber + '뭥미');
        ticketPrice.innerHTML = allMoney.toString()
        .replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + '원';

        if (allNumber > 16) {
            console.log(li);
            li.classList.remove('select-seat-ul-active');
            // normalNumber = teenNumber = oldNumber = 0;
            toastr.error(
                '<div style="color:white">지정한 인원수를 넘었습니다(최대 8명)</div>',
                '<div style="color:white">인원수 확인</div>', {
                    timeOut: 4000,
                }
            );
        }
        payMoney.value = allMoney;
        console.log(allMoney);
    });
}

selectSeatList(selectSeatListNormal);
selectSeatList(selectSeatListTeen);
selectSeatList(selectSeatListOld);

for (let i = 0; i < <%=column%>; i++) {
    div = document.createElement('div');
    div.classList = 'seatButtonWrapper';
    seatWrapper.append(div);

    for (let j = 0; j < <%=row%>; j++) {
        const input = document.createElement('input');
        input.type = 'button';
        input.name = 'seats';
        input.classList = 'seat';
        const d = document.createElement('input');
        d.type = 'button';
        d.name = 'seats';
        d.classList = 'reservation';
        //3중포문을 사용하지 않기위해
        mapping(input, i, j);
        div.append(input);
        //클릭시 이벤트
        inputClickEvent(input);
        if(a!=""){
	    	for(var k=0; k<b.length;k++){
	    		if(i==b[k].substring(0,1) && j== b[k].substring(1,2)){
	    			div.removeChild(input);	
	    			mapping(d, i, j);
	    			div.append(d);
	    			cClickEvent(d);
	    		}
	    	}
    	}
    }

    seat = document.querySelectorAll('.seat');
    remainSeat.innerHTML = seat.length;
    allSeat.innerHTML = <%=seat%>;
}

/* seat.forEach(data => {
    //console.log(data.value.substring(1, data.value.length));
    // console.log(data.value.substring(0, data.value.length - 1));
    //좌석이 2나 9로 끝나는얘들은 왼쪽이나 오른쪽으로 띄워주기위한 class추가
    if (data.value.substring(1, data.value.length) === '2') {
        data.classList.add('left-margin');
    } else if (data.value.substring(1, data.value.length) === '9') {
        data.classList.add('right-margin');
    }
    //앞자리가 E로끝나는 좌석들에 class 추가
    if (
        data.value.substring(0, data.value.length - 1) === 'E' ||
        data.value.substring(0, data.value.length - 2) === 'E'
    ) {
        data.classList.add('top-margin');
    }
}); */

//TODO 좌석 2개씩은 커플석으로 분리하기위해서 해당 class를 추가해줘야하는데 value가 2로끝나는얘들이랑 7로끝나는 얘들은 class를 추가해주기

function cClickEvent(d){
	d.addEventListener('click', function(e) {
		alert('이미예약된 좌석입니다.',e.target.value);
	});
}

function inputClickEvent(input) {
    input.addEventListener('click', function(e) {
        console.log(e.target.value);
        //중복방지 함수
        selectedSeatsArray = selectedSeatsArray.filter(
            (element, index) => selectedSeatsArray.indexOf(element) != index
        );

        //click class가 존재할때(제거해주는 toggle)
        if (input.classList.contains('clicked')) {
            input.classList.remove('clicked');
            clicked = document.querySelectorAll('.clicked');

            //배열안의 값 제거
            selectedSeatsArray.splice(selectedSeatsArray.indexOf(e.target.value), 1);
            clicked.forEach(data => {
                selectedSeatsArray.push(data.value);
            });
            //class가 존재안할때 추가해주는 toggle
        } else {
            input.classList.add('clicked');
            clicked = document.querySelectorAll('.clicked');
            //선택한 번호의 갯수를 넘기면 동작 못하게 하는 코드
            console.log(allNumber);
            if (clicked.length > allNumber) {
                input.classList.remove('clicked');
                toastr.error(
                    '<div style="color:white">지정한 인원수를 넘었습니다</div>',
                    '<div style="color:white">인원수 확인</div>', {
                        timeOut: 4000
                    }
                );
                return;
            }

            clicked.forEach(data => {
                selectedSeatsArray.push(data.value);
            });
        }

        console.log(selectedSeatsArray.length);
        console.log(selectedSeatsArray);
        //좌석번호의 innerHTML 설정
        selectedSeats.innerHTML = selectedSeatsArray;
        reserveNumber.innerHTML = selectedSeatsArray.length;
        remainSeat.innerHTML = seat.length - selectedSeatsArray.length - <%=visitor%>;
        // if (selectedSeatsArray.length > 4) {
        //     return;
        // }
    });
}

function mapping(input, i, j) {
    if (i === 0) {
        input.value = 'A' + j;
    } else if (i === 1) {
        input.value = 'B' + j;
    } else if (i === 2) {
        input.value = 'C' + j;
    } else if (i === 3) {
        input.value = 'D' + j;
    } else if (i === 4) {
        input.value = 'E' + j;
    } else if (i === 5) {
        input.value = 'F' + j;
    } else if (i === 6) {
        input.value = 'G' + j;
    } else if (i === 7) {
        input.value = 'H' + j;
    } else if (i === 8) {
        input.value = 'I' + j;
    } else if (i === 9) {
        input.value = 'J' + j;
    } else if (i === 10) {
        input.value = 'K' + j;
    }
}

//form 제출시 hidden설정하기
reserveButton.addEventListener('click', function() {
    title.value = selectedMovie.innerHTML;
    selectedTheater.value =
        selectedTheaterPlaceInfo[0].innerHTML +
        ' ' +
        selectedTheaterPlaceInfo[1].innerHTML;
    reserveDate.value = theaterDate.innerHTML;
    runningTime.value = theaterTime.innerHTML;
    ticketNumber.value = reserveNumber.innerHTML;
    selectedSeat.value = selectedSeats.innerHTML;
    console.log(allNumber + '임');
    console.log(ticketNumber.value);
    console.log(allNumber === ticketNumber.value);
    console.log(allNumber === Number(ticketNumber.value));
    if (
        Number(ticketNumber.value) === allNumber &&
        ticketNumber.value !== '0' &&
        ticketNumber.value !== 0
    ) {
    	if(confirm('예매를하시겠습니까?')){
        	seatForm.submit();
    	}
    } else {
        alert('좌석을 모두선택해 주세요!');
    }
});
</script>
<!-- <script src="js/seat.js"></script> -->

</html>