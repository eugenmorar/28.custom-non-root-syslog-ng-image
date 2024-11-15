import socket
import os

# Create a Unix socket
sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)

# Define the socket file path
socket_path = "/dev/log"

# Remove the socket file if it already exists
if os.path.exists(socket_path):
    os.remove(socket_path)

# Bind the socket to the file path
sock.bind(socket_path)

# Set the permissions to 666
os.chmod(socket_path, 0o666)

# Listen for incoming connections
sock.listen(1)

print(f"Socket created with 666 permissions at {socket_path}")
