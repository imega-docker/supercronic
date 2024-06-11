FROM scratch

ARG BUILDER_VERSION

LABEL maintainer="Dmitry Stoletoff info@imega<dot>ru" \
    version=$VERSION \
    description="Supercronic for docker." \
    from_image="imega/base-builder:$BUILDER_VERSION" \
    url="https://github.com/imega-docker/supercronic" \
    changelog="https://github.com/imega-docker/supercronic/blob/master/CHANGELOG.md" \
    contributing="https://github.com/imega-docker/supercronic/blob/master/CONTRIBUTING.md" \
    license="https://github.com/imega-docker/supercronic/blob/master/LICENSE"

ADD buildfs/rootfs.tar.gz /

ENTRYPOINT ["supercronic"]
