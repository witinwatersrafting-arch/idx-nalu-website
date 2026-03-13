# 檔案 3：後端串接與 GAS 踩雷指南 (Backend & GAS Integration)

## 1. GAS 部署與權限地雷 (Deployment & Permissions Traps)

開發或修改 Google Apps Script (GAS) 時，必須嚴格遵守以下部署規範，否則前端將面臨無聲失敗或 CORS 錯誤：

- **版本更新陷阱**：每次修改 GAS 程式碼後，僅按「儲存」是不夠的。必須透過「部署 > 管理部署作業 > 編輯 > 版本選『建立新版本 (New version)』」才能生效。
- **執行身分與存取權限**：部署網頁應用程式時，「執行身分」必須設為「我 (Me)」，「誰可以存取」必須設為「所有人 (Anyone)」。
- **底層權限確認**：若設定無誤卻仍遭拒絕，需檢查 GAS 隱藏的 `appsscript.json`，確保包含 `"executeAs": "USER_DEPLOYING"` 與 `"access": "ANYONE_ANONYMOUS"`。
- **OAuth 細部權限陷阱 (Granular Permissions Bug)**：若授權時漏勾選試算表或 Gmail 權限，系統仍會核發權杖，導致背景無聲失敗 (Silent Failure) 且不再要求授權。解決方法：進入 Google 帳戶的安全性設定，手動移除該專案的存取權，重新執行程式以強制喚起完整授權視窗並確實勾選。

## 2. 前端 API 請求規範 (Frontend Fetch Rules)

- **資料傳輸格式遺失 (CORS 防禦)**：**嚴禁**直接透過 `fetch` 傳送原生 `FormData` 或純 `JSON` 至 GAS，這會觸發 302 重定向導致資料遺失或 CORS 預檢請求 (Preflight) 錯誤。
- **強制解決方案**：必須將表單資料轉換為 `URLSearchParams`，以 `application/x-www-form-urlencoded` 格式發送。

### Fetch 標準寫法範本：

```javascript
const formData = new FormData(bookingForm);
const urlEncodedData = new URLSearchParams(formData);

fetch(GAS_URL, {
  method: 'POST',
  body: urlEncodedData
})
  .then(response => {
    if (!response.ok) throw new Error('Network response was not ok');
    return response.json();
  })
  .then(data => {
    if (data.success) {
      // 成功處理邏輯
      formMessage.innerText = data.message;
      formMessage.classList.remove('hidden');
      bookingForm.reset();
    } else {
      throw new Error(data.message || 'Server returned false success status.');
    }
  })
  .catch(error => {
    // 錯誤處理邏輯
    console.error('Error:', error);
    formMessage.innerText = 'Something went wrong. Please try again.';
    formMessage.classList.remove('hidden');
  })
  .finally(() => {
    // 狀態還原與解除防呆
    submitBtn.innerText = 'Submit';
    submitBtn.disabled = false;
    submitBtn.classList.remove('opacity-70', 'cursor-not-allowed');
  });

  3. JavaScript 作用域與事件綁定 (JS Scope & Events)
行內事件陷阱：在 HTML 使用行內綁定（如 onclick="nextSlide()"）時，若對應的 JS 函式包在 DOMContentLoaded 內部，會變成區域變數而失效。

解決方案：將該函式綁定至全域物件（如 window.nextSlide = function() {...}），或全面改用 addEventListener 進行事件綁定。

4. GAS 後端代碼標準 (GAS Code Standard)
試算表欄位強對應：sheet.appendRow() 陣列中的變數順序，必須與 Google 試算表的欄位（如 A1~G1）嚴格、完全一致，否則資料會寫入錯誤欄位。

標準 doPost 模板：後端必須攔截 e.parameter，處理完畢後一律回傳 ContentService.MimeType.JSON 格式的字串，包含 success 狀態。

doPost 基礎結構範本：
JavaScript
function doPost(e) {
  const output = ContentService.createTextOutput();
  output.setMimeType(ContentService.MimeType.JSON);
  try {
    const data = e.parameter;
    // 執行 SpreadsheetApp 寫入與 MailApp 寄信邏輯...
    return output.setContent(JSON.stringify({ "success": true, "message": "Success" }));
  } catch (error) {
    return output.setContent(JSON.stringify({ "success": false, "error": error.toString() }));
  }
}
5. 前端表單互動與 UX 規範
防呆與狀態管理：表單送出事件觸發後，必須立刻更改按鈕文字（如「Sending...」）、將按鈕設為 disabled 並加上視覺反饋（如 opacity-70 cursor-not-allowed），防止使用者重複點擊送出。

日期限制：若表單包含日期選擇器 <input type="date">，需透過 JS 動態設定 min 屬性為今日，防止選擇過去日期。
```
