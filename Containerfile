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

# Cleanup
RUN rm -rf /tmp/*