<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ユーザー登録</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<c:url value='/css/style.css'/>">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="<c:url value='/js/createAccount.js'/>"></script>
</head>
<body>

    <!-- ステップインジケーター -->
    <div class="step-bar">
        <div class="step-inner">
            <div class="step active">
                <span class="step-num">01</span>
                <span class="step-label">情報入力</span>
            </div>
            <div class="step-arrow">&#8250;</div>
            <div class="step">
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

        <!-- 左カラム：見出し・説明 -->
        <div class="left-col">
            <!-- アイコン -->
            <div class="left-icon">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none">
                    <circle cx="32" cy="32" r="32" fill="#1a2744"/>
                    <circle cx="32" cy="24" r="10" fill="#fff"/>
                    <path d="M12 52c0-11 9-18 20-18s20 7 20 18" stroke="#fff" stroke-width="3" stroke-linecap="round"/>
                </svg>
            </div>

            <h1 class="page-title">ユーザー登録</h1>
            <p class="page-desc">
                以下のフォームに必要事項をご入力の上、「登録する」ボタンを押してください。
            </p>
            <p class="page-desc-small">
                <span class="required-badge">※必須</span> は必須項目です。
            </p>

            <!-- 登録のメリット -->
            <div class="benefit-box">
                <p class="benefit-title">会員登録のメリット</p>
                <ul class="benefit-list">
                    <li>
                        <span class="benefit-icon">✓</span>
                        各種サービスへのアクセス
                    </li>
                    <li>
                        <span class="benefit-icon">✓</span>
                        会員限定コンテンツの閲覧
                    </li>
                    <li>
                        <span class="benefit-icon">✓</span>
                        プレミアム機能の利用
                    </li>
                </ul>
            </div>

            <!-- サポート -->
            <div class="support-box">
                <p class="support-label">お困りの際はこちら</p>
                <p class="support-text">サポートデスク</p>
                <p class="support-hours">平日 9:00〜18:00</p>
            </div>
        </div>

        <!-- 右カラム：フォーム -->
        <div class="right-col">

            <c:if test="${param.error != null}">
                <div class="alert">IDまたはパスワードが正しくありません。</div>
            </c:if>

            <form:form action="${pageContext.request.contextPath}/createAccount" method="POST" modelAttribute="userForm" class="form">

                <div class="field-row">
                    <div class="field-label-wrap">
                        <label class="field-label">ログインID</label>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:input type="text" path="loginId" class="field-input" placeholder="ログインIDを入力してください" maxlength="20" />
                        <form:errors path="loginId" cssClass="field-error" />
                    </div>
                </div>

                <div class="field-row">
                    <div class="field-label-wrap">
                        <label class="field-label">パスワード</label>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:input type="password" path="password" class="field-input" placeholder="パスワードを入力してください" maxlength="255" />
                        <form:errors path="password" cssClass="field-error" />
                    </div>
                </div>

                <div class="field-row">
                    <div class="field-label-wrap">
                        <label class="field-label">メールアドレス</label>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:input type="text" path="email" class="field-input" placeholder="example@email.com" />
                        <form:errors path="email" cssClass="field-error" />
                    </div>
                </div>

                <div class="field-row">
                    <div class="field-label-wrap">
                        <label class="field-label">会員種別</label>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <div class="radio-group">
                            <label class="radio-label">
                                <form:radiobutton path="role" value="premium" />
                                <span class="radio-text">プレミアム会員</span>
                            </label>
                            <label class="radio-label">
                                <form:radiobutton path="role" value="general" />
                                <span class="radio-text">一般会員</span>
                            </label>
                            <label class="radio-label">
                                <form:radiobutton path="role" value="guest" />
                                <span class="radio-text">簡易ログイン</span>
                            </label>
                        </div>
                        <form:errors path="role" cssClass="field-error" />
                    </div>
                </div>

                <div class="submit-wrap">
                    <button type="submit" class="submit-btn">登録する</button>
                </div>

            </form:form>
        </div>
    </div>

</body>
</html>
