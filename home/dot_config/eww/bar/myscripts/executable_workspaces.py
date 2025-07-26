#!/usr/bin/env python3
import os
import socket
import subprocess
import sys

# your two icons
filenames = ["circle-regular.png", "circle-solid.png"]

def update_workspace(active_ws: int):
    # build a 10-element list with a 1 at active_ws-1
    flags = [0]*10
    flags[active_ws-1] = 1

    # build the EWW box… you may want to call `eww update …` instead
    parts = []
    for i in range(10):
        icon = filenames[flags[i]]
        parts.append(f'(image :path "${{EWW_CONFIG_DIR}}/images/{icon}" :image-width 13 :image-height 13)')
    prompt = "(box :orientation \"horizontal\" :space-evenly false :spacing 6 " + " ".join(parts) + ")"
    subprocess.run(f"echo '{prompt}'", shell=True)

# figure out the new socket2 path under XDG_RUNTIME_DIR
try:
    xrd = os.environ["XDG_RUNTIME_DIR"]
    sig = os.environ["HYPRLAND_INSTANCE_SIGNATURE"]
except KeyError as e:
    print(f"Missing environment variable: {e}")
    sys.exit(1)

server_address = os.path.join(xrd, "hypr", sig, ".socket2.sock")

sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
try:
    sock.connect(server_address)
except FileNotFoundError:
    print(f"Could not connect to Hyprland socket at {server_address}")
    sys.exit(1)

# read events forever
while True:
    data = sock.recv(4096).decode(errors="ignore")
    if not data:
        break
    for line in data.splitlines():
        if line.startswith("workspace>>"):
            ws = int(line.split(">>",1)[1])
            update_workspace(ws)

# (you might want to catch KeyboardInterrupt and exit cleanly)

