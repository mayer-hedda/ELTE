#!/bin/bash

LOG_FILE="logs.txt"
BANLIST="banlist.txt"
SERVER_SCRIPT="./Server.sh"
USER=$(whoami)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

last_commands=()
start_time=""
last_save_time=""

log() {
    local type="$1"
    local msg="$2"

    case "$type" in
        "Info")
            echo -e "${GREEN}[$type]${NC} $(date '+%Y.%m.%d %H:%M:%S') | $USER | $msg" | tee -a "$LOG_FILE"
            ;;
        "Server")
            echo -e "${YELLOW}[$type]${NC} $(date '+%Y.%m.%d %H:%M:%S') | $USER | $msg" | tee -a "$LOG_FILE"
            ;;
        "Error")
            echo -e "${RED}[$type]${NC} $(date '+%Y.%m.%d %H:%M:%S') | $USER | $msg" | tee -a "$LOG_FILE"
            ;;
    esac
}

show_help() {
    echo "  Parancsok:"
    echo "      start        - szerver indítása"
    echo "      stop         - szerver leállítása"
    echo "      restart      - szerver újraindítása"
    echo "      status       - állapot lekérdezése"
    echo "      ban <user>   - játékos tiltása"
    echo "      help         - parancslista"
    echo "      exit         - kilépés"
}


# 1. feladat
if [[ "$1" == "--help" ]]; then
    echo "Használat: ./ServerHandler.sh"
    echo "Elérhető parancsok: start, stop, restart, status, help, ban <user>"
    exit 0
fi

# 4. feladat
monitor_server() {
    local fail_count=0
    while true; do
        local now=$(date '+%H:%M')
        local status=$($SERVER_SCRIPT -isRunning)

        if [[ "$status" == "0" ]]; then
            log "Error" "A szerver nem fut, indítás próbálkozás..."
            $SERVER_SCRIPT -start && {
                log "Server" "SERVER STARTED"
                start_time=$(date +%s)
                fail_count=0
            } || ((fail_count++))

            # 5. feladat
            if (( fail_count >= 3 )); then
                log "Error" "3 sikertelen indítás, várakozás 5 percig..."
                sleep 300
                fail_count=0
            fi
        elif [[ "$status" == "1" ]]; then
            $SERVER_SCRIPT -save
            last_save_time=$(date '+%Y.%m.%d %H:%M:%S')
            log "Server" "Világ mentve."
        fi

        if [[ "$now" == "04:00" ]]; then
            log "Server" "Napi újraindítás 04:00-kor..."
            $SERVER_SCRIPT -stop
            sleep 5
            $SERVER_SCRIPT -start
            start_time=$(date +%s)
            log "Server" "SERVER RESTARTED"
        fi

        sleep 180
    done
}

monitor_server &


while true; do
    echo -n "> "
    read cmd arg

    last_commands+=("$cmd $arg")
    if (( ${#last_commands[@]} > 5 )); then
        last_commands=("${last_commands[@]: -5}")
    fi

    case "$cmd" in
        # 2. feladat
        "start")
            status=$($SERVER_SCRIPT -isRunning)
            if [[ "$status" == "1" ]]; then
                log "Info" "A szerver már fut."
            else
                log "Server" "Szerver indítása..."
                $SERVER_SCRIPT -start
                start_time=$(date +%s)
            fi
            ;;
        "stop")
            status=$($SERVER_SCRIPT -isRunning)
            if [[ "$status" == "0" ]]; then
                log "Info" "A szerver nem fut."
            else
                log "Server" "Szerver leállítása..."
                $SERVER_SCRIPT -stop
            fi
            ;;
        "restart")
            status=$($SERVER_SCRIPT -isRunning)
            if [[ "$status" == "0" ]]; then
                log "Info" "A szerver nem fut, indítás..."
                $SERVER_SCRIPT -start
            else 
                log "Server" "A szerver újraindul..."
                $SERVER_SCRIPT -stop
                $SERVER_SCRIPT -start
                start_time=$(date +%s)
            fi
            ;;
        "status")
            status=$($SERVER_SCRIPT -isRunning)
            if [[ "$status" == "0" ]]; then
                log "Info" "A szerver nem fut."
            else
                local now=$(date +%s)
                local uptime=""
                if [[ -n "$start_time" ]]; then
                    local diff=$(( now - start_time ))
                    uptime="$(($diff / 3600))h $(( ($diff % 3600) / 60 ))m"
                fi
                log "Info" "A szerver fut. Uptime: ${uptime:-ismeretlen}. Utolsó mentés: ${last_save_time:-még nem történt}."
            fi
            ;;
        "help")
            show_help
            ;;
        # 3. feladat
        "ban")
            if [[ -z "$arg" ]]; then
                log "Error" "Hiányzó felhasználónév."
                continue
            fi

            if grep -q "|\s*$arg\s*|" "$BANLIST"; then
                log "Info" "$arg már tiltva van:"
                grep "|\s*$arg\s*|" "$BANLIST" | while IFS='|' read -r date reason name address ip; do
                    date=$(echo "$date" | xargs)
                    reason=$(echo "$reason" | xargs)
                    name=$(echo "$name" | xargs)
                    address=$(echo "$address" | xargs)
                    ip=$(echo "$ip" | xargs)
                    echo "  Dátum: $date"
                    echo "  Ok: $reason"
                    echo "  Név: $name"
                    echo "  Lakcím, IP cím: $address $ip"
                    echo
                done
            else
                ip=$(ifconfig | awk '/inet /{print $2; exit}')
                echo "$(date '+%Y.%m.%d') | manuális tiltás | $arg | otthon | $ip" >> "$BANLIST"
                $SERVER_SCRIPT -ban "$arg"
                log "Server" "$arg kitiltva."
            fi
            ;;
        "exit")
            log "Info" "Kilépés a programból."
            exit 0
            ;;
        *)
            log "Error" "Ismeretlen parancs: $cmd"
            ;;
    esac

    echo $last_commands
done
