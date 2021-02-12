FROM debian:buster-slim

LABEL io.webscoot.authors="serverlessengineer@gmail.com" \
      io.webscoot.vendor="Siddharth Tiwari"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -yqq update \
  && apt-get -yqq install --no-install-recommends \
        iptables \
        curl \
        perl \
        libwww-perl \
        liblwp-protocol-https-perl \
        libgd-graph-perl \
  && cd /tmp \
# download CSF
  && curl -sLo \
        /tmp/csf.tgz \
        https://download.configserver.com/csf.tgz \
  && tar xzf csf.tgz \
  && cd csf \
# install CSF
  && sh install.sh \
# cleanup
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
            /tmp/* \
# enable lfd
  && sed -i \
	'/^TESTING =/c TESTING = "0"' \
	/etc/csf/csf.conf \
  && touch /var/log/lfd.log

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT [ "entrypoint.sh" ]
