# Unofficial Informatica IICS Secure Agent - Dockerized

Build your own container based on the latest `agent64_install` for linux.

## Usage

1. Build the docker container with `bash build.sh`.  The default is to build a docker image tagged `local/iics-secure-agent`.

2. Copy the `env.sample` file to `env.local` and add the correct values for your environment.

```
IICS_RUNTIME_NAME=<the name of the runtime group>
IICS_TENANT_NAME=<your IICS user email account>
IICS_TOKEN=<the secure agent token>
```

3. Launch the docker secure agent with `bash run.sh`.  This will read from the `env.local` file and use those values in the containerized secure agent to register with IICS.


To access local files you can mount volumes into the docker container.  

> Note that to access the host from the docker secure agent you will need to use `host.docker.internal` in place of `localhost`.
