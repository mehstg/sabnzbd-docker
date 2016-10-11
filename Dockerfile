FROM alpine:3.2
MAINTAINER Paul Braham

# Installing software to compile 
RUN apk add --update gcc autoconf automake git g++ make python-dev openssl-dev libffi-dev
# Installing  par2cmdline 
RUN git clone https://github.com/Parchive/par2cmdline /root/par2cmdline
WORKDIR /root/par2cmdline
RUN aclocal
RUN automake --add-missing
RUN autoconf
RUN ./configure
RUN make
RUN make install
# Installing other sabnzbd dependencies 
RUN apk add unrar unzip p7zip python openssl libffi
# Installing python dependencies 
WORKDIR /root
RUN curl https://bootstrap.pypa.io/get-pip.py > /root/pip.py
RUN python /root/pip.py
RUN pip install cheetah
RUN pip install configobj
RUN pip install feedparser
RUN pip install pyOpenSSL
# -- Installing python-yenc 
RUN curl http://www.golug.it/pub/yenc/yenc-0.3.tar.gz > /root/yenc-0.3.tar.gz
RUN tar -xvzf yenc-0.3.tar.gz
WORKDIR /root/yenc-0.3
RUN python setup.py build
RUN python setup.py install


EXPOSE 8080

VOLUME ["/opt/config","/opt/downloads","/opt/scripts"]

ENV HOME /opt/config

ENTRYPOINT python /opt/sabnzbd/SABnzbd.py -b 0 -s 0.0.0.0:8080

