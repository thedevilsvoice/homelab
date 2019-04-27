FROM python:3.7.3-stretch
#FROM debian:latest
#FROM quay.io/ansible/molecule:2.20

MAINTAINER frank378@gmail.com
ENV container homelab

ENV MY_USER franklin
ENV MY_HOME /home/${MY_USER}
ENV DEBIAN_FRONTEND noninteractive
ENV PYTHON_PATH=/usr/local/lib/python3.7/site-packages

ADD . /tmp/project
WORKDIR /tmp/project

RUN \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367;\
apt-get -y update; \
pip install ansible; \
pip install molecule
