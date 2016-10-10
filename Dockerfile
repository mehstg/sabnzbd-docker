FROM centos:latest
MAINTAINER Paul Braham
RUN yum update -y
RUN yum install git -y
RUN mkdir /opt/sabnzbd
RUN git clone https://github.com/sabnzbd/sabnzbd.git /opt/sabnzbd/ --depth 1

RUN yum install epel-release -y
RUN yum install python-pip gcc gcc-c++ python-devel libffi-devel openssl-devel par2cmdline wget -y
RUN wget "http://www.rarlab.com/rar/rarlinux-x64-5.3.b4.tar.gz"  -P /tmp
RUN tar -xzvf /tmp/rarlinux-x64-5.3.b4.tar.gz -C /tmp
RUN cp /tmp/rar/unrar /usr/sbin/
RUN cp /tmp/rar/rar /usr/sbin/

RUN pip install --upgrade pip
RUN pip install Cheetah support

EXPOSE 8080

VOLUME ["/opt/config","/opt/downloads"]

ENTRYPOINT python /opt/sabnzbd/SABnzbd.py -b 0 -f /opt/config -s 0.0.0.0:8080

