<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>本人情報</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <script src="<c:url value='/js/Ajax.js'/>"></script>
</head>
<body>

    <div class="main-container">

        <!-- 左カラム -->
        <div class="left-col">
            <p class="page-title">本人情報</p>
            <p class="page-desc">ご本人の情報を入力してください。</p>
        </div>

        <!-- 右カラム -->
        <div class="right-col">

            <form:form action="/userInfo001" method="post" modelAttribute="userInfo001Form">

                <!-- 苗字 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">苗字</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:input path="lastName" placeholder="例）山田" />
                        <form:errors path="lastName" cssClass="field-error" />
                    </div>
                </div>

                <!-- 名前 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">名前</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:input path="firstName" placeholder="例）太郎" />
                        <form:errors path="firstName" cssClass="field-error" />
                    </div>
                </div>

                <!-- 苗字カナ -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">苗字カナ</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:input path="lastNameKana" placeholder="例）ヤマダ" />
                        <form:errors path="lastNameKana" cssClass="field-error" />
                    </div>
                </div>

                <!-- 名前カナ -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">名前カナ</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:input path="firstNameKana" placeholder="例）タロウ" />
                        <form:errors path="firstNameKana" cssClass="field-error" />
                    </div>
                </div>

                <!-- 性別 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">性別</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <div class="radio-group">
                            <label class="radio-label">
                                <form:radiobutton path="gender" value="male" />
                                <span class="radio-text">男性</span>
                            </label>
                            <label class="radio-label">
                                <form:radiobutton path="gender" value="female" />
                                <span class="radio-text">女性</span>
                            </label>
                            <label class="radio-label">
                                <form:radiobutton path="gender" value="other" />
                                <span class="radio-text">その他</span>
                            </label>
                        </div>
                        <form:errors path="gender" cssClass="field-error" />
                    </div>
                </div>

                <!-- 郵便番号 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">郵便番号</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <div class="zip-input-wrap">
                            <form:input path="zipCode" placeholder="例）1600022" />
                            <button type="button" class="zip-search-btn">郵便番号検索</button>
                        </div>
                        <form:errors path="zipCode" cssClass="field-error" />
                    </div>
                </div>

                <!-- 住所 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">住所</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:input path="address" placeholder="例）東京都新宿区新宿" />
                        <form:errors path="address" cssClass="field-error" />
                    </div>
                </div>

                <!-- 番地 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">番地</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:input path="streetNumber" placeholder="例）1-2-3" />
                        <form:errors path="streetNumber" cssClass="field-error" />
                    </div>
                </div>

                <!-- 住所フリガナ -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">住所フリガナ</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:input path="addressKana" placeholder="例）トウキョウトシンジュククシンジュク" />
                        <form:errors path="addressKana" cssClass="field-error" />
                    </div>
                </div>

                <!-- 番地フリガナ -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">番地フリガナ</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:input path="streetNumberKana" placeholder="例）イチノニノサン" />
                        <form:errors path="streetNumberKana" cssClass="field-error" />
                    </div>
                </div>

                <!-- 生年月日 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">生年月日</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:input type="date" path="birthDate" />
                        <form:errors path="birthDate" cssClass="field-error" />
                    </div>
                </div>

                <!-- 電話番号 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">電話番号</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:input path="phoneNumber" placeholder="例）09012345678" />
                        <form:errors path="phoneNumber" cssClass="field-error" />
                    </div>
                </div>

                <!-- 緊急連絡先氏名 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">緊急連絡先氏名</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:input path="emergencyName" placeholder="例）山田 花子" />
                        <form:errors path="emergencyName" cssClass="field-error" />
                    </div>
                </div>

                <!-- 緊急連絡先電話番号 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">緊急連絡先電話番号</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:input path="emergencyPhone" placeholder="例）09087654321" />
                        <form:errors path="emergencyPhone" cssClass="field-error" />
                    </div>
                </div>

                <div class="submit-wrap">
                    <button type="button" class="temp-save-btn">一時保存</button>
                    <button type="submit" class="submit-btn">次へ</button>
                </div>

            </form:form>

        </div>
    </div>


<script>
document.querySelector('.temp-save-btn').addEventListener('click', function () {
    const form = document.querySelector('form');
    const formData = new FormData(form);
    const data = {};
    formData.forEach(function (value, key) {
        if (key !== '_csrf') data[key] = value;
    });

    ajaxRequest({
        url: '/api/userInfo001/tempSave',
        method: 'POST',
        data: data,
        onSuccess: function (result) {
            alert(result.message);
        },
        onError: function (status, message) {
            alert('一時保存に失敗しました: ' + message);
        }
    });
});
</script>

</body>
</html>
