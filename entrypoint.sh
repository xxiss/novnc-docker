#!/bin/sh -e

if [ -f "/noVNC/token.conf" ]; then
    /noVNC/utils/websockify/run --web /noVNC --target-config=/noVNC/token.conf 6080
else
    /noVNC/utils/websockify/run --web /noVNC 6080 ${REMOTE_HOST:-localhost}:${REMOTE_PORT:-5900}
fi

