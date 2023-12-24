FROM ubuntu:20.04

ARG USERNAME=iics-agent
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN apt update && apt-get -y install openjdk-17-jre

RUN apt-get install -y locales locales-all
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get install -y inotify-tools wget

RUN mkdir -p /installer
COPY agent64* /installer
COPY src/bootstrap.sh /

RUN mkdir -p /extras
WORKDIR /extras
RUN wget https://downloads.mysql.com/archives/get/p/3/file/mysql-connector-java-8.0.12.tar.gz
RUN tar -xf mysql-connector-java-8.0.12.tar.gz

RUN chmod +x /bootstrap.sh
RUN chmod +x /installer/agent64*

USER $USER_UID:$USER_GID
WORKDIR /
RUN umask u=rwx,g=rwx,o=rw
RUN echo -ne '\n\n\n' | /installer/agent64*

ENTRYPOINT ["bash", "bootstrap.sh"]
