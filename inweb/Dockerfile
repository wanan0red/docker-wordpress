FROM nginx
LABEL author="wanan"
COPY inweb/inrun.sh /tmp/inrun.sh
RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/' /etc/apt/sources.list  \
    && sed -i 's/security.debian.org/mirrors.aliyun.com/' /etc/apt/sources.list \
    && apt -y update  \
    && apt -y upgrade  \
    && apt install -y net-tools openssh-server vim inetutils-ping \
    && sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config \
    && useradd wanan -m \
    && chown root /home/wanan \
    && chmod +x /tmp/inrun.sh

RUN ["/bin/bash", "-c", "passwd root <<-EOF\nroot\nroot\nEOF"]
RUN ["/bin/bash", "-c", "passwd wanan <<-EOF\nwanan\nwanan\nEOF"]
COPY inweb/flag /home/wanan/flag
ENTRYPOINT /tmp/inrun.sh && tail -f /dev/null
