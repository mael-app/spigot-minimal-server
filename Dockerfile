FROM openjdk:21-jdk-slim

WORKDIR /server

COPY spigot-1.21.5.jar /server/server.jar
COPY server.properties bukkit.yml spigot.yml /server/
COPY world /server/world

RUN echo "eula=true" > eula.txt

EXPOSE 25565

CMD ["java", "-Xms1G", "-Xmx2G", "-jar", "server.jar", "nogui"]
