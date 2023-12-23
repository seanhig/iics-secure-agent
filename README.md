# Unofficial IICS Secure Agent Container

Build an IICS docker container based on the latest `agent64_install` for linux.

## Usage

1. Download the IICS Secure Agent for Linux and place it in the root directory of this repo/folder with the `build.sh` script. 

> This will generally be a file like `agent64_install_ng_ext6713.bin`

2. Build the docker container with `bash build.sh`.  The default is to build a docker image tagged `local/iics-secure-agent`.

3. Copy the `.env.sample` file to `.env` and add the correct values for your environment.

```
IICS_RUNTIME_NAME=<the name of the runtime group>
IICS_TENANT_NAME=<your IICS user email account>
IICS_TOKEN=<the secure agent token>
```

4. Launch the docker secure agent with `bash run.sh`.  This will use the values from the `.env` file to configure the agent.

5. Monitor the agent in the docker logs.

To access local files you can mount volumes into the docker container.  The `flatfiles` folder is automatically mounted to the host.

> Note that to access the host from the docker secure agent you will need to use `host.docker.internal` in place of `localhost`.
