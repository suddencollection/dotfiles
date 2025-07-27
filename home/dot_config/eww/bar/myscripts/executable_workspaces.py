#!/usr/bin/env python3

import os
import socket
import subprocess
import sys
import errno
import json

# ─── CONFIG ───────────────────────────────────────────────────────────────────
filenames = ["circle-regular.png", "circle-solid.png"]

def update_workspace(active_ws: int):
    """Render the workspace icons, with only active_ws highlighted."""
    flags = [0] * 10
    if 1 <= active_ws <= 10:
        flags[active_ws - 1] = 1

    parts = [
        f'(image :path "${{EWW_CONFIG_DIR}}/images/{filenames[flags[i]]}" '
        f':image-width 13 :image-height 13)'
        for i in range(10)
    ]
    prompt = (
        "(box :orientation \"horizontal\" :space-evenly false :spacing 6 "
        + " ".join(parts)
        + ")"
    )
    # Replace this with `eww update my-widget '{prompt}'` if you prefer
    subprocess.run(f"echo '{prompt}'", shell=True, check=True)
    sys.stdout.flush()

def main():
    # ─── 1) INITIAL FETCH OF CURRENT WORKSPACE ─────────────────────────────────
    try:
        result = subprocess.run(
            ["hyprctl", "activeworkspace", "-j"],
            stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL,
            check=True,
            text=True,
        )
        current = json.loads(result.stdout).get("id", 1)
        update_workspace(current)
    except Exception:
        # Fallback to workspace 1 if hyprctl fails
        update_workspace(1)

    # ─── 2) SET UP SOCKET PATH & CONNECT ───────────────────────────────────────
    try:
        xrd = os.environ["XDG_RUNTIME_DIR"]
        sig = os.environ["HYPRLAND_INSTANCE_SIGNATURE"]
    except KeyError as e:
        print(f"Missing environment variable: {e}", file=sys.stderr)
        sys.exit(1)

    sock_path = os.path.join(xrd, "hypr", sig, ".socket2.sock")
    sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    try:
        sock.connect(sock_path)
    except FileNotFoundError:
        print(f"Cannot connect to {sock_path}", file=sys.stderr)
        sys.exit(1)

    # ─── 3) SUBSCRIBE FOR WORKSPACE CHANGES ────────────────────────────────────
    sock.sendall(b"subscribe: workspace\n")

    # ─── 4) BLOCKING LOOP FOR FUTURE UPDATES ───────────────────────────────────
    try:
        while True:
            data = sock.recv(4096).decode(errors="ignore")
            if not data:
                break
            for line in data.splitlines():
                if line.startswith("workspace>>"):
                    try:
                        n = int(line.split(">>", 1)[1])
                        update_workspace(n)
                    except ValueError:
                        pass
    except KeyboardInterrupt:
        # Exit cleanly on Ctrl+C
        pass
    finally:
        sock.close()

if __name__ == "__main__":
    main()
