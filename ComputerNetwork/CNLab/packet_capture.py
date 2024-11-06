import requests
import subprocess
import time
import os
import pyshark
import logging

# 设置抓包文件路径
pcap_file = 'tcp_handshake.pcap'
log_file = 'packet_capture.log'  # 日志文件路径

# 配置 logging 模块，输出信息到控制台和文件
logging.basicConfig(
    level=logging.INFO,  # 设置日志级别
    format='%(asctime)s - %(levelname)s - %(message)s',  # 设置日志格式
    handlers=[
        logging.FileHandler(log_file),  # 输出到文件
        logging.StreamHandler()  # 输出到控制台
    ]
)

# 获取 logger 实例
logger = logging.getLogger()

# 1. 启动 tcpdump 抓包
def start_tcpdump():
    logger.info("Starting tcpdump to capture packets...")
    # 使用 subprocess 启动 tcpdump 命令
    # -i eth0 指定网卡（替换为实际网卡名，如 eth0 或 wlan0）
    # tcp 过滤器只抓取 TCP 数据包
    # -w 指定抓包文件名
    command = ['sudo', 'tcpdump', '-i', 'eth0', 'tcp', '-w', pcap_file]
    tcpdump_process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    return tcpdump_process

# 2. 自动访问指定网站
def visit_website(url):
    try:
        logger.info(f"Visiting website: {url}")
        response = requests.get(url)  # 发起 GET 请求
        logger.info(f"Website {url} responded with status code {response.status_code}")
    except requests.exceptions.RequestException as e:
        logger.error(f"Error accessing website: {e}")

# 3. 等待抓包完成并进行分析
def analyze_pcap():
    # 等待文件创建，直到文件存在并且大小大于0
    while not os.path.exists(pcap_file) or os.path.getsize(pcap_file) == 0:
        logger.info(f"Waiting for packet capture file to be created: {pcap_file}")
        time.sleep(1)

    logger.info(f"Analyzing the captured packets from {pcap_file}...")

    # 使用 PyShark 分析抓到的 .pcap 文件
    cap = pyshark.FileCapture(pcap_file)

    # 打印和分析每个数据包
    for packet in cap:
        if 'TCP' in packet:
            logger.info(f"Packet Info: {packet}")

            # 识别 SYN 包（客户端发起连接）
            if packet.tcp.flags_syn == '1' and packet.tcp.flags_ack == '0':
                logger.info(f"SYN Packet: {packet}")
                logger.info(f"Source IP: {packet.ip.src}, Destination IP: {packet.ip.dst}")
                logger.info(f"Source Port: {packet.tcp.srcport}, Destination Port: {packet.tcp.dstport}")
                logger.info(f"Sequence Number: {packet.tcp.seq}")

            # 识别 SYN-ACK 包（服务器响应连接请求）
            elif packet.tcp.flags_syn == '1' and packet.tcp.flags_ack == '1':
                logger.info(f"SYN-ACK Packet: {packet}")
                logger.info(f"Source IP: {packet.ip.src}, Destination IP: {packet.ip.dst}")
                logger.info(f"Source Port: {packet.tcp.srcport}, Destination Port: {packet.tcp.dstport}")
                logger.info(f"Sequence Number: {packet.tcp.seq}, Acknowledgment Number: {packet.tcp.ack}")

            # 识别 ACK 包（客户端确认连接建立）
            elif packet.tcp.flags_syn == '0' and packet.tcp.flags_ack == '1':
                logger.info(f"ACK Packet: {packet}")
                logger.info(f"Source IP: {packet.ip.src}, Destination IP: {packet.ip.dst}")
                logger.info(f"Source Port: {packet.tcp.srcport}, Destination Port: {packet.tcp.dstport}")
                logger.info(f"Sequence Number: {packet.tcp.seq}, Acknowledgment Number: {packet.tcp.ack}")

if __name__ == '__main__':
    # 启动 tcpdump 抓包
    tcpdump_process = start_tcpdump()
    # 等待 tcpdump 启动并捕获部分数据
    time.sleep(2)  # 等待抓包工具启动
    # 自动访问网站来触发 TCP 三次握手
    website_url = input("输入要访问的网站:（http://example.com）")
    visit_website(website_url)
    # 给网站请求一些时间以完成三次握手
    time.sleep(5)  # 等待 5 秒，确保抓到所有数据包
    # 停止 tcpdump 抓包
    tcpdump_process.terminate()
    # 分析抓到的数据包
    analyze_pcap()
