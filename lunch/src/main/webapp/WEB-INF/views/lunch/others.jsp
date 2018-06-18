<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<div class="row">
	<div class="form-group container col-sm-offset-1 col-sm-10 well">
		<form class="form-horizontal col-sm-12">
			<legend><h2 align="center">LUNCH! <small>다른 사람의 식당 보기</small></h2></legend>
			<div class="form-group">
				<label for="code" class="col-sm-2 control-label">코드 입력</label>
				<div class="col-sm-10">
					<input type="text" id="code" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<label for="foodstyle" class="col-sm-2 control-label">음식 종류</label>
				<div class="col-sm-10">
					<label class="radio-inline">
						<input type="radio" name="foodstyle" id="foodstyle1" value="한식" checked>한식
					</label>
					<label class="radio-inline">
						<input type="radio" name="foodstyle" id="foodstyle2" value="일식">일식
					</label>
					<label class="radio-inline">
						<input type="radio" name="foodstyle" id="foodstyle3" value="중식">중식
					</label>
					<label class="radio-inline">
						<input type="radio" name="foodstyle" id="foodstyle4" value="양식">양식
					</label>
					<label class="radio-inline">
						<input type="radio" name="foodstyle" id="foodstyle5" value="분식">분식
					</label>
					<label class="radio-inline">
						<input type="radio" name="foodstyle" id="foodstyle6" value="기타">기타
					</label>
				</div>
			</div>
			<div class="form-group">
				<label for="distance" class="col-sm-2 control-label">거리(이하)</label>
				<div class="col-sm-10">
					<label class="radio-inline">
						<input type="radio" name="distance" id="distance5" value="1" checked>멂
					</label>
					<label class="radio-inline">
						<input type="radio" name="distance" id="distance4" value="2">멀지는 않음
					</label>
					<label class="radio-inline">
						<input type="radio" name="distance" id="distance3" value="3">적당함
					</label>
					<label class="radio-inline">
						<input type="radio" name="distance" id="distance2" value="4">가까운 편
					</label>
					<label class="radio-inline">
						<input type="radio" name="distance" id="distance1" value="5">가까움
					</label>
				</div>
			</div>
			<div class="form-group">
				<label for="tasty" class="col-sm-2 control-label">맛(이상)</label>
				<div class="col-sm-10">
					<label class="radio-inline">
						<input type="radio" name="tasty" id="tasty1" value="1" checked>으.. 노맛
					</label>
					<label class="radio-inline">
						<input type="radio" name="tasty" id="tasty2" value="2">음? 이건 무슨맛..?
					</label>
					<label class="radio-inline">
						<input type="radio" name="tasty" id="tasty3" value="3">흠 그냥 그렇네
					</label>
					<label class="radio-inline">
						<input type="radio" name="tasty" id="tasty4" value="4">오 나쁘지 않은데?
					</label>
					<label class="radio-inline">
						<input type="radio" name="tasty" id="tasty5" value="5">헐 대박 존맛탱
					</label>
				</div>
			</div>
			<div class="form-group">
				<label for="price" class="col-sm-2 control-label">가격대(이하)</label>
				<div class="col-sm-10">
					<label class="radio-inline">
						<input type="radio" name="price" id="price1" value="1" checked>헐 넘 비쌈
					</label>
					<label class="radio-inline">
						<input type="radio" name="price" id="price2" value="2">비싸긴 하네
					</label>
					<label class="radio-inline">
						<input type="radio" name="price" id="price3" value="3">적당적당
					</label>
					<label class="radio-inline">
						<input type="radio" name="price" id="price4" value="4">싼편
					</label>
					<label class="radio-inline">
						<input type="radio" name="price" id="price5" value="5">오 싸다!
					</label>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-12" style="text-align:center; margin-top:10px;">
					<a class="btn btn-success" id="listbtn" href="javascript:list()" role="button">식당 목록보기</a>
					<a class="btn btn-primary" id="selectbtn" href="javascript:select()" role="button">식당 뽑기</a>
				</div>
			</div>
		</form>
		<div id="list" style="display:none;"></div>
		<div id="result" style="display:none;">
			<table class="table table-bordered">
				<tr>
					<th style="width:15%">식당 이름</th>
					<th style="width:10%">거리</th>
					<th style="width:20%">맛</th>
					<th style="width:10%">가격대</th>
					<th style="width:10%">총점</th>
					<th style="width:35%">설명</th>
				</tr>
				<tr>
					<td id="rstname"></td>
					<td id="distance"></td>
					<td id="tasty"></td>
					<td id="price"></td>
					<td id="totalscore"></td>
					<td id="description"></td>
				</tr>
			</table>
		</div>
	</div>
</div>
<!-- 메시지 대화상자 -->
<div id="dialog-message" title="" style="display:none">
	<p>
		<span class="ui-icon ui-icon-circle-check"
			style="float: left; margin: 0 7px 50px 0;"></span>
		<span id="msg"></span>
	</p>
</div>
<script>
// 목록보기 버튼을 클릭하면 호출되는 함수
function list(){
	// 코드체크 함수에 입력된 code와 클릭한 버튼의 id를 넘겨줌
	code = document.getElementById("code").value;
	btn = document.getElementById("listbtn").getAttribute("id");
	codecheck(code, btn);
}

//식당 뽑기를 클릭하면 호출될 함수
function select(){
	code = document.getElementById("code").value;
	btn = document.getElementById("selectbtn").getAttribute("id");
	codecheck(code, btn);
}

//존재하는 membercode 인지 확인하는 함수
function codecheck(code, btn){
	//console.log("코드체크")
	$.ajax({
		url: "codecheck",
		type : "POST",
		data : {
			"membercode": code
			},
		dataType : "json",
		success: function(data){
			//console.log(data.result)
			if(data.result){
				// 존재하면 클릭한 버튼의 아이디를 구분해서 다음 함수 호출
				if(btn.indexOf("list") >= 0){
					listDisp();
				}else if(btn.indexOf("select") >= 0){
					selectDisp();
				}
			}else{
				// 존재하지 않는 코드면 코드 입력창으로 이동
				document.getElementById("msg").innerHTML="존재하지 않는 코드입니다.";
				$("#dialog-message").dialog({
					modal : true,
					buttons : {
						"닫기" : function() {
							$(this).dialog("close");
							document.getElementById("code").focus();
						}
					}
				});
			}
		}
	});
}

// 입력된 사용자코드의 식당리스트를 가져오는 함수
function listDisp(){
	document.getElementById("result").style.display = "none";
	// ajax를 이용해 전체 식당 리스트 불러오기
	$.ajax({
		url: "list",
		type : "POST",
		data : {
			"membercode": code
			},
		dataType : "json",
		success: function(data){
			if(listcheck(data) == true){
				//console.log(data)
				display(data);
			}
		}
	});
}

// 가져온 데이터를 출력하는 함수
function display(data){
	disp = "<table class='table table-bordered'><tr>";
	disp += "<th style='width:8%;'>종류</th>";
	disp += "<th style='width:12%;'>식당 이름</th>";
	disp += "<th style='width:10%;'>거리</th>";
	disp += "<th style='width:18%;'>맛</th>";
	disp += "<th style='width:14%;'>가격대</th>";
	disp += "<th style='width:6%;'>총점</th>";
	disp += "<th style='width:27%;'>설명</th></tr>";
	$(data.list).each(function(idx,item){
		//console.log(item)
		disp += "<tr>";
		disp += "<td>" + item.foodstyle + "</td>";
		disp += "<td>" + item.rstname + "</td>";
		// distance, tasty, price는 변환해서 출력;
		switch(item.distance){
		case 1: 
			distance = "멂";
			break;
		case 2:
			distance = "멀지는 않음";
			break;
		case 3:
			distance = "적당함";
			break;
		case 4:
			distance = "가까운 편";
			break;
		case 5:
			distance = "가까움";
			break;
		}
		disp += "<td>" + distance + "</td>";
		switch(item.tasty){
		case 1:
			tasty = "으 노맛";
			break;
		case 2:
			tasty = "음? 이건 무슨맛?";
			break;
		case 3:
			tasty = "흠 그냥 그렇네";
			break;
		case 4:
			tasty = "오 나쁘지 않은데";
			break;
		case 5:
			tasty = "헐 대박 존맛탱";
			break;
		}
		disp += "<td>" + tasty + "</td>";
		switch(item.price){
		case 1:
			price = "헐 넘 비쌈";
			break;
		case 2:
			price = "비싸긴 하네";
			break;
		case 3:
			price = "적당적당";
			break;
		case 4:
			price = "싼편";
			break;
		case 5:
			price = "오 싸다!";
			break;
		}
		disp += "<td>" + price + "</td>";
		disp += "<td>" + item.totalscore + "</td>";
		disp += "<td>" + item.description + "</td>";
		disp += "</tr>"
	});
	disp += "</table>"
	document.getElementById("list").innerHTML = disp;
	document.getElementById("list").style.display = "block";
}

// 입력된 사용자코드의 식당중 조건에 맞는 식당에서 랜덤하게 1개 뽑기
function selectDisp(){
	document.getElementById("list").style.display = "none";
	foodstyle = $("input[name='foodstyle']:checked").val();
	distance = $("input[name='distance']:checked").val();
	tasty = $("input[name='tasty']:checked").val();
	price = $("input[name='price']:checked").val();
	// console.log(distance +" " +tasty + " " +price)
	// ajax를 이용해 조건에 맞는 식당 리스트 불러오기
	$.ajax({
		url: "select",
		type : "POST",
		data : {
			"membercode": code,
			"foodstyle": foodstyle,
			"distance" : distance, 
			"tasty" : tasty,
			"price" : price	
			},
		dataType : "json",
		success: function(data){
			if(listcheck(data) == true){
				//console.log(data.list)
				// data.list에 저장된 배열에서 totalscore를 기반으로 랜덤하게 뽑기
				rstlist = data.list;
				random(rstlist);	
			};
		}
	});
}

// 식당 뽑기를 클릭했을 때 가져온 식당리스트가 있으면 호출되는 함수
function random(rstlist){
	// 가져온 리스트 중에 랜덤하게 출력
	// totalscore를 기반으로 뽑힐 확률 조정
	// totalscore*10 개 만큼씩 배열에 넣어서 랜덤으로 뽑기
	scorelist = new Array();
	for(i=0; i<rstlist.length; i++){
		for(j=0; j<rstlist[i].totalscore*10;j++){
			scorelist.push(rstlist[i]);
		}
	}
	//console.log(scorelist);
	
	idx = Math.floor(Math.random() * scorelist.length);
	// console.log(idx)
	//console.log(scorelist[idx]);
	document.getElementById("result").style.display = "block";
	document.getElementById("rstname").innerText = scorelist[idx].rstname;
	// distance, tasty, price는 변환해서 출력;
	switch(scorelist[idx].distance){
	case 1: 
		distance = "멂";
		break;
	case 2:
		distance = "멀지는 않음";
		break;
	case 3:
		distance = "적당함";
		break;
	case 4:
		distance = "가까운 편";
		break;
	case 5:
		distance = "가까움";
		break;
	}
	document.getElementById("distance").innerText = distance;
	switch(scorelist[idx].tasty){
	case 1:
		tasty = "으 노맛";
		break;
	case 2:
		tasty = "음? 이건 무슨맛?";
		break;
	case 3:
		tasty = "흠 그냥 그렇네";
		break;
	case 4:
		tasty = "오 나쁘지 않은데";
		break;
	case 5:
		tasty = "헐 대박 존맛탱";
		break;
	}
	document.getElementById("tasty").innerText = tasty;
	switch(scorelist[idx].price){
	case 1:
		price = "헐 넘 비쌈";
		break;
	case 2:
		price = "비싸긴 하네";
		break;
	case 3:
		price = "적당적당";
		break;
	case 4:
		price = "싼편";
		break;
	case 5:
		price = "오 싸다!";
		break;
	}
	document.getElementById("price").innerText = price;
	document.getElementById("description").innerText = scorelist[idx].description;
	document.getElementById("totalscore").innerText = scorelist[idx].totalscore;
}

// 등록된 식당이 있는지 확인하는 함수
function listcheck(data){
	if(data.list == null || data.list.length==0){
		// 등록된 식당이 하나도 없으면 코드 입력창으로 이동
		document.getElementById("msg").innerHTML="등록된 식당이 없습니다.";
		$("#dialog-message").dialog({
			modal : true,
			buttons : {
				"닫기" : function() {
					$(this).dialog("close");
					document.getElementById("code").focus();
				}
			}
		});
		return false;
	}
	return true;
}
</script>
<%@ include file="../include/footer.jsp" %>