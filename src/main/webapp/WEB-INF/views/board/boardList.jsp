<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-09-18
  Time: 오전 11:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <table class="table">
            <tr class="table-danger">
                <th>글번호</th>
                <th>글제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>조회수</th>
            </tr>
            <c:forEach items="${boardList}" var="board">
                <tr class="board" style="cursor: pointer">
                    <td class="id">${board.id}</td>
                    <td>${board.boardTitle}</td>
                    <td>${board.boardWriter}</td>
                    <td>${board.createdAt}</td>
                    <td>${board.boardHits}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
<hr>
<jsp:include page="../footer.jsp"/>
</body>
<script>
    $(".board").on("click",function(){
        const id = $(this).find(".id").text();
        location.href = "/board/detail?id="+id;
    })
</script>
</html>
