FROM nvcr.io/nvidia/pytorch:23.06-py3


RUN apt-get update -y

# Pull tailscale.
RUN curl -fsSL https://tailscale.com/install.sh | sh
RUN apt-get install tailscale

ARG TS_AUTHKEY
ARG TS_HOSTNAME
RUN mkdir /var/runtime/
WORKDIR /var/runtime

COPY ./bootstrap.sh /var/runtime
RUN sh -c ./bootstrap.sh ${TS_AUTHKEY} ${TS_HOSTNAME}
ENV ALL_PROXY=socks5://localhost:1055/

