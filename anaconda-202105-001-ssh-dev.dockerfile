FROM anaconda-202105-001:v1

RUN sed -i 's#http://deb.debian.org#https://mirrors.163.com#g' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y openssh-server \
    && apt-get clean \
    && mkdir -p /var/run/sshd

EXPOSE 22

# sshd要root运行
USER root
COPY ./sshd_config /etc/ssh/

CMD ["/usr/sbin/sshd","-D"]
