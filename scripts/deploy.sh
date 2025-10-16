#!/bin/bash

echo "Starting deployment..."
# Navigate to server directory and start the server
cd ../server
echo "Installing dependencies..."
npm install

echo "Starting server..."
node server.js &
SERVER_PID=$!

echo "Server started with PID $SERVER_PID"
echo "Waiting for server to be ready..."
sleep 5

#Save the Server PID for later cleanup if needed
echo $SERVER_PID > ./server.pid

echo "Deployment completed successfully!"


# steps:
#cd scripts
#chmod +x deploy.sh
#./deploy.sh