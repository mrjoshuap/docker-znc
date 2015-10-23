# version 1.6.1-1
# docker-version 1.8.2
FROM fedora:22
MAINTAINER Josh Preston <jpreston@redhat.com>

RUN dnf -y upgrade \
    && dnf -y install znc \
    && dnf clean all

ADD docker-entrypoint.sh /entrypoint.sh
RUN chmod 644 /znc.conf.default

#VOLUME /var/lib/znc
RUN mkdir -p /var/lib/znc/configs && chown -R znc:znc /var/lib/znc
ADD znc.conf.default /var/lib/znc/configs/znc.conf

EXPOSE 6667

USER znc

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
