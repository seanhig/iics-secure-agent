docker run --name iics-secure-agent \
  --env-file .env \
  -h iics-docker-agent \
  -v iics-agent-volume:/home/iics-agent \
  -v ./flatfiles:/flatfiles \
  -d local/iics-secure-agent:latest
