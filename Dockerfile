# Dockerfile to install Galago
# Based on : https://github.com/osirrc/indri-docker/blob/master/Dockerfile
# For the Open-Source IR Replicability Challenge (OSIRRC) at SIGIR 2019
# https://osirrc.github.io/osirrc2019/

FROM openjdk:8
LABEL maintainer="MichaelZ@cs.umass.edu"

RUN apt-get update && apt-get install -y \
    python3\
    python3-bs4

WORKDIR /work

#download and install Galago
RUN wget --no-check-certificate https://sourceforge.net/projects/lemur/files/lemur/galago-3.15/galago-3.15-bin.tar.gz
RUN tar -xvzf galago-3.15-bin.tar.gz -C /work

COPY index /
COPY indexRobust04.sh /
COPY search /
COPY searchRobust04.sh /
COPY formatTopics.py /

RUN chmod +x /index
RUN chmod +x /search
