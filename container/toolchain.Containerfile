FROM ubuntu:24.04

COPY setup-apt.sh /root/

RUN DEBIAN_FRONTEND=noninteractive /root/setup-apt.sh && rm /root/setup-apt.sh

