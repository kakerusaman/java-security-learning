<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>登録完了</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>

    <!-- ステップインジケーター -->
    <div class="step-bar">
        <div class="step-inner">
            <div class="step">
                <span class="step-num">01</span>
                <span class="step-label">情報入力</span>
            </div>
            <div class="step-arrow">&#8250;</div>
            <div class="step">
                <span class="step-num">02</span>
                <span class="step-label">確認</span>
            </div>
            <div class="step-arrow">&#8250;</div>
            <div class="step active">
                <span class="step-num">03</span>
                <span class="step-label">登録完了</span>
            </div>
        </div>
    </div>

    <!-- メインコンテンツ -->
    <div class="complete-container">

        <!-- 完了アイコン -->
        <div class="complete-icon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 80 80" fill="none">
                <circle cx="40" cy="40" r="40" fill="#1a2744"/>
                <polyline points="22,42 34,54 58,28" stroke="#fff" stroke-width="5" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </div>

        <h1 class="complete-title">登録が完了しました</h1>
        <p class="complete-desc">
            ユーザー登録が正常に完了しました。<br>
            引き続きサービスをご利用ください。
        </p>

        <a href="<c:url value='/login'/>" class="submit-btn complete-btn">ログイン画面へ</a>

    </div>

</body>
</html>
