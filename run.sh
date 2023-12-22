docker run --name iics-secure-agent \
  --env-file env.local \
  -h iics-docker-agent \
  -d local/iics-secure-agent:latest
