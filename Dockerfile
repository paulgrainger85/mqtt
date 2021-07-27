FROM alpine:latest

RUN mkdir -p /source/paho.mqtt.c
RUN mkdir -p /q/l64
RUN mkdir -p /source/mqtt/examples
RUN mkdir -p /source/mqtt/q
RUN mkdir -p /source/mqtt/src
RUN mkdir -p /source/mqtt/include

COPY mqtt_build.sh /source

COPY CMakeLists.txt /source/mqtt
COPY install.sh /source/mqtt
COPY README.md /source/mqtt
COPY LICENSE /source/mqtt

COPY q/ /source/mqtt/q
COPY examples/ /source/mqtt/examples
COPY src/ /source/mqtt/src
COPY include/ /source/mqtt/include

ENV QHOME /q
ENV PATH /q/l64:$PATH
ENV LD_LIBRARY_PATH /usr/local/lib:$LD_LIBRARY_PATH
ENV MQTT_INSTALL_DIR /source/paho.mqtt.c
ENV BUILD_HOME /source/paho.mqtt.c

RUN apk add --update && \
    apk add gcc && \
    apk add cmake && \
    apk add make && \
    apk add openssl && \
    apk add wget && \
    apk add gcompat && \
    apk add libc-dev && \
    cd /source && \
    wget https://github.com/eclipse/paho.mqtt.c/releases/download/v1.3.9/Eclipse-Paho-MQTT-C-1.3.9-Linux.tar.gz && \
    tar xvf Eclipse-Paho-MQTT-C-1.3.9-Linux.tar.gz -C ./paho.mqtt.c --strip-components=1 && \
    /source/mqtt_build.sh && \
    apk del gcc && \
    apk del cmake && \
    apk del make && \
    apk del wget && \
    rm -rf /source/mqtt_build.sh /source/paho.mqtt.c /source/Eclipse* /source/mqtt/CmakeLists.txt /source/mqtt/install.sh

## Update this section here to add kdb+
#COPY q/kc.lic /q/
#COPY q/q.k /q/
#COPY q/l64/q /q/l64

WORKDIR /source

CMD ["/bin/sh"]
