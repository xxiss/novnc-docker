FROM docker.io/ubuntu:20.04

ARG TZ="Asia/Shanghai"
ENV TZ ${TZ}

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak && echo "\
deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse \n\
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse \n\
deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse \n\
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse \n\
deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse \n\
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse \n\
deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse \n\
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse \n\
deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse \n\
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse "\
    > /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y git python3
RUN cd / && git clone git://github.com/kanaka/noVNC && cd noVNC/utils && git clone https://github.com/novnc/websockify
WORKDIR /
EXPOSE 6080
COPY entrypoint.sh .
RUN chmod 755 ./entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]

