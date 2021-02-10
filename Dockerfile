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
        libgd-graph3d-perl \
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
# create user
  && useradd -l -M -U \
        -u 2020 \
        -c 'User' \
        -s /bin/bash \
        -d /home/user \
        user

#CMD [ "/usr/sbin/csf", "--initup" ]
CMD [ "/usr/sbin/lfd" ]