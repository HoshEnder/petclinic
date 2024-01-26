FROM eclipse-temurin:17-alpine

VOLUME /opt/egbtm
#ADD data /
COPY target/spring-petclinic-config-server-3.2.0.jar /app/

WORKDIR /app

ENV JAVA_OPTS=""
ENTRYPOINT ["java", "-jar", "spring-petclinic-config-server-3.2.0.jar"]