ARG  UBUNTU_VERSION=rolling
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
COPY init_gitcache.sh /home/docker/init_gitcache.sh
RUN chown docker /home/docker/init_gitcache.sh
RUN mkdir /gitcache
RUN chown docker /gitcache
USER docker
RUN chmod +x /home/docker/init_gitcache.sh && bash /home/docker/init_gitcache.sh
RUN rm /home/docker/init_gitcache.sh