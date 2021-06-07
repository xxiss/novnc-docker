FROM docker.io/ubuntu:20.04

RUN apt-get update && apt-get install -y git python3
RUN cd / && git clone https://github.com/novnc/noVNC.git && cd noVNC/utils && git clone https://github.com/novnc/websockify
RUN printf "#!/bin/sh -e \n\
if [ -f /noVNC/token.conf ]; then \n  /noVNC/utils/websockify/run --web /noVNC --target-config=/noVNC/token.conf 6080 \nelse \n\
  /noVNC/utils/websockify/run --web /noVNC 6080 ${REMOTE_HOST:-localhost}:${REMOTE_PORT:-5900} \nfi\n" > entrypoint.sh && chmod +x entrypoint.sh
EXPOSE 6080
CMD ["/entrypoint.sh"]
