<%--
  Created by IntelliJ IDEA.
  User: 박경수
  Date: 2023-09-14
  Time: 오후 4:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="row">
    <div class="col">
        <nav class="navbar navbar-expand bg-body-tertiary px-5 py-3">
            <div class="container-fluid">
                <a class="navbar-brand" href="/">Home</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-between" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="/board/save">글작성</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="/board/list">글목록</a>
                        </li>
                    </ul>
                    <ul class="navbar-nav text-end">
                        <c:if test="${sessionScope.member.memberEmail eq 'admin'}">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="/member/list">회원목록</a>
                            </li>
                        </c:if>
                        <c:if test="${not empty sessionScope.member.id}">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="/member/detail?id=${sessionScope.member.id}">${sessionScope.member.memberName}</a><p>님 환영합니다.<p>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="/member/logout">로그아웃</a>
                            </li>
                        </c:if>
                        <c:if test="${empty sessionScope.member.id}">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="/member/save">회원가입</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="/member/login">로그인</a>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </nav>
    </div>
</div>

