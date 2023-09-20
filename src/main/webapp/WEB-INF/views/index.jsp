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
            <form id="search-form" class="" method="get" action="/board/list">
                <div class="row mb-3 justify-content-center">
                    <div class="col-auto">
                        <select id="type" class="form-select form-select-lg" aria-label="Default select example">
                            <option value="boardTitle">제목</option>
                            <option value="boardWriter">작성자</option>
                        </select>
                    </div>
                    <div class="col col-md-6 col-xl-4">
                        <div class="input-group">
                            <span class="input-group-text">검색어</span>
                            <input id="query" class="form-control form-control-lg">
                            <button class="btn btn-primary" type="submit">찾기</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <hr>
    <jsp:include page="footer.jsp"/>
</body>
<script>
    $("#search-form").on("submit",function(event){
        event.preventDefault();
        const query = $("#query").val();
        const type = $("#type").val();
        location.href = "/board/list?page=1&query="+query+"&type="+type;
    });
</script>
</html>
