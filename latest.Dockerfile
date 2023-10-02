FROM alpine:latest

USER root
RUN apk add bash

# Install packages with root
WORKDIR /
COPY init.sh /root/init.sh
RUN chmod +x /root/init.sh && bash /root/init.sh
RUN rm /root/init.sh

# Create account and switch
RUN adduser -s /bin/bash --disabled-password --gecos '' -h /home/container container
RUN adduser container wheel
RUN echo 'container ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER container

# Install packages with rootless
USER root
COPY init_container.sh /home/container/init_container.sh
RUN chown container /home/container/init_container.sh
USER container
RUN chmod +x /home/container/init_container.sh && bash /home/container/init_container.sh
USER root
RUN rm /home/container/init_container.sh
USER container

ENTRYPOINT /bin/bash