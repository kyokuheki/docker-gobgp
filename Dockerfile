FROM golang:alpine as builder
LABEL maintainer Kenzo Okuda <okuda.kenzo@nttv6.net>

RUN apk add --no-cache \
    git

RUN go get -v github.com/osrg/gobgp/cmd/gobgpd
RUN go get -v github.com/osrg/gobgp/cmd/gobgp

FROM alpine:edge
LABEL maintainer Kenzo Okuda <kyokuheki@gmail.com>

COPY --from=builder /go/bin/gobgp /go/bin/gobgpd /usr/bin/

RUN apk add --no-cache \
    iproute2 \
    curl \
    tcpdump

VOLUME [ "/gobgp" ]
EXPOSE 179 179/udp 50051 50051/udp

WORKDIR /

CMD ["/usr/bin/gobgpd", "-p", "-l", "debug", "-f", "/gobgp/gobgpd.conf"]
#CMD ["/usr/bin/gobgpd", "-p", "-l", "debug", "-f", "/gobgp/gobgpd.yaml", "-t", "yaml"]
