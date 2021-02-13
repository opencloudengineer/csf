## CSF + LFD in Docker

### test

`perl /usr/local/csf/bin/csftest.pl`

### run

`docker run -d --name=csf --net host --cap-add=NET_ADMIN ghcr.io/opencloudengineer/csf`
