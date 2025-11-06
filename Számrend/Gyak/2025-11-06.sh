#!/bin/bash


history=()
LOG='log.txt'

while true; do
    read -p ">" cmd
    history+=(`date '+%Y-%m-%d'` "| `whoami` | $cmd >")
    echo "`date` | `whoami` | $cmd >" >> $LOG

    # eval "$cmd"         # megcsinálja amit stringként átadunk neki
    if [[ "$cmd" = "kiskutyus" ]]; then
        echo "Woof Woof"
    else
        eval "$cmd"
        clear
        # echo "${history[-3]}";
        # echo "${history[-2]}";
        echo "${history[@]}";
    fi
done