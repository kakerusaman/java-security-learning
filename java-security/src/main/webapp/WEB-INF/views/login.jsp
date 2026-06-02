<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ログイン</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>

    <div class="login-wrapper">
        <div class="login-card">

            <!-- アイコン -->
            <div class="left-icon" style="text-align:center; margin-bottom:20px;">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none">
                    <circle cx="32" cy="32" r="32" fill="#1a2744"/>
                    <circle cx="32" cy="24" r="10" fill="#fff"/>
                    <path d="M12 52c0-11 9-18 20-18s20 7 20 18" stroke="#fff" stroke-width="3" stroke-linecap="round"/>
                </svg>
            </div>

            <h1 class="login-title">ログイン</h1>

            <!-- エラーメッセージ -->
            <c:if test="${param.error != null}">
                <div class="alert">ログインIDまたはパスワードが正しくありません。</div>
            </c:if>

            <form action="<c:url value='/login'/>" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <div class="login-field">
                    <label class="field-label">ログインID</label>
                    <input type="text" name="userId" class="field-input" placeholder="ログインIDを入力してください" />
                </div>

                <div class="login-field">
                    <label class="field-label">パスワード</label>
                    <input type="password" name="password" class="field-input" placeholder="パスワードを入力してください" />
                </div>

                <div class="submit-wrap" style="margin-top:28px;">
                    <button type="submit" class="submit-btn">ログイン</button>
                </div>

            </form>

            <div class="login-footer">
                <a href="<c:url value='/createAccount'/>" class="login-link">アカウントをお持ちでない方はこちら</a>
            </div>

        </div>
    </div>

</body>
</html>
