FROM ubuntu:cosmic
RUN apt update
RUN apt install -y automake cmake make g++ gcc git libmysqlclient-dev libssl-dev bzip2 libtool patch
RUN apt install -y zlib1g-dev libluajit-5.1-dev libconfig++-dev libjemalloc-dev libdaemon-dev libre2-dev libpcre++-dev
COPY . /tmp/proxysql
WORKDIR /tmp/proxysql
RUN make
