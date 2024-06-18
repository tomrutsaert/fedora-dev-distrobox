FROM ghcr.io/ublue-os/fedora-distrobox AS fedora-dev-distrobox

# Cleanup
RUN rm -rf /tmp/*