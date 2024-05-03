#!/bin/bash

# Define paths and file names
SYMLINK_SOURCE_PATH="$HOME/yocto/poky/build/tmp/deploy/images/intel-corei7-64"
SYMLINK_TARGET_PATH="$HOME/ipxe-images/boot-assets"
FILES=("core-image-kos-intel-corei7-64.iso" "bzImage" "core-image-kos-intel-corei7-64.cpio.gz" "bzImage-initramfs-intel-corei7-64.bin")

# Create symbolic links if they do not already exist
for file in "${FILES[@]}"; do
    source="$SYMLINK_SOURCE_PATH/$file"
    target="$SYMLINK_TARGET_PATH/$file"
    if [ ! -L "$target" ]; then
        echo "Creating symlink for $file"
        ln -sf "$source" "$target"
    else
        echo "Symlink for $file already exists, skipping."
    fi
done

# Function to check if a container is running
is_container_running() {
    docker ps -q -f name="$1"
}

# Start the HTTP server container if not already running
if [ -z $(is_container_running kos-http-server) ]; then
    docker run --rm --name kos-http-server -d \
        --mount type=bind,source=$HOME/ipxe-images/boot-assets,target=/usr/share/nginx/html,readonly \
        --mount type=bind,source=$HOME/yocto/poky/build/tmp/deploy/images/intel-corei7-64/,target=/home/kadmin/yocto/poky/build/tmp/deploy/images/intel-corei7-64/,readonly \
        -v $HOME/ipxe-images/default-nginx.conf:/etc/nginx/conf.d/default.conf:ro \
        -v $HOME/ipxe-images/nginx-cache:/var/cache/nginx \
        -p 80:80 nginx
    echo "Started kos-http-server."
else
    echo "kos-http-server is already running."
fi

# Start the dnsmasq container if not already running
if [ -z $(is_container_running kos-dnsmasq) ]; then
    docker run --rm --name kos-dnsmasq -d --net=host \
        -v $HOME/ipxe-images:/ipxe-images \
        -v $HOME/ipxe-dnsmasq/proxy.conf:/etc/dnsmasq.conf \
        strm/dnsmasq --tftp-root /ipxe-images
    echo "Started kos-dnsmasq."
else
    echo "kos-dnsmasq is already running."
fi
