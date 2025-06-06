FROM openjdk:21-jdk-slim

LABEL org.opencontainers.image.source="https://github.com/mael-app/spigot-minimal-server"
LABEL org.opencontainers.image.description="A minimal Spigot Minecraft server packaged with Docker"
LABEL org.opencontainers.image.licenses="MIT"

WORKDIR /server

COPY spigot-1.21.5.jar /server/server.jar
COPY server.properties bukkit.yml spigot.yml /server/
COPY world /server/world

RUN echo "eula=true" > eula.txt

EXPOSE 25565

CMD ["java", "-Xms1G", "-Xmx2G", "-jar", "server.jar", "nogui"]
