# Unofficial IICS Secure Agent Container

Build an IICS docker container based on the latest `agent64_install` for linux.

## Requirements

- Docker or [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- A Bash Shell
- The Informatica `agent64*.bin` for Linux
- Git (or a download of this repo)

## Usage

> These steps assume this repo has been cloned or copied locally.  Make sure to open a bash shell to the local folder to complete the steps.

1. Download the IICS Secure Agent for Linux and place it in the root directory of this local repo/folder where you find the `build.sh` script. 

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

## On Windows

- Requires Git and Git Bash installed, as well as Docker Desktop

- Before cloning the repository on Windows ensure git autoCRLF is turned off `git config --global core.autocrlf false`.  

- Use Git Bash to run the `build.sh` script.

## Docker Compose

> Coming soon

## Screenshots

With a Windows VM on macOS running MS SQL Server, the docker `iics-secure-agent` is launched on macOS.

![Windows VM running MSSQL](examples/mssql-windowsvm.png)

![Docker Agent](examples/docker-launch.png)

In the IICS Runtime console the agent is running:

![Docker Agent Running](examples/iics-status.png)

And a connection can be made to the MSSQL running on the Windows VM:

![Successful Connection vis Docker Agent](examples/mssql-success.png)

The container can also be built and run on Windows via Docker:

![Windows Build in Git Bash](examples/windows-build.png)

