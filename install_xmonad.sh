#!/bin/bash

PORT="$1"
USER="dtg"
HOST="127.0.0.1"

scp -P "$PORT" -rp ./dotfiles/. $USER@$HOST:~/
