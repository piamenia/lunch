<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LUNCH!</title>
<!-- 현재 기기의 너비에 맞춰서 출력, 기본크기 1배, 최대 크기 1배, 확대축소 못하게
	모바일 웹 애플리케이션에서 주로 이용하는 옵션 -->
<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
<!-- IE9 이하 버전에서 HTML5의 시멘틱 태그를 사용하기 위한 설정 -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.comrespond/1.4.2respond.min.js"></script>
    <![endif]-->
<!-- jQuery설정 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jquery/jquery.1.12.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- css 설정 -->
<link rel="stylesheet" type="text/css" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" />
</head>
<body class="skin-blue sidebar-mini" style="margin:auto 2%;">
	<div class="wrapper">
		<header class="main-header">
			<div class="page-header">
				<h1><a href="${pageContext.request.contextPath }" style="color:black; text-decoration:none;">LUNCH!</a></h1>
			</div>
		</header>
	</div>
	<aside class="main-sidebar" style="margin-bottom:20px">
		<section class="sidebar">
			<ul class="nav nav-tabs">
				<li role="presentation" id="main" class="active"><a href="/lunch">메인</a></li>
				<li role="presentation" id="lunch">
					<ul class="nav nav-tabs">
						<li role="presentation" class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-expanded="false">
						     		LUNCH! <span class="caret"></span>
						   	</a>
							<ul class="dropdown-menu" role="menu">
								<li><a href="${pageContext.request.contextPath }/lunch/select">뽑기</a></li>
								<li><a href="${pageContext.request.contextPath }/lunch/register">등록하기</a></li>
								<li><a href="${pageContext.request.contextPath }/lunch/others">다른사람의 식당 보기</a></li>
								<%-- <li><a href="${pageContext.request.contextPath }/lunch/review">평가하기</a></li> --%>
						  	</ul>
						</li>
					</ul>
				</li>
				<li role="presentation" id="board"><a href="${pageContext.request.contextPath }/board/list?page=1">게시판</a></li>
				<c:if test="${member != null }">
					<li role="presentation" class="dropdown" style="float:right">
						<a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-expanded="false">
					     		${member.nickname }님<span class="caret"></span>
					   	</a>
						<ul class="dropdown-menu dropdown-menu-right" role="menu" id="member">
							<li role="presentation"><a href="${pageContext.request.contextPath}/member/update">회원정보 수정</a></li>
							<li role="presentation"><a href="${pageContext.request.contextPath}/member/code">코드보기</a></li>
							<li role="presentation"><a href="${pageContext.request.contextPath }/member/chat">채팅</a></li>
							<li role="presentation"><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
						</ul>
					</li>							
					<style>
					#member>li {
						text-align:right;
					}
					</style>
					<li role="presentation" class="dropdown" style="float:right">
					</li>
					<li role="presentation" style="float:right">
						<a id="location"></a>
						<script>
						// 현재 접속한 브라우저의 위도와 경로
						navigator.geolocation.getCurrentPosition(function(position){
							lat = position.coords.latitude;
							lng = position.coords.longitude;
							//console.log(lat+", "+lng);
							// 위도와 경도를 하나의 문자열로 만들기
							loc = lat + "-" + lng;
							// alert(loc);
							// address라는 URL에 loc를 파라미터로 넘겨서 json 타입으로 데이터를 받아오는 ajax요청
							$.ajax({
								url:"/lunch/location",
								data:{"loc":loc},
								dataType:"json",
								success:function(data){
									document.getElementById("location").innerHTML =
										data.location.split(" ")[0] + " "
										+ data.location.split(" ")[1] + " "
										+ data.location.split(" ")[2];
									// console.log(data)
								}
							})
						});
						</script>
					</li>
				</c:if>
				<c:if test="${member == null }">
					<li role="presentation" id="register" style="float:right"><a href="${pageContext.request.contextPath}/member/register">회원가입</a></li>
					<li role="presentation" id="login" style="float:right"><a href="${pageContext.request.contextPath}/member/login">로그인</a></li>
				</c:if>
			</ul>
			<script>
				$(function(){
					pathname = jQuery(location).attr('pathname');
					if(pathname.indexOf('board') >= 0){
						$("#board").addClass('active').siblings().removeClass('active');
						$("#board>a").on("click",function(e){
							e.preventDefault();
						});
					}else if(pathname.indexOf('lunch/lunch') >= 0){
						$("#lunch").addClass('active').siblings().removeClass('active');
						
					}
				});
			</script>
		</section>
	</aside>
	<div>