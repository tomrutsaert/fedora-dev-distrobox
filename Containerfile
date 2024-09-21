FROM ghcr.io/ublue-os/fedora-toolbox:latest AS fedora-dev-toolbox

COPY ./install-dev-env.sh /usr/local/bin/install-dev-env
COPY ./install-intellij.sh /usr/local/bin/install-intellij

RUN dnf -y update && \
    dnf -y install gtk4 make jq && \
    dnf clean all && \
    ln -s /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
    echo 'docker compose --compatibility "$@"' | sudo tee -a /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose && \
    sudo chmod +x /usr/local/bin/install-dev-env && \
    sudo chmod +x /usr/local/bin/install-intellij && \
    mkdir -p /tmp/aws && \
    cd /tmp/aws && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip -qq awscliv2.zip && \
    ./aws/install && \
    rm -rf /tmp/* && \
    aws --version && \
    curl -Lo /tmp/starship.tar.gz "https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-gnu.tar.gz" && \
    tar -xzf /tmp/starship.tar.gz -C /tmp && \
    install -c -m 0755 /tmp/starship /usr/bin && \
    echo 'eval "$(starship init bash)"' >> /etc/bashrc
