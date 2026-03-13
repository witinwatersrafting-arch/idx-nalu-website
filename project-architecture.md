# Paddles on the Nile 漂流 - 專案架構文檔

## 專案目錄結構

```
idx-nalu-website/
├── index.html                          # EN: Homepage
├── robots.txt
├── sitemap.xml
├── .gitignore
├── project-architecture.md            # This document
├── AGENTS.md                          # Project specific AI agents & workflows
├── paddles-on-the-nile.cursorrules    # IDE/Cursor specific AI rules
├── wrangler.jsonc                     # Deployment config (Cloudflare)
├── fiveserver.config.js               # Dev server config
├── images/                            # Static assets (WebP format)
│   ├── witin-raft-*.webp
│   ├── team-*.webp
│   ├── tour-*.webp
│   ├── community-*.webp
│   ├── fish-*.webp
│   ├── herbal-tea-*.webp
│   ├── itanda-*.webp
│   └── why-*.webp
├── raw-images/                        # Original unprocessed image copies
├── vibe-standards/                    # Development & Content Guidelines
│   ├── 前端開發標準與佈局手冊...md
│   ├── 影片與媒體效能優化規格...md
│   ├── 後端串接與 GAS 踩雷指南...md
│   └── 進階 SEO、Sitemap 與 Robots 規範.md
├── favicon.png
├── blog/
│   ├── index.html                     # EN: Blog index
│   ├── best-things-to-do-in-jinja.html
│   ├── bujagali-challenge-2025.html
│   ├── empowering-youth-on-the-nile.html
│   ├── itanda-falls-grade-5-rapid.html
│   ├── jinja-rafting-price-trap.html
│   ├── kampala-jinja-matatu-guide.html
│   ├── neighbor-herbal-tea.html
│   ├── nile-perch-fishing-cave-tour.html
│   ├── nile-rafting-safety-rules.html
│   └── uganda-kayak-transport-2026.html
├── faq/
│   └── faq-en.html                    # EN: FAQ Page
└── zh/                                # Chinese (zh-TW) locale root
    ├── index.html                     # ZH: Homepage
    ├── blog/
    │   ├── index.html                 # ZH: Blog index
    │   ├── best-things-to-do-in-jinja.html
    │   ├── bujagali-challenge-2025.html
    │   ├── empowering-youth-on-the-nile.html
    │   ├── itanda-falls-grade-5-rapid.html
    │   ├── jinja-rafting-price-trap.html
    │   ├── kampala-jinja-matatu-guide.html
    │   ├── neighbor-herbal-tea.html
    │   ├── nile-perch-fishing-cave-tour.html
    │   ├── nile-rafting-safety-rules.html
    │   └── uganda-kayak-transport-2026.html
    └── faq/
        └── faq-zh.html                # ZH: FAQ Page
```

## 技術棧與配置

| 類別                        | 技術                                                       |
| --------------------------- | ---------------------------------------------------------- |
| **CSS Framework**           | Tailwind CSS (CDN: `https://cdn.tailwindcss.com`)          |
| **Typography**              | Montserrat (sans), Playfair Display (serif) - Google Fonts |
| **Markup**                  | HTML5 Semantic                                             |
| **Scripting**               | Vanilla JavaScript (ES6+)                                  |
| **Image Format**            | WebP with responsive `<picture>` elements                  |
| **SEO/Schema**              | JSON-LD (Schema.org: BlogPosting, WebPage, FAQPage)        |
| **Social Meta Tags**        | Open Graph, Twitter Card                                   |
| **Internationalization**    | URL-based i18n: `/` (EN) & `/zh/` (zh-TW)                  |
| **Styling Approach**        | Inline Tailwind utility classes + `<script>` config blocks |
| **Build Tools**             | None - Static HTML files served directly                   |
| **Package Manager**         | None - No `package.json` or `node_modules`                 |
| **Development Environment** | Nix (`.idx/dev.nix`)                                       |
| **Clean URLs**              | Handle by Cloudflare (Strictly no `.html` in internal links) |

### Tailwind CSS 配置 (每個 HTML 文件中的 `<script>` 標籤)

```javascript
<script src="https://cdn.tailwindcss.com"></script>
<script>
  tailwind.config = {
    theme: {
      extend: {
        fontFamily: {
          sans: ["Montserrat", "sans-serif"],
          serif: ["Playfair Display", "serif"],
        },
      },
    },
  };
</script>
```

### Google Fonts 引入

```html
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet" />
```

## Hreflang 雙語系配置範例

```html
<!-- 英文版本 -->
<link rel="canonical" href="https://uganda-rafting.com/blog/jinja-rafting-price-trap" />
<link rel="alternate" hreflang="en" href="https://uganda-rafting.com/blog/jinja-rafting-price-trap" />
<link rel="alternate" hreflang="zh-TW" href="https://uganda-rafting.com/zh/blog/jinja-rafting-price-trap" />
<link rel="alternate" hreflang="x-default" href="https://uganda-rafting.com/blog/jinja-rafting-price-trap" />

<!-- 中文版本 -->
<link rel="canonical" href="https://uganda-rafting.com/zh/blog/jinja-rafting-price-trap" />
<link rel="alternate" hreflang="en" href="https://uganda-rafting.com/blog/jinja-rafting-price-trap" />
<link rel="alternate" hreflang="zh-TW" href="https://uganda-rafting.com/zh/blog/jinja-rafting-price-trap" />
<link rel="alternate" hreflang="x-default" href="https://uganda-rafting.com/blog/jinja-rafting-price-trap" />
```

## Schema.org JSON-LD 範例 (BlogPosting)

```json
{
  "@context": "https://schema.org",
  "@type": "BlogPosting",
  "mainEntityOfPage": {
    "@type": "WebPage",
    "@id": "https://uganda-rafting.com/blog/jinja-rafting-price-trap"
  },
  "headline": "Title of the Blog Post",
  "description": "Short description of the blog post content",
  "image": "https://uganda-rafting.com/images/hero-image.webp",
  "author": {
    "@type": "Person",
    "name": "Basoga Witin",
    "jobTitle": "Paddles on the Nile Team Lead"
  },
  "publisher": {
    "@type": "Organization",
    "name": "Paddles on the Nile漂流",
    "logo": {
      "@type": "ImageObject",
      "url": "https://uganda-rafting.com/favicon.png"
    }
  },
  "datePublished": "YYYY-MM-DD",
  "dateModified": "YYYY-MM-DD"
}
```

## 核心 CSS 類別與命名慣例

### 固定導航列 (`<header>`)

- `fixed top-0 left-0 w-full z-50` - Fixed positioning
- `px-6 py-6` - Padding (mobile first)
- `bg-black/50 backdrop-blur-md` - Dark overlay with blur
- `text-white` - Text color

### 響應式斷點使用

- `hidden lg:flex` - Hidden on mobile, flex on lg screens
- `text-2xl sm:text-3xl lg:text-4xl` - Progressive text sizing
- `px-4 sm:px-6 lg:px-10` - Progressive horizontal padding
- `py-20 sm:py-24` - Progressive vertical padding

### 視差滾動容器

- `.parallax-container` - Wrapper 類別，包含 `data-parallax-speed` 屬性
- `.parallax-bg` - 背景圖片元素，應用 `transform: translate3d()`

### 行動選單控制

- `#mobileMenuBtn` - 漢堡菜單按鈕
- `#mobileMenu` - 行動導航選單容器

---

## 開發規範 & 強制要求

### 1. 多語系 Hreflang 標籤 (必須遵守)

**所有新增 HTML 頁面必須在 `<head>` 中包含完整的 Hreflang 絕對路徑標籤。**

- 英文版本必須指定 `hreflang="en"`
- 中文版本必須指定 `hreflang="zh-TW"`
- 所有版本必須包含 `hreflang="x-default"`（指向英文版本）
- 每個版本必須設置正確的 `rel="canonical"`

詳情參閱：`vibe-standards/進階 SEO、Sitemap 與 Robots 規範.md`

---

### 2. Mobile-First 響應式設計策略 (嚴格執行)

**禁止使用絕對像素 (`px`) 進行尺寸設定。必須依賴 Tailwind CSS 的 `rem` 單位與斷點。**

詳情參閱：`vibe-standards/前端開發標準與佈局手冊 (Frontend Vibe Standa.md`

---

### 3. HTML 語意化結構 (嚴禁破壞)

**嚴禁為了視覺樣式而破壞 H1~H6 的語意化階層結構。**

---

### 4. 媒體與圖片優化規範

**所有圖片必須使用 WebP 格式，且寬度不應超過 1920px (除非特殊大圖)。**

詳情參閱：`vibe-standards/影片與媒體效能優化規格 (Media Optimization S.md`

---

### 5. 內容守護協議 - 嚴格逐字轉錄 (STRICT VERBATIM)

**當處理使用者提供的故事、部落格文章或感性文案時，AI 助手必須遵循以下「機械式搬運」原則：**

1. **文字零變動 (Zero Word Change)**：嚴禁以任何理由（包括提升流暢度、修正語法或調整語氣）更改使用者提供的原文。
2. **結構化映射 (Structural Mapping)**：AI 的唯一任務是將原文精確地拆分並填入 HTML 標籤（如 <p>, <h2>, <blockquote>）。標籤內的文字必須與原文 100% 吻合，包含所有的標點符號與人名。
3. **事實神聖性 (Factual Sanity)**：文中的所有人物關係、時間點、情感細節均為真實發生之史實，AI 助手不具備修改事實的權限。
4. **輸出檢查**：在提供代碼建議前，請自動比對原文與 HTML 內的文字，若發現任何單字差異，請立即修正回原文。

---

## 頁面範本檢查清單

新增頁面時，確認以下項目已完成：

- [ ] 所有 Title, Meta Description 與圖片 Alt Text 必須主動融入指定的 SEO 關鍵字，且每次新增頁面必須同步更新 sitemap.xml
- [ ] `<html lang="en">` 或 `<html lang="zh-TW">` 適當設置
- [ ] `<title>` 標籤包含頁面標題
- [ ] `<meta name="description">` 設置頁面描述
- [ ] `<meta name="viewport" content="width=device-width, initial-scale=1.0">` 已包含
- [ ] 所有 Hreflang `<link>` 標籤已完整設置（en + zh-TW + x-default）
- [ ] Open Graph 標籤已設置（`og:title`, `og:description`, `og:image`, `og:url`）
- [ ] Twitter Card 標籤已設置（`twitter:card`, `twitter:title`, `twitter:description`, `twitter:image`）
- [ ] Schema.org JSON-LD 已包含（BlogPosting 或其他適當的類型）
- [ ] 使用了正確的語意化 HTML 標籤（`<article>`, `<section>`, `<nav>`, 等）
- [ ] 所有样式使用 Tailwind 工具類，未使用絕對 `px` 值
- [ ] 響應式斷點正確應用（`sm:`, `md:`, `lg:` 等）
- [ ] 所有圖片使用 WebP 格式並包含 `alt` 屬性
- [ ] 行動菜單邏輯已實現（如適用）
- [ ] 無障礙屬性已設置（`aria-label`, 語意化標籤等）

---

## 資源連結

- [Tailwind CSS 官方文檔](https://tailwindcss.com/docs)
- [Google Fonts](https://fonts.google.com/)
- [Schema.org 參考](https://schema.org/)
- [MDN HTML 語意化指南](https://developer.mozilla.org/en-US/docs/Glossary/semantics#semantics_in_html)

---

**文檔版本：1.2**  
**最後更新：2026年3月13日**
