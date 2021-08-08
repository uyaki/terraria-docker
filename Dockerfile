FROM centos:7
MAINTAINER Uyaki Github:uyaki <737376326@qq.com>
USER root
RUN yum -y update
RUN yum -y install screen

# 开放端口
EXPOSE 7777

RUN mkdir /opt/terraria/
ADD terraria/ /opt/terraria/
RUN chmod 744 /opt/terraria/bin/1423/Linux/TerrariaServer.bin.x86_64
RUN chmod 775 /opt/terraria/terra_script.sh

CMD ["./opt/terraria/terra_script.sh","start"]