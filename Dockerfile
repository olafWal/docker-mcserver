FROM ubuntu:latest
MAINTAINER Olaf Walkowiak <o.walkowiak@etent.de>
RUN apt-get update # Fri Oct 24 13:09:23 EDT 2014
RUN apt-get -y upgrade
ADD ./build/MCServer /var/MCServer
ADD ./scripts /var/scripts
RUN mkdir /var/log/supervisor/
RUN chmod -R 755 /var/scripts
EXPOSE 8080 25565
CMD /var/scripts/start.sh