# 檔案 1：前端開發標準與佈局手冊 (Frontend Vibe Standards)

## 1. 核心開發原則 (Golden Rules)

- **全面行動優先 (Mobile-first)**：預設樣式必須針對手機端撰寫。僅允許使用 `md:`, `lg:`, `xl:` 斷點進行擴充與覆寫桌機樣式。
- **語意化結構**：強制使用 `<header>`、`<main>`、`<section>`、`<article>`、`<footer>` 劃分區塊，取代無意義的 `<div>` 疊床架屋。
- **內部連結規範 (Local Routing)**：為配合 Cloudflare 與本地端測試環境，所有 `<a href="...">` 必須使用**根目錄相對路徑** (如 `/blog/post`)，嚴禁加上主網域前綴，且**嚴禁包含 `.html`**。
- **標題階層**：嚴格遵循 `<h1>` 至 `<h6>` 建立標題階層，嚴禁為了視覺樣式而跳級使用標籤。
- **絕對禁用 px (No Pixels)**：除 1px 的 border 外，全面使用 `rem`, `em`, `%` 或 `vh/vw`。自訂數值必須使用 Tailwind 的 `[ ]` 語法（例如 `w-[3.5rem]`）。

## 2. 佈局與排版指令集 (Layout Toolbox)

### 全域尺寸與邊界對齊

- **主區塊寬度限制**：統一使用 `w-full max-w-[1600px] mx-auto` 控制最大寬度與絕對居中，維持全站視覺一致性。
- **彈性內距 (Padding)**：依據裝置套用不同內距，例如手機端 `px-4` 或 `px-6`，桌機端 `md:px-10`。

### 響應式佈局 (Flex & Grid 策略)

- **Flex 切換**：適用於導覽列或單一維度對齊。手機端 `flex flex-col` $\rightarrow$ 桌機端 `md:flex-row`，並搭配 `justify-between`, `items-center`。
- **Grid 網格策略**：
  - **全域框架骨架**：預設使用 `grid grid-cols-1 md:grid-cols-12 gap-[1.5rem]`。
  - **內容卡片自適應**：使用 `grid-cols-1` (手機) $\rightarrow$ `md:grid-cols-2` (平板) $\rightarrow$ `lg:grid-cols-3` (桌機) 實現自動折行與佈局適應。

### 字體縮放策略 (Typography)

- **大標題 (Hero/H1)**：強制使用流體字體 `text-[clamp(1.5rem,5vw,3rem)]` 確保跨裝置無縫平滑縮放。
- **一般內文 (Body)**：使用斷點縮放 `text-[1rem] md:text-[1.125rem]` 維持閱讀排版的整齊度與易讀性。

## 3. 防禦性排版與互動規範 (Defensive CSS)

- **防破版機制**：
  - **圖片限制**：強制設定 `w-full object-cover`，並搭配 `aspect-` 維持比例。
  - **文字溢出**：長字串與網址強制套用 `break-words`。
  - **容器安全**：Flex 容器必須考慮加入 `flex-wrap` 或 `overflow-x-auto`，防止手機端內容擠壓變形。
- **觸控標準 (A11y)**：互動元素（Button/Input）高度至少需達 `h-11` (約 44px)。
- **語義化變數**：優先使用 Tailwind 內建顏色，自訂需求使用 CSS 變數 `[--my-color:#xxx]`。
- **動態效能優化**：
  - **視差滾動**：使用 `transform: translate3d(0, y, 0)` 觸發 GPU 硬體加速。
  - **背景優化**：對動態元素設定 `will-change: transform` 提示瀏覽器優化渲染。

## 4. 常用組件範本庫 (Component Library)

當需要生成以下組件時，請預設採用此結構：

### 響應式導覽列 (Navbar)

- **手機端**：預設隱藏選單清單 (`hidden`) + 顯示漢堡按鈕 (觸控區塊 `h-11`)。
- **桌機端**：透過 `md:flex` 切換為水平排列，隱藏漢堡按鈕 (`md:hidden`)。

### 產品與特點網格 (Feature Grid)

- **結構**：父容器 `grid grid-cols-1 md:grid-cols-3 gap-[2rem]`。
- **卡片樣式**：子元素 `p-[2rem] rounded-[1rem] border`。

### 頁尾 (Footer)

- **結構**：父容器 `flex flex-col md:flex-row justify-between`。
