import socket

# HOST = '192.168.100.15'
HOST = 'localhost'
PORT = 34

socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
socket.connect((HOST, PORT))

msg = 'hello world'.encode('utf-8')
socket.send(msg)
print(socket.recv(1024))
# print(socket.recv(1024).decode('utf-8'))
