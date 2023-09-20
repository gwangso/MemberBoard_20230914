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
        <form id="search-form" method="get" action="/board/list">
            <div class="row mb-3">
                <div class="col-auto">
                    <select id="type" class="form-select" aria-label="Default select example">
                        <option value="boardTitle">제목</option>
                        <option value="boardWriter">작성자</option>
                    </select>
                </div>
                <div class="col col-md-6 col-xl-4">
                    <div class="input-group">
                        <span class="input-group-text">검색어</span>
                        <input id="query" class="form-control">
                        <button class="btn btn-primary" type="submit">찾기</button>
                    </div>
                </div>
            </div>
        </form>
        <table id="board-list" class="table mb-4">
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
        <div class="container mb-5">
            <ul class="pagination justify-content-center">
                <c:choose>
                    <%-- 현재 페이지가 1페이지면 이전 글자만 보여줌 --%>
                    <c:when test="${paging.page<=1}">
                        <li class="page-item disabled">
                            <a class="page-link">[처음]</a>
                        </li>
                    </c:when>
                    <%-- 1페이지가 아닌 경우에는 [이전]을 클릭하면 현재 페이지보다 1 작은 페이지 요청 --%>
                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link" href="/board/list?page=1&query=${query}&type=${type}">[처음]</a>
                        </li>
                    </c:otherwise>
                </c:choose>

                <c:choose>
                    <%-- 현재 페이지가 1페이지면 이전 글자만 보여줌 --%>
                    <c:when test="${paging.page<=1}">
                        <li class="page-item disabled">
                            <a class="page-link">[이전]</a>
                        </li>
                    </c:when>
                    <%-- 1페이지가 아닌 경우에는 [이전]을 클릭하면 현재 페이지보다 1 작은 페이지 요청 --%>
                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link" href="/board/list?page=${paging.page-1}&query=${query}&type=${type}">[이전]</a>
                        </li>
                    </c:otherwise>
                </c:choose>

                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
                    <c:choose>
                        <%-- 요청한 페이지에 있는 경우 현재 페이지 번호는 텍스트만 보이게 --%>
                        <c:when test="${i eq paging.page}">
                            <li class="page-item active">
                                <a class="page-link">${i}</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item">
                                <a class="page-link" href="/board/list?page=${i}&query=${query}&type=${type}">${i}</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:choose>
                    <c:when test="${paging.page>=paging.maxPage}">
                        <li class="page-item disabled">
                            <a class="page-link">[다음]</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link" href="/board/list?page=${paging.page+1}&query=${query}&type=${type}">[다음]</a>
                        </li>
                    </c:otherwise>
                </c:choose>

                <c:choose>
                    <c:when test="${paging.page>=paging.maxPage}">
                        <li class="page-item disabled">
                            <a class="page-link">[마지막]</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link" href="/board/list?page=${paging.maxPage}&query=${query}&type=${type}">[마지막]</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
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

    $("#search-form").on("submit",function(event){
        event.preventDefault();
        const query = $("#query").val();
        const type = $("#type").val();
        location.href = "/board/list?page=1&query="+query+"&type="+type;
    });
</script>
</html>
