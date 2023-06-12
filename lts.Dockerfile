ARG  UBUNTU_VERSION=latest
FROM ubuntu:${UBUNTU_VERSION}

USER root

# Install packages with root
WORKDIR /
COPY init.sh /init.sh
RUN chmod +x /init.sh && bash /init.sh
RUN rm /init.sh

# Create account and switch
RUN adduser --disabled-password --gecos '' container
RUN adduser container sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER container

# Install packages with rootless
USER root
COPY init_container.sh /home/container/init_container.sh
RUN chown container /home/container/init_container.sh
USER container
RUN chmod +x /home/container/init_container.sh && bash /home/container/init_container.sh
RUN rm /home/container/init_container.sh