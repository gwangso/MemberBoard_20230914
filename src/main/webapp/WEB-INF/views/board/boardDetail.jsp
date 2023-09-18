<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-09-18
  Time: 오후 2:29
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
        <c:if test="${board.boardWriter eq sessionScope.member.memberEmail}">
            <div class="mb-3 text-end">
                <button class="btn btn-outline-danger" onclick="member_check()">삭제</button>
                <button class="btn btn-outline-warning" onclick="update_board()">수정</button>
            </div>
        </c:if>
        <div id="member-check" class="input-group" style="display: none">
            <label>삭제하기 위해 비밀번호를 입력해 주세요</label>
            <span class="input-group-text">비밀번호 확인</span>
            <input id="password" name="memberPassword" class="form-control" type="password">
            <button class="btn btn-danger" onclick="delete_board()">글 삭제</button>
        </div>
        <div class="card p-5">
                <div class="row mb-4">
                    <div class="col-12"><h5>제목 : ${board.boardTitle}</h5></div>
                    <div class="col-4"><h5>작성자 : ${board.boardWriter}</h5></div>
                    <div class="col-4">작성일 : ${board.createdAt}</div>
                    <div class="col-4">조회수 : ${board.boardHits}</div>
                </div>
                <div class="p-3 mb-3"><h6>내용</h6>${board.boardContents}</div>
                <c:forEach items="${boardFileList}" var="boardFile">
                <div class="row">
                    <div class="col col-sm-6 col-lg-4 col-xl-2">
                        <img src="${pageContext.request.contextPath}/update/${boardFile.storedFileName}" width="100%">
                    </div>
                </div>
                </c:forEach>
        </div>
    </div>
</div>
<hr>
<jsp:include page="../footer.jsp"/>
</body>
<script>
    const id = '${board.id}'
    const update_board = () =>{
        location.href = "/board/update?id="+id;
    }

    const member_check = () =>{
        const memberCheck = document.getElementById("member-check")
        const password = document.getElementById("password");
        if (password.value != ${sessionScope.member.memberPassword}){
            alert("비밀번호가 틀렸습니다.")
            password.value = "";
            password.focus();
        }else {
            location.href = "/board/delete?id="+id;
        }
    }

    const delete_board = () =>{
        if(confirm("정말로 해당 글을 삭제하시겠습니까?")){
            location.href = "/board/delete?id="+id;
        }
    }
</script>
</html>