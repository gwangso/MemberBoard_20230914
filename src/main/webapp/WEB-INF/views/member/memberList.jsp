<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 박경수
  Date: 2023-09-15
  Time: 오후 6:25
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
        <table id="member-list" class="table" >
            <tr class="table-dark">
                <th>회원번호</th>
                <th>회원이메일</th>
                <th>회원비밀번호</th>
                <th>회원이름</th>
                <th>회원전화번호</th>
                <th></th>
            </tr>
            <c:forEach items="${memberList}" var="member">
                <tr>
                    <td class="id">${member.id}</td>
                    <td class="email">${member.memberEmail}</td>
                    <td class="password">${member.memberPassword}</td>
                    <td class="name">${member.memberName}</td>
                    <td class="mobile">${member.memberMobile}</td>
                    <td><button class="btn btn-danger btn-sm" onclick="delete_member('${member.id}')">삭제</button></td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
<hr>
<jsp:include page="../footer.jsp"/>
</body>
<script>
    const delete_member = (id) =>{
        const row = $(this).parent().parent();
        const name = row.find(".name").text();
        if(confirm("해당 회원("+name+")을 삭제하시겠습니까?")){
            location.href = "/member/delete?id="+id;
        }
    }
</script>
</html>
