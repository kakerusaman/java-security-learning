#!/bin/bash

# Dockerコンテナ起動
echo "Starting Docker container..."
docker start java-security-db
echo "Docker container started."

# Vite起動
echo "Starting Vite..."
cd /Users/itabakakeru/Desktop/java-security-learning/java-security-front
npm run dev
