FROM golang:alpine
LABEL maintainer Kenzo Okuda <okuda.kenzo@nttv6.net>

RUN apk add --no-cache \
    iproute2 \
    git \
    curl \
    tcpdump

RUN go get -v github.com/osrg/gobgp/cmd/gobgpd
RUN go get -v github.com/osrg/gobgp/cmd/gobgp

VOLUME [ "/gobgp" ]
EXPOSE 179 179/udp 50051 50051/udp

WORKDIR /

CMD ["gobgpd", "-p", "-l", "debug", "-f", "/gobgp/gobgpd.conf"]
#CMD ["gobgpd", "-p", "-l", "debug", "-f", "/gobgp/gobgpd.yaml", "-t", "yaml"]
