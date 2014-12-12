FROM ubuntu:latest
MAINTAINER Olaf Walkowiak <o.walkowiak@etent.de>
VOLUME /var/data
RUN apt-get update # Fri Oct 24 13:09:23 EDT 2014
RUN apt-get -y upgrade
RUN apt-get install psmisc
ADD ./build/MCServer /var/MCServer
ADD ./scripts /var/scripts
RUN mkdir /var/log/supervisor/
RUN chmod -R 755 /var/scripts
EXPOSE 8080 25565
CMD /var/scripts/start.sh