import requests
from bs4 import BeautifulSoup
import os

folder_indices = {}

def download_images(url, folder_name):
    global folder_indices
    response = requests.get(url)
    images = BeautifulSoup(response.content, 'html.parser').find_all('img', {'class': 'img-thumbnail sticker-image'})
    if not os.path.exists(folder_name):
        os.makedirs(folder_name)
        folder_indices[folder_name] = 1
    index = folder_indices[folder_name]
    for image in images:
        image_url = image['data-src-large']
        image_name = f"{folder_name}_{index}.png"
        img_data = requests.get(image_url).content
        with open(os.path.join(folder_name, image_name), 'wb') as handler:
            handler.write(img_data)
        print(f"已爬取 {image_name}")
        index += 1
    folder_indices[folder_name] = index

if __name__ == "__main__":
    user_input = input("请输入要爬取的表情（例如hatsune-miku-1或menhera-chan-1-1）：")
    download_images('https://getstickerpack.com/stickers/'+user_input, 'user_input')
    print("已完成爬取")
