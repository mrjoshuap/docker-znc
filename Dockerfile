# version 1.6.1-1
# docker-version 1.8.2
FROM fedora:22
MAINTAINER Josh Preston <jpreston@redhat.com>

RUN dnf -y upgrade \
    && dnf -y install tree sudo znc \
    && dnf clean all

ADD docker-entrypoint.sh /entrypoint.sh

RUN mkdir -p /var/lib/znc/configs
ADD znc.conf.default /var/lib/znc/configs/znc.conf
RUN chown -R znc:znc /var/lib/znc \
  && chmod 644 /var/lib/znc/configs/znc.conf \
  && tree /var/lib/znc

EXPOSE 6667

USER znc

RUN ls -l /var/lib/znc/configs/znc.conf

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
