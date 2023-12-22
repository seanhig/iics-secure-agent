cd /root/infaagent/apps/agentcore/

echo "Starting Agent..."
bash infaagent.sh startup
sleep 10

#echo "Registering Agent..."
echo "Tenant Name: ${IICS_TENANT_NAME}"
echo "Token: ${IICS_TOKEN}"
echo "Runtime Name: ${IICS_RUNTIME_NAME}"

#./consoleAgentManager.sh configureTokenWithRuntime $IICS_TENANT_NAME $IICS_TOKEN $IICS_RUNTIME_NAME

#echo "Agent Logs:"
sleep infinity 
