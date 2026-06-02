<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>登録内容の確認</title>
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
            <div class="step active">
                <span class="step-num">02</span>
                <span class="step-label">確認</span>
            </div>
            <div class="step-arrow">&#8250;</div>
            <div class="step">
                <span class="step-num">03</span>
                <span class="step-label">登録完了</span>
            </div>
        </div>
    </div>

    <!-- メインコンテンツ -->
    <div class="main-container">

        <!-- 左カラム -->
        <div class="left-col">
            <div class="left-icon">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none">
                    <circle cx="32" cy="32" r="32" fill="#1a2744"/>
                    <circle cx="32" cy="24" r="10" fill="#fff"/>
                    <path d="M12 52c0-11 9-18 20-18s20 7 20 18" stroke="#fff" stroke-width="3" stroke-linecap="round"/>
                </svg>
            </div>
            <h1 class="page-title">登録内容の確認</h1>
            <p class="page-desc">
                入力内容をご確認ください。<br>
                問題なければ「登録する」を押してください。
            </p>

            <div class="benefit-box">
                <p class="benefit-title">ご確認のお願い</p>
                <ul class="benefit-list">
                    <li><span class="benefit-icon">✓</span>入力内容に誤りはありませんか？</li>
                    <li><span class="benefit-icon">✓</span>メールアドレスは正しいですか？</li>
                    <li><span class="benefit-icon">✓</span>会員種別は正しいですか？</li>
                </ul>
            </div>

            <div class="support-box">
                <p class="support-label">修正する場合</p>
                <p class="support-text">「戻る」ボタンから<br>入力画面へ戻れます</p>
            </div>
        </div>

        <!-- 右カラム -->
        <div class="right-col">

            <div class="field-row">
                <div class="field-label-wrap">
                    <span class="field-label">ログインID</span>
                </div>
                <div class="field-input-wrap">
                    <span class="confirm-value">${userForm.loginId}</span>
                </div>
            </div>

            <div class="field-row">
                <div class="field-label-wrap">
                    <span class="field-label">パスワード</span>
                </div>
                <div class="field-input-wrap">
                    <span class="confirm-value confirm-password">&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;</span>
                </div>
            </div>

            <div class="field-row">
                <div class="field-label-wrap">
                    <span class="field-label">メールアドレス</span>
                </div>
                <div class="field-input-wrap">
                    <span class="confirm-value">${userForm.email}</span>
                </div>
            </div>

            <div class="field-row">
                <div class="field-label-wrap">
                    <span class="field-label">会員種別</span>
                </div>
                <div class="field-input-wrap">
                    <c:choose>
                        <c:when test="${userForm.role == 'premium'}">
                            <span class="confirm-value">プレミアム会員</span>
                        </c:when>
                        <c:when test="${userForm.role == 'general'}">
                            <span class="confirm-value">一般会員</span>
                        </c:when>
                        <c:when test="${userForm.role == 'guest'}">
                            <span class="confirm-value">簡易ログイン</span>
                        </c:when>
                    </c:choose>
                </div>
            </div>

            <div class="submit-wrap confirm-actions">
                <a href="<c:url value='/createAccount'/>" class="back-btn">戻る</a>
                <form action="<c:url value='/createAccount/complete'/>" modelAttribute="userForm" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="submit-btn">登録する</button>
                </form>
            </div>

        </div>
    </div>

</body>
</html>
