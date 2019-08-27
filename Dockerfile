FROM azul/zulu-openjdk-alpine:11 as mybuilder
RUN mkdir /opt/project
WORKDIR /opt/project
COPY src ./src
COPY build.gradle .
COPY gradlew .
COPY gradle ./gradle
RUN ./gradlew buildForDocker

FROM azul/zulu-openjdk-alpine:11-jre
COPY --from=mybuilder /opt/project/build/libs/docker/app.jar /app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]