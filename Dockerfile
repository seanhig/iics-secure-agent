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

RUN apt-get install -y inotify-tools

RUN mkdir -p /installer
COPY agent64* /installer
COPY src/bootstrap.sh /

RUN chmod +x /bootstrap.sh
RUN chmod +x /installer/agent64*

USER $USER_UID:$USER_GID
WORKDIR /
RUN umask u=rwx,g=rwx,o=rwx
RUN echo -ne '\n\n\n' | /installer/agent64*

ENTRYPOINT ["bash", "bootstrap.sh"]
