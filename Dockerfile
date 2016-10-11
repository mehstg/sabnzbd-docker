FROM alpine:3.2
MAINTAINER Paul Braham

# Installing packages 
RUN apk add --update gcc autoconf automake git g++ make python-dev openssl-dev libffi-dev unrar unzip p7zip python openssl libffi && \
# Installing  par2cmdline 
git clone https://github.com/Parchive/par2cmdline /root/par2cmdline
WORKDIR /root/par2cmdline
RUN aclocal && \
automake --add-missing && \
autoconf && \
./configure && \
make && \
make install
# Installing python dependencies 
RUN curl https://bootstrap.pypa.io/get-pip.py > /root/pip.py && \
python /root/pip.py && \
pip install cheetah && \
pip install configobj && \
pip install feedparser && \
pip install pyOpenSSL && \
# -- Installing python-yenc 
RUN curl http://www.golug.it/pub/yenc/yenc-0.3.tar.gz > /root/yenc-0.3.tar.gz && \
tar -xvzf /root/yenc-0.3.tar.gz
WORKDIR /root/yenc-0.3
RUN python setup.py build && \
python setup.py install

# Cloning sabnzbd 
RUN git clone -b master https://github.com/sabnzbd/sabnzbd /opt/sabnzbd && \
# Removing all software installed in order to compile par2 
apk del gcc autoconf automake git g++ make python-dev openssl-dev libffi-dev && \
# Removing all download and package cache 
rm -rf /var/cache/apk/* && \
rm -rf /root/par2cmdline && \
rm /root/pip.py && \
rm /root/yenc-0.3.tar.gz && \
RUN rm -rf /root/yenc-0.3

EXPOSE 8080

VOLUME ["/opt/config","/opt/downloads","/opt/scripts"]

ENTRYPOINT python /opt/sabnzbd/SABnzbd.py -f /opt/config -b 0 -s 0.0.0.0:8080

