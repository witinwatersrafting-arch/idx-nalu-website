# 檔案 4：進階 SEO、Sitemap 與 Robots 規範 (Technical SEO Guidelines)

## 1. 核心 Meta 與社群標籤規範 (Head Tags & Social Media)

在生成任何 HTML 頁面的 `<head>` 區塊時，必須嚴格包含以下所有標籤，並確保內容根據各頁面自動變更：

- **基礎 SEO**：包含精確的 `<title>` 以及長度控制在 150 字元內的 `<meta name="description">`。
- **標準網址 (Canonical)**：必須包含 `<link rel="canonical" href="絕對路徑">`，防止重複內容懲罰。
- **Open Graph (FB/IG)**：必須包含 `og:type` (首頁為 website，文章為 article)、`og:url`、`og:title`、`og:description`、`og:image` 與 `og:site_name`。
- **Twitter Card**：必須包含 `twitter:card` (預設為 summary_large_image)、`twitter:url`、`twitter:title`、`twitter:description`、`twitter:image`。
- **網址格式 (乾淨且絕對)**：配合 Cloudflare Clean URLs，以上所有標籤內的網址**嚴禁包含 `.html`**。且**嚴禁使用相對路徑**，必須是包含完整主網域的「絕對路徑 (Absolute URL)」。

## 2. 多語系架構與 Hreflang (Multilingual & Hreflang)

若網站具備多語言版本（例如：預設英文位於根目錄 `/`，中文位於 `/zh/` 目錄），每一頁的 `<head>` 必須包含完整的 Hreflang 叢集，以宣告所有對應版本的存在。

- **宣告規則**：必須宣告所有語言版本，並指定 `x-default` 為預設的國際版本（通常與英文版相同）。
- **Hreflang 代碼範本 (無副檔名版本)**：

  ```html
  <link rel="alternate" hreflang="en" href="[https://example.com/page-name](https://example.com/page-name)" />
  <link rel="alternate" hreflang="zh-TW" href="[https://example.com/zh/page-name](https://example.com/zh/page-name)" />
  <link rel="alternate" hreflang="x-default" href="[https://example.com/page-name](https://example.com/page-name)" />

  3. JSON-LD 結構化資料 (Schema Markup) (以下維持你原本的內容，無須修改...)
  ```

## 4. 網站地圖規範 (sitemap.xml)

當被要求生成或更新 sitemap.xml 時，必須遵循嚴格的 XML 結構，並將多語系 Hreflang 資訊直接嵌入 Sitemap 中。

優先權設定：首頁設定 <priority>1.0</priority>，重要目錄設定 0.9，一般文章設定 0.8。

Sitemap 代碼範本 (必須使用絕對網址，且嚴禁包含 .html)：

<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="[http://www.sitemaps.org/schemas/sitemap/0.9](http://www.sitemaps.org/schemas/sitemap/0.9)" xmlns:xhtml="[http://www.w3.org/1999/xhtml](http://www.w3.org/1999/xhtml)">
  <url>
    <loc>[https://example.com/blog/page-name](https://example.com/blog/page-name)</loc>
    <lastmod>YYYY-MM-DD</lastmod>
    <priority>0.8</priority>
    <xhtml:link rel="alternate" hreflang="en" href="[https://example.com/blog/page-name](https://example.com/blog/page-name)" />
    <xhtml:link rel="alternate" hreflang="zh-TW" href="[https://example.com/zh/blog/page-name](https://example.com/zh/blog/page-name)" />
    <xhtml:link rel="alternate" hreflang="x-default" href="[https://example.com/blog/page-name](https://example.com/blog/page-name)" />
  </url>
</urlset>

## 5. 爬蟲協議規範 (robots.txt)

當被要求生成 robots.txt 時，必須確保搜尋引擎能正確抓取所有公開頁面與資源，同時宣告 Sitemap 的絕對位置。

允許規則：必須允許抓取主要的網頁目錄、CSS、JS 與圖片路徑。

Sitemap 宣告：必須在檔案最末行附上 Sitemap 的絕對路徑。

robots.txt 代碼範本：

Plaintext
User-agent: \*
Allow: /

# 若有不希望被搜尋引擎收錄的後台或測試目錄，請使用 Disallow

# Disallow: /private/

# Disallow: /test/

Sitemap: [https://example.com/sitemap.xml](https://example.com/sitemap.xml)
