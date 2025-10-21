#!/bin/bash

n=$((RANDOM%10))

if [ "$1" -eq "$n" ]; then
    echo -e "\e[32mWIN\e[0m"
else
    echo LOSE, mert $n
fi