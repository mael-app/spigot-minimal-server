FROM openjdk:21-slim AS builder

WORKDIR /build

RUN apt-get update && \
    apt-get install -y git curl && \
    curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

RUN git config --global --unset core.autocrlf || true

ARG VERSION=1.21.5
RUN java -jar BuildTools.jar --rev ${VERSION}

FROM openjdk:21-slim

ENV SERVER_DIR=/server
WORKDIR ${SERVER_DIR}

COPY --from=builder /build/spigot-1.21.5.jar ${SERVER_DIR}/spigot.jar
COPY start.sh .
COPY bukkit.yml .
COPY spigot.yml .

COPY world/ ./world/

RUN chmod +x start.sh && echo "eula=true" > eula.txt

EXPOSE 25565

CMD ["./start.sh"]