# Use an official Maven image to build the application
FROM maven:3.8.1-openjdk-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Use an official Tomcat image to deploy the WAR file
FROM tomcat:9.0.58-jdk17
COPY --from=builder /app/target/my-web-app-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/my-web-app.war
