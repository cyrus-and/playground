FROM debian:buster

# set up repositories
RUN dpkg --add-architecture i386 # XXX for wine
RUN apt-get update

# install services
RUN apt-get install --yes --no-install-recommends \
    apache2 default-mysql-server

# install interpreters
RUN apt-get install --yes --no-install-recommends \
    default-jre php python python-pip python3 python3-pip

# install development tools
RUN apt-get install --yes --no-install-recommends \
    autoconf build-essential git strace

# install wine
RUN apt-get install --yes --no-install-recommends \
    wine wine32

# install other utilities
RUN apt-get install --yes --no-install-recommends \
    bash-completion bsdmainutils ca-certificates curl less locales net-tools \
    netcat openssh-client procps sudo tmux unrar-free unzip vim wget

# finally upgrade and free some space
RUN apt-get upgrade --yes
RUN apt-get clean

# set up locale
ARG LOCALE=en_US
ARG CHARMAP=UTF-8
RUN localedef -i $LOCALE -f $CHARMAP $LOCALE.$CHARMAP
ENV LANG=$LOCALE.$CHARMAP

# add a regular user and grant it sudo privileges
RUN useradd -ms /bin/bash -G sudo user
RUN echo 'user ALL=(ALL) NOPASSWD:ALL' >/etc/sudoers.d/user

# switch to user
USER user
WORKDIR /home/user

# set up a welcome message
RUN echo 'echo [+] Shared directory located at $PLAYGROUND in the host' >>.bashrc

# enable 256 colors in tmux
RUN echo "set-option -g default-terminal 'screen-256color'" >.tmux.conf

# drop a tmux session
ENTRYPOINT ["/usr/bin/tmux"]
