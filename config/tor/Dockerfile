FROM debian:jessie
MAINTAINER nagev <np1nagev@gmail.com>

RUN gpg --keyserver keys.gnupg.net --recv 886DDD89
RUN gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -

RUN echo 'deb http://deb.torproject.org/torproject.org jessie main' >> /etc/apt/sources.list.d/tor.list

RUN apt-get update
RUN apt-get install -y tor

EXPOSE 9050
EXPOSE 53

CMD tor -f /etc/tor/torrc