# Base
FROM docker.io/rockylinux/rockylinux:8
LABEL maintainer="Damian Troy <github@black.hole.com.au>"

# https://github.com/rocky-linux/sig-cloud-instance-images/issues/22
RUN chmod 1777 /tmp

RUN dnf -y update && dnf clean all

# Common
ENV PUID=1001
ENV PGID=1001
RUN groupadd -g "$PGID" videos && \
    useradd --no-log-init -u "$PUID" -g videos -d /config -M videos && \
    install -d -m 0755 -o videos -g videos /config /videos
ENV TZ=Australia/Melbourne
ENV XDG_DATA_HOME="/config"
ENV XDG_CONFIG_HOME="/config"
COPY test.sh /usr/local/bin/
COPY default-config.sh /usr/local/bin/

# App
RUN dnf -y install epel-release && \
    dnf -y install nmap-ncat qbittorrent-nox && \
    dnf clean all
RUN /usr/local/bin/default-config.sh

# Runtime
VOLUME /config /videos
EXPOSE 6881 6881/udp 8111
USER videos
CMD ["/usr/bin/qbittorrent-nox","--webui-port=8111"]
