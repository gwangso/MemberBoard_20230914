<%--
  Created by IntelliJ IDEA.
  User: 박경수
  Date: 2023-09-14
  Time: 오후 3:31
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
    <jsp:include page="header.jsp"/>
    <div class="row m-5">
        <div class="col">
            <h1>메인</h1>
            <div class="row justify-content-center">
                <div class="col col-md-8 col-xl-6">
                    <div class="input-group">
                        <span class="input-group-text">글찾기</span>
                        <input class="form-control">
                        <button class="btn btn-primary"></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <hr>
    <jsp:include page="footer.jsp"/>
</body>
</html>
