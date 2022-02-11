ARG BUILD_FROM=balenalib/rpi-raspbian

FROM $BUILD_FROM

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install --yes --no-install-recommends \
    libnotify-bin \
    wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://www.unifiedremote.com/download/rpi-deb -O ur.deb && \
    apt-get install -y ./ur.deb && \
    rm ur.deb && \
    sed -i 's/NO_MANAGER=false/NO_MANAGER=true/g' /opt/urserver/urserver-start

RUN echo "#!/bin/bash" > /entrypoint.sh && \
    echo "./opt/urserver/urserver-start" >> /entrypoint.sh && \
    echo 'exec "$@"' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

RUN groupadd -g 1000 ur && \
    groupadd uinput && \
    useradd -u 1000 -g ur -g uinput --shell /bin/bash --create-home ur && \
    mkdir /home/ur/.urserver && \
    touch /home/ur/.urserver/urserver.config && \
    chown --recursive ur:ur /home/ur/.urserver

USER ur

COPY --chown=ur:ur custom /home/ur/.urserver/remotes/

EXPOSE 9510/tcp 9512/tcp 9512/udp 9511/udp
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/bin/bash" ]
