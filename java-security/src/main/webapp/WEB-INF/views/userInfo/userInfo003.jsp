<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>利用目的・口座情報</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>

    <div class="main-container">

        <!-- 左カラム -->
        <div class="left-col">
            <p class="page-title">利用目的・口座情報</p>
            <p class="page-desc">ご利用目的と口座情報を入力してください。</p>
        </div>

        <!-- 右カラム -->
        <div class="right-col">

            <form:form action="/userInfo003" method="post" modelAttribute="userInfo003Form">

                <!-- 利用目的 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">利用目的</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <form:checkbox path="purpose" value="investment" />
                                <span class="checkbox-text">資産運用・投資</span>
                            </label>
                            <label class="checkbox-label">
                                <form:checkbox path="purpose" value="saving" />
                                <span class="checkbox-text">貯蓄・積立</span>
                            </label>
                            <label class="checkbox-label">
                                <form:checkbox path="purpose" value="loan" />
                                <span class="checkbox-text">ローン・借入</span>
                            </label>
                            <label class="checkbox-label">
                                <form:checkbox path="purpose" value="insurance" />
                                <span class="checkbox-text">保険加入</span>
                            </label>
                            <label class="checkbox-label">
                                <form:checkbox path="purpose" value="other" />
                                <span class="checkbox-text">その他</span>
                            </label>
                        </div>
                        <form:errors path="purpose" cssClass="field-error" />
                    </div>
                </div>

                <!-- 希望するサービス -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">希望サービス</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <form:checkbox path="service" value="online" />
                                <span class="checkbox-text">オンラインサービス</span>
                            </label>
                            <label class="checkbox-label">
                                <form:checkbox path="service" value="consulting" />
                                <span class="checkbox-text">対面相談</span>
                            </label>
                            <label class="checkbox-label">
                                <form:checkbox path="service" value="phoneSupport" />
                                <span class="checkbox-text">電話サポート</span>
                            </label>
                            <label class="checkbox-label">
                                <form:checkbox path="service" value="app" />
                                <span class="checkbox-text">アプリ利用</span>
                            </label>
                        </div>
                        <form:errors path="service" cssClass="field-error" />
                    </div>
                </div>

                <!-- お知らせメールの受信設定 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">メール受信</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <div class="radio-group">
                            <label class="radio-label">
                                <form:radiobutton path="mailNotification" value="all" />
                                <span class="radio-text">すべて受信する</span>
                            </label>
                            <label class="radio-label">
                                <form:radiobutton path="mailNotification" value="important" />
                                <span class="radio-text">重要なお知らせのみ受信する</span>
                            </label>
                            <label class="radio-label">
                                <form:radiobutton path="mailNotification" value="none" />
                                <span class="radio-text">受信しない</span>
                            </label>
                        </div>
                        <form:errors path="mailNotification" cssClass="field-error" />
                    </div>
                </div>

                <!-- 口座情報ガイダンス -->
                <div class="guidance-box" style="margin-top: 32px;">
                    <p class="guidance-title">🏦 口座情報の取り扱いについて</p>
                    <ul class="guidance-list">
                        <li>ご入力いただいた口座情報は、サービス利用に伴う入出金処理のみに使用します。</li>
                        <li>第三者への提供や、不正な目的での使用は一切行いません。</li>
                        <li>口座情報は暗号化して安全に管理されます。</li>
                        <li>不審な利用を確認した場合は直ちにご連絡ください。</li>
                    </ul>
                </div>

                <!-- 口座情報の利用への同意 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">口座情報への同意</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <label class="checkbox-label">
                            <form:checkbox path="consentBankAccount" />
                            <span class="checkbox-text">口座情報の取り扱いについて確認し、同意します</span>
                        </label>
                        <form:errors path="consentBankAccount" cssClass="field-error" />
                    </div>
                </div>

                <!-- 銀行名 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">銀行名</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:input path="bankName" placeholder="例）〇〇銀行" />
                        <form:errors path="bankName" cssClass="field-error" />
                    </div>
                </div>

                <!-- 支店名 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">支店名</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:input path="branchName" placeholder="例）新宿支店" />
                        <form:errors path="branchName" cssClass="field-error" />
                    </div>
                </div>

                <!-- 口座種別 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">口座種別</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <div class="radio-group">
                            <label class="radio-label">
                                <form:radiobutton path="accountType" value="ordinary" />
                                <span class="radio-text">普通</span>
                            </label>
                            <label class="radio-label">
                                <form:radiobutton path="accountType" value="checking" />
                                <span class="radio-text">当座</span>
                            </label>
                        </div>
                        <form:errors path="accountType" cssClass="field-error" />
                    </div>
                </div>

                <!-- 口座番号 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">口座番号</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:input path="accountNumber" placeholder="例）1234567" />
                        <form:errors path="accountNumber" cssClass="field-error" />
                    </div>
                </div>

                <!-- 引き落とし日の希望 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">希望引き落とし日</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:select path="debitDay" cssClass="field-select">
                            <form:option value="" label="選択してください" />
                            <form:option value="1" label="1日" />
                            <form:option value="5" label="5日" />
                            <form:option value="10" label="10日" />
                            <form:option value="15" label="15日" />
                            <form:option value="20" label="20日" />
                            <form:option value="25" label="25日" />
                            <form:option value="end" label="末日" />
                        </form:select>
                        <form:errors path="debitDay" cssClass="field-error" />
                    </div>
                </div>

                <!-- 暗証番号 -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">暗証番号</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:password path="accountPin" id="accountPin" maxlength="4" placeholder="数字4桁を入力してください" />
                        <span class="field-hint">数字4桁で設定してください</span>
                        <form:errors path="accountPin" cssClass="field-error" />
                    </div>
                </div>

                <!-- 暗証番号（確認） -->
                <div class="field-row">
                    <div class="field-label-wrap">
                        <span class="field-label">暗証番号（確認）</span>
                        <span class="required-badge">※必須</span>
                    </div>
                    <div class="field-input-wrap">
                        <form:password path="accountPinConfirm" id="accountPinConfirm" maxlength="4" placeholder="もう一度入力してください" />
                        <span class="field-error" id="pinError"></span>
                        <form:errors path="accountPinConfirm" cssClass="field-error" />
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
        document.querySelector('form').addEventListener('submit', function(e) {
            const pin = document.getElementById('accountPin').value;
            const pinConfirm = document.getElementById('accountPinConfirm').value;
            const pinError = document.getElementById('pinError');

            if (pin !== pinConfirm) {
                e.preventDefault();
                pinError.textContent = '暗証番号が一致しません';
                document.getElementById('accountPinConfirm').classList.add('input-error');
            } else if (!/^\d{4}$/.test(pin)) {
                e.preventDefault();
                pinError.textContent = '暗証番号は数字4桁で入力してください';
                document.getElementById('accountPin').classList.add('input-error');
            } else {
                pinError.textContent = '';
                document.getElementById('accountPinConfirm').classList.remove('input-error');
                document.getElementById('accountPin').classList.remove('input-error');
            }
        });
    </script>

</body>
</html>
