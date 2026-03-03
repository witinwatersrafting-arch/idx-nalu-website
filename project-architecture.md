# Witin Waters 漂流 - 專案架構文檔

## 專案目錄結構

```
idx-nalu-website/
├── index.html                          # EN: Homepage
├── robots.txt
├── sitemap.xml
├── .gitignore
├── .idx/
│   └── dev.nix                        # Development environment config
├── project-architecture.md            # This document
├── images/                            # Static assets (WebP format)
│   ├── witin-raft-into-bogugo-bow-high-hero.webp
│   ├── witin-raft-*.webp
│   ├── team-witin.webp
│   ├── team-*.webp
│   ├── tour-*.webp
│   ├── why-*.webp
│   ├── kampala-taxi-park1.webp
│   └── uganda-kampala-street1.webp
├── favicon.png
├── blog/
│   ├── index.html                     # EN: Blog index
│   ├── jinja-rafting-price-trap.html  # EN: Blog post - Jinja Rafting
│   ├── kampala-jinja-matatu-guide.html # EN: Blog post - Kampala Matatu Guide
│   └── nile-rafting-safety-rules.html  # EN: Blog post - Safety Rules
└── zh/                                # Chinese (zh-TW) locale root
    ├── index.html                     # ZH: Homepage
    └── blog/
        ├── index.html                 # ZH: Blog index
        ├── jinja-rafting-price-trap.html   # ZH: Blog post - Jinja Rafting
        ├── kampala-jinja-matatu-guide.html # ZH: Blog post - Kampala Matatu Guide
        └── nile-rafting-safety-rules.html  # ZH: Blog post - Safety Rules
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
    "@id": "https://uganda-rafting.com/blog/jinja-rafting-price-trap.html"
  },
  "headline": "Title of the Blog Post",
  "description": "Short description of the blog post content",
  "image": "https://uganda-rafting.com/images/hero-image.webp",
  "author": {
    "@type": "Person",
    "name": "Basoga Witin",
    "jobTitle": "Witin Waters Team Lead"
  },
  "publisher": {
    "@type": "Organization",
    "name": "Witin Waters漂流",
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

範例（英文頁面）：

```html
<link rel="canonical" href="https://uganda-rafting.com/new-page" />
<link rel="alternate" hreflang="en" href="https://uganda-rafting.com/new-page" />
<link rel="alternate" hreflang="zh-TW" href="https://uganda-rafting.com/zh/new-page" />
<link rel="alternate" hreflang="x-default" href="https://uganda-rafting.com/new-page" />
```

範例（中文頁面）：

```html
<link rel="canonical" href="https://uganda-rafting.com/zh/new-page" />
<link rel="alternate" hreflang="en" href="https://uganda-rafting.com/new-page" />
<link rel="alternate" hreflang="zh-TW" href="https://uganda-rafting.com/zh/new-page" />
<link rel="alternate" hreflang="x-default" href="https://uganda-rafting.com/new-page" />
```

---

### 2. Mobile-First 響應式設計策略 (嚴格執行)

**禁止使用絕對像素 (`px`) 進行尺寸設定。必須依賴 Tailwind CSS 的 `rem` 單位與斷點。**

**正確做法：**

```html
<!-- 使用 Tailwind 的響應式斷點 -->
<section class="px-4 sm:px-6 lg:px-10 py-20 sm:py-24">
  <h1 class="text-2xl sm:text-3xl lg:text-4xl">Heading</h1>
  <p class="text-[15px] sm:text-[16px] lg:text-[17px]">Paragraph</p>
</section>
```

**禁止做法：**

```html
<!-- 絕對不允許使用內嵌 style 的 px 值 -->
<section style="padding: 20px; padding-top: 50px;">
  <h1 style="font-size: 32px;">Heading</h1>
</section>
```

**Tailwind 斷點參考：**

- 移動設備（預設）：< 640px
- `sm:` ≥ 640px
- `md:` ≥ 768px
- `lg:` ≥ 1024px
- `xl:` ≥ 1280px

---

### 3. HTML 語意化結構 (嚴禁破壞)

**嚴禁為了視覺樣式而破壞 H1~H6 的語意化階層結構。**

**正確做法：**

```html
<!-- 使用正確的語意化標籤 -->
<article>
  <h1>主要標題</h1>
  <p>段落內容</p>

  <section>
    <h2>子標題</h2>
    <p>段落內容</p>

    <h3>更小的標題</h3>
    <p>段落內容</p>
  </section>
</article>
```

**禁止做法：**

```html
<!-- 不允許為了視覺需求而使用錯誤的標題級別 -->
<article>
  <h2>主要標題</h2>
  <!-- 錯誤：應該使用 h1 -->
  <p>段落內容</p>

  <h1>子標題</h1>
  <!-- 錯誤：在 h2 後面使用 h1 -->
</article>

<!-- 不允許使用 div + class 來偽裝標題 -->
<div class="text-4xl font-bold">標題</div>
<!-- 錯誤：不是真正的標題語意 -->
```

**使用 Tailwind 進行視覺調整（而非更改標籤）：**

```html
<!-- 如果 h3  需要看起來像 h2，使用 Tailwind 的文字樣式類別 -->
<h3 class="text-2xl font-bold">標題</h3>
<!-- 視覺上看起來更大，但語意正確 -->
```

---

## 頁面範本檢查清單

新增頁面時，確認以下項目已完成：

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

**文檔版本：1.0**  
**最後更新：2026年3月4日**
