# Build the application using Maven and Java 17
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Run the packaged Spring Boot application
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/student-management-1.0.0.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
