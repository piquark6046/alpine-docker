ARG  UBUNTU_VERSION=rolling
FROM ubuntu:${UBUNTU_VERSION}

USER root

RUN apt update && apt upgrade -y && apt install -y sudo adduser
# Set rootless
RUN adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER root

# Install packages with root
WORKDIR /
COPY init.sh /init.sh
RUN chmod +x /init.sh && bash /init.sh
RUN rm /init.sh

# Install packages with rootless
USER root
COPY init_container.sh /home/ubuntu/init_container.sh
RUN chown ubuntu /home/ubuntu/init_container.sh
USER ubuntu
RUN chmod +x /home/ubuntu/init_container.sh && bash /home/ubuntu/init_container.sh
RUN rm /home/ubuntu/init_container.sh

# Docker rootless
RUN dockerd-rootless-setuptool.sh install
RUN echo 'export PATH=/usr/bin:$PATH' > /home/ubuntu/.bashrc
RUN echo 'export DOCKER_HOST=unix:///run/user/1000/docker.sock' > /home/ubuntu/.bashrc