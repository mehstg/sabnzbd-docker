Implementation of SABnzbd Usenet downloader in Docker

To build (from within folder containing dockerfile):
docker build -t sabnzbd .

To run:
docker run -d -p <PORT>:8080 -v <Volume location for config>:/opt/config -v <Volume location for downloads>:/opt/downloads <Volume location for scripts>:/opt/scripts -t sabnzbd
