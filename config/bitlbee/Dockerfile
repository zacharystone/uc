FROM        debian:latest

RUN apt-get update \
 && apt-get install -y \
    bitlbee bitlbee-plugin-otr
RUN useradd -m chat
EXPOSE 6667
USER chat
