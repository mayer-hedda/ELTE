#!/bin/bash

# === Color codes ===
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
BOLD="\e[1m"
RESET="\e[0m"

SERVER_NAME="dummy_minecraft_server_marker"

# === Functions ===
start_server() {
    if pgrep -f "$SERVER_NAME" >/dev/null; then
        echo -e "${YELLOW}${BOLD}[INFO]${RESET} Server already running."
    else
        echo -e "${CYAN}${BOLD}[SYSTEM]${RESET} Starting server..."
        bash -c "
            exec -a $SERVER_NAME bash -c '
                while true; do
                    sleep 60
                    if [ \$((RANDOM % 6)) -eq 0 ]; then
                        exit 1
                    fi
                done
            ' &
            disown
        " >/dev/null 2>&1
        echo -e "${GREEN}${BOLD}[OK]${RESET} Server started successfully."
    fi
}

stop_server() {
    pid=$(pgrep -f "$SERVER_NAME")
    if [ -n "$pid" ]; then
        echo -e "${CYAN}${BOLD}[SYSTEM]${RESET} Stopping server..."
        kill "$pid" 2>/dev/null
        sleep 0.2
        if ps -p "$pid" >/dev/null 2>&1; then
            echo -e "${RED}${BOLD}[FAIL]${RESET} Could not stop server."
        else
            echo -e "${GREEN}${BOLD}[OK]${RESET} Server stopped."
        fi
    else
        echo -e "${RED}${BOLD}[WARN]${RESET} Server not running."
    fi
}

save_world() {
    pid=$(pgrep -f "$SERVER_NAME")
    if [ -n "$pid" ]; then
        echo -e "${BLUE}${BOLD}[SAVE]${RESET} World saved successfully."
    else
        echo -e "${RED}${BOLD}[ERROR]${RESET} Server not running. Cannot save."
    fi
}

is_running() {
    pid=$(pgrep -f "$SERVER_NAME")
    if [ -z "$pid" ]; then
        echo 0
    elif ps -p "$pid" >/dev/null 2>&1; then
        echo 1
    else
        echo 2
    fi
}

ban_user() {
    echo -e "${MAGENTA}${BOLD}[BAN]${RESET} User '${YELLOW}$1${RESET}' banned."
}

ban_reset() {
    echo -e "${MAGENTA}${BOLD}[BAN]${RESET} All bans cleared."
}

# === Command handler ===
case "$1" in
    -start) start_server ;;
    -stop) stop_server ;;
    -save) save_world ;;
    -isRunning) is_running ;;
    -ban)
        if [ -z "$2" ]; then
            echo -e "${YELLOW}${BOLD}Usage:${RESET} $0 -ban <user>"
        else
            ban_user "$2"
        fi
        ;;
    -banReset) ban_reset ;;
    *)
        echo -e "${BOLD}Usage:${RESET} $0 {-start|-stop|-save|-isRunning|-ban <user>|-banReset}"
        ;;
esac
