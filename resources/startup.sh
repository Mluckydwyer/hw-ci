#!/bin/sh

# VSCode Server
nohup /usr/bin/start-code-server.sh &> /workspaces/logs/code-server.log

# VNC
nohup /usr/bin/start-vnc-session.sh &> /workspaces/logs/vnc-server.log

# Server
nohup python3 -m http.server 8000 --directory /workspaces/ > /workspaces/logs/web-server.log & 
