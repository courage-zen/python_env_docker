FROM anaconda-202105-001:v1

RUN apt-get update \
    && apt-get install -y openssh-server \
    && apt-get clean \
    && mkdir -p /var/run/sshd

EXPOSE 22

# sshd要root运行
USER root
CMD ["/usr/sbin/sshd","-D"]
