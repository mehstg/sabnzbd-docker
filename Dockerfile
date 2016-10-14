FROM alpine:latest
MAINTAINER Paul Braham

# Installing temporary build packages 
RUN apk add --no-cache --virtual .build-deps curl gcc autoconf automake git g++ make python-dev openssl-dev libffi-dev && \
# Install packages
apk add --no-cache unrar unzip p7zip python openssl && \

# Installing  par2cmdline 
git clone --depth 1 https://github.com/Parchive/par2cmdline /root/par2cmdline && \
cd /root/par2cmdline && \
aclocal && \
automake --add-missing && \
autoconf && \
./configure && \
make && \
make install && \
# Installing python dependencies 
curl https://bootstrap.pypa.io/get-pip.py > /root/pip.py && \
python /root/pip.py && \
pip install cheetah && \
pip install configobj && \
pip install feedparser && \
pip install pyOpenSSL && \
# -- Installing python-yenc 
curl http://www.golug.it/pub/yenc/yenc-0.3.tar.gz > /root/yenc-0.3.tar.gz && \
tar -xvzf /root/yenc-0.3.tar.gz -C /root && \
cd /root/yenc-0.3 && \
python /root/yenc-0.3/setup.py build && \
python /root/yenc-0.3/setup.py install && \

# Cloning sabnzbd 
git clone -b 1.1.0 --depth 1 https://github.com/sabnzbd/sabnzbd /opt/sabnzbd && \
# Removing all software installed in order to compile par2 
apk del .build-deps && \
# Removing all download and package cache 
rm -rf /var/cache/apk/* && \
rm -rf /root/par2cmdline && \
rm /root/pip.py && \
rm /root/yenc-0.3.tar.gz && \
rm -rf /root/yenc-0.3 && \
rm -rf /opt/sabnzbd/.git

EXPOSE 8080

VOLUME ["/opt/config","/opt/downloads","/opt/scripts"]

ENTRYPOINT python /opt/sabnzbd/SABnzbd.py -f /opt/config -b 0 -s 0.0.0.0:8080

