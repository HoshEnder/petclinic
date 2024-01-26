FROM eclipse-temurin:17-alpine

VOLUME /opt/egbtm
#ADD data /
COPY target/spring-petclinic-vets-service-3.2.0.jar /app/

WORKDIR /app

ENV SPRING_PROFILES_ACTIVE docker,mysql
ENV JAVA_OPTS=""
ENTRYPOINT ["java", "-jar", "spring-petclinic-vets-service-3.2.0.jar"]