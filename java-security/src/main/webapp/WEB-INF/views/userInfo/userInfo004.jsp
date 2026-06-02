<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>本人確認</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>

    <div class="main-container">

        <!-- 左カラム -->
        <div class="left-col">
            <p class="page-title">本人確認</p>
            <p class="page-desc">本人確認書類をご提出いただきます。</p>
        </div>

        <!-- 右カラム -->
        <div class="right-col">

            <!-- ガイダンス -->
            <div class="guidance-box">
                <p class="guidance-title">📋 身分証明書の提出について</p>
                <ul class="guidance-list">
                    <li>ご本人様名義の身分証明書をご用意ください。</li>
                    <li>有効期限内のものに限ります。</li>
                    <li>記載内容が鮮明に確認できるものをご提出ください。</li>
                    <li>提出いただいた情報は本人確認の目的のみに使用します。</li>
                </ul>
            </div>

            <form:form action="/userInfo004" method="post" modelAttribute="userInfo004Form" enctype="multipart/form-data">

                <!-- 身分証明書提出への同意 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">提出への同意</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <label class="checkbox-label">
                            <form:checkbox path="consentSubmit" />
                            <span class="checkbox-text">身分証明書の提出に同意します</span>
                        </label>
                        <form:errors path="consentSubmit" cssClass="field-error" />
                    </div>
                </div>

                <!-- 身分証明書の種類 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">証明書の種類</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:select path="idType" cssClass="field-select" onchange="togglePinInput(this)">
                            <form:option value="" label="選択してください" />
                            <form:option value="driverLicense" label="運転免許証" />
                            <form:option value="passport" label="パスポート" />
                            <form:option value="myNumber" label="マイナンバーカード" />
                            <form:option value="healthInsurance" label="健康保険証" />
                            <form:option value="residenceCard" label="在留カード" />
                        </form:select>
                        <form:errors path="idType" cssClass="field-error" />
                    </div>
                </div>

                <!-- ファイルアップロード（証明書種類選択後に表示） -->
                <div id="fileUploadWrap" class="file-upload-wrap">
                    <div class="field-row">
                        <div class="field-label-wrap">
                            <span class="field-label">証明書（表面）</span>
                            <span class="required-badge">※必須</span>
                        </div>
                        <div class="field-input-wrap">
                            <label class="file-upload-label">
                                <input type="file" name="idFront" accept="image/*,.pdf" class="file-input" />
                                <span class="file-upload-btn">ファイルを選択</span>
                                <span class="file-name-text" id="frontFileName">選択されていません</span>
                            </label>
                            <span class="field-hint">JPG・PNG・PDF形式でアップロードしてください</span>
                        </div>
                    </div>
                    <div class="field-row">
                        <div class="field-label-wrap">
                            <span class="field-label">証明書（裏面）</span>
                            <span class="required-badge">※必須</span>
                        </div>
                        <div class="field-input-wrap">
                            <label class="file-upload-label">
                                <input type="file" name="idBack" accept="image/*,.pdf" class="file-input" />
                                <span class="file-upload-btn">ファイルを選択</span>
                                <span class="file-name-text" id="backFileName">選択されていません</span>
                            </label>
                            <span class="field-hint">JPG・PNG・PDF形式でアップロードしてください</span>
                        </div>
                    </div>
                </div>

                <!-- 暗証番号（マイナンバーカード選択時のみ表示） -->
                <div id="pinInputWrap" class="pin-input-wrap">
                    <div class="field-row">
                        <div class="field-label-wrap">
                            <span class="field-label">暗証番号</span>
                            <span class="required-badge">※必須</span>
                        </div>
                        <div class="field-input-wrap">
                            <form:password path="pin" placeholder="暗証番号を入力してください" />
                            <span class="field-hint">数字4桁の暗証番号を入力してください</span>
                            <form:errors path="pin" cssClass="field-error" />
                        </div>
                    </div>
                </div>

                <!-- 身分証明書番号 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">証明書番号</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:input path="idNumber" placeholder="証明書に記載の番号を入力してください" />
                        <form:errors path="idNumber" cssClass="field-error" />
                    </div>
                </div>

                <!-- 有効期限 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">有効期限</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:input type="date" path="expiryDate" />
                        <form:errors path="expiryDate" cssClass="field-error" />
                    </div>
                </div>

                <!-- 利用規約への同意 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">利用規約</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <label class="checkbox-label">
                            <form:checkbox path="consentTerms" />
                            <span class="checkbox-text">
                                <a href="#" class="login-link">利用規約</a>および
                                <a href="#" class="login-link">プライバシーポリシー</a>に同意します
                            </span>
                        </label>
                        <form:errors path="consentTerms" cssClass="field-error" />
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
        function togglePinInput(select) {
            const fileUploadWrap = document.getElementById('fileUploadWrap');
            const pinInputWrap = document.getElementById('pinInputWrap');

            // 証明書の種類が選択されたらアップロード欄を表示
            fileUploadWrap.style.display = select.value ? 'block' : 'none';

            // マイナンバーカード選択時のみ暗証番号を表示
            pinInputWrap.style.display = select.value === 'myNumber' ? 'block' : 'none';
        }

        // ファイル選択時にファイル名を表示
        document.addEventListener('change', function(e) {
            if (e.target.name === 'idFront') {
                document.getElementById('frontFileName').textContent =
                    e.target.files[0] ? e.target.files[0].name : '選択されていません';
            }
            if (e.target.name === 'idBack') {
                document.getElementById('backFileName').textContent =
                    e.target.files[0] ? e.target.files[0].name : '選択されていません';
            }
        });
    </script>

</body>
</html>
