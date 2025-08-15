#!/usr/bin/env bash
if [ -t 0 ]; then
    base64 < "$1" | tr -d '\n' | awk '{printf "\033]52;c;%s\007", $0}'
else
    base64 | tr -d '\n' | awk '{printf "\033]52;c;%s\007", $0}'
fi
