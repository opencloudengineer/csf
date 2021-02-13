FROM	debian:buster-slim

LABEL	org.opencontainers.image.source="https://github.com/opencloudengineer/csf" \
		description="CSF + LFD in Docker" \
		maintainer="Siddharth Tiwari <serverlessengineer@gmail.com>"

ARG	DEBIAN_FRONTEND=noninteractive

RUN	apt-get -yqq update \
	&& apt-get -yqq install --no-install-recommends \
		perl \
		libwww-perl \
		liblwp-protocol-https-perl \
		libgd-graph-perl \
		# Install all the dependencies required by CSF
		# As mentioned in the (SECTION:OS Specific Settings)
		# Except systemctl - as it is only needed by csf to disable firewalld
		iptables \
		curl \
		sendmail \
		net-tools \
		procps \
		unzip \
		coreutils \
		gzip \
		grep \
		e2fsprogs \
		iproute2 \
		wget \
		kmod \
		ipset \
		host \
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
	&& rm -rf \
		/var/lib/apt/lists/* \
		/tmp/* \
	# enable lfd
	&& sed -i \
		'/^TESTING =/c TESTING = "0"' \
		/etc/csf/csf.conf \
	&& touch /var/log/lfd.log

COPY	entrypoint.sh /usr/local/bin/

ENTRYPOINT	[ "entrypoint.sh" ]
