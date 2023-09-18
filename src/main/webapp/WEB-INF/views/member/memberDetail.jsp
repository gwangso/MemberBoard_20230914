<%--
  Created by IntelliJ IDEA.
  User: 박경수
  Date: 2023-09-15
  Time: 오후 7:48
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

    <style>
        #profile {
            border-radius: 10%;
        }
    </style>
</head>
<body>
<jsp:include page="../header.jsp"/>
<div class="row m-5">
    <div class="col">
        <div class="card p-4" style="width: 800px">
            <div class="row">
                <div class="col-6">
                    <c:if test="${empty memberFile}">
                        <img id="none-profile" src="http://placehold.it/150X150" width="300px">
                    </c:if>
                    <c:if test="${not empty memberFile}">
                        <a href="${pageContext.request.contextPath}/profile/${memberFile.storedFileName}" target="_blank"><img id="profile" src="${pageContext.request.contextPath}/profile/${memberFile.storedFileName}" width="300px"></a>
                    </c:if>
                </div>
                <div class="col-6 ps-2">
                    <h5>이메일${member.memberEmail}</h5>
                    <br>
                    <h5>이름 : ${member.memberName}</h5>
                    <br>
                    <h5>전화번호 : ${member.memberMobile}</h5>
                    <br>
                    <div class="">
                        <button class="btn btn-outline-warning" onclick="update_page(${member.id})">수정</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<hr>
<jsp:include page="../footer.jsp"/>
</body>
<script>
    const update_page = (id) => {
        location.href = "/member/update?id="+id;
    }

</script>
</html>
