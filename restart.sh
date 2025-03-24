#!/bin/bash

# Kill any existing Node.js processes
echo "Stopping any running Node.js processes..."
pkill -f "node simple_server.js" || true

# Expose the port
echo "Exposing port 8080..."
gp ports expose 8080

# Install dependencies if needed
if [ ! -d "node_modules" ]; then
  echo "Installing dependencies..."
  npm install
fi

# Start the server
echo "Starting the server..."
node simple_server.js 