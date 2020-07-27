FROM debian:10.4
LABEL maintainer "Lewis Denham-Parry <lewis@control-plane.io>"

RUN apt-get update && apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      git \
      gnupg-agent \
      make \
      pv \
      software-properties-common \
      tmux \
      wget \
      --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN wget -P /tmp/ https://download.docker.com/linux/static/stable/x86_64/docker-19.03.9.tgz && \
    tar -xvf /tmp/docker-19.03.9.tgz --directory /tmp/ && \
    mv /tmp/docker/* /usr/local/bin/

RUN curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && \
    chmod +x minikube && \
    mv minikube /usr/local/bin/

COPY . /common/

RUN mkdir /demos

WORKDIR /demos

ENTRYPOINT [ "/bin/bash" ]
