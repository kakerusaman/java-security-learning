<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OTPコード入力</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<c:url value='/css/style.css'/>">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="<c:url value='/js/otpInput.js'/>"></script>
</head>
<body>

    <div class="login-wrapper">
        <div class="login-card otp-card">

            <!-- アイコン -->
            <div class="otp-icon">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none">
                    <circle cx="32" cy="32" r="32" fill="#1a2744"/>
                    <rect x="20" y="18" width="24" height="30" rx="4" fill="none" stroke="#fff" stroke-width="2.5"/>
                    <line x1="26" y1="24" x2="38" y2="24" stroke="#fff" stroke-width="2" stroke-linecap="round"/>
                    <line x1="26" y1="30" x2="38" y2="30" stroke="#fff" stroke-width="2" stroke-linecap="round"/>
                    <circle cx="32" cy="37" r="2" fill="#fff"/>
                </svg>
            </div>

            <h1 class="login-title">2段階認証</h1>
            <p class="otp-desc">
                認証アプリに表示されている<br>
                6桁のコードを入力してください。
            </p>

            <!-- エラーメッセージ -->
            <c:if test="${param.error != null}">
                <div class="alert">コードが正しくありません。再度お試しください。</div>
            </c:if>
            <c:if test="${param.expired != null}">
                <div class="alert">セッションの有効期限が切れました。再度ログインしてください。</div>
            </c:if>

            <form action="<c:url value='/otp'/>" method="post" id="otpForm">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <!-- 6桁の個別入力ボックス -->
                <div class="otp-inputs">
                    <input type="text" class="otp-box" maxlength="1" inputmode="numeric" pattern="[0-9]" autocomplete="off"/>
                    <input type="text" class="otp-box" maxlength="1" inputmode="numeric" pattern="[0-9]" autocomplete="off"/>
                    <input type="text" class="otp-box" maxlength="1" inputmode="numeric" pattern="[0-9]" autocomplete="off"/>
                    <span class="otp-separator">-</span>
                    <input type="text" class="otp-box" maxlength="1" inputmode="numeric" pattern="[0-9]" autocomplete="off"/>
                    <input type="text" class="otp-box" maxlength="1" inputmode="numeric" pattern="[0-9]" autocomplete="off"/>
                    <input type="text" class="otp-box" maxlength="1" inputmode="numeric" pattern="[0-9]" autocomplete="off"/>
                </div>

                <!-- 6桁をまとめてサーバーに送る hidden -->
                <input type="hidden" name="otpCode" id="otpCode"/>

                <div class="submit-wrap" style="margin-top:28px;">
                    <button type="submit" class="submit-btn" id="otpSubmit" disabled>確認する</button>
                </div>

            </form>

            <div class="login-footer">
                <a href="<c:url value='/login'/>" class="login-link">ログイン画面に戻る</a>
            </div>

        </div>
    </div>

</body>
</html>
