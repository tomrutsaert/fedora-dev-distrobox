FROM ghcr.io/ublue-os/fedora-toolbox:latest AS fedora-dev-toolbox

RUN touch ~/.bashrc && chmod +x ~/.bashrc

#sdkman in in 2 steps: see https://stackoverflow.com/questions/63336131/install-sdkman-in-an-alpine-based-docker-image
RUN curl -s "https://get.sdkman.io" | bash
RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && \
    sdk version && \
    sed -i 's/sdkman_auto_env=false/sdkman_auto_env=true/g' ~/.sdkman/etc/config"

#nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
RUN . ~/.nvm/nvm.sh && \
    source ~/.bashrc && \
    nvm install --latest-npm && \
    nvm alias default $(node --version) && \
    npm --version

#awscli
RUN mkdir -p /tmp/aws && \
    cd /tmp/aws && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    aws --version

# Cleanup
RUN rm -rf /tmp/*