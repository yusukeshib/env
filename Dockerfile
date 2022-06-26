FROM ubuntu:latest

RUN apt-get update
RUN apt-get -y install sudo
RUN apt-get -y install openssh-server
RUN apt-get -y install git
RUN apt-get -y install vim

RUN mkdir -p /var/run/sshd
CMD exec "$@" && /usr/sbin/sshd -D
EXPOSE 22

