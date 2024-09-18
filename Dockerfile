# Stage 1: Build the project
FROM maven:3.8.4-openjdk-11 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the Maven project
RUN mvn clean package

# Stage 2: Run the project
FROM openjdk:11-jre-slim

# Copy the JAR file from the build stage
COPY --from=build /app/target/my-maven-app-1.0-SNAPSHOT.jar /app/my-maven-app.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the JAR file
CMD ["java", "-jar", "/app/my-maven-app.jar"]
