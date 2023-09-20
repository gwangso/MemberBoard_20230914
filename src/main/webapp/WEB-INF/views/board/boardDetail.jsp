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

    <!-- 핸들바 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

    <%-- bootstrap, styleSheet --%>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/resources/css/style.css">

    <!-- 페이지네이션 사용 라이브러리 -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js"></script>

</head>
<body>
<jsp:include page="../header.jsp"/>
<div class="row m-5">
    <div class="col">
        <div id="board" class="m-5">
            <c:if test="${board.boardWriter eq sessionScope.member.memberEmail}">
                <div class="mb-3 text-end">
                    <button class="btn btn-outline-danger" onclick="member_check()">삭제</button>
                    <button class="btn btn-outline-warning" onclick="update_board()">수정</button>
                </div>
            </c:if>
            <div class="input-group mb-3" id="member-check" style="display: none">
                <span class="input-group-text">비밀번호</span>
                <input id="password" name="password" type="password" class="form-control">
                <button class="btn btn-danger" onclick="delete_board()">글 삭제</button>
            </div>
            <div class="card p-5">
                <div class="row mb-4">
                    <div class="col-12"><h5>제목 : ${board.boardTitle}</h5></div>
                    <div class="col-4"><h5>작성자 : ${board.boardWriter}</h5></div>
                    <div class="col-4">작성일 : ${board.createdAt}</div>
                    <div class="col-4">조회수 : ${board.boardHits}</div>
                </div>
                <hr>
                <div class="p-3 mb-3">${board.boardContents}</div>
                <c:if test="${not empty boardFileList}">
                <div class="row">
                <c:forEach items="${boardFileList}" var="boardFile">
                    <div class="col col-sm-6 col-lg-4 col-xl-2">
                        <img src="${pageContext.request.contextPath}/update/${boardFile.storedFileName}" width="100%">
                    </div>
                </c:forEach>
                </div>
                </c:if>
            </div>
        </div>
        <hr>
        <div id="comment" class="m-5">
            <div id="comment-write-area" class="card p-4 mb-4">
                <h5 >댓글</h5>
                <c:choose>
                <c:when test="${empty sessionScope.member}">
                    <h6>로그인 후 입력가능합니다.</h6>
                </c:when>
                <c:otherwise>
                    <div id="comment-header" class="input-group">
                        <span class="input-group-text">작성자</span>
                        <input id="comment-writer" class="form-control" value="${sessionScope.member.memberEmail}" readonly>
                    </div>
                    <div id="comment-body" class="mb-3">
                        <textarea id="comment-writing" class="form-control"></textarea>
                    </div>
                    <div id="comment-footer">
                        <button class="btn btn-outline-primary btn-sm" onclick="comment_make()">댓글 작성</button>
                    </div>
                </c:otherwise>
                </c:choose>
            </div>
            <div id="comment-area" class="m-4"></div>
            <div id="pagination" class="pagination justify-content-center"></div>
        </div>
    </div>
</div>
<hr>
<jsp:include page="../footer.jsp"/>

<script id="comment-area-template" type="text/x-handlebars-template">
    {{#each .}}
    <div class="my-3">
        <span>작성자 : {{commentWriter}}</span>&nbsp;&nbsp;<span>{{createdAt}}</span>
        <br><br>
        <p class="ms-4">{{commentContents}}</p>
    </div>
    <hr>
    {{/each}}
</script>

</body>
<script>
    const id = '${board.id}'
    let commentPage = 1;
    getTotal();

    const update_board = () =>{
        location.href = "/board/update?id="+id;
    }

    const member_check = () =>{
        const memberCheck = document.getElementById("member-check")
        memberCheck.style.display = 'flex';
    }

    const delete_board = () =>{
        const password = document.getElementById("password");
        if (password.value == ""){
            alert("비밀번호를 입력해주세요")
        }else if (password.value != '${sessionScope.member.memberPassword}'){
            alert("비밀번호가 틀렸습니다.")
            password.value = "";
            password.focus();
        }else {
            if(confirm("정말로 해당 글을 삭제하시겠습니까?")){
                location.href = "/board/delete?id="+id;
            }
        }
    }

    const comment_make = () => {
        const commentWriter = document.getElementById("comment-writer").value;
        const commentContents = document.getElementById("comment-writing").value;
        const boardId = '${board.id}';
        if(commentContents==""){
            alert("댓글을 입력해주세요")
        }else {
            $.ajax({
                type:"post",
                url:"/comment/save",
                data:{
                    commentWriter:commentWriter,
                    commentContents:commentContents,
                    boardId:boardId
                },
                success:function(data){
                    getTotal()
                },
                error:function(){
                    alert("댓글작성 실패")
                }
            })
        }
    }

    function comment(){
        const boardId = '${board.id}';
        $.ajax({
            type:"get",
            url:"/comment/findAll",
            data:{
                boardId:boardId,
                commentPage:commentPage
            },
            success:function(data){
                const comment_template = Handlebars.compile($("#comment-area-template").html());
                const html_template = comment_template(data);
                $("#comment-area").html(html_template);
            },
            error:function(){
                alert("댓글불러오기 실패")
            }
        })
    }

    $('#pagination').twbsPagination({
        totalPages:10,	// 총 페이지 번호 수
        visiblePages: 5,	// 하단에서 한번에 보여지는 페이지 번호 수
        startPage : 1, // 시작시 표시되는 현재 페이지
        initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
        first : '<<',	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
        prev : '<',	// 이전 페이지 버튼에 쓰여있는 텍스트
        next : '>',	// 다음 페이지 버튼에 쓰여있는 텍스트
        last : '>>',	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
        onPageClick: function (event, curPage) { //curPage는 클릭한 페이지의 값이 들어간다.
            commentPage=curPage;
            comment();
        }
    });

    function getTotal(){
        const boardId = '${board.id}'
        $.ajax({
            type:"get",
            url:"/comment/count",
            data:{boardId:boardId},
            success:function(data){
                if(data==0){
                    $("#comment-area").html("<h3 class='text-center'>댓글이 없습니다.</h3>")
                }else {
                    const totalPages = Math.ceil(data/5);
                    $("#pagination").twbsPagination("changeTotalPages", totalPages, 1)
                }
            }
        });
    }
</script>
</html>