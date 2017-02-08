# version 1.6.4-1
# docker-version 1.8.2
FROM fedora:24

# maybe get some help?  probably not...
MAINTAINER Josh Preston <mrjoshuap@redhat.com>

# set our default environment values
ENV DATADIR="/var/lib/znc" \
    ZNC_VERSION="1.6.4-1" \
    IRC_NICK="new_znc_user" \
    IRC_NICK_ALT="new_znc_user_" \
    IRC_IDENT="new_znc_user"

# setup our openshift labels
LABEL io.k8s.description="ZNC is a portable, open source IRC bouncer written in C++." \
      io.k8s.display-name="ZNC 1.6.4-1" \
      io.openshift.expose-services="6667:ircd" \
      io.openshift.tags="instant-app,irc-bouncer" \
      io.openshift.non-scalable="true"

# Upgrade system and install znc
RUN dnf -y upgrade \
    && dnf -y install tree znc \
    && dnf -y clean all

# Create 'znc' account we will use to run Ruby application
RUN mkdir -p ${DATADIR}/configs \
    && chmod -R 777 ${DATADIR}

# Add our default configuration
ADD znc.conf.default ${DATADIR}/configs/znc.conf

# setup our permissions
RUN chmod 666 ${DATADIR}/configs/znc.conf

# add our entry point file
ADD docker-entrypoint.sh /usr/local/bin/entrypoint.sh

# change to our znc user
USER znc

# expose our service
EXPOSE 6667

# run out of the data directory
WORKDIR "${DATADIR}"

# export our VOLUME
VOLUME "${DATADIR}"

# use our entry point script with no command
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD [""]
