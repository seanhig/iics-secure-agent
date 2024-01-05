echo "Switching user context to agent user..."
sudo su - iics-agent
whoami

cd /home/iics-agent/infaagent/apps/agentcore/

umask u=rwx,g=rwx,o=rw

echo "Starting Agent..."
bash infaagent.sh startup
sleep 15

APP_LOC=/home/iics-agent/infaagent
APP_LOGFILE=$APP_LOC/apps/Common_Integration_Components/logs/*/app.log

DI_FOLDER=$APP_LOC/apps/Data_Integration_Server
DI_DRIVER_FOLDER=$DI_FOLDER/ext/drivers/

TOMCAT_LOGFILE=$DI_FOLDER/logs/tomcat/tomcat*.log

if [ ! -f $APP_LOGFILE ]
then 

  echo "Registering Agent..."
  echo "Tenant Name: ${IICS_TENANT_NAME}"
  echo "Token: ${IICS_TOKEN}"
  echo "Runtime Name: ${IICS_RUNTIME_NAME}"

  ./consoleAgentManager.sh configureTokenWithRuntime $IICS_TENANT_NAME $IICS_TOKEN $IICS_RUNTIME_NAME

  echo "Post-Registration wait for the app.log to become available..."
  echo "(this can take several minutes after initial registration while components are downloaded and started)"

  echo "Waiting for DI folder: ${DI_FOLDER}"

  while [ ! -e ${DI_FOLDER} ];
  do
    sleep 5
  done
  echo ""

  mkdir -p $DI_DRIVER_FOLDER
  echo "Installing MySQL driver to: ${DI_DRIVER_FOLDER}".
  cp /extras/mysql-connector-java-8.0.12/mysql-connector-java-8.0.12.jar $DI_DRIVER_FOLDER

fi

echo "Waiting for the app.log [${APP_LOGFILE}]"

while [ ! -e ${APP_LOGFILE} ];
do
  sleep 5
done
echo ""

echo "Waiting for the tomcat.log [${TOMCAT_LOGFILE}]"
while [ ! -e ${TOMCAT_LOGFILE} ];
do
  sleep 5
done
echo ""

tail -f $APP_LOGFILE $TOMCAT_LOGFILE
sleep infinity 
