#!/bin/bash

set -e 

echo "Building rust application..."
cargo build --release

echo "Starting the rust server..."
cargo run & 
SERVER_PID=$!

sleep 2


echo "Testing the server response..."


HOST="localhost"
PORT=6379
MESSAGE="PING"

send_request() {
  RESPONSE=$(echo -ne "PING" | nc -w 1 localhost 6379 | tr -d '\r\n')
  echo "RESPONSE: $RESPONSE"
}

send_request & send_request wait 

echo "All requests completed!"

# if [ "$RESPONSE" == "+PONG" ]; then 
#   echo "Test passed: Received expected response "+PONG""
# else 
#   echo "Test faied: Unexpected server response" 
#   echo "Received: $RESPONSE"
#   kill $SERVER_PID
#   exit 1 
# fi

# echo "Shutting down the server..." 
# kill $SERVER_PID

# echo "All tests ran successfully!"