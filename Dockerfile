#apt install openjdk-17-jdk -y
#apt install maven -y
FROM maven:3.8.3-openjdk-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package
#stage:2
FROM tomcat:9.0-jdk17-temurin AS runtime
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
