import socket
import threading

# 定义服务器的IP和端口
HOST = '127.0.0.1'  # 服务器的IP地址
PORT = 65432        # 服务器的端口

# 创建一个TCP/IP套接字
client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# 连接到服务器
client_socket.connect((HOST, PORT))

# 接收服务器推送的消息
def receive_messages():
    while True:
        try:
            data = client_socket.recv(1024)
            if data:
                print(f"收到服务器消息: {data.decode()}")
        except:
            print("与服务器的连接断开")
            break

# 启动接收消息的线程
threading.Thread(target=receive_messages, daemon=True).start()

# 与服务器交互
print("已连接到服务器！")
while True:
    message = input("请输入要发送给服务器的消息 (输入 'exit' 退出): \n")

    if message.lower() == 'exit':
        print("断开连接...")
        client_socket.close()
        break

    # 向服务器发送消息
    client_socket.sendall(message.encode())

    # 接收服务器的响应
    data = client_socket.recv(1024)
    print(f"来自服务器的响应: {data.decode()}")
