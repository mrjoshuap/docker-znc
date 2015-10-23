# version 1.6.1-1
# docker-version 1.8.2
FROM fedora:22
MAINTAINER Josh Preston <jpreston@redhat.com>

RUN dnf -y upgrade \
    && dnf -y install tree sudo znc \
    && dnf clean all

ADD docker-entrypoint.sh /entrypoint.sh

ENV DATADIR "/tmp/znc"
RUN mkdir -p ${DATADIR}/configs
ADD znc.conf.default ${DATADIR}/configs/znc.conf
RUN chown -R znc:znc ${DATADIR} \
  && chmod 644 ${DATADIR}/configs/znc.conf \
  && tree ${DATADIR}

EXPOSE 6667

USER znc
WORKDIR "${DATADIR}"

RUN ls -l ${DATADIR}/configs/znc.conf

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
