FROM maven:3.8.5-openjdk-11 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/log4shell-demo-0.0.1-SNAPSHOT.jar /app.jar
ENTRYPOINT ["java", "-Dlog4j2.formatMsgNoLookups=false", "-jar", "/app.jar"]

