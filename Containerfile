FROM ghcr.io/ublue-os/fedora-toolbox:latest AS fedora-dev-toolbox

# Cleanup
RUN rm -rf /tmp/*