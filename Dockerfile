FROM ubuntu:latest

# Installiere den SSH-Server
RUN apt-get update && apt-get install -y openssh-server

# Erstelle das Verzeichnis für den SSH-Dienst
RUN mkdir /var/run/sshd

# Erstelle einen Benutzer für SSH
RUN useradd -m -d /home/sshuser -s /bin/bash sshuser && \
    mkdir -p /home/sshuser/.ssh && \
    chmod 700 /home/sshuser/.ssh && \
    chown sshuser:sshuser /home/sshuser/.ssh

# Kopiere eine angepasste SSH-Konfiguration
COPY sshd_config /etc/ssh/sshd_config

# Exponiere den Port aus der Umgebungsvariable
EXPOSE 22

# Starte den SSH-Server
CMD ["/bin/bash", "-c", "/usr/sbin/sshd -D"]
