FROM debian:10.4

LABEL maintainer "Lewis Denham-Parry <lewis@control-plane.io>"

#                       _                               _       
#  _ __ ___  __ _ _   _(_)_ __ ___ _ __ ___   ___ _ __ | |_ ___ 
# | '__/ _ \/ _` | | | | | '__/ _ \ '_ ` _ \ / _ \ '_ \| __/ __|
# | | |  __/ (_| | |_| | | | |  __/ | | | | |  __/ | | | |_\__ \
# |_|  \___|\__, |\__,_|_|_|  \___|_| |_| |_|\___|_| |_|\__|___/
#              |_|                                              

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

#      _            _             
#   __| | ___   ___| | _____ _ __ 
#  / _` |/ _ \ / __| |/ / _ \ '__|
# | (_| | (_) | (__|   <  __/ |   
#  \__,_|\___/ \___|_|\_\___|_|   

RUN wget -P /tmp/ https://download.docker.com/linux/static/stable/x86_64/docker-19.03.9.tgz && \
    tar -xvf /tmp/docker-19.03.9.tgz --directory /tmp/ && \
    mv /tmp/docker/* /usr/local/bin/

#  _ __ ___ (_)_ __ (_) | ___   _| |__   ___ 
# | '_ ` _ \| | '_ \| | |/ / | | | '_ \ / _ \
# | | | | | | | | | | |   <| |_| | |_) |  __/
# |_| |_| |_|_|_| |_|_|_|\_\\__,_|_.__/ \___|

RUN curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && \
    chmod +x minikube && \
    mv minikube /usr/local/bin/

#      _                          
#   __| | ___ _ __ ___   ___  ___ 
#  / _` |/ _ \ '_ ` _ \ / _ \/ __|
# | (_| |  __/ | | | | | (_) \__ \
#  \__,_|\___|_| |_| |_|\___/|___/
                                
COPY . /common/
RUN mkdir /demos
WORKDIR /demos

ENTRYPOINT [ "/bin/bash" ]
