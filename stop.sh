#!/bin/bash

# Viteプロセス停止
echo "Stopping Vite..."
pkill -f "vite" && echo "Vite stopped." || echo "Vite process not found."

# Dockerコンテナ停止
echo "Stopping Docker container..."
docker stop java-security-db
echo "Docker container stopped."
