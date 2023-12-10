ARG  UBUNTU_VERSION=latest
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
COPY init_container.sh /home/container/init_container.sh
RUN chown ubuntu /home/container/init_container.sh
USER ubuntu
RUN chmod +x /home/container/init_container.sh && bash /home/container/init_container.sh
RUN rm /home/container/init_container.sh