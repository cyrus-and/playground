FROM debian:stretch

RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get upgrade --yes

RUN apt-get install --yes --no-install-recommends \
    apache2 \
    autoconf \
    bash-completion \
    bsdmainutils \
    build-essential \
    ca-certificates \
    curl \
    default-jre \
    git \
    less \
    locales \
    mysql-server \
    net-tools \
    netcat \
    openssh-client \
    php \
    procps \
    sudo \
    tmux \
    unrar-free \
    unzip \
    vim \
    wget \
    wine \
    wine32
RUN apt-get clean

# set up locale
ARG LOCALE=en_US
ARG CHARMAP=UTF-8
RUN localedef -i ${LOCALE} -f ${CHARMAP} ${LOCALE}.${CHARMAP}
ENV LANG=${LOCALE}.${CHARMAP}

# add regular user
RUN useradd -ms /bin/bash -G sudo user
RUN echo 'user ALL=(ALL) NOPASSWD:ALL' >/etc/sudoers.d/user

# switch to user
USER user
WORKDIR /home/user

ENTRYPOINT ["/bin/bash"]
