# docker-gobgp
Containerized gobgp daemon

## usage
run gobgpd daemon

```shell
mkdir -p /srv/gobgp
vim /srv/gobgp/gobgpd.conf
docker run -d --rm --name gobgpd -p179:179/tcp -p50051:50051 -p50051:50051/udp -v/srv/gobgp:/gobgp kyokuheki/gobgp
```

run gobgp client

```shell
ipaddr=`docker inspect gobgpd -f '{{ .NetworkSettings.IPAddress }}'`
docker run -it --rm kyokuheki/gobgp gobgp -u $ipaddr global
```

## build

```shell
git clone https://github.com/kyokuheki/docker-gobgp.git
docker build docker-gobgp -t gobgp
```
