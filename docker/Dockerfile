FROM python:3.8.1-buster
#FROM debian:latest
#FROM quay.io/ansible/molecule:2.20

LABEL AUTHOR="frank378@gmail.com"
ENV container homelab
ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONPATH=/usr/local/lib/python3.8/site-packages

ADD . /root
WORKDIR /root

RUN \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367;\
DEBIAN_FRONTEND=noninteractive apt update; \
DEBIAN_FRONTEND=noninteractive apt install -y dialog apt-utils; \
DEBIAN_FRONTEND=noninteractive apt install -y sshpass; \
make test

RUN \
mkdir /etc/ansible; \
cp /root/ansible/hosts /etc/ansible; \
cp /root/ansible/ansible.cfg /etc/ansible
#ansible raspis -m ping
