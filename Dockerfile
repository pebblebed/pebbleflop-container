FROM nvcr.io/nvidia/pytorch:23.06-py3


RUN apt-get update -y
RUN apt-get install -y sudo

# Pull tailscale, mostly from the stable docker image
RUN curl -fsSL https://tailscale.com/install.sh | sh

ARG TS_AUTHKEY
ARG TS_HOSTNAME
ARG USER=pebble

ENV ALL_PROXY=socks5://localhost:1055/


RUN mkdir -p /var/runtime
COPY ./bootstrap.sh /var/runtime
WORKDIR /var/runtime

ENV TS_AUTHKEY=${TS_AUTHKEY}
ENV TS_HOSTNAME=${TS_HOSTNAME}

## Create a less privileged user
RUN useradd -m ${USER}
RUN echo "${USER}:${USER}" | chpasswd
RUN usermod -aG sudo ${USER}
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Run the daemons and chill
ENTRYPOINT /var/runtime/bootstrap.sh ${TS_AUTHKEY} ${TS_HOSTNAME}

