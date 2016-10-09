FROM        debian:latest

RUN apt-get update \
 && apt-get install -y \
    bzip2 gnupg \
    mc \
    tor \
    tmux \
    ssh
RUN useradd -m shell
USER shell