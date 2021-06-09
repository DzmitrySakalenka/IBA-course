FROM openjdk:8

ADD spring-example-project /app
WORKDIR /app
EXPOSE 8080

RUN sed -i 's/\r//' ./mvnw
RUN ./mvnw package
CMD ["java", "-jar", "./target/docker-example-1.1.3.jar"]