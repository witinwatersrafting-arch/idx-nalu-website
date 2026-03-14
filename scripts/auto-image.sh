#!/bin/bash
export PATH=/opt/homebrew/bin:/usr/local/bin:$PATH

# 1. GPS 定位路徑
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( dirname "$SCRIPT_DIR" )"
RAW_DIR="$PROJECT_ROOT/rawimage"
OUT_DIR="$PROJECT_ROOT/images"

BASE_NAME=$1
if [ -z "$BASE_NAME" ]; then
  echo "❌ 錯誤：未提供基礎檔名。"
  exit 1
fi

mkdir -p "$RAW_DIR" "$OUT_DIR"

# 2. 搜尋圖片
shopt -s nullglob
shopt -s nocaseglob
FILES=("$RAW_DIR"/*.{jpg,jpeg,png,webp,heic})

if [ ${#FILES[@]} -eq 0 ]; then
  echo "⚠️  在 /rawimage 中找不到圖片。"
  exit 0
fi

GENERATED_FILES=()
INDEX=1
COUNT=${#FILES[@]}

for file in "${FILES[@]}"; do
    # --- 修正後的命名邏輯 ---
    if [ "$COUNT" -eq 1 ]; then
        FINAL_NAME="${BASE_NAME}.webp"
    else
        # 這裡使用變數 $INDEX，才會變成 -1, -2, -3
        FINAL_NAME="${BASE_NAME}-${INDEX}.webp"
    fi
    
    OUTPUT_PATH="$OUT_DIR/$FINAL_NAME"

    # 3. 執行轉檔
    magick "$file" -auto-orient -resize "1200>" -quality 70 -define webp:method=6 -strip "$OUTPUT_PATH"

    # 4. 防呆：確認新檔案存在，才刪除原始檔案
    if [ -f "$OUTPUT_PATH" ]; then
        echo "✅ 成功產出：$FINAL_NAME"
        rm "$file"
        GENERATED_FILES+=("$FINAL_NAME")
    else
        echo "❌ 轉檔失敗：$(basename "$file")，保留原圖。"
    fi
    
    # 增加序號
    ((INDEX++))
done

echo "---"
echo "✅ 圖片處理完成！請在 HTML 中使用以下檔名："
for name in "${GENERATED_FILES[@]}"; do
    echo "- $name"
done