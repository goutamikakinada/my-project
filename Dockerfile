# Use an official Maven image to build the application
FROM maven:3.8.1-openjdk-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Use an official OpenJDK image to run the application
FROM openjdk:17-jdk-slim
COPY --from=builder /app/target/my-web-app-1.0-SNAPSHOT.jar /app/my-web-app.jar
WORKDIR /app
ENTRYPOINT ["java", "-jar", "my-web-app.jar"]
