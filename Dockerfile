# version 1.6.1-1
# docker-version 1.8.2
FROM fedora:23

# maybe get some help?  probably not...
MAINTAINER Josh Preston <jpreston@redhat.com>

# set our default environment values
ENV DATADIR="/var/lib/znc" \
    ZNC_VERSION="1.6.1-1"

# setup our openshift labels
LABEL io.k8s.description="ZNC is a portable, open source IRC bouncer written in C++." \
      io.k8s.display-name="ZNC 1.6.1-1" \
      io.openshift.expose-services="6667:ircd" \
      io.openshift.tags="chat,irc-bouncer" \
      io.openshift.non-scalable="true"

# Upgrade system and install znc
RUN dnf -y upgrade \
    && dnf -y install tree znc \
    && dnf clean all

# Create 'znc' account we will use to run Ruby application
RUN mkdir -p ${DATADIR}/configs

# Add our default configuration
ADD znc.conf.default ${DATADIR}/configs/znc.conf

# setup our permissions
RUN chown -R 995:0 ${DATADIR} \
  && chmod 640 ${DATADIR}/configs/znc.conf

# add our entry point file
ADD docker-entrypoint.sh /usr/local/bin/entrypoint.sh

# expose our service
EXPOSE 6667

# run as our desired user
USER 995

# run out of the data directory
WORKDIR "${DATADIR}"

# use our entry point script with no command
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD [""]
