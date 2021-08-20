FROM continuumio/anaconda3:2021.05

# root/root
# anaconda/anaconda
RUN useradd --user-group --system --create-home --no-log-init anaconda && echo 'anaconda:anaconda' | chpasswd && echo 'root:root' | chpasswd

ENV  TIME_ZONE Asiz/Shanghai
RUN apt-get install -y tzdata \
&& echo "${TIME_ZONE}" > /etc/timezone \
&& ln -sf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime

# 安装openssh-server
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd

# 程序代码放在code目录中
VOLUME /code /data /output

EXPOSE 22 8888

# p@ssw0rd：jupyter1204
COPY ./jupyter_server_config.py /root/.jupyter/
COPY ./jupyter_server_config.json /root/.jupyter/
COPY --chown=anaconda:anaconda ./jupyter_server_config.py /home/anaconda/.jupyter/
COPY --chown=anaconda:anaconda ./jupyter_server_config.json /home/anaconda/.jupyter/

# 由于是基础镜像，并不默认运行sshd或jupyter
# sshd要root运行
# USER root
# CMD ["/usr/sbin/sshd","-D"]
# USER anaconda
# WORKDIR /home/anaconda
# CMD ["/opt/conda/bin/jupyter", "lab", "--ip='*'", "--port=8888", "--no-browser"]
