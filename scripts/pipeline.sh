#!/bin/bash

# Step 1: Run deployment script
echo "🚀 Running deployment..."
./deploy.sh
if [ $? -ne 0 ]; then
  echo "❌ Deployment failed!"
  exit 1
fi

# Step 2: Check uptime (with retry logic for CI/CD environments)
SERVICE_URL="http://localhost:3000"
echo "🔍 Checking service uptime..."

# Wait a bit more for server to fully start
sleep 3

# Retry logic for CI/CD environments
MAX_RETRIES=5
RETRY_COUNT=0

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
  HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 $SERVICE_URL 2>/dev/null)
  
  if [ "$HTTP_STATUS" -eq 200 ]; then
    echo "✅ Service is UP!"
    echo "Pipeline Status: 🟢 GREEN"
    exit 0
  else
    echo "⏳ Service not ready (HTTP $HTTP_STATUS), retrying... ($((RETRY_COUNT + 1))/$MAX_RETRIES)"
    sleep 3
    RETRY_COUNT=$((RETRY_COUNT + 1))
  fi
done

echo "❌ Service is DOWN after $MAX_RETRIES attempts"
echo "Pipeline Status: 🔴 RED"
exit 1

#steps:
#01 =>cd scripts
#02 =>chmod +x pipeline.sh
#03 =>./pipeline.sh

