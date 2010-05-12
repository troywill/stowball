groupadd -fg 27 polkituser &&
useradd -c "Policy Kit Daemon User" -d /dev/null -u 27 \
    -g polkituser -s /bin/false polkituser || [ $? == 9 ]
