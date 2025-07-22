#!/usr/bin/env bash
DATA_DIR="/data"

exec python3 -m piper.http_server --host 0.0.0.0 --data-dir "${DATA_DIR}" -m en_GB-southern_english_female-low "$@" & /usr/sbin/nginx -g 'daemon off;'