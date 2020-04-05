FROM python:3.8.0b1-stretch
#FROM debian:latest
#FROM quay.io/ansible/molecule:2.20

MAINTAINER frank378@gmail.com
ENV container homelab

ENV MY_USER franklin
ENV MY_HOME /home/${MY_USER}
ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONPATH=/usr/local/lib/python3.7/site-packages

ADD . /tmp/project
WORKDIR /tmp/project

RUN \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367;\
apt update; \
apt install -y sshpass; \
python -m pip install ansible; \
python -m pip install molecule['docker']

RUN \
mkdir /etc/ansible; \
cp /tmp/project/ansible/hosts /etc/ansible; \
cp /tmp/project/ansible/ansible.cfg /etc/ansible
#ansbile raspis -m ping
