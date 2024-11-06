import requests
from bs4 import BeautifulSoup
import json
import csv
import os

class OsuCrawler:
    def __init__(self, beatmap_id):
        self.base_url = f"https://osu.ppy.sh/beatmapsets/{beatmap_id}"
        self.session = requests.Session()
        self.headers = {
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36"
        }
        self.beatmap_id = beatmap_id

    def fetch_page(self):
        """请求页面内容"""
        try:
            response = self.session.get(self.base_url, headers=self.headers)
            response.raise_for_status()
            return response.text
        except requests.exceptions.RequestException as e:
            print(f"请求出错: {e}")
            return None

    def parse_comments_from_json(self, page_content):
        """从 JSON 中解析评论数据"""
        soup = BeautifulSoup(page_content, "html.parser")
        script_tag = soup.find("script", id="json-comments", type="application/json")
        if not script_tag:
            print("未找到评论数据。")
            return []
        
        try:
            comments_data = json.loads(script_tag.string)
            comments = comments_data.get("comments", [])
            parsed_comments = []
            for comment in comments:
                user_id = comment.get("user_id")
                text = comment.get("message")
                created_at = comment.get("created_at")
                parsed_comments.append({
                    "user_id": user_id,
                    "text": text,
                    "created_at": created_at
                })
            return parsed_comments
        except json.JSONDecodeError:
            print("评论数据解析失败。")
            return []

    def download_beatmap(self):
        """下载曲谱文件"""
        download_url = f"{self.base_url}/download"
        try:
            response = self.session.get(download_url, headers=self.headers, stream=True)
            if response.status_code == 200:
                filename = f"beatmap_{self.beatmap_id}.osz"
                with open(filename, "wb") as f:
                    for chunk in response.iter_content(1024):
                        f.write(chunk)
                print(f"谱面下载完成: {filename}")
            else:
                print("谱面下载失败，可能需要登录。")
        except requests.exceptions.RequestException as e:
            print(f"下载出错: {e}")

    def save_comments_csv(self, comments):
        """保存评论为 CSV 文件"""
        if not comments:
            print("没有评论数据可保存。")
            return
        with open(f"comments_{self.beatmap_id}.csv", "w", encoding="utf-8", newline='') as csvfile:
            fieldnames = ["user_id", "created_at", "text"]
            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
            writer.writeheader()
            for comment in comments:
                writer.writerow(comment)
        print(f"评论保存完成: comments_{self.beatmap_id}.csv")

    def run(self):
        """执行爬虫流程"""
        page_content = self.fetch_page()
        if page_content:
            comments = self.parse_comments_from_json(page_content)
            self.save_comments_csv(comments)
            self.download_beatmap()

# 主函数，支持单个曲目ID或范围
if __name__ == "__main__":
    user_input = input("请输入要爬取的曲目ID或范围（例如 2113834 或 2113830-2113835）：")
    
    if '-' in user_input:
        start_id, end_id = map(int, user_input.split('-'))
        for beatmap_id in range(start_id, end_id + 1):
            print(f"\n开始爬取曲目ID: {beatmap_id}")
            crawler = OsuCrawler(beatmap_id)
            crawler.run()
    else:
        beatmap_id = int(user_input)
        print(f"\n开始爬取曲目ID: {beatmap_id}")
        crawler = OsuCrawler(beatmap_id)
        crawler.run()
