# version 1.6.1-1
# docker-version 1.8.2
FROM fedora:22
MAINTAINER Josh Preston <jpreston@redhat.com>

RUN dnf -y upgrade \
    && dnf -y install znc

ADD docker-entrypoint.sh /entrypoint.sh
ADD znc.conf.default znc.conf.default
RUN chmod 644 /znc.conf.default

VOLUME /var/lib/znc
RUN mkdir -p /var/lib/znc && chown -R znc:znc /var/lib/znc

EXPOSE 6667

USER znc

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
