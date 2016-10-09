FROM debian:jessie
RUN apt-get update \
 && apt-get install -y \
    git-core build-essential \
    libssl-dev
RUN cd /tmp \
 && git clone https://github.com/katmagic/Shallot.git shallot \
 && cd shallot && ./configure && make \
 && cp shallot /usr/local/bin

CMD /usr/local/bin/generate-keys