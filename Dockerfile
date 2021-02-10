ARG JAVA_VERSION=11

FROM adoptopenjdk/openjdk${JAVA_VERSION}:debian

RUN apt-get update \
 && apt-get install -y unzip xvfb libegl1 curl libxrender1 liblwjgl-java libxtst6

COPY run.sh /usr/local/bin/tectonicus
COPY config.xml /config.xml

RUN useradd --home-dir /var/lib/tectonicus --create-home tectonicus

ARG TECTONICUS_VERSION=2.28.7
RUN curl -sL -o /tmp/dl.zip "https://github.com/tectonicus/tectonicus/releases/download/v${TECTONICUS_VERSION}/Tectonicus-${TECTONICUS_VERSION}.zip" \
 && cd /opt \
 && unzip /tmp/dl.zip \
 && rm /tmp/dl.zip \
 && mv "Tectonicus-${TECTONICUS_VERSION}" "tectonicus" \
 && mkdir /var/log/tectonicus /var/cache/tectonicus \
 && chown -R tectonicus:tectonicus /var/log/tectonicus /var/cache/tectonicus \
 && ln -s /var/log/tectonicus /opt/tectonicus/log \
 && ln -s /var/cache/tectonicus /opt/tectonicus/Cache

USER tectonicus

WORKDIR /var/lib/tectonicus

