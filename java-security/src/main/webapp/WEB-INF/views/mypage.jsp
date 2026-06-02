<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>マイページ</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>

    <div class="login-wrapper">
        <div class="login-card">

            <h1 class="login-title">マイページ</h1>

            <div class="submit-wrap" style="margin-top:28px;">
                <c:url value="/userInfo/userInfo001" var="userInfo001Url"/>                                                                                                                                                                     
                <button type="button" onclick="location.href='${userInfo001Url}'">本人情報入力</button>  
            </div>

            <div class="submit-wrap" style="margin-top:28px;">
                <c:url value="/mockApiController" var="mockApiController"/>                                                                                                                                                                     
                <button type="button" onclick="location.href='${mockApiController}'">JSONPlaceholder</button>  
            </div>

        </div>
    </div>

</body>
</html>
