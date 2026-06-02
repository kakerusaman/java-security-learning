<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ダミー用のAPIページ</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>

    <div class="login-wrapper">
        <div class="login-card">

            <h1 class="login-title">ダミー用のAPIページ</h1>

            <!-- HttpClientシンプル版（GET） -->
            <div class="submit-wrap" style="margin-top:28px;">
                <c:url value="/simpleHttpClientGet" var="simpleHttpClientGetUrl"/>
                <button type="button" onclick="location.href='${simpleHttpClientGetUrl}'">HttpClientシンプル版（GET）</button>
            </div>

            <!-- HttpClientカスタマイズ版（GET） -->
            <div class="submit-wrap" style="margin-top:28px;">
                <c:url value="/customHttpClientGet" var="customHttpClientGetUrl"/>
                <button type="button" onclick="location.href='${customHttpClientGetUrl}'">HttpClientカスタマイズ版（GET）</button>
            </div>

            <!-- HttpClientシンプル版（POST） -->
            <div class="submit-wrap" style="margin-top:28px;">
                <form action="<c:url value='/simpleHttpClientPost'/>" method="post">
                    <button type="submit">HttpClientシンプル版（POST）</button>
                </form>
            </div>

            <!-- HttpClientカスタマイズ版（POST） -->
            <div class="submit-wrap" style="margin-top:28px;">
                <form action="<c:url value='/customHttpClientPost'/>" method="post">
                    <button type="submit">HttpClientカスタマイズ版（POST）</button>
                </form>
            </div>

            <!-- 郵便番号API -->
            <div class="submit-wrap" style="margin-top:28px;">
                <form action="<c:url value='/zipCloudApi'/>" method="get">
                    <input type="text" name="zipCode" placeholder="例）1600022" />
                    <button type="submit">郵便番号API</button>
                </form>
            </div>

        </div>
    </div>

</body>
</html>
