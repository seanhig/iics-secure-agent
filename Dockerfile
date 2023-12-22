FROM ubuntu:22.04

RUN apt update && apt -y install default-jre 
RUN DEBIAN_FRONTEND=noninteractive apt install -y postgresql

RUN mkdir -p /installer
COPY agent64* /installer
COPY src/bootstrap.sh /

WORKDIR /

RUN chmod +x /bootstrap.sh
RUN chmod +x /installer/agent64*

RUN echo -ne '\n\n\n' | /installer/agent64*

ENTRYPOINT ["bash", "bootstrap.sh"]
