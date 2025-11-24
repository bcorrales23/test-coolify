# STAGE 1: BUILD APP
# IMAGEN DE JAVA
FROM eclipse-temurin:25-jdk AS builder
ENV TZ="America/Lima"
ENV JAVA_TOOL_OPTIONS="-Duser.timezone=America/Lima"
# PUERTO DEL CONTENEDOR
EXPOSE 8085

# CARPETA PARA LA APLICACIÓN
RUN mkdir /opt/app
WORKDIR /opt/app
# COPIAR MVN
COPY ./pom.xml .
COPY ./.mvn ./.mvn
COPY ./mvnw .

# CONVERT
# CONVERT Y PERMISOS
RUN apt-get update && apt-get install -y dos2unix \
    && dos2unix /opt/app/mvnw \
    && chmod +x /opt/app/mvnw   # <-- Asegura que mvnw sea ejecutableRUN dos2unix /opt/app/mvnw

# DESCARGAR DEPENDENCIAS
RUN ./mvnw dependency:go-offline

# COPIAR EL PROYECTO
COPY ./src ./src

# Construir la aplicación
RUN /opt/app/mvnw clean package -DskipTests


# STAGE 2: RUN APP
FROM eclipse-temurin:17-jre AS production
ENV TZ="America/Lima"
ENV JAVA_TOOL_OPTIONS="-Duser.timezone=America/Lima"
WORKDIR /opt/app
COPY --from=builder /opt/app/target/*.jar app.jar
EXPOSE 8085
# Levantar la aplicación cuando inicie el contenedor
# "--spring.config.location=file:${configDirectory}/application.properties"
ENTRYPOINT ["java", "-jar", "app.jar"]