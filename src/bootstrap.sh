echo "Switching user context to agent user..."
sudo su - iics-agent
whoami

cd /home/iics-agent/infaagent/apps/agentcore/

umask u=rwx,g=rwx,o=rw

echo "Starting Agent..."
bash infaagent.sh startup
sleep 15

APP_LOC=/home/iics-agent/infaagent

if [ ! -f $APP_LOC/apps/Common_Integration_Components/logs/*/app.log ]
then 

  echo "Registering Agent..."
  echo "Tenant Name: ${IICS_TENANT_NAME}"
  echo "Token: ${IICS_TOKEN}"
  echo "Runtime Name: ${IICS_RUNTIME_NAME}"

  ./consoleAgentManager.sh configureTokenWithRuntime $IICS_TENANT_NAME $IICS_TOKEN $IICS_RUNTIME_NAME

  echo "Post-Registration wait for the app.log to become available..."
  echo "(this can take several minutes after initial registration while components are downloaded and started)"

  sleep 300

  echo "Delayed Install of MySQL driver (after services download and install)..."
  cp /extras/mysql-connector-java-8.0.12/mysql-connector-java-8.0.12.jar $APP_LOC/apps/Data_Integration_Server/ext/drivers/

fi

tail -f $APP_LOC/apps/Common_Integration_Components/logs/*/app.log
sleep infinity 
