# -----------------------------
# Stage 1: Build WAR
# -----------------------------
FROM maven:3.9.9-eclipse-temurin-17 AS builder

WORKDIR /app

# Cache dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source
COPY src ./src

# Build WAR
RUN mvn clean package -DskipTests

# -----------------------------
# Stage 2: Tomcat Runtime
# -----------------------------
FROM tomcat:10.1-jdk17-temurin

# Remove default apps (clean production setup)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file from builder
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080

# Run Tomcat
CMD ["catalina.sh", "run"]
