import socket

HOST = '0.0.0.0'
PORT = 389

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind((HOST, PORT))
    s.listen()
    print(f"Fake LDAP server listening on port {PORT}...")
    conn, addr = s.accept()
    with conn:
        print(f"Received LDAP callback from: {addr}")
        data = conn.recv(1024)
        print(f"Data: {data}")
