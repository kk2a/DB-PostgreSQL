"""
授業資料(Web)から定着確認問題を収集するスクリプト

定着確認の開始位置: h3タグで id が「定着確認-[番号]」のような形式
終了位置: 別のheaderタグ（h1, h2, h3など）が出現するまで
"""

import re
import requests
from bs4 import BeautifulSoup
from typing import List, Dict

# 対象のURL一覧
LECTURE_URLS = [
    "https://takeshiwada1980.github.io/DB-2025/lecture01.html",
    "https://takeshiwada1980.github.io/DB-2025/lecture02.html",
    "https://takeshiwada1980.github.io/DB-2025/lecture03.html",
    "https://takeshiwada1980.github.io/DB-2025/lecture04.html",
    "https://takeshiwada1980.github.io/DB-2025/lecture05.html",
    "https://takeshiwada1980.github.io/DB-2025/lecture06.html",
    "https://takeshiwada1980.github.io/DB-2025/lecture07.html",
]


def extract_sections(url: str, keyword: str) -> List[Dict[str, str]]:
    """
    指定されたURLから特定のキーワードを含むセクションを抽出する
    
    Args:
        url: 講義資料のURL
        keyword: 検索するキーワード（例: '定着確認', 'SQLドリル'）
        
    Returns:
        セクションのリスト。各要素は以下のキーを持つ辞書:
            - id: セクションのID
            - title: セクションのタイトル
            - content_html: セクションの内容（HTML）
            - content_text: セクションの内容（テキスト）
            - url: 元のURL
    """
    try:
        response = requests.get(url)
        response.raise_for_status()
        response.encoding = response.apparent_encoding
        
        soup = BeautifulSoup(response.text, 'html.parser')
        sections = []
        
        # ベースURLを取得（相対パスを絶対URLに変換するため）
        from urllib.parse import urljoin
        base_url = url
        
        # 指定されたキーワードを含むh3タグを全て検索
        headers = soup.find_all('h3', id=lambda x: x and keyword in x)
        
        for header in headers:
            section_id = header.get('id', '')
            section_title = header.get_text(strip=True)
            
            # 次のheaderタグまでの内容を取得
            content_html = []
            content_text = []
            
            current = header.find_next_sibling()
            while current:
                # 次のheaderタグが来たら終了
                if current.name and re.match(r'^h[1-6]$', current.name):
                    break
                    
                if current.name:  # タグの場合のみ処理
                    # 画像タグやリンクの相対パスを絶対URLに変換
                    current_copy = BeautifulSoup(str(current), 'html.parser')
                    for img in current_copy.find_all('img'):
                        if img.get('src'):
                            img['src'] = urljoin(base_url, img['src'])
                    for a in current_copy.find_all('a'):
                        if a.get('href'):
                            a['href'] = urljoin(base_url, a['href'])
                    for link in current_copy.find_all('link'):
                        if link.get('href'):
                            link['href'] = urljoin(base_url, link['href'])
                    for script in current_copy.find_all('script'):
                        if script.get('src'):
                            script['src'] = urljoin(base_url, script['src'])
                    
                    content_html.append(str(current_copy))
                    # テキストを取得（空白の整形）
                    text = current.get_text(strip=True)
                    if text:
                        content_text.append(text)
                
                current = current.find_next_sibling()
            
            sections.append({
                'id': section_id,
                'title': section_title,
                'content_html': '\n'.join(content_html),
                'content_text': '\n'.join(content_text),
                'url': url
            })
        
        return sections
    
    except Exception as e:
        print(f"エラーが発生しました（URL: {url}）: {e}")
        return []


def main():
    """メイン処理"""
    # 定着確認とSQLドリルの両方を収集
    all_teichaku = []
    all_drill = []
    
    print("定着確認問題とSQLドリルを収集中...")
    print("=" * 60)
    
    for url in LECTURE_URLS:
        lecture_num = re.search(r'lecture(\d+)', url)
        lecture_name = f"第{lecture_num.group(1)}回" if lecture_num else url
        
        print(f"\n{lecture_name} の講義資料を処理中: {url}")
        
        # 定着確認を収集
        teichaku_sections = extract_sections(url, '定着確認')
        if teichaku_sections:
            print(f"  → {len(teichaku_sections)}個の定着確認セクションを発見")
            all_teichaku.extend(teichaku_sections)
        
        # SQLドリルを収集
        drill_sections = extract_sections(url, 'sqlドリル')
        if drill_sections:
            print(f"  → {len(drill_sections)}個のSQLドリルセクションを発見")
            all_drill.extend(drill_sections)
    
    print("\n" + "=" * 60)
    print(f"合計: 定着確認 {len(all_teichaku)}個、SQLドリル {len(all_drill)}個を収集しました\n")
    
    # 結果を表示
    print("【定着確認】")
    for i, section in enumerate(all_teichaku, 1):
        print(f"【{i}】 {section['title']} (ID: {section['id']})")
        print(f"URL: {section['url']}")
        print(f"内容:\n{section['content_text'][:100]}...")
        print("-" * 40)
    
    print("\n【SQLドリル】")
    for i, section in enumerate(all_drill, 1):
        print(f"【{i}】 {section['title']} (ID: {section['id']})")
        print(f"URL: {section['url']}")
        print(f"内容:\n{section['content_text'][:100]}...")
        print("-" * 40)
    
    # 定着確認をファイルに保存
    output_file = "teichaku_sections.html"
    save_to_html(all_teichaku, output_file, "定着確認問題一覧")
    print(f"\n定着確認を {output_file} に保存しました")
    
    # SQLドリルをファイルに保存
    output_file = "sql_drill_sections.html"
    save_to_html(all_drill, output_file, "SQLドリル問題一覧")
    print(f"SQLドリルを {output_file} に保存しました")


def save_to_html(sections: List[Dict[str, str]], output_file: str, title: str):
    """セクションをHTMLファイルに保存する"""
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("<!DOCTYPE html>\n")
        f.write("<html lang='ja'>\n<head>\n")
        f.write("<meta charset='UTF-8'>\n")
        f.write("<meta name='viewport' content='width=device-width, initial-scale=1.0'>\n")
        f.write(f"<title>{title}</title>\n")
        # GitHubリポジトリから元のCSSを読み込む
        f.write("<link rel='stylesheet' href='https://takeshiwada1980.github.io/DB-2025/site_libs/bootstrap/bootstrap.min.css'>\n")
        f.write("<link rel='stylesheet' href='https://takeshiwada1980.github.io/DB-2025/site_libs/bootstrap/bootstrap-icons.css'>\n")
        f.write("<style>\n")
        f.write(".section { margin-bottom: 40px; padding: 20px; border: 2px solid #dee2e6; border-radius: 8px; background-color: #fff; }\n")
        f.write(".section-header { background-color: #f8f9fa; padding: 15px; margin: -20px -20px 20px -20px; border-radius: 6px 6px 0 0; border-bottom: 2px solid #dee2e6; }\n")
        f.write(".section-title { margin: 0; color: #212529; font-size: 1.5em; }\n")
        f.write(".section-url { font-size: 0.9em; color: #6c757d; margin-top: 8px; }\n")
        f.write(".section-url a { color: #0d6efd; text-decoration: none; }\n")
        f.write(".section-url a:hover { text-decoration: underline; }\n")
        f.write("/* マスク処理用CSS */\n")
        f.write(".masked {\n")
        f.write("  color: transparent;\n")
        f.write("  background-color: #fff57c;\n")
        f.write("  padding: 0.05em 0.5em;\n")
        f.write("  border: solid 2px #fff57c;\n")
        f.write("  cursor: pointer;\n")
        f.write("  user-select: none;\n")
        f.write("  -webkit-user-select: none;\n")
        f.write("  transition: all 0.3s ease;\n")
        f.write("}\n")
        f.write(".masked.open {\n")
        f.write("  color: inherit;\n")
        f.write("  background-color: transparent;\n")
        f.write("  border-color: transparent;\n")
        f.write("}\n")
        f.write(".masked:hover {\n")
        f.write("  opacity: 0.8;\n")
        f.write("}\n")
        f.write("</style>\n")
        f.write("</head>\n<body>\n")
        f.write("<div class='container py-4'>\n")
        f.write(f"<h1 class='mb-4'>{title}</h1>\n")
        
        for i, section in enumerate(sections, 1):
            f.write(f"<div class='section'>\n")
            f.write(f"  <div class='section-header'>\n")
            f.write(f"    <h2 class='section-title'>【{i}】 {section['title']} (ID: {section['id']})</h2>\n")
            f.write(f"    <div class='section-url'>URL: <a href='{section['url']}'>{section['url']}</a></div>\n")
            f.write(f"  </div>\n")
            f.write(f"  <div class='section-content'>\n")
            f.write(f"{section['content_html']}\n")
            f.write(f"  </div>\n")
            f.write(f"</div>\n\n")
        
        f.write("</div>\n")
        # 元のサイトと同じJavaScriptを追加
        f.write("<script>\n")
        f.write("window.onload = function () {\n")
        f.write("  // マスク処理\n")
        f.write("  let maskedSpans = document.getElementsByClassName('masked');\n")
        f.write("  console.log('Found masked spans:', maskedSpans.length);\n")
        f.write("  Array.from(maskedSpans).forEach((span) => {\n")
        f.write("    span.onclick = () => {\n")
        f.write("      span.classList.toggle('open');\n")
        f.write("    };\n")
        f.write("  });\n")
        f.write("};\n")
        f.write("</script>\n")
        f.write("</body>\n</html>")


if __name__ == "__main__":
    main()