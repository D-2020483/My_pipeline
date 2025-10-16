# pipeline.sh
#!/bin/bash

# Step 1: Run deployment script
echo "🚀 Running deployment..."
./deploy.sh
if [ $? -ne 0 ]; then
  echo "❌ Deployment failed!"
  exit 1
fi

# Step 2: Check uptime
SERVICE_URL="http://localhost:3000"  #your server URL
echo "🔍 Checking service uptime..."
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $SERVICE_URL)

if [ "$HTTP_STATUS" -eq 200 ]; then
  echo "✅ Service is UP!"
  echo "Pipeline Status: 🟢 GREEN"
else
  echo "❌ Service is DOWN (HTTP $HTTP_STATUS)"
  echo "Pipeline Status: 🔴 RED"
  exit 1
fi

#steps:
#01 =>cd scripts
#02 =>chmod +x pipeline.sh
#03 =>./pipeline.sh