FROM alpine:3.11

ENV FAIL2BAN_VERSION="0.11.1" \
  TZ="UTC"

RUN apk --update --no-cache add \
    curl \
    ipset \
    iptables \
    ip6tables \
    kmod \
    nftables \
    python3 \
    python3-dev \
    py3-setuptools \
    ssmtp \
    tzdata \
    wget \
    whois \
  && pip3 install --upgrade pip \
  && pip3 install dnspython3 pyinotify \
  && cd /tmp \
  && curl -SsOL https://github.com/fail2ban/fail2ban/archive/${FAIL2BAN_VERSION}.zip \
  && unzip ${FAIL2BAN_VERSION}.zip \
  && cd fail2ban-${FAIL2BAN_VERSION} \
  && 2to3 -w --no-diffs bin/* fail2ban \
  && python3 setup.py install \
  && rm -rf /etc/fail2ban/jail.d /var/cache/apk/* /tmp/*

COPY entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

VOLUME [ "/data" ]

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "fail2ban-server", "-f", "-x", "-v", "start" ]

HEALTHCHECK --interval=10s --timeout=5s \
  CMD fail2ban-client ping || exit 1