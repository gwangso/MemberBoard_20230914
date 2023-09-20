<%--
  Created by IntelliJ IDEA.
  User: 박경수
  Date: 2023-09-14
  Time: 오후 5:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

    <%-- jquery --%>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>

    <%-- bootstrap, styleSheet --%>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>
<jsp:include page="../header.jsp"/>
<div class="row m-5">
    <div class="col">
        <div class="row justify-content-center">
            <div id="title" class="text-center mb-3">
                <h3>로그인</h3>
            </div>
            <div class="card p-5 " style="width: 500px">
                <form action="/member/login" id="login-form" method="post">
                    <div class="input-group" style="display: none">
                        <span class="input-group-text">돌아갈 주소</span>
                        <input type="text" name="url" class="form-control" value="${url}">
                    </div>
                    <div class="input-group mb-3">
                        <span class="input-group-text">아이디</span>
                        <input type="text" name="memberEmail" class="form-control">
                    </div>
                    <div class="input-group mb-3">
                        <span class="input-group-text">비밀번호</span>
                        <input type="password" name="memberPassword" class="form-control">
                    </div>
                    <div class="text-end">
                        <input type="submit" class="btn btn-primary" value="로그인">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<hr>
<jsp:include page="../footer.jsp"/>
</body>

</html>
