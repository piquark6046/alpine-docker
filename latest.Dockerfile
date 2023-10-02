FROM alpine:latest

USER root
RUN apk add bash

# Install packages with root
WORKDIR /
COPY init.sh /root/init.sh
RUN chmod +x /root/init.sh && bash /root/init.sh
RUN rm /root/init.sh

# Create account and switch
RUN adduser --disabled-password --gecos '' -h /home/container container
RUN adduser container sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER container

# Install packages with rootless
USER root
COPY init_container.sh /home/container/root/init_container.sh
RUN chown container /home/container/root/init_container.sh
USER container
RUN chmod +x /home/container/root/init_container.sh && bash /home/container/root/init_container.sh
RUN rm /home/container/root/init_container.sh