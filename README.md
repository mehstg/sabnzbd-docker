Implementation of SABnzbd Usenet grabber in Docker

To build (from within folder containing dockerfile):
docker build -t sabnzbd .

To run:
docker run -d -p <PORT>:8080 -v <Volume location for config>:/opt/config -v <Volume location for downloads>:/opt/downloads -t sabnzbd
