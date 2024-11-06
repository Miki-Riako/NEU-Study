import socket
import threading

# 定义服务器的IP和端口
HOST = '127.0.0.1'  # 本地IP地址
PORT = 65432        # 服务器的端口

# 存储客户端连接的字典 (IP地址作为标识)
clients = {}

# 处理每个客户端连接的函数
def handle_client(conn, addr):
    print(f"已连接客户端: {addr}")
    
    # 将新客户端添加到 clients 字典中
    clients[addr] = conn

    while True:
        try:
            # 接收客户端发送的数据
            data = conn.recv(1024)
            if not data:
                break  # 客户端关闭连接

            print(f"收到来自客户端 {addr} 的消息: {data.decode()}")
            
            # 向所有客户端广播消息
            broadcast(data.decode(), addr)
            
            # 向客户端发送响应
            response = f"服务器收到: {data.decode()}"
            conn.sendall(response.encode())
        except:
            break

    # 客户端断开连接
    print(f"客户端 {addr} 断开连接")
    conn.close()
    del clients[addr]  # 从客户端列表中移除断开的客户端

# 向所有客户端广播消息
def broadcast(message, client_addr=None):
    for addr, conn in clients.items():
        if addr != client_addr:  # 排除发送者自己
            try:
                conn.sendall(f"广播消息: {message}".encode())
            except:
                # 发送失败，移除该客户端
                print(f"无法向 {addr} 发送消息，客户端可能已断开")
                del clients[addr]

# 创建服务器Socket
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server_socket.bind((HOST, PORT))
server_socket.listen(5)

print(f"服务器正在监听 {HOST}:{PORT} ...")

# 不断接受客户端连接并创建线程处理
while True:
    conn, addr = server_socket.accept()
    # 为每个客户端连接创建一个新的线程
    client_thread = threading.Thread(target=handle_client, args=(conn, addr))
    client_thread.start()
