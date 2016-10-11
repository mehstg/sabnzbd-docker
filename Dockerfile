FROM centos:latest
MAINTAINER Paul Braham
RUN yum update -y && \
yum install git -y && \
mkdir /opt/sabnzbd && \
mkdir /opt/scripts && \
git clone https://github.com/sabnzbd/sabnzbd.git /opt/sabnzbd/ --depth 1 && \
yum install epel-release -y && \
yum install python-pip gcc gcc-c++ python-devel libffi-devel openssl-devel par2cmdline unzip p7zip -y && \
curl "http://www.rarlab.com/rar/rarlinux-x64-5.3.b4.tar.gz" >  /tmp/rarlinux-x64-5.3.b4.tar.gz && \
tar -xzvf /tmp/rarlinux-x64-5.3.b4.tar.gz -C /tmp && \
cp /tmp/rar/unrar /usr/sbin/ && \
cp /tmp/rar/rar /usr/sbin/ && \
pip install --upgrade pip && \
pip install Cheetah support && \
curl "http://www.golug.it/pub/yenc/yenc-0.3.tar.gz" > /tmp/yenc-0.3.tar.gz && \
tar -xzvf /tmp/yenc-0.3.tar.gz -C /tmp

WORKDIR /tmp/yenc-0.3
RUN python setup.py build && \
python setup.py install

EXPOSE 8080

VOLUME ["/opt/config","/opt/downloads","/opt/scripts"]

ENTRYPOINT python /opt/sabnzbd/SABnzbd.py -b 0 -f /opt/config -s 0.0.0.0:8080

