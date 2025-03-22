# Use Fedora as base image
FROM fedora:38

# Install required packages
RUN dnf update -y && \
    dnf install -y \
    sudo \
    vulkan-loader \
    vulkan-loader-devel \
    cmake \
    git \
    gcc-c++ \
    libXext-devel \
    libgudev-devel \
    qt6-qtbase-devel \
    qt6-qtbase-private-devel \
    qt6-qtsvg-devel \
    systemd-devel \
    openal-soft-devel \
    libevdev-devel \
    libao-devel \
    SOIL-devel \
    libXrandr-devel \
    pulseaudio-libs-devel \
    bluez-libs-devel \
    libusb1-devel \
    libXi-devel \
    curl \
    fuse \
    fuse-libs \
    mesa-libGL-devel \
    SDL2-devel \
    SDL2_ttf-devel \
    SDL2_gfx-devel \
    libpng-devel \
    libvorbis-devel \
    libvpx-devel \
    fontconfig-devel \
    libcurl-devel \
    glew-devel \
    libzstd-devel \
    gh \
    SDL2_image-devel \
    premake \
    && dnf clean all

# Set the working directory
WORKDIR /workspace

# Download the required files
RUN curl -L -o /usr/local/bin/linuxdeploy-x86_64.AppImage https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage && \
    curl -L -o /usr/local/bin/linuxdeploy-plugin-qt-x86_64.AppImage https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/continuous/linuxdeploy-plugin-qt-x86_64.AppImage && \
    curl -L -o /usr/local/bin/linuxdeploy-plugin-checkrt.sh https://github.com/darealshinji/linuxdeploy-plugin-checkrt/releases/download/continuous/linuxdeploy-plugin-checkrt.sh && \
    curl -L -o /usr/local/bin/appimagetool-x86_64.AppImage https://github.com/probonopd/go-appimage/releases/download/continuous/appimagetool-869-x86_64.AppImage

# Mark the files as executable
RUN chmod +x /usr/local/bin/linuxdeploy-x86_64.AppImage && \
    chmod +x /usr/local/bin/linuxdeploy-plugin-qt-x86_64.AppImage && \
    chmod +x /usr/local/bin/linuxdeploy-plugin-checkrt.sh && \
    chmod +x /usr/local/bin/appimagetool-x86_64.AppImage

# Add a non-root user
RUN useradd -ms /bin/bash fuseuser
USER fuseuser

# Set the user and group ID to match your host (optional)
ENV USER=fuseuser
ENV HOME=/home/fuseuser

# Set default command (optional)
CMD ["bash"]
