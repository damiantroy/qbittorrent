# qBittorrent CentOS container

This is a CentOS 8 container for [qBittorrent](https://www.qbittorrent.org/), an open source BitTorrent client.

## Building

To build and test the image, run:

```shell script
make all # build test
```

## Running

More complete instructions are in my [VideoBot Tutorial](https://github.com/damiantroy/videobot),
but this should be enough to get you started.

### Configuration

| Command | Config   | Description
| ------- | -------- | -----
| ENV     | PUID     | UID of the runtime user (Default: 1001)
| ENV     | PGID     | GID of the runtime group (Default: 1001)
| ENV     | TZ       | Timezone (Default: Australia/Melbourne)
| VOLUME  | /videos  | Videos directory, including 'downloads/'
| VOLUME  | /config  | Configuration directory
| EXPOSE  | 8111/tcp | HTTP port for web interface
| EXPOSE  | 6881/tcp | TCP port for torrents
| EXPOSE  | 6881/udp | UDP port for torrents


```shell script
PUID=1001
PGID=1001
TZ=Australia/Melbourne
VIDEOS_DIR=/videos
QBITTORRENT_CONFIG_DIR=/etc/qbittorrent
QBITTORRENT_IMAGE=localhost/qbittorrent # Or damiantroy/qbittorrent if deploying from docker.io

sudo mkdir -p "$VIDEOS_DIR" "$QBITTORRENT_CONFIG_DIR"
sudo chown -R "$PUID:$PGID" "$VIDEOS_DIR" "$QBITTORRENT_CONFIG_DIR"

sudo podman run -d \
    --name=qbittorrent \
    --network=host \
    -e PUID="$PUID" \
    -e PGID="$PGID" \
    -e TZ="$TZ" \
    -v "$QBITTORRENT_CONFIG_DIR:/config:Z" \
    -v "$VIDEOS_DIR:/videos:z" \
    "$QBITTORRENT_IMAGE"
```
