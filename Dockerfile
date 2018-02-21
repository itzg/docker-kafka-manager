FROM openjdk:8-jdk as build

ARG VERSION=1.3.3.16

WORKDIR /build
ADD https://github.com/yahoo/kafka-manager/archive/${VERSION}.tar.gz /build/
RUN tar xf ${VERSION}.tar.gz --strip-components=1
RUN ./sbt dist

FROM openjdk:8-jre

ARG VERSION=1.3.3.16

COPY --from=build /build/target/universal/kafka-manager-${VERSION}.zip /tmp

RUN unzip -d /opt /tmp/kafka-manager-${VERSION}.zip && rm /tmp/kafka-manager-${VERSION}.zip
WORKDIR /opt/kafka-manager-${VERSION}

EXPOSE 9000

ENTRYPOINT ["../start-kafka-manager.sh"]

COPY start-kafka-manager.sh /opt