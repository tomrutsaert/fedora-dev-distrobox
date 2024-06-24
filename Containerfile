FROM ghcr.io/ublue-os/fedora-toolbox:latest AS fedora-dev-toolbox

COPY ./init.sh /usr/local/bin/dev-box-init

RUN dnf -y update && \
    dnf -y install gtk4 make jq && \
    ln -s /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
    echo 'docker compose --compatibility "$@"' | sudo tee -a /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose && \
    sudo chmod +x /usr/local/bin/dev-box-init

#awscli
RUN mkdir -p /tmp/aws && \
    cd /tmp/aws && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip -qq awscliv2.zip && \
    ./aws/install && \
    aws --version

#jetbrains-idea
RUN mkdir -p /tmp/idea && cd /tmp/idea && \
    curl -sSfL -o releases.json "https://data.services.jetbrains.com/products/releases?code=IIU&latest=true&type=release" && \
    BUILD_VERSION=$(jq -r '.IIU[0].build' ./releases.json) && \
    DOWNLOAD_LINK=$(jq -r '.IIU[0].downloads.linux.link' ./releases.json) && \
    CHECKSUM_LINK=$(jq -r '.IIU[0].downloads.linux.checksumLink' ./releases.json) && \
    echo "Installing Intellij ${BUILD_VERSION}" && \
    curl -sSfL -O "${DOWNLOAD_LINK}" && \
    curl -sSfL "${CHECKSUM_LINK}" | sha256sum -c && \
    ls -al . && \
    chmod 777 ideaIU-*.tar.gz && \
    tar -xzf ideaIU-*.tar.gz -C . --no-same-owner --no-same-permissions --no-overwrite-dir --touch --owner=root --group=root && \
    mv /tmp/idea/idea-IU-${BUILD_VERSION} /opt/idea-IU-${BUILD_VERSION} && \
    cat << EOF > /usr/share/applications/jetbrains-idea.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=IntelliJ IDEA Ultimate Edition
Icon=/opt/idea-IU-${BUILD_VERSION}/bin/idea.svg
Exec="/opt/idea-IU-${BUILD_VERSION}/bin/idea.sh" %f
Comment=Capable and Ergonomic IDE for JVM
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-idea
StartupNotify=true
EOF

# Cleanup
RUN rm -rf /tmp/*