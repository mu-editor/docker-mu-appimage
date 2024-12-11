FROM ubuntu:18.04

LABEL org.opencontainers.image.description="Docker image to create Mu Editor AppImage builds."
LABEL org.opencontainers.image.source="https://github.com/mu-editor/docker-mu-appimage"

# Installing build tools, git, python3 and setting it as the default python
ENV DEBIAN_FRONTEND=noninteractive

# Download Python from the standalonge builds, symlink it to /bin/, and add to path
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends ca-certificates wget && \
    apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* && \
    wget https://github.com/indygreg/python-build-standalone/releases/download/20241002/cpython-3.8.20+20241002-x86_64-unknown-linux-gnu-install_only.tar.gz && \
    tar -xf cpython-3.8.20+20241002-x86_64-unknown-linux-gnu-install_only.tar.gz -C / && \
    rm cpython-3.8.20+20241002-x86_64-unknown-linux-gnu-install_only.tar.gz && \
    ln -s /python/bin/python3.8 /bin/python && \
    ln -s /python/bin/python3.8 /bin/python3
ENV PATH /python/bin:$PATH

RUN apt-get update -qq && \
    # Install tooling neded by Mu
    apt-get install -y --no-install-recommends make git && \
    # Install xvfb to be able to run tests headless
    apt-get install -y --no-install-recommends libxkbcommon-x11-0 xvfb && \
    # Workaround for PyQt5 issue
    # qt.qpa.plugin: Could not load the Qt platform plugin "xcb" in "" even though it was found.
    apt-get install -y --no-install-recommends libqt5gui5 && \
    # Install AppImage dependencies
    apt-get install -y --no-install-recommends libfuse2 file appstream && \
    apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

WORKDIR /home/
