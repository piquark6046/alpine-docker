ARG  UBUNTU_VERSION=devel
FROM ubuntu:${UBUNTU_VERSION}

USER root

# Install packages with root
WORKDIR /
COPY init.sh /init.sh
RUN chmod +x /init.sh && bash /init.sh
RUN rm /init.sh

# Create account and switch
RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER docker

# Install packages with rootless
USER root
COPY init_docker.sh /home/docker/init_docker.sh
RUN chown docker /home/docker/init_docker.sh
USER docker
RUN chmod +x /home/docker/init_docker.sh && bash /home/docker/init_docker.sh
RUN rm /home/docker/init_docker.sh