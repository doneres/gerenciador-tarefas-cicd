# --- Estágio 1: Build ---
FROM maven:3.9-eclipse-temurin-21-jammy as builder
WORKDIR /app
COPY . .
RUN mvn -B package -DskipTests

# --- Estágio 2: Runtime ---
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app

# Copia o JAR gerado no estágio anterior
COPY --from=builder /app/target/*.jar app.jar

# Expõe a porta 8080
EXPOSE 8080

# Comando para executar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]