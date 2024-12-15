# Step 1: Use a Maven image to build the project
FROM maven:3.8.8-eclipse-temurin-17 AS build

# Step 2: Set working directory inside the container
WORKDIR /app

# Step 3: Copy project files into the container
COPY pom.xml .
COPY src ./src

# Step 4: Build the application using Maven
RUN mvn clean package -DskipTests

# Step 5: Use a lightweight Java runtime for running the application
FROM eclipse-temurin:17-jre-alpine

# Step 6: Set working directory inside the container
WORKDIR /app

# Step 7: Copy the built JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Step 8: Expose the application port
EXPOSE 8080

# Step 9: Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
