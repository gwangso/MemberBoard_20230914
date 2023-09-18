<%--
  Created by IntelliJ IDEA.
  User: 박경수
  Date: 2023-09-14
  Time: 오후 5:27
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
        <div class="card p-5">
            <div id="title" class="mb-4 ms-4">
                <h3>회원가입</h3>
            </div>
            <div id="info" class="text-end">
                <p style="color:red">붉은색 *이 표시된 부분은 필수 입력사항입니다.</p>
            </div>
            <form id="save-form" name="saveForm" action="/member/save" method="post" enctype="multipart/form-data">
                <div class="row">
                    <div class="col-lg-6 mb-5">
                        <input type="file" name="memberProfile" class="form-control">
                        <div class="input-group mb-5 text-center">
                            <span class="input-group-text">프로필 사진</span>
                            <span class="input-group-text"><img id="profile-image"
                                                                src="http://via.placeholder.com/300x300" width='100%'></span>
                        </div>
                    </div>
                    <div class="col-lg-6 mb-5">
                        <div class="input-group mb-5">
                            <span class="input-group-text"><p style="color: red">*</p>이메일</span>
                            <div class="form-floating">
                                <input type="text" id="member-email" name="memberEmail" class="form-control"
                                       onkeyup="check_duplicate(this.value)">
                                <label for="member-email" id="duplicate-check" style="color:gray">이메일을 입력해주세요</label>
                            </div>
                        </div>
                        <div class="input-group mb-5">
                            <span class="input-group-text"><p style="color: red">*</p>비밀번호</span>
                            <div class="form-floating">
                                <input type="password" id="password" name="memberPassword" class="form-control"
                                       onkeyup="password_check(this.value)">
                                <label for="member-email" id="password-check" style="color:gray">영어,숫자,특수문자로 조합된 8자리 이상의
                                    비밀번호를 입력해주세요</label>
                            </div>
                        </div>
                        <div class="input-group mb-5">
                            <span class="input-group-text"><p style="color: red">*</p>이름</span>
                            <input name="memberName" class="form-control">
                        </div>
                        <div class="input-group">
                            <span class="input-group-text">전화번호</span>
                            <input name="memberMobile" class="form-control">
                        </div>
                    </div>
                </div>
                <div class="text-end my-3">
                    <input type="reset" class="btn btn-outline-warning" value="초기화">
                    <input type="button" class="btn btn-outline-success" value="회원가입" onclick="save_member()">
                </div>
            </form>

        </div>
    </div>
</div>
<hr>
<jsp:include page="../footer.jsp"/>
</body>

<script>
    let duplicateCheck = false;
    let passwordCheck = false;

    const check_duplicate = (memberEmail) => {
        const duplicateLabel = document.getElementById("duplicate-check")
        if (memberEmail == "") {
            duplicateCheck = false;
            duplicateLabel.innerText = "이메일을 입력해주세요.";
            duplicateLabel.style.color = "gray";
        } else {
            $.ajax({
                type: "post",
                url: "/member/duplicate",
                data: {memberEmail: memberEmail},
                success: function (data) {
                    if (data >= 1) {
                        duplicateCheck = true;
                        duplicateLabel.innerText = "사용할 수 있는 아이디입니다.";
                        duplicateLabel.style.color = "green";
                    } else {
                        duplicateCheck = false;
                        duplicateLabel.innerText = "사용할 수 없는 아이디입니다.";
                        duplicateLabel.style.color = "red";
                    }
                }
            })
        }
    }

    const password_check = (memberPassword) => {
        const reg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
        const passwordLabel = document.getElementById("password-check")
        if (memberPassword == "") {
            passwordCheck = false;
            passwordLabel.innerText = "영어,숫자,특수문자로 조합된 8자리 이상의 비밀번호를 입력해주세요.";
            passwordLabel.style.color = "gray";
        } else if (reg.test(memberPassword)) {
            passwordCheck = false;
            passwordLabel.innerText = "사용가능한 비밀번호입니다.";
            passwordLabel.style.color = "green";
        } else {
            passwordCheck = false;
            passwordLabel.innerText = "사용할 수 없는 비밀번호입니다.";
            passwordLabel.style.color = "red";
        }
    }

    const save_member = () => {
        const memberSaveForm = document.querySelector("#save-form");
        if (confirm("해당 정보로 가입하시겠습니까?")) {
            memberSaveForm.submit();
        }
    }

    // 사진 미리보기
    $(saveForm.memberProfile).on("change", function (e) {
        $("#profile-image").attr("src", URL.createObjectURL(e.target.files[0]));
    })
</script>
</html>
